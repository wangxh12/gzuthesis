% mythesis.cls
\ProvidesClass{mythesis}[2026/09/20 v0.0.1 Minimal thesis class]

% 1. 加载基类：学位论文一般基于 report，不要用 article/book
% report 自带 chapter 章节，适合学位论文
\LoadClass[12pt,a4paper,openright]{report}

% 2. 设置页面基础：页边距，先用 geometry
\RequirePackage{geometry}
\geometry{
    left=3cm,
    right=2cm,
    top=2.5cm,
    bottom=2.5cm
}

% 3. 基础宏包预先加载，模板类里面 RequirePackage，用户tex不要重复写
\RequirePackage{ctex}   % 中文支持，国内学位必用
\RequirePackage{setspace} % 行距

% 设置行距，1.5倍
\onehalfspacing

% 4. 修改章节标题格式：重定义 chapter
\renewcommand{\chaptername}{第}
\renewcommand{\thechapter}{\arabic{chapter}}

% 5. 定义一个简单封面命令，后面扩展
\newcommand{\makemycover}{%
  \begin{center}
    \vspace*{2cm}
    {\Huge\bfseries 学位论文标题}\\[1cm]
    {\Large 作者：XXX}\\[0.5cm]
    {\Large 2026年9月}
  \end{center}
  \clearpage
}

\endinput
