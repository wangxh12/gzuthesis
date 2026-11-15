# gzuthesis

贵州大学硕士学位论文 LaTeX 模板，当前版本 **0.4.0**，支持学术型和专业型硕士。依据 `requirements/` 中贵大研〔2026〕12号通知及其附件开发，适用于通知所述的 **2026 年 9 月起**的格式。

本版包含题名页、答辩委员会名单、原创性与授权声明、中英文摘要、目次、正文、致谢、参考文献、附录、参考书目、索引、作者简历与后记。示例中的个人信息、研究文字和成果条目需要替换，声明签名和日期默认留空。

## 开始使用

建议安装完整的 TeX Live 2024 或更新版本（开发验证环境为 TeX Live 2026），使用 **XeLaTeX + Biber**。完整 TeX Live 包含所需的 CTeX、Fandol、TeX Gyre、biblatex-gb7714-2015 等宏包及字体。

在项目根目录运行：

```bash
latexmk thesis.tex
```

`.latexmkrc` 会选择 XeLaTeX，并自动运行 Biber 和必要的重复编译。结果位于 **`build/thesis/thesis.pdf`**。

当前 WSL 环境若提示找不到命令，先运行：

```bash
export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
```

先填写 `thesis-info.tex` 的论文信息，然后修改 `data/abstracts.tex` 的中英文摘要、`data/` 中的正文，以及 `data/endmatter.tex` 的个人经历与成果。`thesis.tex` 控制各部分顺序，文献放在 `ref/example.bib`。原项目中的 `gzuthesis.tex` 已保留，可用 `latexmk -outdir=build/legacy gzuthesis.tex` 编译，但它的摘要、致谢和参考文献占位写法并未自动迁移到新接口。

## 文件结构

| 文件 | 用途 |
| --- | --- |
| `thesis.tex` | 推荐论文入口，调整选项、载入章节和文献 |
| `thesis-info.tex` | 题名、作者、导师、学号、答辩信息、关键词等统一设置 |
| `data/abstracts.tex` | 中文和英文摘要 |
| `data/endmatter.tex` | 可选索引、作者简历、在学成果和后记 |
| `data/*.tex` | 正文、图表、公式、跨页表格及附录示例 |
| `examples/body-stress.tex` | 长标题、网址、多行单元格和跨页公式示例 |
| `ref/example.bib` | 从学校附件抄录的三条书目，分别演示引用文献与未引参考书目 |
| `gzuthesis.dtx` | 模板类的唯一维护源文件 |
| `gzuthesis.cls` | 从 dtx 提取，日常写论文直接使用 |
| `docs/requirements.md` | 学校要求与模板实现的逐项对应 |
| `utils/check.py` | 编译、回归及 PDF 文本集成检查 |

## 选项与字体

```latex
\documentclass[
  degree=master,          % 仅支持硕士，可省略
  degree-type=academic,   % academic / professional
  fontset=fandol,         % 跨平台字体；Windows 可选 windows
  bibliography=numeric   % numeric / author-year / none
]{gzuthesis}
```

默认双面，正文从右页开始，每章另起页；章与章之间不强制插入空白页。电子稿若不需要双面装订，可加 `oneside`。`degree-type` 区分学术型和专业型，不会改动正文的统一字号。自 0.3.0 起不再接受 `degree=doctor`；当前项目只维护硕士论文。

默认 Fandol 宋体、黑体、楷体可直接随 TeX Live 使用。Fandol 不是中易宋体。如院系指定具体字体，可在已安装相应字体的 Windows 环境选择 `fontset=windows`；Linux 可使用 `fontset=none`，并自行设置 `\setCJKmainfont`、`\setCJKsansfont` 以及 `\setCJKfamilyfont{zhsong}`、`{zhhei}`、`{zhkai}`。默认西文字体为 TeX Gyre Termes，不是 Times New Roman；正文附件没有指定西文字体名称。

附件未给定页边距和行距。当前默认内侧 30 mm，其余 25 mm；正文基线间距 20 bp，无额外段间距、无页眉、页码居中。这些默认值可在导言区覆盖：

```latex
\geometry{top=25mm,bottom=25mm,inner=30mm,outer=25mm}
\renewcommand\gzubodybaselineskip{20bp}
```

## 常用写法

### 论文信息与前置页面

`\gzusetup{...}` 在导言区使用，完整配置见 `thesis-info.tex`。题名、作者等信息自动用于封面及 PDF 元数据；中英文摘要重复使用对应题名，无需分别修改。

