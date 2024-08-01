% uhhltthesis
%
% Originally by Keith A. Gillow (gillow@maths.ox.ac.uk), 1997
% Modified by Sam Evans (sam@samuelevansresearch.org), 2007
% Modified by John McManigle (mcmanigle@gmail.com), 2015
% Modified by Steffen Remus (steremus@gmail.com), 2023
%
%-------------------------- identification ---------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{conf/uhhltthesis}[2023/12/01 LT Hamburg University thesis class] % based on {ociamthesis}[2015/04/30 Oxford thesis class]
%-------------------------- initial code -----------------------

% Set encoding
\usepackage[utf8]{inputenc}

% JEM: Defaults to one-side, but passing 'twoside' should set everything up for that
\LoadClass[openright,12pt]{report}

\newif\ifmc@nobind
\mc@nobindfalse

\newif\ifmasters % master?
\newif\ifbachelors % bachelor?
\newif\ifdissertation % phd?
\newif\ifuhh % UHH thesis style
\newif\ifdebugbibkeys % debug bib keys?
% presets for ifs
\mastersfalse
\bachelorsfalse
\dissertationfalse
\uhhtrue
\debugbibkeysfalse

\DeclareOption{nobind}{\mc@nobindtrue}
\DeclareOption{msc}{\masterstrue}
\DeclareOption{bsc}{\bachelorstrue}
\DeclareOption{phd}{\dissertationtrue}
\DeclareOption{debugbibkeys}{\debugbibkeystrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\setlength{\parskip}{0pt plus 1pt}
\setlength{\parfillskip}{0pt plus .7\textwidth}

% JEM: Lengths for single spacing (ie separate abstract, captions), front matter (abstract,
%   acknowledgements, table of contents, etc), and main body text.
\newlength{\singlebaselineskip}
\newlength{\frontmatterbaselineskip}
\newlength{\textbaselineskip}

\setlength{\singlebaselineskip}{\baselineskip}
\setlength{\frontmatterbaselineskip}{17pt plus1pt minus1pt}
\setlength{\textbaselineskip}{22pt plus2pt}

\newcommand{\submittedtext}{{A thesis submitted for the degree of}}
\usepackage{varwidth}
\newcommand{\originalitytext}{%
   \rule[-2mm]{1pt}{7mm}\hspace{-1pt}%
   \rule[-2mm]{7mm}{1pt}\hspace{-1pt}%
   \rule[-2mm]{1pt}{7mm}\hspace{-7mm}%
   \rule[5mm]{7mm}{1pt}\hspace{1em}%
   \begin{varwidth}{\textwidth}I hereby certify that this is entirely\\my own work unless otherwise stated.\end{varwidth}}

%
% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

% The year and term the degree will be officially conferred
\def\degreedate#1{\gdef\@degreedate{#1}}
% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}
% The name of your Oxford college (eg Christ Church, Pembroke)
\def\college#1{\gdef\@college{#1}}
% The name of your University (eg Hamburg University)
\def\university#1{\gdef\@university{#1}}
% The address of your University (eg Hamburg, Germany)
\def\address#1{\gdef\@address{#1}}
% The logo of your University (eg {\includegraphics{figures/beltcrest.pdf}})
\def\universitylogo#1{\gdef\@universitylogo{#1}}
% The logo of your faculty
\def\facultylogo#1{\gdef\@facultylogo{#1}}
% The logo of your researchgroup
\def\grouplogo#1{\gdef\@grouplogo{#1}}
% Your date of submission
\def\dateofsubmission#1{\gdef\@dateofsubmission{#1}}
% Your date of defending
\def\dateofdisputation#1{\gdef\@dateofdisputation{#1}}
% Your type of submission, i.e. Dissertation, Master's Thesis, Bachelor's Thesis, Thesis, ...
\def\typeofthesis#1{\gdef\@typeofthesis{#1}}
% Your supervisor(s)
\def\supervisonby#1{\gdef\@supervisonby{#1}}
% Your entire committe e.g. reviewer 1, reviewer 2, ...
\def\comittee#1{\gdef\@comittee{#1}}
% Your faculty, eg. Faculty of Mathematics, Informatics and Natural Sciences
\def\faculty#1{\gdef\@faculty{#1}}
% Your department, eg. Department of Informatics
\def\department#1{\gdef\@department{#1}}
% Your research group, eg. Language technology
\def\researchgroup#1{\gdef\@researchgroup{#1}}
% Your title plain w/o linebreaks
\def\titleplain#1{\gdef\@titleplain{#1}}
% Your declaration of academic honesty
\def\affidavit#1{\gdef\@affidavit{#1}}
% Your field of study
\def\fieldofstudy#1{\gdef\@fieldofstudy{#1}}
% Your matriculation number
\def\matriculationno#1{\gdef\@matriculationno{#1}}


