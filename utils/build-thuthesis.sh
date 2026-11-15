#!/usr/bin/env bash
# Build the local, unmodified ThuThesis master's example for comparison.
set -euo pipefail
cd -- "$(dirname -- "$0")/.."
project_dir="$PWD"
if [[ -d /usr/local/texlive/2026/bin/x86_64-linux ]]; then
  export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
fi
export TEXMFHOME="$project_dir/build/thuthesis-texmf"
mkdir -p "$project_dir/build/thuthesis"
if [[ "${1:-}" == --install-deps ]]; then
  if [[ ! -f "$TEXMFHOME/tlpkg/texlive.tlpdb" ]]; then
    tlmgr --usermode --usertree "$TEXMFHOME" init-usertree
  fi
  tlmgr --usermode --usertree "$TEXMFHOME" install \
    titlesec notoccite pdfpages enumitem environ footmisc bibunits \
    threeparttable multirow algorithms siunitx xits newtx trimspaces \
    xstring fontaxes xkeyval float bigfoot mweights figureversions \
    accsupp unicode-math lualatex-math translations xpatch
fi
cd "$project_dir/thuthesis"
xetex -interaction=nonstopmode -halt-on-error thuthesis.ins
latexmk -g -jobname=thuthesis-example -outdir="$project_dir/build/thuthesis" thuthesis-preview.tex
