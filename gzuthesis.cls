%%
%% This is file `gzuthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% gzuthesis.dtx  (with options: `cls')
%% 
%% This is a generated file.
%% 
%% This file is part of the GZUThesis project, derived from ThuThesis.
%% 
%% Copyright (C) 2005-2021 by Tsinghua University TUNA Association <tuna@tsinghua.edu.cn>
%% Copyright (C) 2026 by Your Name <your@email.com>
%% 
%% GZUThesis adapts ThuThesis for the thesis formatting requirements
%% of Guizhou University. The original project is available at
%% https://github.com/tuna/thuthesis.
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008 or later.
%% 
%% To produce the documentation run the original source files ending
%% with `.dtx' through LaTeX.
%% 


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gzuthesis}[2026/11/17 v0.3.3-dev Guizhou University Thesis Template]
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}

\SetupKeyvalOptions{
  family  = gzu,
  prefix  = gzu@,
  setkeys = \kvsetkeys,
}

\newcommand\gzuthesis{GZUThesis}
\newcommand\gzuversion{0.3.3-dev}
\providecommand\version{\gzuversion}

\newcommand\gzu@error[2]{\ClassError{gzuthesis}{#1}{#2}}

\newif\ifgzu@options@ready
\gzu@options@readyfalse
\let\gzu@setup@hook\@empty

\newcommand\gzusetup[1]{%
  \let\gzu@setup@hook\@empty
  \kvsetkeys{gzu}{#1}%
  \gzu@setup@hook
}

\newcommand\gzu@define@key[1]{%
  \kvsetkeys{gzu@key}{#1}%
}

\newcommand\gzu@option@hook[2]{%
  \expandafter\g@addto@macro\csname gzu@#1@@code\endcsname{#2}%
}

\newcommand\gzu@run@option@hook[1]{%
  \ifgzu@options@ready
    \@nameuse{gzu@#1@@code}%
  \fi
}
\kv@define@key{gzu@definition}{name}{\def\gzu@@name{#1}}
\kv@define@key{gzu@definition}{choices}{\def\gzu@@choices{#1}}
\kv@define@key{gzu@definition}{default}{\def\gzu@@default{#1}}
\kv@define@key{gzu@definition}{code}{\def\gzu@@code{#1}}

\kv@set@family@handler{gzu@key}{%
  \@ifundefined{gzu@#1@@name}{%
    \gzu@declare@key{#1}{#2}%
  }{%
    \gzu@error{Option `#1' already defined}%
      {Declare each option only once.}%
  }%
}