%% DEFAULTS
\university{Universit\"a{}t Hamburg}%
\address{Hamburg, Germany}%
\faculty{}
\department{}
\researchgroup{}
\fieldofstudy{}
\matriculationno{}

\universitylogo{
  \includegraphics[width=\textwidth,clip,trim=1.95cm 2.5cm 1.95cm 2.5cm]{figures/up-uhh-logo-u-2010-u-farbe-u-cmyk-modus}
}
\newcommand{\universitylogobox}{
  \begin{minipage}[b]{62mm}
    \noindent
    \@universitylogo
  \end{minipage}
}

\facultylogo{
  % \includegraphics[width=\textwidth]{figures/uhh-min-faculty-de}
}
\newcommand{\facultylogobox}{
  \begin{minipage}[b]{62mm}
    \noindent
    \@facultylogo
  \end{minipage}
}

\grouplogo{
  % \includegraphics[width=\textwidth]{figures/uhh-lt-logo}
}
\newcommand{\grouplogobox}{
  \begin{minipage}[b]{11mm}
    \noindent
    \@grouplogo
  \end{minipage}
}

\newcommand{\typeofmonograph}{{T~~H~~E~~S~~I~~S}}
\typeofthesis{Thesis}
\newcommand{\titlepagerequirements}{}
\def\titlesseppacing{35mm}%

\ifbachelors
\renewcommand{\typeofmonograph}{{B~A~C~H~E~L~O~R~T~H~E~S~I~S}}
% Your type of submission, i.e. Dissertation, Master's Thesis, Bachelor's Thesis, Thesis, ...
\typeofthesis{Bachelor's Thesis}
\renewcommand{\titlepagerequirements}{%
\vspace*{1ex} %
Field of Study: \@fieldofstudy \par %
Matriculation No.: \@matriculationno \par %
\@comittee %
\vspace*{1ex}%
}%
\def\titlesseppacing{25mm}%
\else {} \fi

\ifmasters 
\renewcommand{\typeofmonograph}{{M~A~S~T~E~R~T~H~E~S~I~S}}
\typeofthesis{Masters's Thesis}
\renewcommand{\titlepagerequirements}{%
\vspace*{1ex} %
Field of Study: \@fieldofstudy \par %
Matriculation No.: \@matriculationno \par %
\@comittee %
\vspace*{1ex}%
}%
\def\titlesseppacing{25mm}%
\else {} \fi

\ifdissertation 
\renewcommand{\typeofmonograph}{{D~I~S~S~E~R~T~A~T~I~O~N}}
\typeofthesis{Dissertation}
\else {} \fi


%
% CRESTS
%
\def\crest{\@universitylogo}

%
% Define text area of page and margin offsets
%

\ifmc@nobind
\usepackage[includehead,ignoremp,hmargin={3.1cm, 3.1cm}, vmargin={1.7cm,2.4cm},headsep=.8cm,footskip=1.2cm]{geometry}
\else
\usepackage[includehead,ignoremp,hmargin={4.1cm, 3.1cm}, vmargin={1.7cm,2.4cm},headsep=.8cm,footskip=1.2cm]{geometry}%
\fi

\usepackage[dvipsnames]{xcolor}
\usepackage[pdftex]{graphicx}
	% allows graphics in pdf format.


\usepackage{fancyhdr}
\setlength{\headheight}{15pt}
\fancyhf{} % clear the header and footers
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter. #1}{\thechapter. #1}}
\renewcommand{\sectionmark}[1]{\markright{\thesection. #1}}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LO]{\emph{\leftmark}}
\fancyhead[RE]{\emph{\rightmark}}
\fancyhead[RO,LE]{\emph{\thepage}}

\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\emph{\thepage}}}

% JEM fix header on cleared pages for openright
\def\cleardoublepage{\clearpage\thispagestyle{empty}\if@twoside \ifodd\c@page\else
   \hbox{}
   \fancyhead[RE,LO]{}
   \newpage
   \if@twocolumn\hbox{}\newpage
   \fi
   \fancyhead[LO]{\emph{\leftmark}}
   \fancyhead[RE]{\emph{\rightmark}}
   \fi\fi}


\usepackage{microtype}
\usepackage{nicefrac}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{textcomp}

\usepackage{longtable}
	% Allows tables to span multiple pages (this package must be called before hyperref)

\usepackage[font=small,labelfont=bf]{caption}
	% Nicer captions

\usepackage{multicol,multirow,array}
	% Used to make multiple columns for the indices and for creating columns that span multiple rows in tables

\usepackage{rotating}
	% To allow tables in landscape mode

\usepackage{booktabs}
	% For better looking tables

\usepackage{pdfpages}
	% Allows multi-page pdfs to be inserted as graphics

\usepackage{xfrac}

%\usepackage{enumerate}
	% Allows different numbering styles for Lists
	% to use:
	% \begin{enumerate}[x]
		% \item text
	% \end{enumerate}
	% where x is:
	% A	uppercase letters (as produced by \Alph)
	% a	lowercase letters (as produced by \alph)
	% I	uppercase roman numerals (as produced by \Roman)
	% i	lowercase roman numerals (as produced by \roman)
	% 1	arabic numbers (as produced by \arabic)

% JEM the following package allows changing spacing in lists (for acknowledgements)
%\usepackage{enumitem}
	% interferes with paralist for in paragraph enumerations

% JEM the following allows table columns aligned by decimal point
\usepackage{dcolumn}
\newcolumntype{d}[3]{D{.}{\cdot}{#1} }

\usepackage{appendix}
	% For helping format appendicies
\usepackage{notoccite}
	% To format the bibliography


\usepackage[colorlinks=false,pdfpagelabels]{hyperref}
	% for linking between references, figures, TOC, etc in the pdf document

\usepackage[nohints,tight]{minitoc}
	\setcounter{minitocdepth}{2}
	% Generates mini tables of contents per chapter

% JEM: The following fixes minitoc to not be multiple-spaced.
\let\oldmtc@verse\mtc@verse
\renewcommand{\mtc@verse}[1]{\oldmtc@verse{#1}\setlength{\baselineskip}{\z@}}


%
% Environments
%

% This macro define an environment for front matter that is always
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi}%
       {\if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}

%define title page layout
\newcommand{\maketitleuhh}{%
 \newgeometry{left=2.5cm,top=1.5cm,right=2.5cm,bottom=1.5cm,ignoremp}%
 \begin{titlepage}%
  \setcounter{page}{1}
  \renewcommand{\footnotesize}{\small}
  \renewcommand{\footnoterule}{\relax}
  \thispagestyle{empty}\pagestyle{empty}
  \noindent
  \universitylogobox
  \hfill
  \facultylogobox
  \hfill
  \grouplogobox
  \par
  \vspace*{\titlesseppacing}
  \begin{center}
    {\Large { {\textcolor{red}{\bf \sffamily \typeofmonograph}}} \par}
    \vspace*{\titlesseppacing}
    { \LARGE {\bfseries {\@title}} \par}
    \vspace*{\titlesseppacing}
    {{\Large \@author} \par}
    {\large \vspace*{1ex} 
      {{\titlepagerequirements}}
      {{\@researchgroup \par \@department \par \@faculty} \par}
      \vspace*{1ex}
      {{\@university\\\@address} \par}
      \vspace*{\titlesseppacing}
      {{\submittedtext} \par}
      \vspace*{1ex}
      {\it {\@degree} \par}
      \vspace*{2ex}
      {\@degreedate}
    }
  \end{center}
  %
  \clearpage
  %%% HERE COMES THE BACK OF THE TITLE PAGE
  \restoregeometry
  %%% AFFIDAVIT BEGIN:
  \bgroup%
    %
    \setlength{\baselineskip}{\frontmatterbaselineskip}%
    %
    \sffamily%
    \noindent%
    \@titleplain \\[\baselineskip]%
    \@typeofthesis ~ submitted by: \@author \\[\baselineskip]%
    \noindent
    \begin{tabular*}{\linewidth}{@{}l@{~}l@{}}%
      Date of Submission:  & \@dateofsubmission \\%
      \ifdissertation
        Date of Disputation: & \@dateofdisputation \\%
      \else {} \fi
      & \\%
    \end{tabular*}
    %
    \par\noindent Supervisor(s): \par%
    \noindent
    \@supervisonby
    \vspace{\baselineskip}
    %
    \par\noindent Committee: \par%
    \noindent
    \@comittee
    %
    \vfill%
    %
    \noindent%
    \@university,~\@address \\%
    \@faculty \\%
    \@department \\[.5\baselineskip]%
    \@researchgroup %
    %
    \clearpage%
    % NEXT PAGE: AFFIDAVIT as part of titlepage
    %
    \setlength{\baselineskip}{\frontmatterbaselineskip}%
    %
    \vspace*{40pt}%
    \null\hfill { \Huge Affidavit\\ }%
    \vspace*{30pt}%
    %
    \@affidavit
    %
    \vspace*{6em}%
    %
    \noindent%
    \begin{center}%
      \begin{tabular}{@{}c@{}p{2cm}@{}c@{}}%
        \hrulefill & & \hrulefill \\%
        \parbox{6cm}{\centering Date} & & \parbox{6cm}{\centering Signature} \\%
        & & \parbox{6cm}{\centering \scriptsize (\@author)} \\%
      \end{tabular}%  
    \end{center}%
    
  \egroup%
  %%% AFFIDAVIT END
 \end{titlepage}
 \restoregeometry
}%

% redefine maketitle
\renewcommand{\maketitle}{\maketitleuhh}


% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.
\newenvironment{dedication}
{\begin{alwayssingle}
  \thispagestyle{empty}
  \vspace*{\fill} \begin{center}}
{\end{center}\vspace*{\fill}\vspace*{\fill} \end{alwayssingle}}


% THEMED QUOTE
%
% The themedquote environment makes sure the themed quote gets its
% own page and is set out in verse format.
\newsavebox{\quoteauthor}
\newenvironment{themedquote}[1]{%
  \sbox\quoteauthor{#1}%
  \begin{alwayssingle}
    \thispagestyle{empty}
    \vspace*{\fill} 
    \begin{center}
      \begin{minipage}{.80\linewidth}\centering
        \begin{minipage}{.90\linewidth}\raggedleft\it
}%
{%
        \end{minipage}\\[.5\baselineskip]
        \hfill ---~\usebox{\quoteauthor}
      \end{minipage}
    \end{center}
    \vspace*{\fill}
    \vspace*{\fill} 
  \end{alwayssingle}
}%


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

\newenvironment{acknowledgements}%
{   \begin{alwayssingle}\chapter*{Acknowledgements}
    \thispagestyle{empty}
	\pagestyle{empty}
	\setlength{\baselineskip}{\frontmatterbaselineskip}
}
{\end{alwayssingle}}


%ABSTRACT
%
%The abstract environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself appears in a quote environment,
%i.e. tabbed in at both sides, and on its own page.

\renewenvironment{abstract}%
{   \begin{alwayssingle}\chapter*{Abstract}
    \thispagestyle{empty}
    \pagestyle{empty}
   \setlength{\baselineskip}{\frontmatterbaselineskip}}
{\end{alwayssingle}}


%ABSTRACT GERMAN
%
%The abstract environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself appears in a quote environment,
%i.e. tabbed in at both sides, and on its own page.

\newenvironment{germanabstract}%
{   \begin{alwayssingle}\begin{otherlanguage}{ngerman}\chapter*{Zusammenfassung}
    \thispagestyle{empty}
    \pagestyle{empty}
   \setlength{\baselineskip}{\frontmatterbaselineskip}}
{\end{otherlanguage}\end{alwayssingle}}


%
% List of publications
%
\newenvironment{listofpublications}%
{   \begin{alwayssingle}\chapter*{List of Publications}\addcontentsline{toc}{chapter}{List of Publications}
   \setlength{\baselineskip}{\frontmatterbaselineskip}}
{\end{alwayssingle}}


%The abstractseparate environment is for running of a page with the abstract
%on including title and author etc as required to be handed in separately

\newenvironment{abstractseparate} {\newgeometry{margin=3.3cm}\thispagestyle{empty}\begin{alwayssingle}
 \begin{center}
    {\Large \bfseries \@title \par}
    {{\large \vspace*{2ex} \@author} \par}
{\large \vspace*{1ex}
{{\@college} \par}
{{\@university,~\@address} \par}
\vspace*{1ex}
    {{\it \submittedtext} \par}
    {\it {\@degree} \par}
\vspace*{2ex}
    {\@degreedate} \par}
\vfill
  {\Large \bfseries  Abstract}
  \end{center}
\vspace{1ex}
   \setlength{\baselineskip}{\z@}}
{\vfill\end{alwayssingle}\restoregeometry}


%ROMANPAGES
%
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).
%
% Edited by JEM

\newenvironment{romanpages}
{\cleardoublepage\setlength{\baselineskip}{\frontmatterbaselineskip}\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\cleardoublepage\setcounter{page}{1}\renewcommand{\thepage}{\arabic{page}}}


%Figure placement on page
%
%This is to help prevent too many figures on their own pages.  I got it from:
% http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/LatexTips.html#captfont

\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}


% JEM: VERSE, QUOTATION, and QUOTE must be single-spaced.
% These rename the internal commands for the \begin{...} and
% \end{...} environment commands.
\let\@ldquote=\quote
\let\@ldendquote=\endquote
\renewenvironment{quote}
   {\@ldquote\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendquote}

\let\@ldqttn=\quotation
\let\@ldendqttn=\endquotation
\renewenvironment{quotation}
   {\@ldqttn\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendqttn}

\let\@ldverse=\verse
\let\@ldendverse=\endverse
\renewenvironment{verse}
   {\@ldverse\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendverse}

% JEM: Stuff for List of Abbreviations (or Glossary or other list)
\usepackage{calc}
\newcommand{\t@cfill}{\cleaders\hbox{$\m@th \mkern\@dotsep mu . \mkern\@dotsep mu$}\hfill}
\newcommand{\abbrl@bel}[1]{\makebox[\labelwidth][l]{\textbf{#1}\ \t@cfill}}
\newenvironment{mclistof}[2]{%
   \chapter*{#1}%
   \addcontentsline{toc}{chapter}{#1}
   \begin{list}{}%
   {\renewcommand{\makelabel}{\abbrl@bel}%
    \setlength{\labelwidth}{#2}%
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\itemsep}{0pt}%
    \markboth{#1}{#1}%
   }}
   {\end{list}\mtcaddchapter}


\usepackage[grey,utopia]{quotchap}
	% To put nice quotes at the beginning of the chapters

\usepackage[nottoc]{tocbibind}
	% Used for inserting the Bibliography, List of Figures, indices, etc into the table of contents.

% JEM: Allow flexible spacing after figures, to reduce other stretching
\setlength{\textfloatsep}{20pt plus15pt minus4pt}

% JEM: Fix paragraph spacing within quotes for multi-par quotes
\renewenvironment{savequote}[1][10cm]{%
\begin{lrbox}{\@quotebox}
\begin{minipage}[t]{#1}\footnotesize\slshape%
\setlength{\parskip}{6px}}{%
\unskip\end{minipage}\end{lrbox}
\global\setbox\@quotebox\copy\@quotebox
\global\let\@printcites\@iprintcites
\ignorespacesafterend}
\renewcommand{\qauthor}[1]{\par
{\raggedleft\upshape #1\qquad\hbox{}\par}\bigskip}

% JEM: All of this is so that headers in these sections aren't uppercase
\let\@ldtoc\tableofcontents
\renewcommand*\tableofcontents{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldtoc}}
\let\@ldlof\listoffigures
\renewcommand*\listoffigures{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlof}}
\let\@ldlot\listoftables
\renewcommand*\listoftables{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlot}}
\let\@ldbib\bibliography
\renewcommand*\bibliography[1]{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldbib{#1}}}

% JEM: for crazy multi character set quotes and Unicode and all
%\usepackage{lmodern}
%\usepackage[LGR,TS1,T1]{fontenc}
%\usepackage[utf8]{inputenc}
%\usepackage[greek,latin,ngerman,english]{babel}
\usepackage{csquotes}
\hyphenpenalty=500
\def\longs{{\fontencoding{TS1}\selectfont s}}

% JEM: for highlighting corrections
\newlength{\mccurrentbaselineskip}
\newlength{\mccurrentparskip}
\newlength{\mccurrentparindent}
\newif\ifcorrections
\newif\ifm@csection
\m@csectionfalse
\correctionsfalse

\colorlet{shadecolor}{blue!20}

\usepackage{framed}
\OuterFrameSep=-9pt
\newenvironment{mccorrection}
{\ifcorrections\if@nobreak\m@csectiontrue\fi\begin{shaded}\ifm@csection\noindent\ignorespaces\fi\fi}
{\ifcorrections\end{shaded}\m@csectionfalse\ifx\@captype\@undefined\@nobreakfalse\fi\fi}

\usepackage{soul}
\sethlcolor{shadecolor}
\newcommand{\mccorrect}[1]{\ifcorrections\hl{#1}\else#1\fi}


% JEM: adjust start-of-chapter spacing
\renewcommand{\chapterheadstartvskip}{\vspace*{40pt}}
\renewcommand{\chapterheadendvskip}{\vspace{30pt}}


% JEM: combine all of the commands you run before appendices start
\newcommand{\startappendices}
  {\appendix\adjustmtc\noappendicestocpagenum\addappheadtotoc\appendixpage}


%%%%% BIBLIOGRAPHY SETUP
\usepackage[
    authordate,
    natbib,
    backend=biber,
    bibencoding=inputenc,
    maxbibnames=99,
    minbibnames=1,
    maxcitenames=2,
    mincitenames=1,
    backref=true,
    backrefstyle=all+,
    hyperref=true,
    sorting=nyt,
    useprefix=true,
    block=space,
    giveninits=false,
    doi=false,
    isbn=false,
    url=false,
    terseinits=true,
    dashed=true,
    ibidtracker=false
]{biblatex-chicago}%

% how to sort
\DeclareNameAlias{sortname}{last-first}

% firstname lastname format for all entries
\DeclareNameAlias{author}{given-family}

% makes bibliography left-aligned and slightly small
\renewcommand*{\bibfont}{\raggedright\small}

% no special format for title
\DeclareFieldFormat*{title}{#1\isdot}

% notes in brackets (TODO: not sure if the addendum should be activated)
%\DeclareFieldFormat{addendum}{(#1)}
\DeclareFieldFormat{addendum}{}

% parenthesized in-text citations with comma
\renewcommand*{\nameyeardelim}{\addcomma\space}

% parenthesized in-text citations with colon instead of space
\renewcommand*{\prenotedelim}{}
\renewcommand*{\postnotedelim}{}

% redefine \cite
\let\oldcite\cite
\let\cite\citep

\newbibmacro{string+doiurlisbn}[1]{%
  \iffieldundef{doi}{%
    \iffieldundef{url}{%
      \iffieldundef{isbn}{%
        \iffieldundef{issn}{%
          #1%
        }{%
          \href{https://search.worldcat.org/search?q=n2:\thefield{issn}}{#1}%
        }%
      }{%
        \href{https://search.worldcat.org/search?q=bn:\thefield{isbn}}{#1}%
      }%
    }{%
      \href{\thefield{url}}{#1}%
    }%
  }{%
    \href{http://dx.doi.org/\thefield{doi}}{#1}%
  }%
}
\DeclareFieldFormat{title}{\usebibmacro{string+doiurlisbn}{#1}}
\DeclareFieldFormat[article,incollection]{title}%
    {\usebibmacro{string+doiurlisbn}{#1}}

%% DEBUG BIB KEYS FOR DRAFT, deactivate for final version!
\ifdebugbibkeys
\DeclareFieldFormat{entrykey}{%
 \textcolor{orange}{%
   \mkbibbrackets{#1}}}
%
\renewbibmacro*{finentry}{%
 \setunit{\finentrypunct\addspace}%
 \printfield{entrykey}%
 \renewcommand\finentrypunct{}%
 \finentry
}
\else {} \fi


% chapter title
\newcommand*{\bibtitle}{References}

% cite only first author and year
\newcommand\singlecite[1]{\AtNextCite{\defcounter{maxnames}{1}}\citeauthor{#1}~(\citeyear{#1})}

%%% COMMAND DEFINITIONS
% To make text superscripts shortcuts
\renewcommand{\th}{\textsuperscript{th}} % ex: I won 4\th place
\newcommand{\nd}{\textsuperscript{nd}}
\renewcommand{\st}{\textsuperscript{st}}
\newcommand{\rd}{\textsuperscript{rd}}

% define an abstract per chapter
\newenvironment{chapterabstract}%
{%\setlength{\baselineskip}{\frontmatterbaselineskip}%
  \small%
  \hspace*{0.1\linewidth}%
  \begin{minipage}{.8\linewidth}%
  \parindent1em%
  \bf%
  \small%
}{%
  ~\vspace{\medskipamount}%
  \end{minipage}%
}%

% change margin of a page
\newenvironment{changemargin}[2]{%
  \begin{list}{}{%
    \setlength{\topsep}{0pt}%
    \setlength{\leftmargin}{#1}%
    \setlength{\rightmargin}{#2}%
    \setlength{\listparindent}{\parindent}%
    \setlength{\itemindent}{\parindent}%
    \setlength{\parsep}{\parskip}%
  }%
  \item[]}{\end{list}}%
%

% define some extra colors
\definecolor{darkred}{rgb}{.8,0,0}
\definecolor{darkgreen}{rgb}{0,.5,0}

