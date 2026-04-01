%% polinetwork.cls
%% PoliNetwork APS — Document Class
%% 
%% Modular LaTeX class inspired by Awesome-CV structure.
%% Supports XeLaTeX and LuaLaTeX via fontspec.
%%
%% Usage:
%%   \documentclass[legal]{polinetwork}    % for legal documents (privacy, T&C)
%%   \documentclass[letter]{polinetwork}   % for letters
%%   \documentclass[report]{polinetwork}   % for reports with title page
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{polinetwork}[2026/04/01 PoliNetwork APS Document Class v1.0]

%% ========================================================================
%% CLASS OPTIONS
%% ========================================================================

\newif\if@pnletter   \@pnletterfalse
\newif\if@pnreport   \@pnreportfalse
\newif\if@pnlegal    \@pnlegalfalse

\DeclareOption{letter}{\@pnlettertrue}
\DeclareOption{report}{\@pnreporttrue}
\DeclareOption{legal}{\@pnlegaltrue}

% Pass all unknown options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Base class
\LoadClass[a4paper, 11pt]{article}

%% ========================================================================
%% REQUIRED PACKAGES
%% ========================================================================

% Page geometry
\RequirePackage[
  a4paper,
  top=2.5cm,
  bottom=2.5cm,
  left=2.5cm,
  right=2.5cm,
  headheight=1.5cm,
  headsep=0.8cm,
  footskip=1.5cm
]{geometry}

% Font support (XeLaTeX / LuaLaTeX)
\RequirePackage{fontspec}
\RequirePackage{unicode-math}

% Typography
\RequirePackage{microtype}
\RequirePackage{setspace}
\RequirePackage{parskip}

% Graphics
\RequirePackage{graphicx}
\RequirePackage{tikz}

% Tables
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{longtable}

% Lists
\RequirePackage{enumitem}

% Links
\RequirePackage[
  colorlinks=true,
  linkcolor=pn-link,
  urlcolor=pn-link,
  citecolor=pn-primary,
  bookmarks=true,
  bookmarksnumbered=true
]{hyperref}

% Header/Footer
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

% Conditionals
\RequirePackage{ifthen}
\RequirePackage{xifthen}

%% ========================================================================
%% LOAD POLINETWORK PACKAGES
%% ========================================================================

\RequirePackage{polinetwork-colors}
\RequirePackage{polinetwork-commands}

%% ========================================================================
%% FONT CONFIGURATION
%% ========================================================================

% DM Sans — primary body/display font
\newfontfamily\dmsansfont{DMSans}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Variable,
  ItalicFont     = *-Variable-Italic,
  BoldFeatures   = {RawFeature={weight=700}},
  ItalicFeatures = {RawFeature={weight=400}},
  BoldItalicFeatures = {RawFeature={weight=700}},
]

% Poppins — headlines & wordmark
\newfontfamily\poppinsfont{Poppins}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Regular,
  BoldFont       = *-Bold,
  ItalicFont     = *-Italic,
  BoldItalicFont = *-MediumItalic,
  FontFace       = {m}{n}{*-Medium},
  FontFace       = {sb}{n}{*-SemiBold},
]

% Red Hat Text — labels, captions, small text
\newfontfamily\redhattextfont{RedHatText}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Variable,
  ItalicFont     = *-Variable-Italic,
  BoldFeatures   = {RawFeature={weight=700}},
]

% Set main document fonts
\setmainfont{DMSans}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Variable,
  ItalicFont     = *-Variable-Italic,
  BoldFeatures   = {RawFeature={weight=700}},
  ItalicFeatures = {RawFeature={weight=400}},
  BoldItalicFeatures = {RawFeature={weight=700}},
]

% Aliases for use in commands.sty
\let\headlinefont\poppinsfont
\let\labelfont\redhattextfont

%% ========================================================================
%% PARAGRAPH & SPACING
%% ========================================================================

\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt plus 2pt minus 1pt}
\onehalfspacing

% Line color for body text
\color{pn-text}