\newcommand\gzu@declare@key[2]{%
  \def\gzu@@name{#1}%
  \let\gzu@@choices\@empty
  \let\gzu@@default\@empty
  \let\gzu@@code\@empty
  \kvsetkeys{gzu@definition}{#2}%
  \expandafter\let\csname gzu@#1@@name\endcsname\gzu@@name
  \expandafter\let\csname gzu@#1@@choices\endcsname\gzu@@choices
  \expandafter\let\csname gzu@#1@@code\endcsname\gzu@@code
  \@namedef{gzu@#1@@reset}{}%
  \@namedef{gzu@#1@@guard}{\@firstofone}%
  \def\gzu@declare@choice##1{%
    \ifx\gzu@@default\@empty
      \def\gzu@@default{##1}%
    \fi
    \expandafter\newif\csname ifgzu@\gzu@@name @##1\endcsname
    \@namedef{gzu@#1@@choice@##1}{}%
    \expandafter\g@addto@macro\csname gzu@#1@@reset\endcsname{%
      \@nameuse{gzu@\@nameuse{gzu@#1@@name}@##1false}%
    }%
  }%
  \expandafter\comma@parse\expandafter{\gzu@@choices}{\gzu@declare@choice}%
  \kv@define@key{gzu}{#1}{\gzu@set@key{#1}{##1}}%
  \def\gzu@set@default##1{\gzu@set@key{#1}{##1}}%
  \expandafter\gzu@set@default\expandafter{\gzu@@default}%
}
\newcommand\gzu@set@key[2]{%
  \@nameuse{gzu@#1@@guard}{\gzu@set@key@value{#1}{#2}}%
}

\newcommand\gzu@set@key@value[2]{%
  \expandafter\ifx\csname gzu@#1@@choices\endcsname\@empty
    \@namedef{gzu@\@nameuse{gzu@#1@@name}}{#2}%
    \gzu@run@option@hook{#1}%
  \else
    \edef\gzu@@value{#2}%
    \@ifundefined{gzu@#1@@choice@\gzu@@value}{%
      \gzu@error{Invalid value `#1 = \gzu@@value'}%
        {Allowed values: \@nameuse{gzu@#1@@choices}.}%
    }{%
      \expandafter\let\csname gzu@\@nameuse{gzu@#1@@name}\endcsname\gzu@@value
      \@nameuse{gzu@#1@@reset}%
      \@nameuse{gzu@\@nameuse{gzu@#1@@name}@\gzu@@value true}%
      \gzu@run@option@hook{#1}%
    }%
  \fi
}

\newcommand\gzu@option@classonly[1]{%
  \@namedef{gzu@#1@@guard}{\gzu@reject@class@option{#1}}%
}

\newcommand\gzu@reject@class@option[2]{%
  \gzu@error{Option `#1' is only valid in documentclass}%
    {Move this option to the optional argument of \string\documentclass.}%
}
\gzu@define@key{
  degree = {
    choices = {master, doctor},
    default = master,
  },
  degree-type = {
    name = degree@type,
    choices = {academic, professional},
    default = academic,
  },
  fontset = {
    choices = {auto, windows, windows-local, mac, ubuntu, fandol, none},
    default = auto,
  },
  font = {
    choices = {auto, times, times-local, termes, stix, xits,
               libertinus, newcm, lm, none},
    default = auto,
  },
  cjk-font = {
    name = cjk@font,
    choices = {auto, windows, windows-local, mac, mac-word,
               noto, fandol, none},
    default = auto,
  },
  windows-font-dir = {
    name = windows@font@dir,
    default = {.},
  },
  math-font = {
    name = math@font,
    choices = {auto, stix, xits, libertinus, newcm, lm, none},
    default = auto,
  },
}
\gzu@define@key{
  title = {},
  title* = {name = title@en},
  blind-title = {name = blind@title},
  keywords = {},
  keywords* = {name = keywords@en},
  author = {},
  author* = {name = author@en},
  student-id = {name = student@id},
  degree-category = {name = degree@category},
  degree-category* = {name = degree@category@en},
  supervisor = {},
  supervisor* = {name = supervisor@en},
  associate-supervisor = {name = associate@supervisor},
  associate-supervisor* = {name = associate@supervisor@en},
  co-supervisor = {name = co@supervisor},
  co-supervisor* = {name = co@supervisor@en},
  department = {},
  department* = {name = department@en},
  discipline = {},
  discipline* = {name = discipline@en},
  research-direction = {name = research@direction},
  research-direction* = {name = research@direction@en},
  professional-field = {name = professional@field},
  professional-field* = {name = professional@field@en},
  date = {},
  graduation-year = {name = graduation@year},
  clc = {},
  udc = {},
  school-code = {name = school@code},
  secret-level = {name = secret@level},
  secret-year = {name = secret@year},
}
\gzu@define@key{
  % 论文版本：正式版或盲审版
  thesis-version = {
    name = thesis@version,
    choices = {official, blind},
    default = official,
  },
  % 输出模式：打印版或电子版
  output = {
    choices = {print, electronic},
    default = print,
  },
  % 是否在封面背页绘制书脊
  include-spine = {
    name = include@spine,
    choices = {false, true},
    default = false,
  },
  figure-number-separator = {
    name = figure@separator,
    default = {.},
  },
  table-number-separator = {
    name = table@separator,
    default = {.},
  },
  equation-number-separator = {
    name = equation@separator,
    default = {.},
  },
  number-separator = {
    name = number@separator,
    default = {.},
  },
  figure-numbering = {
    name = figure@numbering,
    choices = {chapter, global},
    default = chapter,
  },
  table-numbering = {
    name = table@numbering,
    choices = {chapter, global},
    default = chapter,
  },
  equation-numbering = {
    name = equation@numbering,
    choices = {chapter, global},
    default = chapter,
  },
  table-rule-width = {
    name = table@rule@width,
    default = {1.5bp},
  },
  table-midrule-width = {
    name = table@midrule@width,
    default = {0.75bp},
  },
  table-cmidrule-width = {
    name = table@cmidrule@width,
    default = {0.75bp},
  },
  caption-language = {
    name = caption@language,
    choices = {auto, chinese, bilingual},
    default = auto,
  },
  cite-style = {
    name = cite@style,
    choices = {auto, super, inline, author-year},
    default = auto,
  },
  % 参考文献标题
  bib-title = {
    name = bib@title,
    default = {参考文献},
  },
  bib-appendix-title = {
    name = bib@appendix@title,
    default = {参考文献},
  },
  % BibTeX 附录使用的 BST 样式
  bib-bst = {
    name = bib@bst,
    default = {gbt7714-2025-numeric},
  },
  % 参考文献正文字体
  bib-font = {
    name = bib@font@family,
    default = {\songti},
  },
  bib-font-size = {
    name = bib@font@size,
    default = {9bp},
  },
  bib-line-height = {
    name = bib@line@height,
    default = {14bp},
  },
  % 参考文献标题格式
  bib-title-format = {
    name = bib@title@format,
    default = {
      \centering\heiti
      \fontsize{12bp}{18bp}\selectfont
    },
  },
  % 条目间距和缩进
  bib-item-sep = {
    name = bib@item@sep,
    default = {3bp plus 2bp minus 1bp},
  },
  bib-hang = {
    name = bib@hang,
    default = {21bp},
  },
  bib-label-sep = {
    name = bib@label@sep,
    default = {0.5em},
  },
  % 参考文献标题所在页面的页面样式
  bib-page-style = {
    name = bib@page@style,
    choices = {plain, empty},
    default = plain,
  },
  % 正文参考文献标题层级
  bib-heading = {
    name = bib@heading@level,
    choices = {chapter, section, none},
    default = chapter,
  },
  % 附录独立参考文献标题层级
  bib-appendix-heading = {
    name = bib@appendix@heading@level,
    choices = {section, chapter, none},
    default = section,
  },
  % 附录顺序编码是否添加 A.、B. 等前缀
  bib-appendix-prefix = {
    name = bib@appendix@prefix,
    choices = {true, false},
    default = true,
  },
  % 附录图表是否加入图表清单
  appendix-figure-in-lof = {
    name = appendix@figure@in@lof,
    choices = {true, false},
    default = false,
  },
  % 附录在总目录中的显示深度
  appendix-toc-depth = {
    name = appendix@toc@depth,
    choices = {0, 1, 2, 3},
    default = 0,
  },
  % 中文学位论文默认采用 GB 数学排版风格。
  math-style = {
    name = math@style,
    choices = {GB, ISO, TeX},
    default = GB,
  },
  % 细分数学符号选项：auto 表示服从 math-style 预设。
  uppercase-greek = {
    name = uppercase@greek,
    choices = {auto, italic, upright},
    default = auto,
  },
  less-than-or-equal = {
    name = leq,
    choices = {auto, slanted, horizontal},
    default = auto,
  },
  integral = {
    choices = {auto, upright, slanted},
    default = auto,
  },
  integral-limits = {
    name = integral@limits,
    choices = {auto, true, false},
    default = auto,
  },
  partial = {
    choices = {auto, upright, italic},
    default = auto,
  },
  math-ellipsis = {
    name = math@ellipsis,
    choices = {auto, centered, lower, AMS},
    default = auto,
  },
  real-part = {
    name = real@part,
    choices = {auto, roman, fraktur},
    default = auto,
  },
  eqn-paren-style = {
    name = eqn@paren@style,
    choices = {full, half},
    default = full,
  },
  % 默认保留当前的普通脚注行为，另提供清华式按页编号和带圈脚注。
  footnote-numbering = {
    name = footnote@numbering,
    choices = {chapter, page, global},
    default = chapter,
  },
  footnote-style = {
    name = footnote@style,
    choices = {plain, circled},
    default = plain,
  },
}
\DeclareDefaultOption{%
  \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
\ProcessKeyvalOptions*

\edef\gzu@math@style@classoption{math-style=\gzu@math@style}
\@expandtwoargs\@removeelement
  {\gzu@math@style@classoption}{\@classoptionslist}\@classoptionslist

\LoadClass[
  a4paper,
  UTF8,
  zihao=-4,
  scheme=plain,
  fontset=none,
  twoside
]{ctexbook}
\@openrighttrue
\RequirePackage{geometry}

\geometry{
  paper      = a4paper,
  top        = 3cm,
  bottom     = 2.5cm,
  left       = 2.5cm,
  right      = 2.5cm,
  marginparwidth = 2cm,
  marginparsep   = 0.5cm,
  headheight = 0.5cm,
  headsep    = 0.3cm,
  footskip   = 0.75cm,
}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}

\newcommand\gzu@font@require[1]{%
  \IfFontExistsTF{#1}{}{%
    \ClassError{gzuthesis}{Required font `#1' not found}%
      {Install the requested font or select a file-based font scheme.}%
  }%
}
\newcommand\gzu@font@require@file[1]{%
  \IfFileExists{\gzu@windows@font@dir/#1}{}{%
    \ClassError{gzuthesis}{Required font file `#1' not found}%
      {Check windows-font-dir and the installed font file names.}%
  }%
}

\def\gzu@value@windows@local{windows-local}
\def\gzu@value@times@local{times-local}
\newcommand\gzu@resolve@font{%
  \ifgzu@font@auto
    \ifgzu@fontset@none
      \gzu@set@key{font}{none}%
    \else\ifgzu@fontset@ubuntu
      \gzu@set@key{font}{termes}%
    \else\ifgzu@fontset@fandol
      \gzu@set@key{font}{termes}%
    \else
      \ifx\gzu@fontset\gzu@value@windows@local
        \gzu@set@key{font}{times-local}%
      \else
        \IfFontExistsTF{Times New Roman}{%
          \gzu@set@key{font}{times}%
        }{%
          \IfFileExists{\gzu@windows@font@dir/times.ttf}{%
            \gzu@set@key{font}{times-local}%
          }{%
            \ClassError{gzuthesis}{Cannot find Times New Roman}%
              {Install Times New Roman or set windows-font-dir.}%
          }%
        }%
      \fi
    \fi\fi\fi
  \fi
}
\newcommand\gzu@resolve@cjk@font{%
  \ifgzu@cjk@font@auto
    \ifgzu@fontset@none
      \gzu@set@key{cjk-font}{none}%
    \else\ifgzu@fontset@mac
      \gzu@set@key{cjk-font}{mac}%
    \else\ifgzu@fontset@ubuntu
      \gzu@set@key{cjk-font}{noto}%
    \else\ifgzu@fontset@fandol
      \gzu@set@key{cjk-font}{fandol}%
    \else
      \ifx\gzu@fontset\gzu@value@windows@local
        \gzu@set@key{cjk-font}{windows-local}%
      \else
        \IfFontExistsTF{SimSun}{%
          \gzu@set@key{cjk-font}{windows}%
        }{%
          \IfFileExists{\gzu@windows@font@dir/simsun.ttc}{%
            \gzu@set@key{cjk-font}{windows-local}%
          }{%
            \IfFileExists{\gzu@windows@font@dir/Simsun.ttc}{%
              \gzu@set@key{cjk-font}{windows-local}%
            }{%
              \ClassError{gzuthesis}{Cannot find SimSun}%
                {Install Windows CJK fonts or set windows-font-dir.}%
            }%
          }%
        }%
      \fi
    \fi\fi\fi\fi
  \fi
}
\gzu@resolve@font
\gzu@resolve@cjk@font
\newcommand\gzu@set@font@times{%
  \gzu@font@require{Times New Roman}%
  \gzu@font@require{Arial}%
  \gzu@font@require{Courier New}%
  \setmainfont{Times New Roman}%
  \setsansfont{Arial}%
  \setmonofont{Courier New}[Scale=MatchLowercase]%
}
\@namedef{gzu@set@font@times-local}{%
  \@for\gzu@font@file:=times.ttf,timesbd.ttf,timesi.ttf,timesbi.ttf,%
    arial.ttf,arialbd.ttf,ariali.ttf,arialbi.ttf,%
    cour.ttf,courbd.ttf,couri.ttf,courbi.ttf\do{%
    \expandafter\gzu@font@require@file\expandafter{\gzu@font@file}%
  }%
  \setmainfont{times.ttf}[
    Path=\gzu@windows@font@dir/,
    BoldFont=timesbd.ttf,
    ItalicFont=timesi.ttf,
    BoldItalicFont=timesbi.ttf,
  ]%
  \setsansfont{arial.ttf}[
    Path=\gzu@windows@font@dir/,
    BoldFont=arialbd.ttf,
    ItalicFont=ariali.ttf,
    BoldItalicFont=arialbi.ttf,
  ]%
  \setmonofont{cour.ttf}[
    Path=\gzu@windows@font@dir/,
    BoldFont=courbd.ttf,
    ItalicFont=couri.ttf,
    BoldItalicFont=courbi.ttf,
    Scale=MatchLowercase,
  ]%
}
\newcommand\gzu@set@texgyre@sans@mono{%
  \setsansfont{texgyreheros}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic,
  ]%
  \setmonofont{texgyrecursor}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic,
    Scale=MatchLowercase,Ligatures=CommonOff,
  ]%
}
\newcommand\gzu@set@font@termes{%
  \setmainfont{texgyretermes}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic,
  ]%
  \gzu@set@texgyre@sans@mono
}
\newcommand\gzu@set@windows@sans@mono{%
  \gzu@font@require{Arial}%
  \gzu@font@require{Courier New}%
  \setsansfont{Arial}%
  \setmonofont{Courier New}[Scale=MatchLowercase]%
}
\newcommand\gzu@set@font@stix{%
  \setmainfont{STIXTwoText}[
    Extension=.otf,UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic,
  ]%
  \gzu@set@windows@sans@mono
}
\newcommand\gzu@set@font@xits{%
  \setmainfont{XITS}[
    Extension=.otf,UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic,
  ]%
  \gzu@set@windows@sans@mono
}
\newcommand\gzu@set@font@libertinus{%
  \setmainfont{LibertinusSerif}[
    Extension=.otf,UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic,
  ]%
  \setsansfont{LibertinusSans}[
    Extension=.otf,UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,
  ]%
  \setmonofont{lmmonolt10}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-oblique,BoldItalicFont=*-boldoblique,
  ]%
}
\newcommand\gzu@set@font@newcm{%
  \setmainfont{NewCM10}[
    Extension=.otf,UprightFont=*-Book,BoldFont=*-Bold,
    ItalicFont=*-BookItalic,BoldItalicFont=*-BoldItalic,
  ]%
  \setsansfont{NewCMSans10}[
    Extension=.otf,UprightFont=*-Book,BoldFont=*-Bold,
    ItalicFont=*-BookOblique,BoldItalicFont=*-BoldOblique,
  ]%
  \setmonofont{NewCMMono10}[
    Extension=.otf,UprightFont=*-Book,BoldFont=*-Bold,
    ItalicFont=*-BookItalic,BoldItalicFont=*-BoldOblique,
  ]%
}
\newcommand\gzu@set@font@lm{%
  \setmainfont{lmroman10}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic,
  ]%
  \setsansfont{lmsans10}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-oblique,BoldItalicFont=*-boldoblique,
  ]%
  \setmonofont{lmmonolt10}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-oblique,BoldItalicFont=*-boldoblique,
  ]%
}
\newcommand\gzu@set@font@none{}
\newcommand\gzu@set@font{\@nameuse{gzu@set@font@\gzu@font}}
\gzu@set@font
\newcommand\gzu@set@cjk@font@windows{%
  \gzu@font@require{SimSun}%
  \gzu@font@require{SimHei}%
  \gzu@font@require{KaiTi}%
  \gzu@font@require{FangSong}%
  \setCJKmainfont{SimSun}[AutoFakeBold=3,ItalicFont=KaiTi]%
  \setCJKsansfont{SimHei}[AutoFakeBold=3]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold=3]%
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold=3]%
  \setCJKfamilyfont{zhkai}{KaiTi}%
  \setCJKfamilyfont{zhfs}{FangSong}%
}
\newcommand\gzu@set@windows@local@names{%
  \IfFileExists{\gzu@windows@font@dir/simsun.ttc}{%
    \def\gzu@local@simsun{simsun.ttc}%
  }{%
    \def\gzu@local@simsun{Simsun.ttc}%
  }%
  \expandafter\gzu@font@require@file\expandafter{\gzu@local@simsun}%
  \IfFileExists{\gzu@windows@font@dir/simhei.ttf}{%
    \def\gzu@local@simhei{simhei.ttf}%
  }{%
    \def\gzu@local@simhei{SimHei.ttf}%
  }%
  \expandafter\gzu@font@require@file\expandafter{\gzu@local@simhei}%
  \IfFileExists{\gzu@windows@font@dir/Kaiti.ttf}{%
    \def\gzu@local@simkai{Kaiti.ttf}%
  }{%
    \def\gzu@local@simkai{simkai.ttf}%
  }%
  \expandafter\gzu@font@require@file\expandafter{\gzu@local@simkai}%
  \IfFileExists{\gzu@windows@font@dir/Fangsong.ttf}{%
    \def\gzu@local@simfang{Fangsong.ttf}%
  }{%
    \def\gzu@local@simfang{simfang.ttf}%
  }%
  \expandafter\gzu@font@require@file\expandafter{\gzu@local@simfang}%
}
\@namedef{gzu@set@cjk@font@windows-local}{%
  \gzu@set@windows@local@names
  \setCJKmainfont{\gzu@local@simsun}[
    Path=\gzu@windows@font@dir/,
    AutoFakeBold=3,
    ItalicFont=\gzu@local@simkai,
    ItalicFeatures={Path=\gzu@windows@font@dir/},
  ]%
  \setCJKsansfont{\gzu@local@simhei}[
    Path=\gzu@windows@font@dir/,AutoFakeBold=3,
  ]%
  \setCJKmonofont{\gzu@local@simfang}[
    Path=\gzu@windows@font@dir/,
  ]%
  \setCJKfamilyfont{zhsong}{\gzu@local@simsun}[
    Path=\gzu@windows@font@dir/,AutoFakeBold=3,
  ]%
  \setCJKfamilyfont{zhhei}{\gzu@local@simhei}[
    Path=\gzu@windows@font@dir/,AutoFakeBold=3,
  ]%
  \setCJKfamilyfont{zhkai}{\gzu@local@simkai}[
    Path=\gzu@windows@font@dir/,
  ]%
  \setCJKfamilyfont{zhfs}{\gzu@local@simfang}[
    Path=\gzu@windows@font@dir/,
  ]%
}
\@namedef{gzu@set@cjk@font@mac-word}{%
  \@nameuse{gzu@set@cjk@font@windows-local}%
}
\newcommand\gzu@set@cjk@font@mac{%
  \gzu@font@require{Songti SC}%
  \gzu@font@require{Heiti SC}%
  \gzu@font@require{Kaiti SC}%
  \gzu@font@require{STFangsong}%
  \setCJKmainfont{Songti SC}[
    UprightFont=* Light,BoldFont=* Bold,
    ItalicFont=Kaiti SC Regular,BoldItalicFont=Kaiti SC Bold,
  ]%
  \setCJKsansfont{Heiti SC}[
    UprightFont=* Light,BoldFont=* Medium,
  ]%
  \setCJKmonofont{STFangsong}%
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont=* Light,BoldFont=* Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont=* Light,BoldFont=* Medium,
  ]%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[
    UprightFont=* Regular,BoldFont=* Bold,
  ]%
  \setCJKfamilyfont{zhfs}{STFangsong}%
}
\newcommand\gzu@set@cjk@font@noto{%
  \gzu@font@require{Noto Serif CJK SC}%
  \gzu@font@require{Noto Sans CJK SC}%
  \setCJKmainfont{Noto Serif CJK SC}[
    UprightFont=* Light,BoldFont=* Bold,Script=CJK,
  ]%
  \setCJKsansfont{Noto Sans CJK SC}[
    BoldFont=* Medium,Script=CJK,
  ]%
  \setCJKmonofont{Noto Sans CJK SC}[Script=CJK]%
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
    UprightFont=* Light,BoldFont=* Bold,Script=CJK,
  ]%
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
    BoldFont=* Medium,Script=CJK,
  ]%
  % 楷体、仿宋字体需分别安装。用户显式选择了 noto 才使用本方案。
  \setCJKfamilyfont{zhkai}{FandolKai-Regular.otf}%
  \setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}%
}
\newcommand\gzu@set@cjk@font@fandol{%
  \setCJKmainfont{FandolSong}[
    Extension=.otf,UprightFont=*-Regular,
    BoldFont=*-Bold,ItalicFont=FandolKai-Regular,
    ItalicFeatures={Extension=.otf},
  ]%
  \setCJKsansfont{FandolHei}[
    Extension=.otf,UprightFont=*-Regular,BoldFont=*-Bold,
  ]%
  \setCJKmonofont{FandolFang}[
    Extension=.otf,UprightFont=*-Regular,
  ]%
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension=.otf,UprightFont=*-Regular,BoldFont=*-Bold,
  ]%
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension=.otf,UprightFont=*-Regular,BoldFont=*-Bold,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension=.otf,UprightFont=*-Regular,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension=.otf,UprightFont=*-Regular,
  ]%
}
\newcommand\gzu@set@cjk@font@none{}
\newcommand\gzu@set@cjk@font{\@nameuse{gzu@set@cjk@font@\gzu@cjk@font}}
\gzu@set@cjk@font
\ifgzu@cjk@font@none\else
  \providecommand\songti{\CJKfamily{zhsong}}
  \providecommand\heiti{\CJKfamily{zhhei}}
  \providecommand\kaishu{\CJKfamily{zhkai}}
  \providecommand\fangsong{\CJKfamily{zhfs}}
