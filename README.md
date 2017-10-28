# Academic CV & Resume
A LaTeX academic CV and resume template. Derived from https://github.com/treyhunner/resume.

## Getting Started
1. Edit *academic_cv_resume.tex* and *publications/publications.bib* with your information.
2. Change settings in *academic_cv_resume.tex* for indentation of skill section.
3. Change settings in *resume.cls* where one can (a) toggle between resume or cv settings and (b) set column width for date column on the left hand side.
4. Compile the document using the commands below.

```bash
make # generates pdf
make AUTHOR_NAME="J.~D. Doe"; # generates pdf with author name in bold
make clean # clean up temp files
```

## License

See LICENSE file
