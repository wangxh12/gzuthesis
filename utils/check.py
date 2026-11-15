#!/usr/bin/env python3
"""Compile real documents and check numbering, references and PDF pagination.

Requires TeX Live (xelatex, latexmk, biber, l3build) and Poppler (pdftotext).
Uses only the Python standard library. Run from any working directory.
"""
from pathlib import Path
import re
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "build" / "verification"
OUT.mkdir(parents=True, exist_ok=True)


def run(args, log):
    with (OUT / log).open("w", encoding="utf-8") as stream:
        result = subprocess.run(args, cwd=ROOT, stdout=stream, stderr=subprocess.STDOUT)
    if result.returncode:
        raise RuntimeError(f"Command failed: {args}; see {OUT / log}")


def pdf_pages(pdf):
    text = subprocess.check_output(
        ["pdftotext", "-layout", str(pdf), "-"], encoding="utf-8"
    )
    return text.split("\f")[:-1]


def check_log(path):
    text = path.read_text(encoding="utf-8")
    errors = re.findall(
        r"^.*(?:Overfull|Missing character:|undefined|multiply defined|"
        r"Please \(re\)run Biber|Rerun to get|Float too large|Token not allowed in a PDF string).*$", text, re.M
    )
    assert not errors, f"{path}: {errors}"


for executable in ("xelatex", "xetex", "latexmk", "biber", "l3build", "pdftotext"):
    if not shutil.which(executable):
        raise SystemExit(f"Missing executable on PATH: {executable}")

run(["xetex", "-interaction=nonstopmode", "gzuthesis.ins"], "unpack.log")
run(["l3build", "check"], "regression.log")
run(["latexmk", "thesis.tex"], "example.log")
check_log(ROOT / "build/thesis/thesis.log")
pages = pdf_pages(ROOT / "build/thesis/thesis.pdf")
main = next(i for i, p in enumerate(pages) if re.match(r"\s*1\s+绪论\s*\n", p))
assert main % 2 == 0, "Main matter must start on a physical recto"
# Depending on the length of front matter, no parity blank may be necessary.
assert not re.search(r"\n\s*I\s*$", pages[0]), "Title page must not print its Roman page number"
assert "硕士学位论文答辩委员会名单" in pages[1]
assert "原创性声明" in re.sub(r"\s+", "", pages[2])
assert "Key words:" in "\n".join(pages[:main])
for number, page in enumerate(pages[main:], 1):
    assert page.strip().splitlines()[-1].strip() == str(number), "Discontinuous page numbering"
text = "\n".join(pages)
assert "跨页数据排版示例（续）" in text, "Long table must really cross a page"
assert "(A-1)" in text and "Figure 2-1" in text and "Table 2-1" in text
assert "附录 B" in text and "参考书目" in text
assert "作者简历" in text and "后记" in text and "索引" in text
# Uncited reading material must not contaminate the main bibliography.
reference_page = next(p for p in pages[main:] if p.strip().startswith("参考文献"))
assert "网络安全等级保护标准汇编" not in reference_page

# Synthetic reference, deliberately not part of the user's bibliography.
bib = OUT / "authors.bib"
bib.write_text("""@book{authors,
author={Smith, Alice and Johnson, Bob and Brown, Carol and Jones, David and Miller, Eve},
title={Synthetic bibliography test}, location={Test City}, publisher={Test Press}, date={2020},
url={https://example.org/""" + "abcdefghijklmnopqrstuvwxyz0123456789" * 7
    + "}}\n", encoding="utf-8")
for name, options in (
    ("master-numeric", "degree=master,degree-type=academic,bibliography=numeric"),
    ("master-author-year", "degree=master,degree-type=professional,oneside,bibliography=author-year"),
    ("master-none", "degree=master,degree-type=professional,oneside,bibliography=none"),
):
    with_bib = "bibliography=none" not in options
    source = (
        "\\documentclass[" + options + "]{gzuthesis}\n"
        + ("\\addbibresource{build/verification/authors.bib}\n" if with_bib else "")
        + r"""\begin{document}
\frontmatter\tableofcontents
\mainmatter\chapter{编号检查}
如图~\ref{fig:test}~所示；如式~\eqref{eq:test}~所示。
\begin{figure}[htbp]\centering\rule{3cm}{1cm}
\gzubicaption{测试图}{Test figure}\label{fig:test}\end{figure}
\begin{equation}a=b\label{eq:test}\end{equation}
"""
        + (r"\cite{authors}" if with_bib else "")
        + r"\backmatter" + (r"\printbibliography" if with_bib else "")
        + r"""\appendix\chapter{测试附录}\label{app:test}
\begin{equation}c=d\label{eq:extra}\end{equation}
\end{document}
"""
    )
    tex = OUT / f"{name}.tex"
    tex.write_text(source, encoding="utf-8")
    outdir = f"build/verification/{name}"
    run(["latexmk", f"-outdir={outdir}", str(tex.relative_to(ROOT))], f"{name}.log")
    check_log(ROOT / outdir / f"{name}.log")
    fixture_pages = pdf_pages(ROOT / outdir / f"{name}.pdf")
    rendered = "\n".join(fixture_pages)
    assert "(1-1)" in rendered and "(A-1)" in rendered
    assert "Figure 1-1" in rendered
    if "oneside" in options:
        assert all(page.strip() for page in fixture_pages), "Unexpected parity blank in oneside"
    if with_bib:
        for author in ("SMITH", "JOHNSON", "BROWN", "JONES", "MILLER"):
            assert author in rendered.upper(), f"Bibliography truncated author {author}"
    print(f"PASS {name}")