\fi
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip 6bp%
  \abovedisplayshortskip 6bp%
  \belowdisplayshortskip 6bp%
  \belowdisplayskip \abovedisplayskip
}
\normalsize
\ifx\MakeRobust\@undefined\else\MakeRobust\normalsize\fi

\def\gzu@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}%
}
\gzu@def@fontsize{chuhao}{42bp}
\gzu@def@fontsize{xiaochu}{36bp}
\gzu@def@fontsize{yihao}{26bp}
\gzu@def@fontsize{xiaoyi}{24bp}
\gzu@def@fontsize{erhao}{22bp}
\gzu@def@fontsize{xiaoer}{18bp}
\gzu@def@fontsize{sanhao}{16bp}
\gzu@def@fontsize{xiaosan}{15bp}
\gzu@def@fontsize{sihao}{14bp}
\gzu@def@fontsize{xiaosi}{12bp}
\gzu@def@fontsize{wuhao}{10.5bp}
\gzu@def@fontsize{xiaowu}{9bp}
\gzu@def@fontsize{liuhao}{7.5bp}
\gzu@def@fontsize{xiaoliu}{6.5bp}
\gzu@def@fontsize{qihao}{5.5bp}
\gzu@def@fontsize{bahao}{5bp}
\ctexset{
  punct      = quanjiao,
  autoindent = 2,
}
\RequirePackage{enumitem}
\setlist{nosep}
\RequirePackage{xurl}
\urlstyle{same}
\Urlmuskip=0mu plus 0.1mu
\interfootnotelinepenalty=10000

\ifgzu@footnote@numbering@page
  \PassOptionsToPackage{perpage}{footmisc}%
\fi
\RequirePackage[hang]{footmisc}
\ifgzu@footnote@numbering@global
  \@removefromreset{footnote}{chapter}%
