# -------------------------------------------------------
# Resume LaTeX Compiler
# Base  : texlive/texlive:latest  (full TeX Live — available locally)
# Usage : see compile.sh
# -------------------------------------------------------
FROM texlive/texlive:latest

WORKDIR /workspace

# Compile twice: first pass builds TOC/refs, second pass resolves them
CMD ["bash", "-c", \
     "pdflatex -interaction=nonstopmode resume.tex && \
      pdflatex -interaction=nonstopmode resume.tex && \
      echo '--- Compilation successful ---'"]
