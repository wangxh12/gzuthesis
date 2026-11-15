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
\ProvidesClass{gzuthesis}[2026/11/15 v0.1.0 Guizhou University Thesis Template]
\RequirePackage{kvoptions}

\SetupKeyvalOptions{
  family = gzu,
  prefix = gzu@,
}
\DeclareStringOption[master]{degree}
\DeclareStringOption[academic]{degree-type}
\DeclareStringOption[auto]{fontset}
\DeclareStringOption[xits]{math-font}
\DeclareDefaultOption{
  \PassOptionsToClass{\CurrentOption}{ctexbook}
}

\ProcessKeyvalOptions*
\newif\ifgzu@degree@master
\newif\ifgzu@degree@doctor

\newif\ifgzu@degree@type@academic
\newif\ifgzu@degree@type@professional
\def\gzu@master{master}
\def\gzu@doctor{doctor}

\def\gzu@academic{academic}
\def\gzu@professional{professional}
\ifx\gzu@degree\gzu@master
  \gzu@degree@mastertrue
\else
  \ifx\gzu@degree\gzu@doctor
    \gzu@degree@doctortrue
  \else
    \ClassError{gzuthesis}
      {Invalid degree `\gzu@degree'}
      {Use degree=master or degree=doctor.}
  \fi
\fi
\edef\gzu@degree@type{\csname gzu@degree-type\endcsname}

\ifx\gzu@degree@type\gzu@academic
  \gzu@degree@type@academictrue
\else
  \ifx\gzu@degree@type\gzu@professional
    \gzu@degree@type@professionaltrue
  \else
    \ClassError{gzuthesis}
      {Invalid degree-type `\gzu@degree@type'}
      {Use degree-type=academic or degree-type=professional.}
  \fi
\fi
\LoadClass[
  a4paper,
  UTF8,
  zihao=-4,
  scheme=plain,
  fontset=none,
  twoside
]{ctexbook}

\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}