\fi
\newcommand\gzu@circled[1]{%
  \ifnum#1>10\relax
    \ClassWarningNoLine{gzuthesis}{More than ten circled footnotes on a page}%
  \fi
  \textcircled{#1}%
}
\ifgzu@footnote@style@circled
  \renewcommand\thefootnote{\gzu@circled{\arabic{footnote}}}%
  \renewcommand\thempfootnote{\gzu@circled{\arabic{mpfootnote}}}%
\fi
\def\footnoterule{%
  \vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@
}
\footnotemargin=13.5bp
\long\def\@makefntext#1{%
  \begingroup
    \def\@makefnmark{\hbox{\normalfont\@thefnmark}}%
    \xiaowu
    \ifFN@hangfoot
      \bgroup
      \setbox\@tempboxa\hbox{%
        \ifdim\footnotemargin>\z@
          \hb@xt@\footnotemargin{\@makefnmark\hss}%
        \else
          \@makefnmark
        \fi
      }%
      \leftmargin\wd\@tempboxa
      \rightmargin\z@
      \linewidth\columnwidth
      \advance\linewidth-\leftmargin
      \parshape\@ne\leftmargin\linewidth
      \xiaowu
      \@setpar{{\@@par}}%
      \leavevmode
      \llap{\box\@tempboxa}%
      \parskip\hangfootparskip\relax
      \parindent\hangfootparindent\relax
    \else
      \parindent1em\noindent
      \hb@xt@\footnotemargin{\hss\@makefnmark}%
    \fi
    \footnotelayout#1%
    \ifFN@hangfoot
      \par\egroup
    \fi
  \endgroup
}
\ctexset{
  chapter = {
    name         = {第,章},
    number       = \thechapter,
    format       = \centering\sffamily
                   \fontsize{16bp}{20.8bp}\selectfont,
    nameformat   = {},
    numberformat = {},
    titleformat  = {},
    aftername    = \quad,
    beforeskip   = 27bp,
    afterskip    = 27bp,
    fixskip      = true,
    afterindent  = true,
  },
  section = {
    format       = \sffamily
                   \fontsize{14bp}{20bp}\selectfont,
    aftername    = \quad,
    beforeskip   = 24bp,
    afterskip    = 6bp,
    afterindent  = true,
  },
  subsection = {
    format       = \sffamily
                   \fontsize{13bp}{20bp}\selectfont,
    aftername    = \quad,
    beforeskip   = 12bp,
    afterskip    = 6bp,
    afterindent  = true,
  },
  subsubsection = {
    format       = \sffamily
                   \fontsize{12bp}{20bp}\selectfont,
    aftername    = \quad,
    beforeskip   = 12bp,
    afterskip    = 6bp,
    afterindent  = true,
  },
}
\setcounter{secnumdepth}{3}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand\headrulewidth{0.75bp}%
  \renewcommand\footrulewidth{0pt}%
  \fancyhead[CO]{%
    \songti
    \fontsize{10.5bp}{12.1bp}\selectfont
    \nouppercase{\leftmark}%
  }%
  \fancyhead[CE]{%
    \songti
    \fontsize{10.5bp}{12.1bp}\selectfont
    \ifgzu@degree@doctor
      贵州大学博士学位论文%
    \else
      贵州大学硕士学位论文%
    \fi
  }%
  \fancyfoot[C]{%
    \rmfamily
    \fontsize{10.5bp}{12.1bp}\selectfont
    \thepage
  }%
  \let\@mkboth\markboth
  \def\chaptermark##1{%
    \markboth{%
      \CTEXifname{\CTEX@chaptername\CTEX@chapter@aftername}{}##1%
    }{}%
  }%
  \let\sectionmark\@gobble
}
\RequirePackage{etoolbox}
\patchcmd{\@chapter}{\chaptermark{#1}}{\chaptermark{#2}}{}{%
  \ClassWarningNoLine{gzuthesis}{Unable to synchronize full chapter title in header}%
}
\fancypagestyle{gzu-chapter-first}{%
  \fancyhf{}%
  \renewcommand\headrulewidth{0.75bp}%
  \renewcommand\footrulewidth{0pt}%
  \fancyhead[C]{%
    \songti
    \fontsize{10.5bp}{12.1bp}\selectfont
    \nouppercase{\leftmark}%
  }%
  \fancyfoot[C]{%
    \rmfamily
    \fontsize{10.5bp}{12.1bp}\selectfont
    \thepage
  }%
}
\pagestyle{plain}
\ctexset{
  chapter/pagestyle = gzu-chapter-first,
}

\renewcommand\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else
      \ifgzu@output@print
        \thispagestyle{empty}%
        \hbox{}%
        \newpage
        \if@twocolumn
          \hbox{}\newpage
        \fi
      \else
        \stepcounter{page}%
      \fi
    \fi
  \fi
}
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
}
\renewcommand\backmatter{%
  \clearpage
  \@mainmatterfalse
}
\newcommand\gzu@unnumbered@chapter[2]{%
  % 先切换到目标章节所在页面
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  % 在章节标题之前建立跳转锚点
  \@ifpackageloaded{hyperref}{\phantomsection}{}%
  % 记录目录和 PDF 书签
  \addcontentsline{toc}{chapter}{#2}%
  % 生成未编号章节标题
  \chapter*{#1}%
  % 页眉继承实际显示标题的全部间距；目录标题仍由 #2 独立控制
  \markboth{#1}{#1}%
}
\RequirePackage{titletoc}

\setcounter{tocdepth}{2}
\renewcommand\contentsname{目\quad 录}
\renewcommand\tableofcontents{%
  \chapter*{\contentsname}%
  \markboth{\contentsname}{\contentsname}%
  \begingroup
    \setlength{\parskip}{0pt}%
    \@starttoc{toc}%
  \endgroup
}
\contentsmargin{0pt}

\newcommand\gzu@toc@leaders{%
  \nobreak\titlerule*[4bp]{.}\nobreak
}
\titlecontents{chapter}
  [0pt]
  {\sffamily\fontsize{12bp}{20bp}\selectfont}
  {\contentspush{\thecontentslabel\quad}}
  {}
  {\rmfamily\gzu@toc@leaders\thecontentspage}
\titlecontents{section}
  [1em]
  {\rmfamily\fontsize{12bp}{20bp}\selectfont}
  {\contentspush{\thecontentslabel\quad}}
  {}
  {\gzu@toc@leaders\thecontentspage}
\titlecontents{subsection}
  [2em]
  {\rmfamily\fontsize{12bp}{20bp}\selectfont}
  {\contentspush{\thecontentslabel\quad}}
  {}
  {\gzu@toc@leaders\thecontentspage}
\PassOptionsToPackage{
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=2,
  bookmarksdepth=2,
  unicode=true,
  psdextra=true,
  breaklinks=true,
  plainpages=false,
  pdfpagelabels=true,
  pdfdisplaydoctitle=true,
  hidelinks,
}{hyperref}
\AddToHook{package/hyperref/after}{%
  \hypersetup{
    pdflang=zh-CN,
    pdfpagemode=UseOutlines,
  }%
  \pdfstringdefDisableCommands{%
    \let\\\relax
    \let\quad\relax
    \let\qquad\relax
    \let\hspace\@gobble
  }%
  \AddToHook{begindocument/before}{%
    \hypersetup{
      pdftitle={\gzu@title},
      pdfcreator={GZUThesis v\gzuversion},
    }%
    \ifgzu@thesis@version@blind
      \hypersetup{
        pdfauthor={},
        pdfsubject={},
        pdfkeywords={},
      }%
    \else
      \hypersetup{
        pdfauthor={\gzu@author},
        pdfsubject={\gzu@discipline},
        pdfkeywords={\gzu@keywords},
      }%
    \fi
  }%
}

\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{etoolbox}
\RequirePackage{bicaption}
\renewcommand\figurename{图}
\renewcommand\tablename{表}
\renewcommand\listfigurename{插图清单}
\renewcommand\listtablename{附表清单}

\newcommand\gzu@apply@float@numbering{%
  \ifgzu@figure@numbering@global
    \@removefromreset{figure}{chapter}%
  \fi
  \ifgzu@table@numbering@global
    \@removefromreset{table}{chapter}%
  \fi
}
\gzu@apply@float@numbering
\renewcommand\thefigure{%
  \ifgzu@figure@numbering@chapter
    \ifnum\c@chapter>\z@
      \thechapter\gzu@figure@separator
    \fi
  \fi
  \arabic{figure}%
}
\renewcommand\thetable{%
  \ifgzu@table@numbering@chapter
    \ifnum\c@chapter>\z@
      \thechapter\gzu@table@separator
    \fi
  \fi
  \arabic{table}%
}

\DeclareCaptionFont{gzu}{%
  \fontsize{11bp}{14.3bp}\selectfont
}

\captionsetup{
  font           = {gzu,rm},
  labelsep       = quad,
  justification  = centering,
  singlelinecheck = false,
  skip           = 6bp,
  figureposition = bottom,
  tableposition  = top,
}
\captionsetup{bi-swap=false}
\bicaptionsetup
  {font={gzu,rm}}
  {font={gzu,rm},list=off}
\bicaptionsetup[figure]{name=图}{name=Figure}
\bicaptionsetup[table]{name=表}{name=Table}
\newif\ifgzu@caption@bilingual

\newcommand\gzu@apply@caption@language{%
  \ifgzu@caption@language@auto
    \ifgzu@degree@doctor
      \gzu@caption@bilingualtrue
    \else
      \gzu@caption@bilingualfalse
    \fi
  \else
    \ifgzu@caption@language@bilingual
      \gzu@caption@bilingualtrue
    \else
      \gzu@caption@bilingualfalse
    \fi
  \fi
  \ifgzu@caption@bilingual
    \captionsetup{bi-lang=both}%
  \else
    \captionsetup{bi-lang=first}%
    \ifgzu@degree@doctor
      \ClassWarningNoLine{gzuthesis}{%
        Chinese-only captions selected for a doctoral thesis.
        Use auto or bilingual for bilingual captions}%
    \fi
  \fi
}
\gzu@apply@caption@language
\gzu@option@hook{caption-language}{\gzu@apply@caption@language}
\NewDocumentCommand\gzucaption{o m m}{%
  \ifgzu@caption@bilingual
    \ifblank{#3}{%
      \ClassError{gzuthesis}
        {An English caption is required in bilingual mode}%
        {Fill the second mandatory argument of
         \string\gzucaption.}%
    }{}%
    \IfNoValueTF{#1}
      {\bicaption{#2}{#3}}
      {\bicaption[#1]{#2}{#3}}%
  \else
    \IfNoValueTF{#1}
      {\caption{#2}}
      {\caption[#1]{#2}}%
  \fi
}
\captionsetup[sub]{font={gzu,rm}}
\renewcommand\thesubfigure{(\alph{subfigure})}
\renewcommand\thesubtable{(\alph{subtable})}
\newcommand\gzu@table@font{%
  \fontsize{11bp}{14.3bp}\selectfont
  \renewcommand\arraystretch{1.42}%
}

\AtBeginEnvironment{tabular}{\gzu@table@font}
\AtBeginEnvironment{tabular*}{\gzu@table@font}
\AtBeginEnvironment{longtable}{\gzu@table@font}
\setlength\heavyrulewidth{\gzu@table@rule@width}
\setlength\lightrulewidth{\gzu@table@midrule@width}
\setlength\cmidrulewidth{\gzu@table@cmidrule@width}

\gzu@option@hook{table-rule-width}{%
  \setlength\heavyrulewidth{\gzu@table@rule@width}%
}
\gzu@option@hook{table-midrule-width}{%
  \setlength\lightrulewidth{\gzu@table@midrule@width}%
}
\gzu@option@hook{table-cmidrule-width}{%
  \setlength\cmidrulewidth{\gzu@table@cmidrule@width}%
}
\def\fps@figure{htbp}
\def\fps@table{htbp}
\setlength\floatsep{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\intextsep{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\@fptop{0bp \@plus 1.0fil}
\setlength\@fpsep{12bp \@plus 2.0fil}
\setlength\@fpbot{0bp \@plus 1.0fil}
\renewcommand\textfraction{0.15}
\renewcommand\topfraction{0.85}
\renewcommand\bottomfraction{0.65}
\renewcommand\floatpagefraction{0.60}
\renewcommand\listoffigures{%
  \gzu@unnumbered@chapter
    {\listfigurename}{\listfigurename}%
  \@starttoc{lof}%
}
\renewcommand\listoftables{%
  \gzu@unnumbered@chapter
    {\listtablename}{\listtablename}%
  \@starttoc{lot}%
}
\newcommand\gzu@list@leaders{%
  \nobreak\titlerule*[4bp]{.}\nobreak
}

\titlecontents{figure}
  [0pt]
  {\fontsize{12bp}{20bp}\selectfont}
  {\contentspush{\figurename~\thecontentslabel\quad}}
  {}
  {\gzu@list@leaders\thecontentspage}

\titlecontents{table}
  [0pt]
  {\fontsize{12bp}{20bp}\selectfont}
  {\contentspush{\tablename~\thecontentslabel\quad}}
  {}
  {\gzu@list@leaders\thecontentspage}

\RequirePackage{amsmath}

\newif\ifgzu@math@initialised
\newif\ifgzu@math@managed
\newif\ifgzu@math@realbold
\newif\ifgzu@math@boldwarned
\newcommand\gzu@math@keys{math-font,math-style,uppercase-greek,%
  less-than-or-equal,integral,integral-limits,partial,math-ellipsis,real-part}

\newcommand\gzu@math@default[2]{%
  \@nameuse{ifgzu@\@nameuse{gzu@#1@@name}@auto}%
    \gzu@set@key{#1}{#2}%
  \fi
}
\newcommand\gzu@math@preset@GB{%
  \gzu@math@default{uppercase-greek}{italic}%
  \gzu@math@default{less-than-or-equal}{slanted}%
  \gzu@math@default{integral}{upright}%
  \gzu@math@default{integral-limits}{false}%
  \gzu@math@default{partial}{upright}%
  \gzu@math@default{math-ellipsis}{centered}%
  \gzu@math@default{real-part}{roman}%
}
\newcommand\gzu@math@preset@ISO{%
  \gzu@math@default{uppercase-greek}{italic}%
  \gzu@math@default{less-than-or-equal}{horizontal}%
  \gzu@math@default{integral}{upright}%
  \gzu@math@default{integral-limits}{true}%
  \gzu@math@default{partial}{upright}%
  \gzu@math@default{math-ellipsis}{lower}%
  \gzu@math@default{real-part}{roman}%
}
\newcommand\gzu@math@preset@TeX{%
  \gzu@math@default{uppercase-greek}{upright}%
  \gzu@math@default{less-than-or-equal}{horizontal}%
  \gzu@math@default{integral}{slanted}%
  \gzu@math@default{integral-limits}{false}%
  \gzu@math@default{partial}{italic}%
  \gzu@math@default{math-ellipsis}{AMS}%
  \gzu@math@default{real-part}{fraktur}%
}

\newcommand\gzu@math@check@package[1]{%
  \@ifpackageloaded{#1}{%
    \ClassError{gzuthesis}{Package `#1' is not supported in managed Unicode math}%
      {Remove #1 and use unicode-math commands, or set math-font=none\MessageBreak
       and configure the entire math stack yourself before begin(document).}%
  }{}%
}
\newcommand\gzu@math@check@packages{%
  \@for\gzu@math@package:=amsfonts,amssymb,bm,mathrsfs,mathspec,%
    newtxmath,txfonts,pxfonts,mathptmx,mathpazo,eulervm\do{%
    \expandafter\gzu@math@check@package\expandafter{\gzu@math@package}%
  }%
}

\newcommand\gzu@math@setup@style{%
  \ifgzu@uppercase@greek@upright
    \unimathsetup{math-style=TeX}%
  \else
    \unimathsetup{math-style=ISO}%
  \fi
  \ifgzu@math@style@TeX
    \unimathsetup{bold-style=TeX}%
  \else
    \unimathsetup{bold-style=ISO}%
  \fi
  \ifgzu@partial@upright
    \unimathsetup{partial=upright}%
  \else
    \unimathsetup{partial=italic}%
  \fi
}

\newcommand\gzu@math@require@font[1]{%
  \IfFontExistsTF{#1}{}{%
    \ClassError{gzuthesis}{Math font `#1' was not found}%
      {Install the corresponding TeX Live font package, or select\MessageBreak
       an installed math-font. The template does not download fonts.}%
  }%
}
\newcommand\gzu@math@load@font[3]{%
  \gzu@math@require@font{#1}%
  \gzu@math@require@font{#2}%
  \setmathfont{#1}[BoldFont={#2},StylisticSet={#3}]%
}
\newcommand\gzu@math@load@range[4]{%
  % Each range creates another font family; it needs its own BoldFont mapping.
  \setmathfont{#1}[BoldFont={#2},StylisticSet={#3},range={#4}]%
}
\newcommand\gzu@math@font@xits{%
  \gzu@math@realboldtrue
  \def\gzu@math@ss{}%
  \ifgzu@integral@upright\def\gzu@math@ss{8}\fi
  \gzu@math@load@font{XITSMath-Regular.otf}{XITSMath-Bold.otf}{\gzu@math@ss}%
  \gzu@math@load@range{XITSMath-Regular.otf}{XITSMath-Bold.otf}{1}{cal,bfcal}%
}
\newcommand\gzu@math@font@stix{%
  \def\gzu@math@ss{}%
  \ifgzu@integral@upright\def\gzu@math@ss{8}\fi
  \gzu@math@load@font{STIXTwoMath-Regular.otf}{STIXTwoMath-Regular.otf}{\gzu@math@ss}%
  \gzu@math@load@range{STIXTwoMath-Regular.otf}{STIXTwoMath-Regular.otf}{1}{scr,bfscr}%
}
\newcommand\gzu@math@font@libertinus{%
  \def\gzu@math@ss{}%
  \ifgzu@integral@slanted\def\gzu@math@ss{8}\fi
  \gzu@math@load@font{LibertinusMath-Regular.otf}{LibertinusMath-Regular.otf}{\gzu@math@ss}%
}
\newcommand\gzu@math@font@newcm{%
  \def\gzu@math@ss{}%
  \ifgzu@integral@upright\def\gzu@math@ss{2}\fi
  \gzu@math@load@font{NewCMMath-Book.otf}{NewCMMath-Book.otf}{\gzu@math@ss}%
  \gzu@math@load@range{NewCMMath-Book.otf}{NewCMMath-Book.otf}{1}{scr,bfscr}%
}
\newcommand\gzu@math@font@lm{%
  \ifgzu@integral@upright
    \ClassWarningNoLine{gzuthesis}{Latin Modern Math has no upright-integral\MessageBreak
      preset here; retaining its native integral shape.\MessageBreak
      Select xits, stix, libertinus or newcm for upright integrals}%
  \fi
  \gzu@math@load@font{latinmodern-math.otf}{latinmodern-math.otf}{}%
}

\newcommand\gzu@math@warn@bold{%
  \ifgzu@math@realbold\else
    \ifgzu@math@boldwarned\else
      \global\gzu@math@boldwarnedtrue
      \ClassWarningNoLine{gzuthesis}{Math font `\gzu@math@font' has no separate\MessageBreak
        bold face configured. Bold letters are available, but operators\MessageBreak
        and delimiters retain their native weight. Use symbfup/symbfit\MessageBreak
        for bold letters, or math-font=xits for a bold whole formula}%
    \fi
  \fi
}
\newcommand\gzu@math@setup@compat{%
  \NewCommandCopy\gzu@math@original@boldsymbol\boldsymbol
  \DeclareRobustCommand\boldsymbol[1]{%
    \gzu@math@warn@bold
    \gzu@math@original@boldsymbol{##1}}%
  % Compatibility for the common \bm{...} call, NOT the full bm package API.
  \DeclareRobustCommand\bm[1]{\boldsymbol{##1}}%
  \AddToHook{cmd/boldmath/before}[gzuthesis/math]{\gzu@math@warn@bold}%
  \providecommand\square{\mdlgwhtsquare}%
  \providecommand\blacksquare{\mdlgblksquare}%
}

\newcommand\gzu@math@setup@symbols{%
  \ifgzu@leq@slanted
    \let\le\leqslant \let\leq\leqslant
    \let\ge\geqslant \let\geq\geqslant
  \fi
  \ifgzu@integral@limits@true
    \removenolimits{\int\iint\iiint\iiiint\oint\oiint\oiiint}%
  \else
    \addnolimits{\int\iint\iiint\iiiint\oint\oiint\oiiint}%
  \fi
  \ifgzu@math@ellipsis@centered
    \def\mathellipsis{\mathinner{\unicodecdots}}%
  \else\ifgzu@math@ellipsis@lower
    \def\mathellipsis{\mathinner{\unicodeellipsis}}%
  \fi\fi
  \ifgzu@real@part@roman
    \def\Re{\operatorname{Re}}%
    \def\Im{\operatorname{Im}}%
  \fi
  \gzu@math@setup@compat
}

\newcommand\gzu@math@locked[2]{%
  \ClassError{gzuthesis}{Math option `#1' cannot be changed after initialisation}%
    {Put all math options in documentclass or gzusetup in the preamble.}%
}
\newcommand\gzu@math@lock@key[1]{%
  \@namedef{gzu@#1@@guard}{\gzu@math@locked{#1}}%
}
\newcommand\gzu@math@initialise{%
  \ifgzu@math@initialised\else
    \gzu@math@initialisedtrue
    \ifgzu@math@font@none
      % A real opt-out: no Unicode package, no font or symbol overrides.
      \ClassInfo{gzuthesis}{Math fonts and styles are user-managed (math-font=none)}%
    \else
      \gzu@math@managedtrue
      \gzu@math@default{math-font}{xits}%
      \@nameuse{gzu@math@preset@\gzu@math@style}%
      \gzu@math@check@packages
      \RequirePackage{unicode-math}%
      \gzu@math@setup@style
      \@nameuse{gzu@math@font@\gzu@math@font}%
      % Text math alphabets inherit fontspec's existing text font families.
      % Do not duplicate the Times/Windows/local-path selection here.
      \ClassInfo{gzuthesis}{Math font=\gzu@math@font, style=\gzu@math@style}%
    \fi
    \@for\gzu@math@key:=\gzu@math@keys\do{%
      \expandafter\gzu@math@lock@key\expandafter{\gzu@math@key}%
    }%
  \fi
}
\AddToHook{begindocument/before}[gzuthesis/math]{\gzu@math@initialise}
\AddToHook{begindocument/end}[gzuthesis/math]{%
  \ifgzu@math@managed\gzu@math@setup@symbols\fi
}
\ifgzu@equation@numbering@global
  \@removefromreset{equation}{chapter}%
\fi
\renewcommand\theequation{%
  \ifgzu@equation@numbering@chapter
    \ifnum\c@chapter>\z@
      \thechapter\gzu@equation@separator
    \fi
  \fi
  \arabic{equation}%
}
\newcommand\gzu@set@number@separator{%
  \let\gzu@figure@separator\gzu@number@separator
  \let\gzu@table@separator\gzu@number@separator
  \let\gzu@equation@separator\gzu@number@separator
}
\gzu@option@hook{number-separator}{\gzu@set@number@separator}
\def\gzu@default@separator{.}
\ifx\gzu@number@separator\gzu@default@separator\else
  \gzu@set@number@separator
\fi

\newcommand\gzu@put@parentheses[1]{%
  \ifgzu@eqn@paren@style@full
    \kern0pt（#1）%
  \else
    (#1)%
  \fi
}
\def\tagform@#1{%
  \maketag@@@{\gzu@put@parentheses{\ignorespaces#1\unskip\@@italiccorr}}%
}
\renewcommand\eqref[1]{%
  \ifgzu@eqn@paren@style@full\unskip\fi
  \textup{\tagform@{\ref{#1}}}%
  \ifgzu@eqn@paren@style@full\ignorespaces\fi
}
\allowdisplaybreaks[4]
\RequirePackage{amsthm}
\newcommand\gzu@theorem@separator{：}

\newtheoremstyle{gzu}
  {0pt}
  {0pt}
  {\normalfont}
  {0pt}
  {\normalfont\sffamily}
  {\gzu@theorem@separator}
  {0.5em}
  {}

\theoremstyle{gzu}
\newtheorem{assumption}{假设}[chapter]
\newtheorem{definition}{定义}[chapter]
\newtheorem{proposition}{命题}[chapter]
\newtheorem{lemma}{引理}[chapter]
\newtheorem{theorem}{定理}[chapter]
\newtheorem{axiom}{公理}[chapter]
\newtheorem{corollary}{推论}[chapter]
\newtheorem{exercise}{练习}[chapter]
\newtheorem{example}{例}[chapter]
\newtheorem{remark}{注释}[chapter]
\newtheorem{problem}{问题}[chapter]
\newtheorem{conjecture}{猜想}[chapter]
\renewenvironment{proof}[1][证明]{%
  \par
  \pushQED{\qed}%
  \normalfont
  \topsep0pt\relax
  \trivlist
  \item[\hskip\labelsep\sffamily #1]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
\renewcommand\qedsymbol{%
  \ifdefined\QED\ensuremath{\QED}\else\openbox\fi
}
\RequirePackage{notoccite}
\RequirePackage{url}
\RequirePackage{etoolbox}

\renewcommand\bibname{\gzu@bib@title}

\newif\ifgzu@in@appendix
\gzu@in@appendixfalse

\g@addto@macro\appendix{%
  \gzu@in@appendixtrue
}
\g@addto@macro\backmatter{%
  \gzu@in@appendixfalse
}

\newcommand\gzu@bib@font{%
  \gzu@bib@font@family
  \fontsize
    {\gzu@bib@font@size}
    {\gzu@bib@line@height}\selectfont
  \interlinepenalty=10000\relax
  \clubpenalty=10000\relax
  \widowpenalty=10000\relax
}

\newcommand\gzu@bib@section@heading[1]{%
  \clearpage
  \@ifpackageloaded{hyperref}{\phantomsection}{}%
  \addcontentsline{toc}{section}{#1}%
  \begingroup
    \ctexset{section/format={\gzu@bib@title@format}}%
    \section*{#1}%
  \endgroup
  \markboth{#1}{#1}%
}

\newcommand\gzu@bib@chapter@heading[1]{%
  \begingroup
    \ctexset{chapter/format={\gzu@bib@title@format}}%
    \gzu@unnumbered@chapter{#1}{#1}%
  \endgroup
}

\newcommand\gzu@bib@apply@pagestyle{%
  \ifgzu@bib@page@style@empty
    \thispagestyle{empty}%
  \else
    \ifgzu@in@appendix
      \ifgzu@bib@appendix@heading@level@chapter
        \thispagestyle{gzu-chapter-first}%
      \else
        \thispagestyle{plain}%
      \fi
    \else
      \ifgzu@bib@heading@level@chapter
        \thispagestyle{gzu-chapter-first}%
      \else
        \thispagestyle{plain}%
      \fi
    \fi
  \fi
}

\newcommand\gzu@bib@heading[1]{%
  \ifgzu@in@appendix
    \gzu@bib@appendix@heading{#1}%
  \else
    \ifgzu@bib@heading@level@chapter
      \gzu@bib@chapter@heading{#1}%
    \else\ifgzu@bib@heading@level@section
      \gzu@bib@section@heading{#1}%
    \fi\fi
  \fi
  \gzu@bib@apply@pagestyle
}

\newcommand\gzu@bib@appendix@heading[1]{%
  \ifgzu@bib@appendix@heading@level@chapter
    \gzu@bib@chapter@heading{#1}%
  \else\ifgzu@bib@appendix@heading@level@section
    \par
    \@ifpackageloaded{hyperref}{\phantomsection}{}%
    \addcontentsline{toc}{section}{#1}%
    \begingroup
      \ctexset{section/format={\gzu@bib@title@format}}%
      \section*{#1}%
    \endgroup
  \fi\fi
  \gzu@bib@apply@pagestyle
}


\def\gzu@bib@cite@super{super}
\def\gzu@bib@cite@inline{inline}
\def\gzu@bib@cite@author@year{author-year}

\newcommand\gzu@apply@cite@style{%
  \@ifpackageloaded{natbib}{%
    \ifx\gzu@cite@style\gzu@bib@cite@super
      \bibpunct{[}{]}{,}{s}{,}{,}%
    \else\ifx\gzu@cite@style\gzu@bib@cite@inline
      \bibpunct{[}{]}{,}{n}{,}{,}%
    \else\ifx\gzu@cite@style\gzu@bib@cite@author@year
      \bibpunct{(}{)}{;}{a}{,}{,}%
    \fi\fi\fi
  }{}%
}

\AddToHook{begindocument/end}{%
  \gzu@apply@cite@style
}

\AddToHook{package/gbt7714/after}{%
  \@ifundefined{gbtsetup}{}{%
    \gbtsetup{%
      maxbibnames=0,
      minbibnames=0
    }%
  }%
}

\AddToHook{package/natbib/after}{%
  \RequirePackage{bibunits}%
  \renewcommand\bibsection{%
    \gzu@bib@heading{\bibname}%
  }%
  \renewcommand\bibfont{\gzu@bib@font}%
}

\AddToHook{begindocument/end}{%
  \@ifpackageloaded{natbib}{%
    \providecommand\inlinecite[1]{%
      \begingroup
        \ifNAT@numbers
          \textup{[\citealp{#1}]}%
        \else
          \citep{#1}%
        \fi
      \endgroup
    }%
    \providecommand\onlinecite[1]{%
      \citet{#1}%
    }%
  }{}%
}

\newcommand\gzu@apply@bib@natbib{%
  \@ifpackageloaded{natbib}{%
    \renewcommand\bibfont{\gzu@bib@font}%
    \setlength\bibsep{\gzu@bib@item@sep}%
    \setlength\bibhang{\gzu@bib@hang}%
  }{}%
}

\newcommand\gzu@patch@bib@natbib{%
  \@ifpackageloaded{natbib}{%
    \@ifundefined{NAT@bibsetnum}{}{%
      \pretocmd\NAT@bibsetnum{%
        \setlength{\labelsep}{\gzu@bib@label@sep}%
      }{}{%
        \ClassWarningNoLine{gzuthesis}
          {Unable to patch natbib bibliography spacing}%
      }%
    }%
    \gzu@apply@bib@natbib
  }{}%
}
\AddToHook{package/biblatex/after}{%
  % 贵州大学参考文献表列出全部作者
  \ExecuteBibliographyOptions{maxbibnames=999,defernumbers=true}%

  % 正文参考文献标题
  \defbibheading{bibliography}[\bibname]{%
    \gzu@bib@heading{#1}%
  }%

  % 附录独立参考文献标题
  \defbibheading{gzuappendix}[\gzu@bib@appendix@title]{%
    \gzu@bib@appendix@heading{#1}%
  }%

  % 引用辅助命令
  \providecommand\inlinecite[1]{\parencite{#1}}%
  \providecommand\onlinecite[1]{\textcite{#1}}%

  % 参考文献字体
  \renewcommand\bibfont{\gzu@bib@font}%
}

\newcommand\gzu@apply@bib@biblatex{%
  \@ifpackageloaded{biblatex}{%
    \renewcommand\bibfont{\gzu@bib@font}%
    \setlength\bibitemsep{\gzu@bib@item@sep}%
    \setlength\bibhang{\gzu@bib@hang}%
    \setlength\biblabelsep{\gzu@bib@label@sep}%
  }{}%
}
\newcounter{gzu@appendix@bib@unit}
\newif\ifgzu@appendix@bib@printed

\newenvironment{gzuappendixrefs}{%
  % 必须在附录内部使用
  \ifgzu@in@appendix\else
    \ClassError{gzuthesis}
      {gzuappendixrefs outside appendix}
      {Use \string\appendix\space and
       \string\chapter\space before this environment.}%
  \fi

  \gzu@appendix@bib@printedfalse
  \stepcounter{gzu@appendix@bib@unit}%
  \edef\gzu@appendix@bib@namespace{%
    gzuappendix.\arabic{gzu@appendix@bib@unit}.}%

  \@ifpackageloaded{biblatex}{%
    % BibLaTeX 使用独立 refsection
    \begin{refsection}%
    \ifgzu@bib@appendix@prefix@true
      \begin{refcontext}[labelprefix=\thechapter.]%
    \fi
  }{%
    % 不覆盖 natbib/hyperref 的实现，只为当前 bibunit 隔离 key 与锚点。
    \@ifpackageloaded{bibunits}{%
      \let\@extra@binfo\gzu@appendix@bib@namespace
      \let\@extra@b@citeb\gzu@appendix@bib@namespace
      \begin{bibunit}[\gzu@bib@bst]%
      \edef\@bibunitname{%
        \jobname-appendix-\arabic{gzu@appendix@bib@unit}%
      }%
      \ifgzu@bib@appendix@prefix@true
        \def\citenumfont##1{\thechapter.##1}%
        \def\bibnumfmt##1{[\thechapter.##1]\hfill}%
      \fi
    }{%
      \ClassError{gzuthesis}
        {bibunits package required}
        {Load bibunits for BibTeX appendix references.}%
    }%
  }%
}{%
  \ifgzu@appendix@bib@printed\else
    \ClassWarningNoLine{gzuthesis}
      {Appendix bibliography not printed}%
  \fi

  \@ifpackageloaded{biblatex}{%
    \ifgzu@bib@appendix@prefix@true
      \end{refcontext}%
    \fi
    \end{refsection}%
  }{%
    \@ifpackageloaded{bibunits}{%
      \end{bibunit}%
    }{}%
  }%
}

\newcommand\gzuprintappendixbibliography[1]{%
  \gzu@appendix@bib@printedtrue

  \@ifpackageloaded{biblatex}{%
    \printbibliography[heading=gzuappendix]%
  }{%
    \@ifpackageloaded{bibunits}{%
      \begingroup
        \renewcommand\bibsection{%
          \gzu@bib@appendix@heading{%
            \gzu@bib@appendix@title
          }%
        }%
        \@ifpackageloaded{gbt7714}{%
          % 使附录的 bibunit 也读取国标 BST 控制记录
          \@startbibunitorrelax
          \if@filesw
            \immediate\write\@bibunitaux{%
              \string\citation{GBT7714:BSTcontrol}}%
          \fi
          \putbib[\jobname-BSTcontrol,#1]%
        }{%
          \putbib[#1]%
        }%
      \endgroup
    }{%
      \ClassError{gzuthesis}
        {bibunits package required}
        {Load bibunits for appendix bibliographies.}%
    }%
  }%
}

\AddToHook{begindocument/before}{%
  \@ifpackageloaded{biblatex}{%
    \@ifpackageloaded{natbib}{%
      \ClassError{gzuthesis}
        {biblatex and natbib cannot coexist}
        {Choose BibTeX or BibLaTeX, not both.}%
    }{}%
    \gzu@apply@bib@biblatex
  }{%
    \gzu@patch@bib@natbib
  }%
}
\RequirePackage{tikz}
\newif\ifgzu@cover@fonts@ready
\gzu@cover@fonts@readyfalse
\newcommand\gzu@init@cover@fonts{%
  \ifgzu@cover@fonts@ready\else
    % 宋体
    \IfFileExists{\gzu@windows@font@dir/simsun.ttc}{%
      \newCJKfontfamily\gzu@cover@song[
        Path=\gzu@windows@font@dir/,
      ]{simsun.ttc}%
    }{%
      \IfFileExists{\gzu@windows@font@dir/Simsun.ttc}{%
        \newCJKfontfamily\gzu@cover@song[
          Path=\gzu@windows@font@dir/,
        ]{Simsun.ttc}%
      }{%
        \gzu@font@require{SimSun}%
        \newCJKfontfamily\gzu@cover@song{SimSun}%
      }%
    }%
    % 黑体
    \IfFileExists{\gzu@windows@font@dir/simhei.ttf}{%
      \newCJKfontfamily\gzu@cover@hei[
        Path=\gzu@windows@font@dir/,
      ]{simhei.ttf}%
    }{%
      \gzu@font@require{SimHei}%
      \newCJKfontfamily\gzu@cover@hei{SimHei}%
    }%
    % 西文封面字体
    \IfFileExists{\gzu@windows@font@dir/times.ttf}{%
      \gzu@font@require@file{timesbd.ttf}%
      \gzu@font@require@file{timesi.ttf}%
      \gzu@font@require@file{timesbi.ttf}%
      \newfontfamily\gzu@cover@times[
        Path=\gzu@windows@font@dir/,
        BoldFont=timesbd.ttf,
        ItalicFont=timesi.ttf,
        BoldItalicFont=timesbi.ttf,
      ]{times.ttf}%
    }{%
      \gzu@font@require{Times New Roman}%
      \newfontfamily\gzu@cover@times{Times New Roman}%
    }%
    % 学校名专用华文行楷
    \IfFileExists{\gzu@windows@font@dir/STXINGKA.TTF}{%
      \newCJKfontfamily\gzu@cover@schoolfont[
        Path=\gzu@windows@font@dir/,
      ]{STXINGKA.TTF}%
    }{%
      \IfFileExists{\gzu@windows@font@dir/stxingka.ttf}{%
        \newCJKfontfamily\gzu@cover@schoolfont[
          Path=\gzu@windows@font@dir/,
        ]{stxingka.ttf}%
      }{%
        \gzu@font@require{STXingkai}%
        \newCJKfontfamily\gzu@cover@schoolfont{STXingkai}%
      }%
    }%
    \global\gzu@cover@fonts@readytrue
  \fi
}
\newlength\gzu@cover@left@labelwidth
\newlength\gzu@cover@left@tmpwidth

\newcommand\gzu@cover@measure@left{%
  % 测量中文标签
  \settowidth\gzu@cover@left@labelwidth{%
    {\gzu@cover@song\gzu@cover@times
     \fontsize{12bp}{16bp}\selectfont
     中图分类号}%
  }%

  % 测量 UDC 标签
  \settowidth\gzu@cover@left@tmpwidth{%
    {\gzu@cover@song\gzu@cover@times
     \fontsize{12bp}{16bp}\selectfont
     UDC分类号}%
  }%

  % 两个标签采用较大的宽度
  \ifdim\gzu@cover@left@tmpwidth>
         \gzu@cover@left@labelwidth
    \setlength\gzu@cover@left@labelwidth{%
      \gzu@cover@left@tmpwidth}%
  \fi
}
\newcommand\gzu@cover@top@row[4]{%
  \node[anchor=base west] at
    ([xshift=#1mm,yshift=-#2mm]current page.north west) {%
      \gzu@cover@song\gzu@cover@times
      \fontsize{12bp}{16bp}\selectfont
      \makebox[\gzu@cover@left@labelwidth][s]{#3}%
      ：\hspace{0.5\ccwd}%
      #4%
    };%
}
\newcommand\gzu@cover@right@row[3]{%
  \node[anchor=base east] at
    ([xshift=-25mm,yshift=-#1mm]current page.north east) {%
      \gzu@cover@song\gzu@cover@times
      \fontsize{12bp}{16bp}\selectfont
      \makebox[4\ccwd][s]{#2}：\hspace{1mm}%
      \makebox[\gzu@cover@right@valuewidth][s]{%
        \gzu@cover@spread@value{#3}%
      }%
    };%
}
\newcommand\gzu@cover@info@row[3]{%
  \node[anchor=base west] at
    ([xshift=43mm,yshift=-#1mm]current page.north west) {%
      \gzu@cover@song\gzu@cover@times
      \fontsize{14bp}{18bp}\selectfont
      \makebox[40mm][s]{#2}%
      \underline{\makebox[84mm][c]{\strut #3}}%
    };%
}
\ExplSyntaxOn

\clist_new:N \l__gzu_supervisor_parts_clist

\cs_new_protected:Npn \gzu_cover_supervisor:
  {
    % 按逗号拆分姓名和职称
    \exp_args:NNo \clist_set:Nn
      \l__gzu_supervisor_parts_clist { \gzu@supervisor }

    \int_compare:nNnTF
      { \clist_count:N \l__gzu_supervisor_parts_clist } = { 2 }
      {
        % 导师姓名
        \clist_item:Nn \l__gzu_supervisor_parts_clist { 1 }

        % 姓名与职称之间空半个汉字宽度
        \hspace{0.5\ccwd}

        % 导师职称
        \clist_item:Nn \l__gzu_supervisor_parts_clist { 2 }
      }
      {
        \ClassError{gzuthesis}
          {Invalid supervisor format}
          {Use supervisor={Name, Title}.}
      }
  }

\cs_new_eq:NN
  \gzu@cover@supervisor
  \gzu_cover_supervisor:

\ExplSyntaxOff
\newcommand\gzu@cover@degree@name{%
  \ifgzu@degree@doctor 博\hspace{0.45em}士%
  \else 硕\hspace{0.45em}士\fi
}
\newcommand\gzu@cover@degree@type{%
  \ifgzu@degree@type@professional
    （专业学位）%
  \else
    （学术学位）%
  \fi
}
\newlength\gzu@cover@right@valuewidth
\newlength\gzu@cover@right@tmpwidth

\newcommand\gzu@cover@measure@right{%
  \settowidth\gzu@cover@right@valuewidth{{%
    \gzu@cover@song\gzu@cover@times
    \fontsize{12bp}{16bp}\selectfont
    \gzu@school@code}}%

  \settowidth\gzu@cover@right@tmpwidth{{%
    \gzu@cover@song\gzu@cover@times
    \fontsize{12bp}{16bp}\selectfont
    \gzu@secret@level}}%

  \ifdim\gzu@cover@right@tmpwidth>
         \gzu@cover@right@valuewidth
    \setlength\gzu@cover@right@valuewidth{%
      \gzu@cover@right@tmpwidth}%
  \fi
}

\ExplSyntaxOn

\tl_new:N \l__gzu_cover_value_tl
\int_new:N \l__gzu_cover_index_int

\cs_new_protected:Npn \gzu_cover_spread_value:n #1
  {
    \tl_set:Nx \l__gzu_cover_value_tl {#1}
    \int_zero:N \l__gzu_cover_index_int

    \tl_map_inline:Nn \l__gzu_cover_value_tl
      {
        \int_compare:nNnT
          {\l__gzu_cover_index_int} > {0}
          {\hfill}
        ##1
        \int_incr:N \l__gzu_cover_index_int
      }
  }

\cs_new_eq:NN
  \gzu@cover@spread@value
  \gzu_cover_spread_value:n

\ExplSyntaxOff

\ExplSyntaxOn

\cs_new_protected:Npn \gzu_cover_degree_line:
  {
    % 保留当前 100 mm 的学位论文名称宽度。
    \hbox to 100mm
      {
        \hfill
        \ifgzu@degree@doctor
          博
        \else
          硕
        \fi
        \hfill
        士
        \hfill
        学
        \hfill
        位
        \hfill
        论
        \hfill
        文
        \hfill % 最右侧弹簧
      }
  }

\cs_set_eq:NN \gzu@cover@degree@line \gzu_cover_degree_line:

\ExplSyntaxOff

\newcommand\gzu@cover@verso{%
  \thispagestyle{empty}%
  \null

  \ifgzu@include@spine@true
    \begin{tikzpicture}[
      remember picture,
      overlay,
      every node/.style={
        inner sep=0pt,
        outer sep=0pt
      }
    ]
      \node[
        rotate=90,
        anchor=center,
        text width=235mm,
        align=center
      ] at ([xshift=-12mm]current page.east) {%
        \gzu@cover@song
        \fontsize{12bp}{18bp}\selectfont
        \gzu@title\quad\gzu@author
      };
    \end{tikzpicture}%
  \fi

  \clearpage
}

\newlength\gzu@cover@heading@gap
\setlength\gzu@cover@heading@gap{6mm}
\def\gzu@cover@date@parse#1-#2-#3\@nil{%
  #1\hspace{0.5em}年\hspace{0.5em}%
  \number\numexpr#2\relax\hspace{0.5em}月%
}

\newcommand\gzu@cover@date{%
  \expandafter\gzu@cover@date@parse
  \gzu@date\@nil
}
\newcommand\gzu@blind@heading@font{%
  \IfFileExists{\gzu@windows@font@dir/STXINGKA.TTF}{%
    \fontspec[Path=\gzu@windows@font@dir/]{STXINGKA.TTF}%
  }{%
    \IfFileExists{\gzu@windows@font@dir/stxingka.ttf}{%
      \fontspec[Path=\gzu@windows@font@dir/]{stxingka.ttf}%
    }{%
      \fontspec{STXingkai}%
    }%
  }%
  \gzu@cover@schoolfont
}

\newcommand\gzu@blind@maketitle{%
  \gzu@init@cover@fonts
  \begin{titlepage}%
    \thispagestyle{empty}%
    \null

    \begin{tikzpicture}[
      remember picture,overlay,
      every node/.style={inner sep=0pt,outer sep=0pt}
    ]

      % 校徽与学校书法校名
      \node[anchor=center]
        at ([yshift=-68mm]current page.north)
        {\includegraphics[
          width=40mm
        ]{logo/gzu-cover-logo.pdf}};

      \node[anchor=center]
        at ([yshift=-101mm]current page.north)
        {\includegraphics[
          width=43mm,
          keepaspectratio
        ]{logo/gzu-cover-text.pdf}};

      % 届别与论文类型：华文行楷，小初
      \node[anchor=center]
        at ([yshift=-125mm]current page.north) {%
          \gzu@blind@heading@font
          \fontsize{36bp}{43bp}\selectfont
          \gzu@graduation@year\hspace{0.15em}届%
          \ifgzu@degree@doctor
            博士%
          \else
            硕士%
          \fi
          学位论文
        };

      % 论文题目：黑体，一号
      \node[
        anchor=center,
        align=center,
        text width=166mm
      ]
        at ([yshift=-162mm]current page.north) {%
          \gzu@cover@hei
          \fontsize{26bp}{37bp}\selectfont
          \ifx\gzu@blind@title\@empty
            \gzu@title
          \else
            \gzu@blind@title
          \fi
        };

      % 学科专业：黑体，三号
      \node[anchor=center]
        at ([yshift=-201mm]current page.north) {%
          \gzu@cover@hei
          \fontsize{16bp}{23bp}\selectfont
          \makebox[29mm][l]{学科专业：}%
          \underline{%
            \makebox[55mm][c]{%
              \strut\gzu@discipline
            }%
          }%
        };

      % 研究方向：黑体，三号
      \node[anchor=center]
        at ([yshift=-211mm]current page.north) {%
          \gzu@cover@hei
          \fontsize{16bp}{23bp}\selectfont
          \makebox[29mm][l]{研究方向：}%
          \underline{%
            \makebox[55mm][c]{%
              \strut\gzu@research@direction
            }%
          }%
        };

      % 地点和日期：黑体，四号
      \node[
        anchor=north,
        align=center,
        font={\gzu@cover@hei\sffamily\fontsize{14bp}{20bp}\selectfont}
      ]
        at ([yshift=-251mm]current page.north) {%
          中国·贵州·贵阳\\[1.5mm]
          \gzu@cover@date
        };

    \end{tikzpicture}%
  \end{titlepage}%

  % 打印版保留空白背页，但不生成作者书脊
  \ifgzu@output@print
    \thispagestyle{empty}%
    \null
    \clearpage
  \fi
}
\renewcommand\maketitle{%
  \cleardoublepage
  \pagenumbering{Alph}%
  \ifgzu@thesis@version@blind
    \gzu@blind@maketitle
  \else
    \gzu@init@cover@fonts
    \begin{titlepage}%
    \thispagestyle{empty}%
    \null

    % 先测量宽度
    \gzu@cover@measure@left
    \gzu@cover@measure@right

    \begin{tikzpicture}[
      remember picture,overlay,
      every node/.style={inner sep=0pt,outer sep=0pt}
    ]
      % Top left: equal label widths.
      \gzu@cover@top@row{26}{35}
        {中\hfill 图\hfill 分\hfill 类\hfill 号}
        {\gzu@clc}

      \gzu@cover@top@row{26}{42}
        {UDC\hfill 分\hfill 类\hfill 号}
        {\gzu@udc}
      % Top right: equal label widths.

      % 学校代码和密级
      \gzu@cover@right@row{35}{学校代码}{\gzu@school@code}
      \gzu@cover@right@row{42}{密\hfill 级}{\gzu@secret@level}

      % 三行标题共用已初始化的垂直间距。

      % 第一行：贵州大学
      \node[anchor=north] (gzuCoverSchool)
        at ([yshift=-74mm]current page.north)
        {%
          \gzu@cover@schoolfont
          \fontsize{29bp}{50bp}\selectfont
          贵\hspace{1em}州\hspace{1em}大\hspace{1em}学
        };

      % 第二行：硕士学位论文
      \node[anchor=north] (gzuCoverDegree)
        at ([yshift=-\gzu@cover@heading@gap]gzuCoverSchool.south)
        {%
          \gzu@cover@song\gzu@cover@times
          \fontsize{20bp}{34bp}\selectfont
          \gzu@cover@degree@line
        };

      % 第三行：（专业学位）
      \node[anchor=north] (gzuCoverDegreeType)
        at ([yshift=-\gzu@cover@heading@gap]gzuCoverDegree.south)
        {%
          \gzu@cover@song
          \fontsize{16.5bp}{26bp}\selectfont
          \gzu@cover@degree@type
        };

      % 中文论文标题
      \node[
        anchor=north,
        align=center,
        text width=183mm
      ] (gzuCoverTitleZh)
        at ([yshift=-117mm]current page.north)
        {%
          \gzu@cover@song\gzu@cover@times
          \fontsize{20bp}{27bp}\selectfont
          \gzu@title
        };

      % 英文论文标题
      \node[
        anchor=north,
        align=center,
        text width=183mm
      ] (gzuCoverTitleEn)
        at ([yshift=-5mm]gzuCoverTitleZh.south)
        {%
          \gzu@cover@times
          \fontsize{20bp}{27bp}\selectfont
          \gzu@title@en
        };

      % 六行信息的基线间距为 10 mm，标签列和填写列的宽度保持一致。
      \gzu@cover@info@row{180}{学\hfill 生\hfill 姓\hfill 名：}{\gzu@author}
      \gzu@cover@info@row{190}{学\hfill 号：}{\gzu@student@id}
      \gzu@cover@info@row{200}{导\hfill 师\hfill 姓\hfill 名\hfill 、\hfill 职\hfill 称：}{\gzu@cover@supervisor}
      \gzu@cover@info@row{210}{学\hfill 科\hfill 专\hfill 业：}{\gzu@discipline}
      \gzu@cover@info@row{220}{研\hfill 究\hfill 方\hfill 向：}{\gzu@research@direction}
      \gzu@cover@info@row{230}{培\hfill 养\hfill 单\hfill 位：}{\gzu@department}

      % 地点与日期均为 14 bp；日期中文使用黑体，西文使用无衬线字体。
      \node[anchor=north,align=center]
        at ([yshift=-251mm]current page.north)
        {%
          \gzu@cover@hei\gzu@cover@times
          \fontsize{14bp}{20bp}\selectfont
          中国·贵州·贵阳\\[1.5mm]
          \gzu@cover@hei\sffamily
          \gzu@cover@date
        };
    \end{tikzpicture}%
  \end{titlepage}%

  % 自动处理中文封面的背页
  %\gzu@cover@verso

  % 仅打印版生成封面背页
  \ifgzu@output@print
    \gzu@cover@verso
  \else
    % 电子版忽略书脊配置
    \ifgzu@include@spine@true
      \ClassWarningNoLine{gzuthesis}
        {include-spine=true is ignored when output=electronic}%
    \fi
  \fi
  \fi % thesis-version=official
}

\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}

\newcounter{gzu@specialpage}

\newcommand\gzu@special@bookmark[1]{%
  \stepcounter{gzu@specialpage}%
  \@ifpackageloaded{hyperref}{%
    \pdfbookmark[0]{#1}{%
      gzu.special.\arabic{gzu@specialpage}%
    }%
  }{}%
}



\kv@define@key{gzu@committee}{name}{%
  \def\gzu@committee@name{#1}%
}

\kv@define@key{gzu@committee}{file}{%
  \def\gzu@committee@file{#1}%
}

\kv@define@key{gzu@committee}{body-width}{%
  \setlength\gzu@committee@bodywidth{#1}%
}

\kv@define@key{gzu@committee}{line-height}{%
  \def\gzu@committee@lineheight{#1}%
}

\kv@define@key{gzu@committee}{row-sep}{%
  \setlength\gzu@committee@rowgap{#1}%
}

\kv@define@key{gzu@committee}{role-width}{%
  \setlength\gzu@committee@rolewidth{#1}%
}

\kv@define@key{gzu@committee}{role-gap}{%
  \setlength\gzu@committee@rolegap{#1}%
}

\kv@define@key{gzu@committee}{name-align}{%
  \def\gzu@committee@namealign{#1}%
}

\kv@define@key{gzu@committee}{name-position}{%
  \def\gzu@committee@nameposition{#1}%
}


\newlength\gzu@committee@bodywidth
\newlength\gzu@committee@rowgap
\newlength\gzu@committee@rolewidth
\newlength\gzu@committee@rolegap

\newlength\gzu@committee@labelwidth
\newlength\gzu@committee@rulewidth
\newlength\gzu@committee@namecenter
\newlength\gzu@committee@indent

\def\gzu@committee@align@column{column}
\def\gzu@committee@align@line{line}

\newif\ifgzu@committee@firstrow


\newcommand\gzu@committee@rowstart{%
  \par
  \ifgzu@committee@firstrow
    \gzu@committee@firstrowfalse
  \else
    \vspace{\gzu@committee@rowgap}%
  \fi
  \noindent
}


\newcommand\committeemember[3]{%
  \gzu@committee@rowstart
  % 测量单位、职称及冒号的实际宽度
  \settowidth\gzu@committee@labelwidth{#1：}%
  % 计算下划线可用宽度
  \setlength\gzu@committee@rulewidth{%
    \dimexpr
      \gzu@committee@bodywidth
      -\gzu@committee@labelwidth
      -\gzu@committee@rolewidth
      -\gzu@committee@rolegap
    \relax
  }%
  % 检查是否有足够的下划线空间
  \ifdim\gzu@committee@rulewidth<2\ccwd
    \ClassError{gzuthesis}
      {Committee member label too long}
      {Increase body-width or shorten the label.}%
  \fi
  % 整行占满信息区域
  \hbox to \gzu@committee@bodywidth{%
    % 左侧：自然左对齐
    #1：%
    % 中间：自适应下划线
    \underline{%
      \makebox[\gzu@committee@rulewidth][l]{%
        \ifx
          \gzu@committee@namealign
          \gzu@committee@align@column
          % 姓名在统一的位置居中
          \hspace*{%
            \dimexpr
              \gzu@committee@namecenter
              -\gzu@committee@labelwidth
            \relax
          }%
          \makebox[0pt][c]{#2}%
        \else
          % 姓名在各自下划线的正中
          \makebox[\gzu@committee@rulewidth][c]{#2}%
        \fi
      }%
    }%
    % 横线与角色之间的间距
    \hspace{\gzu@committee@rolegap}%
    % 右侧：统一右对齐
    \makebox[\gzu@committee@rolewidth][r]{（#3）}%
  }%
  \par
}


\kv@define@key{gzu@secretary}{before-name}{%
  \def\gzu@secretary@before@name{#1}%
}

\kv@define@key{gzu@secretary}{before-title}{%
  \def\gzu@secretary@before@title{#1}%
}

\NewDocumentCommand\committeesecretary{O{} m m}{%
  \gzu@committee@rowstart
  \begingroup
    \def\gzu@secretary@before@name{0pt}%
    \def\gzu@secretary@before@title{1\ccwd}%
    \kvsetkeys{gzu@secretary}{#1}%
    答辩秘书：%
    \hspace{\gzu@secretary@before@name}%
    #2%
    \hspace{\gzu@secretary@before@title}%
    #3%
  \endgroup
  \par
}


\newcommand\committeedate[1]{%
  \gzu@committee@rowstart
  答辩时间：#1\par
}

\newcommand\committeeplace[1]{%
  \gzu@committee@rowstart
  答辩地点：#1\par
}


\NewDocumentEnvironment{committee}{O{} +b}{%
  \ifgzu@thesis@version@official
  \begingroup
  % 根据学位层次确定默认标题
  \ifgzu@degree@doctor
    \def\gzu@committee@name{%
      博士学位论文答辩委员会名单%
    }%
  \else
    \def\gzu@committee@name{%
      硕士学位论文答辩委员会名单%
    }%
  \fi
  \let\gzu@committee@file\@empty
  % 初始化布局默认值
  \setlength\gzu@committee@bodywidth{0.86\textwidth}%
  \setlength\gzu@committee@rowgap{2mm}%
  \setlength\gzu@committee@rolewidth{4\ccwd}%
  \setlength\gzu@committee@rolegap{0.5\ccwd}%
  \def\gzu@committee@lineheight{24bp}%
  \def\gzu@committee@namealign{column}%
  \def\gzu@committee@nameposition{0.63}%
  % 解析用户配置
  \kvsetkeys{gzu@committee}{#1}%
  % 检查姓名对齐模式
  \ifx\gzu@committee@namealign\gzu@committee@align@column
  \else
    \ifx\gzu@committee@namealign\gzu@committee@align@line
    \else
      \ClassError{gzuthesis}
        {Invalid committee name-align}
        {Use column or line.}%
    \fi
  \fi
  % 姓名中心相对于信息区域左端的位置
  \setlength\gzu@committee@namecenter{%
    \gzu@committee@nameposition
    \gzu@committee@bodywidth
  }%
  % 页面起始
  \cleardoublepage
  \ifx\gzu@committee@file\@empty
    \thispagestyle{empty}%
    \gzu@special@bookmark{\gzu@committee@name}%
    % 页面标题：黑体二号
    \par\vspace*{8mm}%
    {%
      \centering
      \heiti
      \fontsize{22bp}{30bp}\selectfont
      \gzu@committee@name\par
    }%
    \vspace{16mm}%
    % 论文题目：黑体小二
    {%
      \centering
      \heiti
      \fontsize{18bp}{27bp}\selectfont
      \gzu@title\par
    }%
    \vspace{14mm}%
    % 计算信息区域左右缩进
    \setlength\gzu@committee@indent{%
      \dimexpr
        (\textwidth-\gzu@committee@bodywidth)/2
      \relax
    }%
    % 信息区域
    \begingroup
      \leftskip=\gzu@committee@indent
      \rightskip=\gzu@committee@indent
      \parindent=0pt
      \parskip=0pt
      \songti
      \fontsize{14bp}{\gzu@committee@lineheight}\selectfont
      % 答辩人
      \noindent 答辩人：\gzu@author\par
      \vspace{6mm}%
      % 委员名单标题
      \noindent 答辩委员会委员：\par
      \vspace{4mm}%
      % 下面所有信息行共享统一行距
      \gzu@committee@firstrowtrue
      #2\par
    \endgroup
    \clearpage
  \else
    % 使用外部 PDF 页面
    \includepdf[
      pages=1,
      pagecommand={%
        \thispagestyle{empty}%
        \gzu@special@bookmark{\gzu@committee@name}%
      }%
    ]{\gzu@committee@file}%
  \fi
  \endgroup
  \fi
}{}




\kv@define@key{gzu@statement}{file}{%
  \def\gzu@statement@file{#1}%
}

\kv@define@key{gzu@statement}{body-width}{%
  \setlength\gzu@statement@bodywidth{#1}%
}

\kv@define@key{gzu@statement}{line-height}{%
  \def\gzu@statement@lineheight{#1}%
}

\kv@define@key{gzu@statement}{form-line-height}{%
  \def\gzu@statement@formlineheight{#1}%
}

\kv@define@key{gzu@statement}{title-before}{%
  \def\gzu@statement@titlebefore{#1}%
}

\kv@define@key{gzu@statement}{title-after}{%
  \def\gzu@statement@titleafter{#1}%
}

\kv@define@key{gzu@statement}{authorization-before}{%
  \def\gzu@statement@authorizationbefore{#1}%
}

\kv@define@key{gzu@statement}{signature-before}{%
  \def\gzu@statement@signaturebefore{#1}%
}

\kv@define@key{gzu@statement}{signature-row-sep}{%
  \def\gzu@statement@signaturerowsep{#1}%
}

\kv@define@key{gzu@statement}{confidential-before}{%
  \def\gzu@statement@confidentialbefore{#1}%
}

\kv@define@key{gzu@statement}{right-column-position}{%
  \def\gzu@statement@rightcolumnposition{#1}%
}

\kv@define@key{gzu@statement}{form-indent}{%
  \setlength\gzu@statement@formindent{#1}%
}


\newlength\gzu@statement@bodywidth
\newlength\gzu@statement@indent
\newlength\gzu@statement@rightstart
\newlength\gzu@statement@formindent


\newcommand\gzu@statement@title[2]{%
  \par\vspace*{#1}%
  {%
    \centering
    \heiti
    \fontsize{16bp}{24bp}\selectfont
    #2\par
  }%
  \vspace{\gzu@statement@titleafter}%
}


\newcommand\gzu@statement@paragraph[1]{%
  \par
  \begingroup
    \noindent
    \hspace*{2\ccwd}%
    #1\par
  \endgroup
}


\newcommand\gzu@statement@formrow[1]{%
  \par\noindent
  \hspace*{\gzu@statement@formindent}%
  #1\par
}


\newcommand\gzu@statement@signature@row[2]{%
  \par\noindent
  \hbox to \gzu@statement@bodywidth{%
    \hspace*{\gzu@statement@formindent}%
    \makebox[
      \dimexpr
        \gzu@statement@rightstart
        -\gzu@statement@formindent
      \relax
    ][l]{#1}%
    \makebox[
      \dimexpr
        \gzu@statement@bodywidth
        -\gzu@statement@rightstart
      \relax
    ][l]{#2}%
  }%
  \par
}


\newcommand\gzu@statement@datefields{%
  \makebox[4\ccwd][l]{日\hfill 期}：%
  \hfill
  \makebox[1.5\ccwd]{}年%
  \makebox[1.2\ccwd]{}月%
  \makebox[1.2\ccwd]{}日%
}


\newcommand\gzu@statement@originality{%
  本人郑重声明：所呈交的学位论文，是本人在导师的指导下，
  独立进行研究所取得的成果。除文中已经注明引用的内容外，
  本论文不包含任何其他个人或集体已经发表或撰写过的科研成果。
  对本文的研究作出重要贡献的个人和集体，
  均已在文中以明确方式标明。
  本人在导师指导下所完成的学位论文及相关的职务作品，
  知识产权归属贵州大学。
  本人完全意识到本声明的法律责任由本人承担。%
}


\newcommand\gzu@statement@authorization{%
  本人完全了解贵州大学有关保留、使用学位论文的规定，
  同意学校保留或向国家有关部门或机构送交论文的复印件和电子版，
  允许论文被查阅和借阅；
  本人授权贵州大学可以将本学位论文的全部或部分内容
  编入有关数据库进行检索，
  可以采用影印、缩印或其他复制手段保存论文
  和汇编本学位论文。%
}


\NewDocumentCommand\statement{O{}}{%
  \ifgzu@thesis@version@official
  \begingroup
    % ----------------------------------------------
    % 初始化页面参数
    % ----------------------------------------------

    \let\gzu@statement@file\@empty

    % 正文区域宽度
    \setlength\gzu@statement@bodywidth{\textwidth}%

    % 正文基线间距：30 bp
    \def\gzu@statement@lineheight{30bp}%

    % 表单行距默认继承正文行距
    \def\gzu@statement@formlineheight{%
      \gzu@statement@lineheight
    }%

    % 标题段前、段后
    \def\gzu@statement@titlebefore{24bp}%
    \def\gzu@statement@titleafter{6bp}%
    \def\gzu@statement@authorizationbefore{24bp}%

    % 签名及保密信息间距
    \def\gzu@statement@signaturebefore{2mm}%
    \def\gzu@statement@signaturerowsep{1mm}%
    \def\gzu@statement@confidentialbefore{2mm}%

    % 右侧信息列位置：正文宽度的 53%
    \def\gzu@statement@rightcolumnposition{0.53}%

    % 表单内容左侧缩进两个汉字
    \setlength\gzu@statement@formindent{2\ccwd}%

    % 解析用户参数
    \kvsetkeys{gzu@statement}{#1}%

    % ----------------------------------------------
    % 计算页面布局
    % ----------------------------------------------

    % 右侧列的起点
    % right-column-position 使用无单位比例
    \setlength\gzu@statement@rightstart{%
      \dimexpr
        \gzu@statement@rightcolumnposition
        \gzu@statement@bodywidth
      \relax
    }%

    % 声明内容整体水平居中
    \setlength\gzu@statement@indent{%
      \dimexpr
        (\textwidth-\gzu@statement@bodywidth)/2
      \relax
    }%

    % 检查右侧列位置
    \ifdim\gzu@statement@rightstart<
      \gzu@statement@formindent
      \ClassError{gzuthesis}
        {Invalid statement right column position}
        {Increase right-column-position.}%
    \fi

    \ifdim\gzu@statement@rightstart>
      \gzu@statement@bodywidth
      \ClassError{gzuthesis}
        {Statement right column exceeds body width}
        {Use a right-column-position between 0 and 1.}%
    \fi

    % ----------------------------------------------
    % 页面开始
    % ----------------------------------------------

    \cleardoublepage

    \ifx\gzu@statement@file\@empty

      \thispagestyle{empty}%

      \gzu@special@bookmark{%
        原创性声明与学位论文使用授权声明%
      }%

      % --------------------------------------------
      % 声明正文区域
      % --------------------------------------------

      \begingroup

        \leftskip=\gzu@statement@indent\relax
        \rightskip=\gzu@statement@indent\relax

        \parindent=0pt\relax
        \parskip=0pt\relax

        % 防止 ctexbook 的 baselinestretch
        % 额外放大指定的固定行距。
        \renewcommand\baselinestretch{1}%

        % 正文字体：宋体四号
        \songti
        \fontsize{14bp}{\gzu@statement@lineheight}%
        \selectfont

        % ------------------------------------------
        % 原创性声明
        % ------------------------------------------

        \gzu@statement@title
          {\gzu@statement@titlebefore}
          {原创性声明}%

        \gzu@statement@paragraph{%
          \gzu@statement@originality
        }%

        % 原创性声明签名及日期
        \par\vspace{\gzu@statement@signaturebefore}%

        \begingroup
          \fontsize
            {14bp}
            {\gzu@statement@formlineheight}%
          \selectfont

          \gzu@statement@signature@row
            {论文作者签名：}
            {\gzu@statement@datefields}%
        \endgroup

        % ------------------------------------------
        % 学位论文使用授权声明
        % ------------------------------------------

        \gzu@statement@title
          {\gzu@statement@authorizationbefore}
          {关于学位论文使用授权的声明}%

        \gzu@statement@paragraph{%
          \gzu@statement@authorization
        }%

        % ------------------------------------------
        % 保密选项及签名区域
        % ------------------------------------------

        \begingroup
          \fontsize
            {14bp}
            {\gzu@statement@formlineheight}%
          \selectfont

          \par\vspace{%
            \gzu@statement@confidentialbefore
          }%

          \gzu@statement@formrow{%
            本学位论文属于：%
          }%

          % 不保密与保密各占三个汉字宽度
          % 括号内部仅保留空白，不绘制方框

          \gzu@statement@formrow{%
            \makebox[3\ccwd][l]{不保密}%
            （\makebox[1.5\ccwd]{}）%
          }%

          \gzu@statement@formrow{%
            \makebox[3\ccwd][l]{保\hfill 密}%
            （\makebox[1.5\ccwd]{}），%
            在\underline{\makebox[1.5\ccwd]{}}%
            年解密后适用授权。%
          }%

          \gzu@statement@formrow{%
            （请在以上相应方框内打“√”，%
            \textbf{请慎重勾选！}）%
          }%

          % ----------------------------------------
          % 作者、导师签名
          % ----------------------------------------

          \par\vspace{%
            \gzu@statement@signaturebefore
          }%

          \gzu@statement@signature@row
            {论文作者签名：}
            {导师签名：}%

          % 日期位于右侧列，与上方日期对齐
          \par\vspace{%
            \gzu@statement@signaturerowsep
          }%

          \gzu@statement@signature@row
            {}
            {\gzu@statement@datefields}%

        \endgroup

      \endgroup

      \clearpage

    \else

      % --------------------------------------------
      % 导入已签字扫描 PDF
      % --------------------------------------------

      \includepdf[
        pages=1,
        pagecommand={%
          \thispagestyle{empty}%
          \gzu@special@bookmark{%
            原创性声明与学位论文使用授权声明%
          }%
        }%
      ]{\gzu@statement@file}%

    \fi

  \endgroup
  \fi
}


\newcommand\gzu@abstract@heading[2]{%
  \gzu@unnumbered@chapter{#1}{#2}%
}

\ExplSyntaxOn

\clist_new:N \l__gzu_abstract_keywords_clist

\cs_new_protected:Npn \gzu_abstract_keywords:nnn #1#2#3
  {
    \exp_args:NNo \clist_set:Nn
      \l__gzu_abstract_keywords_clist {#1}

    \clist_if_empty:NF \l__gzu_abstract_keywords_clist
      {
        \par\medskip\noindent
        \textbf{#2}%
        \clist_use:Nn
          \l__gzu_abstract_keywords_clist {#3}%
        \par
      }
  }

\cs_new_eq:NN
  \gzu@abstract@keywords
  \gzu_abstract_keywords:nnn

\ExplSyntaxOff

\newenvironment{abstract}{%
  \gzu@abstract@heading{摘\qquad 要}{摘要}%
  \ignorespaces
}{%
  \gzu@abstract@keywords
    {\gzu@keywords}{关键词：}{；}%
}

\newenvironment{abstract*}{%
  \gzu@abstract@heading{Abstract}{Abstract}%
  \ignorespaces
}{%
  \gzu@abstract@keywords
    {\gzu@keywords@en}{Keywords:~}{;~}%
}

\RequirePackage{enumitem}
\newcommand\gzu@denotation@name{主要符号对照表}
\newlist{gzu@denotation}{description}{1}

\setlist[gzu@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!,
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}
\newenvironment{denotation}[1][2.5cm]{%
  \gzu@unnumbered@chapter
    {\gzu@denotation@name}
    {\gzu@denotation@name}%
  \begin{gzu@denotation}[labelwidth=#1]%
}{%
  \end{gzu@denotation}%
}
\newcommand\gzu@acknowledgements@name{致\qquad 谢}
\newcommand\gzu@acknowledgements@tocname{致谢}

\NewDocumentEnvironment{acknowledgements}{+b}{%
  \ifgzu@thesis@version@official
    \gzu@unnumbered@chapter
      {\gzu@acknowledgements@name}
      {\gzu@acknowledgements@tocname}%
    #1\par
  \fi
}{}
\g@addto@macro\appendix{%
  \@mainmattertrue
  \ctexset{
    chapter = {
      name = {附录~,},
      aftername = \quad, % \par 为换行，\quad：一字空
    }
  }%
  % 附录图表是否加入图表清单
  \ifgzu@appendix@figure@in@lof@false
    \captionsetup*[figure]{list=false}%
    \captionsetup*[table]{list=false}%
  \fi
  % 附录目录层级
  \protected@write\@auxout{}{%
    \string\ttl@writefile{toc}{%
      \protect\setcounter{tocdepth}{\gzu@appendix@toc@depth}%
    }%
  }%
}
\gzu@option@classonly{degree}
\gzu@option@classonly{degree-type}

\gzu@option@classonly{fontset}
\gzu@option@classonly{font}
\gzu@option@classonly{cjk-font}
\gzu@option@classonly{windows-font-dir}
\gzu@option@classonly{footnote-numbering}
\gzu@option@classonly{footnote-style}
\gzu@option@classonly{figure-numbering}
\gzu@option@classonly{table-numbering}
\gzu@option@classonly{equation-numbering}

\gzu@options@readytrue

\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\file{\nolinkurl}
\DeclareRobustCommand\env{\textsf}
\DeclareRobustCommand\pkg{\textsf}
\DeclareRobustCommand\cls{\textsf}
\endinput
%%
%% End of file `gzuthesis.cls'.
