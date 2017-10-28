%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) 2017 by Leland Taylor
%
% This file has been modified and re-distributed from a file by Trey 
% Hunner. The original copyright by Trey Hunner is reproduced below.
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved.  This file is offered as-is,
% without any warranty.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved.  This file is offered as-is,
% without any warranty.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SETTINGS:

% Compile RESUME or CV?
%  RESUME is more compressed designed to fit on one page. 
%  Compression set below using various line spacing settings
\newif\ifresume % use resume settings which compresses the doc
\resumetrue % uncomment to compile resume instead of cv.

% Font size and paper type
%\LoadClass[11pt,letterpaper]{article} % USA
\LoadClass[11pt,a4paper]{article} % UK

% LOAD PACKAGES:
\usepackage[T1]{fontenc} % need this for bold smallcaps font
\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements
\usepackage{multirow}
\usepackage{enumitem} % Required for SKILLS LIST
\usepackage{needspace} % to prevent page break in important lines

% SETTINGS:
% general spacing settings
\def\namesize{\huge} % Size of the name at the top of the document
%\def\addressskip{\smallskip} % Space between the two address at top. DEFUNCT

\ifresume % FOR_RESUME
    \def\pointskip{\smallskip}
    \def\nameskip{\smallskip} % Space after your name at the top
    \def\sectionlineskip{\smallskip} % Space above horizontal line for section 
    \def\sectionskip{\smallskip} % Space after the each section.
\else % FOR_CV 
    \def\pointskip{\bigskip}
    \def\nameskip{\bigskip} % Space after your name at the top
    \def\sectionlineskip{\smallskip} % Space above horizontal line for section 
    \def\sectionskip{\bigskip} % Space after the each section. default = medium
\fi

% change line spacing for everything in the document, including footnotes/tables
\ifresume % FOR_RESUME
    \renewcommand{\baselinestretch}{0.89} 
\else % FOR_CV 
    \renewcommand{\baselinestretch}{1.0}
\fi

% left hand column that runs through the document
\newlength{\lcolglobal}
\setlength{\lcolglobal}{\dimexpr0.14\textwidth} 

% settings for SKILLS LIST
\setitemize[0]{leftmargin=0pt} % remove extra left hand side space
\renewcommand{\labelitemi}{$\cdot$} % change bullet item to dot
\newlength{\pcolwdth} 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADER: Commands for printing name and address

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \addressSep {$ \>\> \>\> $} % Set default address separator to a tab

% One or two address lines can be specified 
\let \@addressone \relax
\let \@addresstwo \relax

% \address command can be used to set the first and second address (optional)
\def \address #1{
  \@ifundefined{@addresstwo}{
    \def \@addresstwo {#1}
  }{
    \def \@addressone {#1}
  }
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  %\addressskip
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\textbf{\textsc{\namesize \@name}}}\hfil
    \nameskip\break
  \endgroup
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRINT THE HEADING LINES

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \printname % Print the name specified with \name
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION FORMATTING

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \needspace{3\baselineskip} % helps prevent hanging headers
 %\sectionskip % skip before section
  \MakeUppercase{#1} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \begin{list}{}{ % List for each individual item in the section
    %\setlength{\leftmargin}{1.5em} % Margin within the section
     \setlength{\leftmargin}{0em} % Margin within the section
     %\smallskip % skip below line
  }
  \item[]
}{ 
 \sectionskip % skip after section
 \end{list}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WORK EXPERIENCE FORMATTING

% 4 input arguments - company name, year(s) employed, job title and location
\newenvironment{rSubsection}[4]{ 
  \noindent % needed if the tabularx env isn't encased in table environment
  \begin{tabular*}{1\textwidth}{@{}
      p{\lcolglobal}
      p{\dimexpr\textwidth-\lcolglobal-2\tabcolsep}
    }
    \multirow[t]{2}{\linewidth}{#2} & 
      {\bf #1} \hfill {#4}
      % If the third argument is not specified, 
      % don't print the job title and location line
      \ifthenelse{ \equal{#3}{} }
        % Italic job title and location
        {}% true 
        {\\ & {#3}\\}% false
    \end{tabular*}\par
    \smallskip
    % \cdot used for bullets, no indentation
    \begin{list}{$\cdot$}{\leftmargin=\dimexpr\lcolglobal+2em}
      % Compress items in list together for aesthetics
      \itemsep -0.5em \vspace{-0.5em} 
    }{
    \end{list}
    {}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERAL ENTRY FORMATTING

\newenvironment{rEntry}[3]{
  \begin{tabular*}{1\textwidth}{@{}
      p{\lcolglobal}
      p{\dimexpr\textwidth-\lcolglobal-2\tabcolsep}
    }
    \multirow[t]{2}{0.1\textwidth}{#2} &
      {\bf{#1}. }{#3.}
    \end{tabular*}\par
    \vspace{-0.25em}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRESENTATION ENTRY FORMATTING

\newenvironment{rPres}[3]{
  \begin{tabular*}{1\textwidth}{@{}
      p{\lcolglobal}
      p{\dimexpr\textwidth-\lcolglobal-2\tabcolsep}
    }
    \multirow[t]{2}{0.1\textwidth}{#2} &
      {{#1} -- }{\emph{#3}.}
    \end{tabular*}\par
    \vspace{-0.25em}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SKILLS LIST FORMAT

% the below code is from the following link
% https://tex.stackexchange.com/questions/54039/a-list-inside-a-table
%
% \begin{tabular}{li{\pcolwdth}}
% 2009--present & \multicolumn{1}{p{\pcolwdth}}{company 1} \\
%               & \item editor                             \\
% 2011--2012    & \multicolumn{1}{p{\pcolwdth}}{company 2} \\
%               & \item judge
%                 \item jury
%                 \item executioner                        \\
% \end{tabular}
\newcolumntype{e}[1]{ %--- Enumerated cells ---
   >{\minipage[t]{\linewidth}%
     \NoHyper % Hyperref adds a vertical space
     \let\\\tabularnewline
     \enumerate
        \addtolength{\rightskip}{0pt plus 20pt}% for raggedright
        \setlength{\itemsep}{-\parsep}}%
   p{#1}%
   <{\@finalstrut\@arstrutbox\endenumerate
     \endNoHyper
     \endminipage}}

\newcolumntype{i}[1]{ %--- Itemized cells ---
   >{\minipage[t]{\linewidth} %if linewidth, can set overall width in main call
        \NoHyper % Hyperref adds a vertical space
        \let\\\tabularnewline
        \itemize
           \setlength{\itemsep}{-0.5em}}%
   p{#1}
   <{\@finalstrut\@arstrutbox\enditemize\endNoHyper\endminipage}}