print("PASS regression, example, continuous page numbers, recto start, bilingual captions and continued table")

run(["latexmk", "-outdir=build/body-stress", "examples/body-stress.tex"], "body-stress.log")
check_log(ROOT / "build/body-stress/body-stress.log")
stress_pages = pdf_pages(ROOT / "build/body-stress/body-stress.pdf")
stress_text = "\n".join(stress_pages)
assert "(2-1)" in stress_text and "(2-48)" in stress_text
aux = (ROOT / "build/body-stress/body-stress.aux").read_text(encoding="utf-8")
first = re.search(r"\\newlabel\{eq:first-row\}\{\{[^}]+\}\{(\d+)\}", aux)
last = re.search(r"\\newlabel\{eq:last-row\}\{\{[^}]+\}\{(\d+)\}", aux)
assert first and last and int(last[1]) > int(first[1]), "Long align must actually span pages"
assert "此处已经离开表格环境" in stress_text
print("PASS long URLs (body and bibliography), wrapping tables/headings and multipage equations")

# Exercise portable fonts, long fields, multipage abstracts and both explicit
# authorization settings. All personal data remains illustrative.
for authorization in ("public", "confidential"):
    name = "front-" + authorization
    source = r"""\documentclass[degree-type=professional,oneside,bibliography=none]{gzuthesis}
\input{thesis-info}
\gzusetup{front-fonts=portable,authorization=""" + authorization + r""",
declassification-year=2030,
title={复杂研究场景下的多源数据处理方法与硕士学位论文排版系统研究},
title-en={A Study of Multisource Data Processing and Typesetting for Master's Theses}}
\begin{document}\frontmatter
\maketitle\makecommittee\makedeclarations
\begin{abstractzh}
""" + ("这一段文字用于验证较长摘要的自动分页和宋体字号，关键词应该位于摘要最后而不是覆盖正文。" * 4 + "\n\n") * 8 + r"""
\end{abstractzh}
\begin{abstracten}
""" + ("This paragraph checks page breaks in a long abstract while preserving the specified font size and leaving the keywords at the end. " * 6 + "\n\n") * 5 + r"""
\end{abstracten}
\mainmatter\chapter{正文检查}
\makeatletter\typeout{GZU-AFTER-ABSTRACT-SIZE=\f@size}
\typeout{GZU-AFTER-ABSTRACT-BASELINE=\the\baselineskip}\makeatother
正文已恢复字号与行距。
\appendix\chapter{附录示例}补充内容。
\begin{resume}\section{教育经历}示例经历。\end{resume}
\begin{postscript}示例后记。\end{postscript}
\end{document}
"""
    tex = OUT / f"{name}.tex"
    tex.write_text(source, encoding="utf-8")
    outdir = f"build/verification/{name}"
    run(["latexmk", f"-outdir={outdir}", str(tex.relative_to(ROOT))], f"{name}.log")
    log = ROOT / outdir / f"{name}.log"
    check_log(log)
    contents = log.read_text(encoding="utf-8")
    assert "GZU-AFTER-ABSTRACT-SIZE=10.53937" in contents
    assert "GZU-AFTER-ABSTRACT-BASELINE=20.075pt" in contents
    result = pdf_pages(ROOT / outdir / f"{name}.pdf")
    assert "专业学位" in result[0]
    declaration = re.sub(r"\s+", "", result[2])
    assert ("不保密（✓）" if authorization == "public" else "保密（✓），在2030年") in declaration
    assert len(result) > 8, "Long abstracts did not exercise pagination"
    print(f"PASS {name}: multipage abstracts, explicit consent, font restoration")