```latex
\gzusetup{
  title={中文题名}, title-en={English Title},
  author={姓名}, student-id={学号}, supervisor={导师姓名及职称},
  discipline={学科专业}, research-field={研究方向}, department={培养单位},
  date={2026 年 9 月},
  keywords={关键词一,关键词二,关键词三},
  keywords-en={First keyword,second keyword,third keyword},
  front-fonts=auto, authorization=blank
}
\gzucommittee[主席]{姓名}{单位}{职称}
\gzucommittee{姓名}{单位}{职称}
```

委员会名单按输入顺序排版，默认身份为委员；可用 `\gzuclearcommittee` 清空并重新设置。分类号、学校代码、密级、答辩日期地点及秘书等字段均在信息文件中列出。模板不猜测个人资料或密级。

正文中的顺序为：

```latex
\frontmatter
\maketitle
\makecommittee
\makedeclarations
\begin{abstractzh}中文摘要正文。\end{abstractzh}
\begin{abstracten}English abstract text.\end{abstracten}
\tableofcontents
\listoffigures
\listoftables
\mainmatter
```

中文题名小二号黑体，中文摘要与关键词四号宋体；英文题名小二号 Arial，英文摘要与关键词四号 Times New Roman。每个摘要另起页，较长摘要允许自然续页，关键词自动放在摘要末尾。关键词以英文逗号分隔输入，输出中文用分号、英文用逗号；数量不是 3–8 个时会给出编译警告。英文首个关键词的大小写由作者填写。

题名页作为前置部分首页计入罗马页序但不显示页码，委员会名单从 II 开始，其后连续；正文从右页开始并重置为阿拉伯数字 1。学校文件未说明首页是否参与计数，此处明确采用“计数但不显示”的默认解释。

两段声明保留学校附件原文，默认不代填签名和日期、不替作者作保密选择。如已经明确确定授权类别，可设置 `authorization=public` 或 `authorization=confidential, declassification-year={2030}`；`blank` 保持两项均未勾选。封面上的 `secrecy` 应与实际审批结果一致。

**前置页专用字体**：`front-fonts=auto` 优先查找已安装的华文行楷、Times New Roman、Arial；WSL 下也可直接读取现有 `/mnt/c/Windows/Fonts/` 字体。本项目不复制或分发字体文件。缺少字体时使用替代字体并明确警告；`front-fonts=strict` 缺字体直接报错，适合最终检查；`front-fonts=portable` 使用楷体、TeX Gyre Termes/Heros，仅用于跨平台草稿。此选项与控制正文中文字体的 `fontset` 相互独立。

封面纸张颜色按学校要求：学术型硕士深蓝色、专业型硕士黄色。PDF 保持白底，印制时选择相应封面材料。封面和委员会页保持指定字号；字段过长导致整页放不下时会报错，不静默缩小字号。

可选的 `preface`（前言）、`notation`（符号和缩略语说明）环境提供加入目录的独立页面。前言放在摘要后、目次前，符号说明放在图表清单后。

### 图、表、公式

沿用标准 `figure`、`table`、`equation`、`align`、`longtable` 环境，示例见 `data/layout-example.tex`。编号自动按章生成，如图 2-1、表 2-1、式 (2-1)。图前、表前和公式前应有正文提示。

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=.8\textwidth]{figures/my-figure.pdf}
  \gzunote{注：图注置于图题上方。} % 没有图注时删除
  \gzubicaption{中文图题}{English caption}
  \label{fig:example}