\newcommand\gzusetup[1]{%
  \kvsetkeys{gzuinfo}{#1}%
}
\newcommand\gzu@title{}
\newcommand\gzu@title@en{}
\newcommand\gzu@author{}
\newcommand\gzu@student@id{}
\newcommand\gzu@supervisor{}
\newcommand\gzu@discipline{}
\newcommand\gzu@research@direction{}
\newcommand\gzu@department{}
\newcommand\gzu@date{}
\newcommand\gzu@graduation@year{}
\newcommand\gzu@clc{}
\newcommand\gzu@udc{}
\newcommand\gzu@school@code{}
\newcommand\gzu@secret@level{}
\kv@define@key{gzuinfo}{title}{%
  \def\gzu@title{#1}%
}
\kv@define@key{gzuinfo}{title*}{%
  \def\gzu@title@en{#1}%
}
\kv@define@key{gzuinfo}{author}{%
  \def\gzu@author{#1}%
}
\kv@define@key{gzuinfo}{student-id}{%
  \def\gzu@student@id{#1}%
}
\kv@define@key{gzuinfo}{supervisor}{%
  \def\gzu@supervisor{#1}%
}
\kv@define@key{gzuinfo}{discipline}{%
  \def\gzu@discipline{#1}%
}
\kv@define@key{gzuinfo}{research-direction}{%
  \def\gzu@research@direction{#1}%
}
\kv@define@key{gzuinfo}{department}{%
  \def\gzu@department{#1}%
}
\kv@define@key{gzuinfo}{date}{%
  \def\gzu@date{#1}%
}
\kv@define@key{gzuinfo}{graduation-year}{%
  \def\gzu@graduation@year{#1}%
}
\kv@define@key{gzuinfo}{clc}{%
  \def\gzu@clc{#1}%
}
\kv@define@key{gzuinfo}{udc}{%
  \def\gzu@udc{#1}%
}
\kv@define@key{gzuinfo}{school-code}{%
  \def\gzu@school@code{#1}%
}
\kv@define@key{gzuinfo}{secret-level}{%
  \def\gzu@secret@level{#1}%
}
\RequirePackage{geometry}

\geometry{
  paper      = a4paper,
  top        = 3cm,
  bottom     = 2.5cm,
  left       = 2.5cm,
  right      = 2.5cm,
  headheight = 0.5cm,
  headsep    = 0.3cm,
  footskip   = 0.75cm,
}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}

\setmainfont{texgyretermes-regular.otf}[
  BoldFont       = texgyretermes-bold.otf,
  ItalicFont     = texgyretermes-italic.otf,
  BoldItalicFont = texgyretermes-bolditalic.otf,
]
\setsansfont{texgyreheros-regular.otf}[
  BoldFont       = texgyreheros-bold.otf,
  ItalicFont     = texgyreheros-italic.otf,
  BoldItalicFont = texgyreheros-bolditalic.otf,
]
\setmonofont{texgyrecursor-regular.otf}[
  BoldFont       = texgyrecursor-bold.otf,
  ItalicFont     = texgyrecursor-italic.otf,
  BoldItalicFont = texgyrecursor-bolditalic.otf,
]
\def\gzu@fontset@auto{auto}
\def\gzu@fontset@windows{windows}
\def\gzu@fontset@mac{mac}
\def\gzu@fontset@ubuntu{ubuntu}
\def\gzu@fontset@fandol{fandol}

\ifx\gzu@fontset\gzu@fontset@auto
  \IfFontExistsTF{SimSun}{
    \def\gzu@fontset{windows}
  }{
    \IfFontExistsTF{Songti SC}{
      \def\gzu@fontset{mac}
    }{
      \IfFontExistsTF{Noto Serif CJK SC}{
        \def\gzu@fontset{ubuntu}
      }{
        \def\gzu@fontset{fandol}
      }
    }
  }
\fi
\ifx\gzu@fontset\gzu@fontset@windows
  \setCJKmainfont{SimSun}[
    AutoFakeBold = 3,
    ItalicFont = KaiTi
  ]
  \setCJKsansfont{SimHei}[AutoFakeBold=3]
  \setCJKmonofont{FangSong}
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold=3]
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold=3]
  \setCJKfamilyfont{zhkai}{KaiTi}
  \setCJKfamilyfont{zhfs}{FangSong}
\else\ifx\gzu@fontset\gzu@fontset@mac
  \setCJKmainfont{Songti SC}
  \setCJKsansfont{Heiti SC}
  \setCJKmonofont{STFangsong}
  \setCJKfamilyfont{zhsong}{Songti SC}
  \setCJKfamilyfont{zhhei}{Heiti SC}
  \setCJKfamilyfont{zhkai}{Kaiti SC}
  \setCJKfamilyfont{zhfs}{STFangsong}
\else\ifx\gzu@fontset\gzu@fontset@ubuntu
  \setCJKmainfont{Noto Serif CJK SC}[
    ItalicFont = FandolKai-Regular.otf
  ]
  \setCJKsansfont{Noto Sans CJK SC}
  \setCJKmonofont{FandolFang-Regular.otf}
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}
  \setCJKfamilyfont{zhkai}{FandolKai-Regular.otf}
  \setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}
\else\ifx\gzu@fontset\gzu@fontset@fandol
  \setCJKmainfont{FandolSong}[
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold
  ]
  \setCJKsansfont{FandolHei}[
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold
  ]
  \setCJKmonofont{FandolFang}[
    Extension = .otf,
    UprightFont = *-Regular
  ]
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold
  ]
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold
  ]
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension = .otf,
    UprightFont = *-Regular
  ]
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension = .otf,
    UprightFont = *-Regular
  ]
\else
  \ClassError{gzuthesis}
    {Invalid fontset `\gzu@fontset'}
    {Use auto, windows, mac, ubuntu or fandol.}
\fi\fi\fi\fi

\providecommand\songti{\CJKfamily{zhsong}}
\providecommand\heiti{\CJKfamily{zhhei}}
\providecommand\kaishu{\CJKfamily{zhkai}}
\providecommand\fangsong{\CJKfamily{zhfs}}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip 6bp%
  \abovedisplayshortskip 6bp%
  \belowdisplayshortskip 6bp%
  \belowdisplayskip \abovedisplayskip
}
\normalsize
\ctexset{
  punct      = quanjiao,
  autoindent = 2,
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
      \CTEXifname{\CTEXthechapter\quad}{}##1%
    }{}%
  }%
  \let\sectionmark\@gobble
}
\pagestyle{plain}
\ctexset{
  chapter/pagestyle = plain,
}

\renewcommand\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else
      \thispagestyle{empty}%
      \hbox{}%
      \newpage
      \if@twocolumn
        \hbox{}\newpage
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
\newcommand\gzu@figure@separator{.}
\newcommand\gzu@table@separator{.}

\renewcommand\thefigure{%
  \ifnum\c@chapter>\z@
    \thechapter\gzu@figure@separator
  \fi
  \arabic{figure}%
}

\renewcommand\thetable{%
  \ifnum\c@chapter>\z@
    \thechapter\gzu@table@separator
  \fi
  \arabic{table}%
}
\kv@define@key{gzuinfo}{figure-number-separator}{%
  \def\gzu@figure@separator{#1}%
}

\kv@define@key{gzuinfo}{table-number-separator}{%
  \def\gzu@table@separator{#1}%
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
\newcommand\gzu@caption@language{auto}

\newcommand\gzu@set@caption@language[1]{%
  \ifboolexpr{
    test {\ifstrequal{#1}{auto}} or
    test {\ifstrequal{#1}{chinese}} or
    test {\ifstrequal{#1}{bilingual}}
  }{%
    \def\gzu@caption@language{#1}%
    \ifstrequal{#1}{auto}{%
      \ifgzu@degree@doctor
        \gzu@caption@bilingualtrue
      \else
        \gzu@caption@bilingualfalse
      \fi
    }{%
      \ifstrequal{#1}{bilingual}
        {\gzu@caption@bilingualtrue}
        {\gzu@caption@bilingualfalse}%
    }%
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
  }{%
    \ClassError{gzuthesis}{Invalid caption-language `#1'}%
      {Use auto, chinese, or bilingual.}%
  }%
}

\kv@define@key{gzuinfo}{caption-language}{%
  \gzu@set@caption@language{#1}%
}
\gzu@set@caption@language{auto}
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
\setlength\heavyrulewidth{1.5bp}
\setlength\lightrulewidth{0.75bp}
\setlength\cmidrulewidth{0.75bp}

\kv@define@key{gzuinfo}{table-rule-width}{%
  \setlength\heavyrulewidth{#1}%
}

\kv@define@key{gzuinfo}{table-midrule-width}{%
  \setlength\lightrulewidth{#1}%
}

\kv@define@key{gzuinfo}{table-cmidrule-width}{%
  \setlength\cmidrulewidth{#1}%
}
\renewcommand\textfraction{0.15}
\renewcommand\topfraction{0.85}
\renewcommand\bottomfraction{0.65}
\renewcommand\floatpagefraction{0.60}
\renewcommand\listoffigures{%
  \chapter*{\listfigurename}%
  \markboth{\listfigurename}{\listfigurename}%
  \addcontentsline{toc}{chapter}{\listfigurename}%
  \@starttoc{lof}%
}
\renewcommand\listoftables{%
  \chapter*{\listtablename}%
  \markboth{\listtablename}{\listtablename}%
  \addcontentsline{toc}{chapter}{\listtablename}%
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
\RequirePackage{unicode-math}
\unimathsetup{
  math-style = ISO,
  bold-style = ISO,
  partial    = upright,
}
\AtBeginDocument{%
  \let\le\leqslant
  \let\ge\geqslant
  \let\leq\leqslant
  \let\geq\geqslant
}
\edef\gzu@math@font{%
  \csname gzu@math-font\endcsname
}

\def\gzu@math@font@xits{xits}
\def\gzu@math@font@stix{stix}
\def\gzu@math@font@lm{lm}
\ifx\gzu@math@font\gzu@math@font@xits
  \setmathfont{XITSMath-Regular.otf}[
    BoldFont = XITSMath-Bold.otf,
    StylisticSet = 8,
  ]
\else
  \ifx\gzu@math@font\gzu@math@font@stix
    \setmathfont{STIXTwoMath-Regular.otf}
  \else
    \ifx\gzu@math@font\gzu@math@font@lm
      \setmathfont{latinmodern-math.otf}
    \else
      \ClassError{gzuthesis}
        {Invalid math font `\gzu@math@font'}
        {Use math-font=xits, stix or lm.}
    \fi
  \fi
\fi
\newcommand\gzu@equation@separator{.}

\renewcommand\theequation{%
  \ifnum\c@chapter>\z@
    \thechapter\gzu@equation@separator
  \fi
  \arabic{equation}%
}
\kv@define@key{gzuinfo}{equation-number-separator}{%
  \def\gzu@equation@separator{#1}%
}
\def\tagform@#1{%
  \maketag@@@{%
    \kern0pt（\ignorespaces#1\unskip\@@italiccorr）%
  }%
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
\renewcommand\qedsymbol{\ensuremath{\QED}}
\RequirePackage{url}
\renewcommand\bibname{参考文献}

\newcommand\gzu@bib@heading[1]{%
  \chapter*{#1}%
  \markboth{#1}{#1}%
  \@ifpackageloaded{hyperref}{\phantomsection}{}%
  \addcontentsline{toc}{chapter}{#1}%
}

\newif\ifgzu@main@language@chinese
\gzu@main@language@chinesetrue
\newif\ifgzu@language@chinese
\gzu@language@chinesetrue

\def\gzu@cite@style{auto}
\def\gzu@cite@style@auto{auto}
\def\gzu@cite@style@super{super}
\def\gzu@cite@style@inline{inline}
\def\gzu@cite@style@author@year{author-year}

\newcommand\gzu@apply@cite@style{%
  \ifx\gzu@cite@style\gzu@cite@style@auto
  \else
    \ifx\gzu@cite@style\gzu@cite@style@super
      \citestyle{super}%
    \else
      \ifx\gzu@cite@style\gzu@cite@style@inline
        \citestyle{inline}%
      \else
        \ifx\gzu@cite@style\gzu@cite@style@author@year
          \citestyle{author-year}%
        \else
          \ClassError{gzuthesis}{Unknown cite-style `\gzu@cite@style'}%
            {Use auto, super, inline, or author-year.}%
        \fi
      \fi
    \fi
  \fi
}
\kv@define@key{gzuinfo}{cite-style}{\def\gzu@cite@style{#1}}

\PassOptionsToPackage{compress}{natbib}
\AddToHook{package/natbib/after}{%
  \newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{,}}%
  \newcommand\bibstyle@inline{\bibpunct{[}{]}{,}{n}{,}{,}}%
  \@namedef{bibstyle@author-year}{\bibpunct{(}{)}{;}{a}{,}{,}}%
  \@namedef{bibstyle@gzuthesis-numeric}{\citestyle{super}}%
  \@namedef{bibstyle@gzuthesis-author-year}{\citestyle{author-year}}%
  \DeclareRobustCommand\inlinecite{\@inlinecite}%
  \def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}%
  \let\onlinecite\inlinecite
  \renewcommand\bibsection{\gzu@bib@heading{\bibname}}%
  \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
  \setlength\bibsep{3bp plus 3bp minus 3bp}%
  \setlength\bibhang{21bp}%
  \def\@biblabel#1{[#1]\hfill}%
  \renewcommand\NAT@bibsetnum[1]{%
    \setlength{\labelwidth}{1cm}%
    \setlength{\leftmargin}{\labelwidth}%
    \setlength{\labelsep}{0pt}%
    \setlength{\itemsep}{\bibsep}%
    \setlength{\parsep}{0pt}%
    \ifNAT@openbib
      \addtolength{\leftmargin}{\bibindent}%
      \setlength{\itemindent}{-\bibindent}%
      \setlength{\listparindent}{\itemindent}%
      \setlength{\parsep}{0pt}%
    \fi
  }%
  \AtBeginDocument{\gzu@apply@cite@style}%
}

\AddToHook{package/biblatex/after}{%
  \DeclareRobustCommand\inlinecite{\parencite}%
  \let\onlinecite\inlinecite
  \defbibheading{bibliography}[\bibname]{\gzu@bib@heading{#1}}%
  \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
  \setlength\bibitemsep{3bp plus 3bp minus 3bp}%
  \setlength\biblabelsep{0pt}%
  \setlength\bibhang{21bp}%
}
\RequirePackage{tikz}

\IfFileExists{/mnt/c/Windows/Fonts/simsun.ttc}{%
  \newCJKfontfamily\gzu@cover@song[
    Path=/mnt/c/Windows/Fonts/
  ]{simsun.ttc}%
}{%
  \newCJKfontfamily\gzu@cover@song{FandolSong-Regular.otf}%
}
\IfFileExists{/mnt/c/Windows/Fonts/simhei.ttf}{%
  \newCJKfontfamily\gzu@cover@hei[
    Path=/mnt/c/Windows/Fonts/
  ]{simhei.ttf}%
}{%
  \newCJKfontfamily\gzu@cover@hei{FandolHei-Regular.otf}%
}
\IfFileExists{/mnt/c/Windows/Fonts/times.ttf}{%
  \newfontfamily\gzu@cover@times[
    Path=/mnt/c/Windows/Fonts/,
    UprightFont=times.ttf,
    BoldFont=timesbd.ttf,
    ItalicFont=timesi.ttf,
    BoldItalicFont=timesbi.ttf
  ]{times.ttf}%
}{%
  \IfFileExists{texgyretermes-regular.otf}{%
    \newfontfamily\gzu@cover@times{texgyretermes-regular.otf}[
      BoldFont=texgyretermes-bold.otf,
      ItalicFont=texgyretermes-italic.otf,
      BoldItalicFont=texgyretermes-bolditalic.otf
    ]%
  }{%
    \newfontfamily\gzu@cover@times{Liberation Serif}%
  }%
}
\IfFileExists{/mnt/c/Windows/Fonts/STXINGKA.TTF}{%
  \newCJKfontfamily\gzu@cover@schoolfont[
    Path=/mnt/c/Windows/Fonts/
  ]{STXINGKA.TTF}%
}{%
  \newCJKfontfamily\gzu@cover@schoolfont{FandolKai-Regular.otf}%
}
\newcommand\gzu@cover@top@row[4]{%
  \node[anchor=base west] at
    ([xshift=#1mm,yshift=-#2mm]current page.north west) {%
      \gzu@cover@song\gzu@cover@times
      \fontsize{12bp}{16bp}\selectfont
      \makebox[29mm][l]{#3}%
      \makebox[23mm][l]{#4}%
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

\tl_new:N \l__gzu_cover_degree_text_tl
\dim_new:N \l__gzu_cover_degree_cell_dim

\cs_new_protected:Npn \gzu_cover_degree_line:
  {
    % 总宽度可以自己微调，115mm 比较合适，如果还不够宽可以改大
    \hbox to 115mm
      {
        \hfill % 最左侧弹簧
        \gzu@graduation@year % 2027 作为一个整体，绝不被拆开
        \hfill
        届
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

\renewcommand\maketitle{%
  \begin{titlepage}%
    \thispagestyle{empty}%
    \null

    % 先测量宽度
    \gzu@cover@measure@right

    \begin{tikzpicture}[
      remember picture,overlay,
      every node/.style={inner sep=0pt,outer sep=0pt}
    ]
      % Top left: equal label widths.
      \gzu@cover@top@row{26}{35}{中\hfill 图\hfill 分\hfill 类\hfill 号：}{\gzu@clc}
      \gzu@cover@top@row{26}{42}{UDC\hfill 分\hfill 类\hfill 号：}{\gzu@udc}
      % Top right: equal label widths.

      % 学校代码和密级
      \gzu@cover@right@row{35}{学校代码}{\gzu@school@code}
      \gzu@cover@right@row{42}{密\hfill 级}{\gzu@secret@level}

      \node[anchor=north]
        at ([yshift=-74mm]current page.north)
        {\gzu@cover@schoolfont\fontsize{29bp}{50bp}\selectfont
          贵\hspace{1.1em}州\hspace{1.1em}大\hspace{1.1em}学};

      \node[anchor=north]
        at ([yshift=-90mm]current page.north)
        {%
          \gzu@cover@song\gzu@cover@times
          \fontsize{20bp}{34bp}\selectfont
          \gzu@cover@degree@line
        };

      \node[anchor=north]
        at ([yshift=-104mm]current page.north)
        {\gzu@cover@song\fontsize{16.5bp}{26bp}\selectfont
          \gzu@cover@degree@type};

      % Both thesis titles: 20 bp as specified in the Word reference.
      \node[anchor=north,align=center,text width=183mm]
        at ([yshift=-117mm]current page.north)
        {\gzu@cover@song\gzu@cover@times\fontsize{20bp}{27bp}\selectfont
          \gzu@title};
      \node[anchor=north,align=center,text width=183mm]
        at ([yshift=-132mm]current page.north)
        {\gzu@cover@times\fontsize{20bp}{27bp}\selectfont
          \gzu@title@en};

      % Six baselines, spaced by 9 mm; identical label/value columns.
      \gzu@cover@info@row{180}{学\hfill 生\hfill 姓\hfill 名：}{\gzu@author}
      \gzu@cover@info@row{189}{学\hfill 号：}{\gzu@student@id}
      \gzu@cover@info@row{198}{导\hfill 师\hfill 姓\hfill 名\hfill 、\hfill 职\hfill 称：}{\gzu@supervisor}
      \gzu@cover@info@row{207}{学\hfill 科\hfill 专\hfill 业：}{\gzu@discipline}
      \gzu@cover@info@row{216}{研\hfill 究\hfill 方\hfill 向：}{\gzu@research@direction}
      \gzu@cover@info@row{225}{培\hfill 养\hfill 单\hfill 位：}{\gzu@department}

      % Location and date: SimHei 14 bp; Latin numbers in Times New Roman.
      \node[anchor=north,align=center,text width=155mm]
        at ([yshift=-251mm]current page.north)
        {\gzu@cover@hei\gzu@cover@times\fontsize{14bp}{20bp}\selectfont
          中国·贵州·贵阳\\[1.5mm]
          \gzu@date};
    \end{tikzpicture}%
  \end{titlepage}%
}

\newcommand\gzu@acknowledgements@name{致\quad 谢}
\newcommand\gzu@acknowledgements@tocname{致谢}

\newenvironment{acknowledgements}{%
  \chapter*{\gzu@acknowledgements@name}%
  \markboth
    {\gzu@acknowledgements@tocname}
    {\gzu@acknowledgements@tocname}%
  \@ifpackageloaded{hyperref}{\phantomsection}{}%
  \addcontentsline{toc}{chapter}{%
    \gzu@acknowledgements@tocname}%
  \ignorespaces
}{\par}
\g@addto@macro\appendix{%
  \@mainmattertrue
  \ctexset{
    chapter = {
      name = {附录~,},
      aftername = \par,
    }
  }%
  \protected@write\@auxout{}{%
    \string\ttl@writefile{toc}{%
      \protect\setcounter{tocdepth}{0}%
    }%
  }%
}

\endinput
%%
%% End of file `gzuthesis.cls'.
