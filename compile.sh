#!/usr/bin/env bash
# -------------------------------------------------------
# compile.sh  (root)
# Compiles any resume profile into output/<profile>/
#
# Usage:
#   bash compile.sh <profile>             # profile name as role label
#   bash compile.sh <profile> "RoleName" # custom role label
#
# Examples:
#   bash compile.sh base-data-analyst
#   bash compile.sh company-swiggy "Analyst_TrustSafety"
#
# Available profiles are any folder matching base-* or company-*
# -------------------------------------------------------
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="resume-builder"

# ── Helpers ──────────────────────────────────────────
list_profiles() {
  for d in "$ROOT_DIR"/base-* "$ROOT_DIR"/company-*; do
    [ -d "$d" ] && echo "  $(basename "$d")"
  done
}

# ── Args ─────────────────────────────────────────────
PROFILE="${1:-}"

if [[ -z "$PROFILE" ]]; then
  echo "Usage: bash compile.sh <profile> [role]"
  echo ""
  echo "Available profiles:"
  list_profiles
  exit 1
fi

SOURCE_DIR="${ROOT_DIR}/${PROFILE}"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "ERROR: Profile '${PROFILE}' not found."
  echo ""
  echo "Available profiles:"
  list_profiles
  exit 1
fi

if [[ ! -f "${SOURCE_DIR}/resume.tex" ]]; then
  echo "ERROR: No resume.tex found in '${PROFILE}/'."
  exit 1
fi

ROLE="${2:-${PROFILE}}"
DATESTAMP="$(date '+%Y%m%d')"
TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"
OUTPUT_DIR="${ROOT_DIR}/output/${PROFILE}/${DATESTAMP}"
OUTPUT_FILE="SoumyaGupta_${ROLE}_${TIMESTAMP}.pdf"

# ── Header ────────────────────────────────────────────
echo "============================================"
echo "  Resume LaTeX Compiler"
echo "  Profile   : ${PROFILE}"
echo "  Role      : ${ROLE}"
echo "  Date      : ${DATESTAMP}"
  echo "  Output    : output/${PROFILE}/${DATESTAMP}/${OUTPUT_FILE}"
  echo "  Timestamp : ${TIMESTAMP}"
echo "============================================"
echo ""

mkdir -p "$OUTPUT_DIR"

# ── Step 1: Build Docker image ────────────────────────
echo "[1/3] Building Docker image '${IMAGE_NAME}'..."
docker build --tag "${IMAGE_NAME}" "${ROOT_DIR}"
echo "      Image built successfully."
echo ""

# ── Step 2: Compile LaTeX (2 passes) ─────────────────
echo "[2/3] Compiling ${PROFILE}/resume.tex..."
docker run --rm \
    --volume "${SOURCE_DIR}:/workspace" \
    "${IMAGE_NAME}"
echo "      Compilation finished."
echo ""

# ── Step 3: Save PDF ─────────────────────────────────
echo "[3/3] Saving PDF..."
if [ -f "${SOURCE_DIR}/resume.pdf" ]; then
    cp "${SOURCE_DIR}/resume.pdf" "${OUTPUT_DIR}/${OUTPUT_FILE}"

    rm -f "${SOURCE_DIR}/resume.aux" \
          "${SOURCE_DIR}/resume.log" \
          "${SOURCE_DIR}/resume.out" \
          "${SOURCE_DIR}/resume.pdf"

    echo ""
    echo "============================================"
    echo "  Done!"
    echo "  PDF saved to: output/${PROFILE}/${DATESTAMP}/${OUTPUT_FILE}"
    echo "============================================"
else
    echo "ERROR: resume.pdf not found after compilation."
    echo "       Check Docker logs above for LaTeX errors."
    exit 1
fi