%% ========================================================================
%% SECTION STYLING  
%% ========================================================================

\RequirePackage{titlesec}

% Section: blue bar + Poppins bold
\titleformat{\section}
  {\Large\poppinsfont\bfseries\color{pn-text}}
  {\textcolor{pn-rule}{\rule[-2pt]{4pt}{16pt}}\hspace{8pt}\thesection\hspace{8pt}}
  {0pt}
  {}
  [\vspace{-4pt}]

% Subsection: sky-700 + Poppins regular
\titleformat{\subsection}
  {\large\poppinsfont\color{pn-primary}}
  {\thesubsection\hspace{8pt}}
  {0pt}
  {}

% Subsubsection: DM Sans bold
\titleformat{\subsubsection}
  {\normalsize\dmsansfont\bfseries\color{pn-text}}
  {\thesubsubsection\hspace{8pt}}
  {0pt}
  {}

% Spacing
\titlespacing*{\section}{0pt}{18pt}{8pt}
\titlespacing*{\subsection}{0pt}{12pt}{6pt}
\titlespacing*{\subsubsection}{0pt}{8pt}{4pt}

%% ========================================================================
%% LIST STYLING
%% ========================================================================

\setlist{
  leftmargin=1.5em,
  itemsep=3pt,
  parsep=0pt,
  topsep=4pt,
}

\setlist[itemize]{
  label={\textcolor{pn-primary}{\textbullet}},
}

\setlist[enumerate]{
  label={\textcolor{pn-primary}{\arabic*.}},
}

\setlist[description]{
  font=\normalfont\color{pn-primary}\bfseries,
}

%% ========================================================================
%% HEADER / FOOTER (fancyhdr)
%% ========================================================================

\pagestyle{fancy}
\fancyhf{} % clear defaults

% First page: full header via \pnMakeHeader (called manually)
% Subsequent pages: compact running header
\fancyhead[L]{\pnMakeRunningHeader}
\fancyhead[R]{%
  \small\color{pn-text-muted}%
  \ifthenelse{\equal{\pn@doctitle}{}}{}{\pn@doctitle}%
}
\fancyfoot[C]{%
  \small\color{pn-text-muted}%
  \pn@str@page~\thepage~\pn@str@of~\pageref*{LastPage}%
}
\fancyfoot[R]{%
  \footnotesize\color{pn-text-muted}%
  \pn@associationname%
}

% Rule styling
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\headrule}{\hbox to\headwidth{\color{pn-sky-300}\leaders\hrule height \headrulewidth\hfill}}
\renewcommand{\footrulewidth}{0pt}

% First page style: no running header
\fancypagestyle{firstpage}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[C]{%
    \small\color{pn-text-muted}%
    \pn@str@page~\thepage~\pn@str@of~\pageref*{LastPage}%
  }
  \fancyfoot[R]{%
    \footnotesize\color{pn-text-muted}%
    \pn@associationname%
  }
}

% Title page style (no header/footer)
\fancypagestyle{titlepage}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

%% ========================================================================
%% HYPERREF METADATA
%% ========================================================================

\AtBeginDocument{%
  \hypersetup{
    pdftitle={\pn@doctitle},
    pdfauthor={\pn@associationname},
    pdfsubject={\pn@docsubject},
    pdfcreator={XeLaTeX with polinetwork.cls},
  }%
}

%% ========================================================================
%% CONVENIENCE: AUTO-SETUP BASED ON DOCUMENT TYPE
%% ========================================================================

% Legal documents (privacy, T&C): use numbered sections, no title page
\if@pnlegal
  % Enable paragraph numbering for legal docs
  \setcounter{secnumdepth}{3}
\fi

% Reports: will use \pnMakeTitlePage
\if@pnreport
  \setcounter{secnumdepth}{3}
\fi

% Letters: simpler layout
\if@pnletter
  \setcounter{secnumdepth}{0}
  % Tighter margins for letters
  \geometry{top=2cm, bottom=2cm, left=2.5cm, right=2.5cm}
\fi

\endinput
