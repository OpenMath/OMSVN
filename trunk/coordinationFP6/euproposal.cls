
\LoadClass[a4paper,oneside,mctitle]{rapport3}
\usepackage{textcomp}
\usepackage{multicol}
\usepackage{url}
\usepackage{lscape,longtable}
\usepackage{graphicx}
\usepackage{calc}
\usepackage{colortbl}
\usepackage[latin1]{inputenc}

\addtolength\textwidth{1.5in}
%\addtolength\oddsidemargin{-0.25in}
\addtolength\oddsidemargin{-0.75in}
\addtolength\evensidemargin{-1.25in}

\addtolength\textheight{.75in}
\addtolength\topmargin{-0.5in}


\def\thepart{\Alph{part}}

\def\thechapter{\thepart.\arabic{chapter}}
\def\@makechapterhead#1{%
  {\setlength\parindent{\z@}%
   \setlength\parskip  {\z@}%
   \head@style \normalfont
    \Large \ChapFont \thechapter: #1\par
    \nobreak
    \vskip 40\p@
  }}
\def\tableofcontents{%
    \chapter*{\contentsname
        \@mkboth{\MakeUppercase{\contentsname}}%
                {\MakeUppercase{\contentsname}}}%
    \@starttoc{toc}%
    }

\def\ps@empty{%
\def\@oddfoot{\hfill page~\thepage~of~\thelastpage}%
}

\def\ps@plain{
\def\@oddhead{\emph{MCD\hfill{}\hfill\today{}}}
\let\@evenhead\@oddhead
\def\@oddfoot{\hfill page~\thepage~of~\thelastpage}%
\let\@evenfoot\@oddfoot
}

\pagestyle{plain}

\def\@listi{%
            \leftmargin20pt\relax
            \labelsep.5em%
            \labelwidth\leftmargin
            \advance\labelwidth-\labelsep
            \parsep \z@
            \topsep -.5\parskip \@plus\p@
            \itemsep 0\p@ \@plus1\p@}
\let\@listI\@listi
\@listi

\AtEndDocument{%
  \clearpage
  \count@\c@page
  \advance\count@\m@ne
  \edef\@tempa{\the\count@}%
  \ifx\@tempa\thelastpage
  \else
    \ClassWarningNoLine{euproposal}{Last page changed: Rerun LaTeX}%
  \fi
  \immediate\write\@auxout{%
    \gdef\string\thelastpage{\the\count@}}}
\def\thelastpage{??}

\g@addto@macro\maketitle{\setcounter{page}{2}}