\end{figure}
```

硕士可将 `\gzubicaption{中文}{English}` 换成 `\caption{中文}`。双语题只生成一个编号、一个中文图表目录条目；`\label` 放在题注命令之后。图较窄时可把图和题注放进同宽的 `minipage`，避免题注宽于图。表题命令放在表格上方；表内使用 `\toprule`、`\midrule`、`\bottomrule`。不要使用连续空格或手动输入图表序号。

`\gzunote{...}` 提供小五号宋体的图注/表注；`\gzuequationwhere{...}` 提供顶格的“式中”说明。跨页表格需要作者声明 `\endfirsthead` 和 `\endhead`，以重复表号、续表标记和表头，完整写法已放入示例。

多行单元格可使用 `p{宽度}` 或已加载的 `tabularx` 的 `X` 列。表格内为小五号宋体、12 bp 文字基线，行支架倍率为 1.25；单行最小行高约 15 bp，多行单元格不会把每行文字都拉开到 15 bp。表格字体设置局限于环境内部，独立表格之后正文自动恢复。

`align`、`gather` 等多行公式允许必要时在行间分页；使用 `\\*` 禁止某一处分页，使用 `\displaybreak` 建议分页。单个 `equation` 内的 `aligned`、`split` 仍不可拆分；非常宽的公式仍需要作者主动分行。

### 长网址与复杂标题

`\url{...}` 和参考文献中的长 URL 可以在字母或数字间断行。中西文混排段落额外允许少量应急伸缩，仅在普通断行失败时启用。

长标题自然换行。带数学符号的标题需要提供书签用的文字版本：

```latex
\section{基于\texorpdfstring{$\alpha+\beta$}{alpha + beta}的模型}
```

书签中的 `\quad`、`\qquad`、`\\` 和 `\hspace` 按文字间隔处理或移除。目录文字和页码均可点击。不要用连续空格或强制换行排齐目录。

### 文献

```latex
% 导言区
\addbibresource{ref/example.bib}
% 正文
已有研究\cite{zhang2002}……
% 正文之后
\printbibliography
```

默认 GB/T 7714 顺序编码制，`\cite` 输出上标编号。选择 `bibliography=author-year` 可切换著者—出版年制，正文可使用 `\parencite` 或 `\textcite`。参考文献表列出全部作者（上限设为 999）；请在 `.bib` 中写全作者，不要用 `and others` 人为截断。著者—出版年制的中文排序依赖准确的姓名和拼音排序信息，提交前应核对排序，必要时补 `sortkey`。

学校要求硕士文献不少于 35 篇；模板不会凑数或插入未引用文献。`bibliography=none` 关闭自动加载，适合自行配置 BibTeX/natbib；此时引用样式和参考文献字体由作者负责，不要再直接使用示例中的 biblatex 命令。

### 致谢和附录

```latex
\backmatter
\begin{acknowledgements}
感谢…… % 五号楷体
\end{acknowledgements}
\printbibliography
\appendix
\chapter{补充材料} % “附录 A”与标题分行居中
```

附录在 `\backmatter` 后仍正常编号为 A、B……，图表公式相应为 A-1；正文和后置部分的阿拉伯页码连续。`\gzuchapter{作者简历}` 可创建加入目次的无编号章。

正文后完整写法见 `thesis.tex` 和 `data/endmatter.tex`：

```latex
\appendix
\chapter{补充材料}
% 可选：列出读过但未在正文引用的书目，另起一个附录，不污染正文文献表
\printreadinglist{bibkey1,bibkey2}
\begin{thesisindex}
  \gzuindexitem{术语名称}{label:key}
\end{thesisindex}
\begin{resume}
  \section{教育经历}实际经历。
  \section{攻读硕士学位期间发表的学术论文及其他成果}
  \begin{achievements}\item 实际成果条目。\end{achievements}
  \section{获奖情况}实际奖项。
  \section{参加项目}实际项目。
\end{resume}
\begin{postscript}可选的后记。\end{postscript}
```

`resume` 中的节不编号，成果列表使用独立的 `[1]` 序号、小五号宋体。索引是手工条目列表，页码由标签自动更新；作者自行按拼音或所需顺序排列，可删去不需要的可选部分。索引、简历和后记不会继承附录的居中标题样式。`\printreadinglist` 仅在启用 biblatex 时可用，应置于 `\appendix` 后；新增的 refsection 由 latexmk 自动调用 Biber 处理。

## 维护和验证

修改类文件时，请改 `gzuthesis.dtx` 后重新提取，不要只修改生成的 cls：

```bash
xetex gzuthesis.ins
l3build check
python3 utils/check.py
```

集成检查另需 Poppler 的 `pdftotext`。它编译不同硕士选项的文档，检查正文右页开始、页码连续、附录编号、双语题注、跨页续表、全部作者，以及正文/文献中的长 URL、多行表格、长标题和真正跨页的 48 行公式。回归测试还检查表格结束后和 `\normalsize` 恢复后的字号、行距。中间文件全部在 `build/`，PDF 仍需进行视觉检查。

0.4.0 还检查完整前置页、长题名、专业型封面、多页中英文摘要、两种明确授权选择、摘要后的正文字号恢复，以及参考书目与正文参考文献的隔离。测试中的授权选择只属于生成的虚构测试文件，不改变实际论文的信息文件。

复杂排版示例可单独编译：

```bash
latexmk -outdir=build/body-stress examples/body-stress.tex
```

参考清华模板的工程组织和前后置部分处理思路；贵州大学的格式独立实现，编译不依赖 `thuthesis/`。本次修改前的已有 dtx/cls 备份在本地 `build/before-0.2/`。
