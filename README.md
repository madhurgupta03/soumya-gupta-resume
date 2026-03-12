# Resume Builder

A LaTeX-based resume system that separates **base profiles** from **company-tailored versions**, compiles via Docker, and organises all output PDFs automatically.

---

## Table of Contents

1. [Requirements](#requirements)
2. [Repository Structure](#repository-structure)
3. [Quick Start](#quick-start)
4. [Working with This Codebase](#working-with-this-codebase)
   - [Day-to-day editing workflow](#day-to-day-editing-workflow)
   - [Understanding resume.tex](#understanding-resumetex)
   - [Editing the resume](#editing-the-resume)
   - [ATS & JD matching workflow](#ats--jd-matching-workflow)
   - [Git workflow](#git-workflow)
5. [All Makefile Commands](#all-makefile-commands)
6. [How to Add a New Base Profile](#how-to-add-a-new-base-profile)
7. [How to Add a New Company](#how-to-add-a-new-company)
8. [How compile.sh Works](#how-compilesh-works)
9. [Dockerfile Reference](#dockerfile-reference)
10. [.gitignore Notes](#gitignore-notes)
11. [Workflow Summary](#workflow-summary)

---

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) — must be running before any build
- `make` — pre-installed on macOS/Linux
- No LaTeX installation needed locally — Docker handles the full TeX Live environment

---

## Repository Structure

```
resume/
│
├── Makefile                    ← all commands (start here)
├── compile.sh                  ← build engine (called by Makefile)
├── Dockerfile                  ← single shared LaTeX compiler image
├── README.md                   ← this file
├── IMPROVEMENT_GUIDE.md        ← skill gap analysis and action plan
│
├── base-data-analyst/          ← base profile: Data Analyst
│   └── resume.tex              ← canonical source — edit this
│
├── base-data-engineer/         ← base profile: Data Engineer
│   └── resume.tex
│
├── company-swiggy/             ← JD-tailored: Swiggy (T&S + Analytics roles)
│   └── resume.tex              ← derived from base-data-analyst, JD-optimised
│
└── output/                     ← all compiled PDFs (gitignored)
    ├── base-data-analyst/
    ├── base-data-engineer/
    └── company-swiggy/
```

### Naming Convention

| Folder prefix | Purpose | Rule |
|---|---|---|
| `base-<profile>` | Canonical resume for a role type | Always keep factually accurate. Never inflate. |
| `company-<name>` | JD-tailored copy of a base profile | One folder per company. Derived, never independent. |

---

## Quick Start

```bash
# Show help and list all profiles
make

# Compile a specific profile
make base-data-analyst
make company-swiggy  ROLE="Analyst_TrustSafety"

# Compile everything at once
make all

# List available profiles
make list

# Delete all output PDFs
make clean
```

---

## Working with This Codebase

### Day-to-day editing workflow

The typical loop for any resume change:

```
1. Edit   →  open resume.tex in your editor
2. Build  →  make <profile>
3. Review →  open the PDF in output/<profile>/
4. Repeat
```

Always start Docker Desktop before running `make`.

---

### Understanding resume.tex

Each `resume.tex` is structured in this order:

```
[1] LaTeX preamble        — packages, colours, margins (rarely touch)
[2] PDF metadata          — pdfkeywords array (ATS-targeted keywords)
[3] Header                — name, tagline, contact info
[4] Professional Summary  — 3-line paragraph, most ATS-critical section
[5] Technical Skills      — 5 skill rows using \skillrow{Category}{items}
[6] Professional Experience — roles using \role{} + itemize bullets
[7] Education
[8] Certifications & Training
```

**Most changes happen in sections 2–6.** Section 1 is infrastructure — only touch if changing layout or fonts.

#### Key LaTeX commands used in this codebase

| Command | What it renders |
|---|---|
| `\role{Title}{Company, Location}{Date Range}` | Job title block with right-aligned date |
| `\skillrow{Category}{item1, item2, ...}` | Bold label + comma-separated skill list |
| `\textbf{text}` | **Bold** — used to highlight metrics |
| `\textbar{}` | A vertical pipe `\|` separator |
| `\&` | Ampersand `&` (must be escaped in LaTeX) |
| `\textasciitilde` | Tilde `~` (used in `~20%`) |
| `\textbf{30\%}` | Bold percentage (backslash before `%`) |

---

### Editing the resume

#### Edit the Professional Summary

The summary is a single paragraph on one line. It is the highest-weighted ATS section — lead with role keywords:

```latex
\section{Professional Summary}

Results-driven Data Analyst with almost 2 years of experience...
```

Keep it to 3 lines maximum when compiled. Any longer and it crowds the experience section.

#### Add or remove a skill

Skills use the `\skillrow` command. Each row is one category:

```latex
\skillrow{Core Competencies}{Skill A, Skill B, Skill C}
\skillrow{BI, SQL \& Data}{SQL, Power BI, Tableau, MySQL}
```

To add a skill, append it to the relevant row's comma-separated list. To remove, delete the term. The row wraps automatically.

#### Edit an experience bullet

Bullets follow the Google XYZ format: **Accomplished [X] by doing [Y] resulting in [Z]**

```latex
\begin{itemize}
  \item Improved data quality by \textbf{40\%} by building an ETL pipeline...
  \item Eliminated \textbf{12+ hours/week} of manual reporting by...
\end{itemize}
```

Rules:
- Lead every bullet with a strong action verb
- Bold all quantified metrics with `\textbf{}`
- Keep each bullet to 1–2 lines when compiled (no wrapping to 3+)
- Never fabricate numbers — only reframe real work

#### Change contact details

```latex
\href{tel:+917674981551}{+91-76749-81551}
\href{mailto:soumya1698@gmail.com}{soumya1698@gmail.com}
Mumbai, Maharashtra
\href{https://linkedin.com/in/soumya-gupta1698}{linkedin.com/in/soumya-gupta1698}
```

Replace the values inside `\href{}{}` and the plain text portions.

#### Update the PDF keyword metadata (ATS boost)

The `pdfkeywords` block near the top of the file is indexed by some ATS parsers. Keep it in sync with the skills section:

```latex
\hypersetup{
    pdfkeywords = {Data Analyst, SQL, Python, Power BI, Fraud Detection, ...}
}
```

---

### ATS & JD matching workflow

When applying to a new company:

**Step 1 — Score the base resume against the JD**

Read the JD carefully and note:
- Mandatory skills (must-have keywords)
- Preferred skills (good-to-have keywords)
- Exact phrases used in responsibilities
- Experience requirement (years)
- Domain-specific language (e.g., "fraud hypothesis", "measurement framework")

**Step 2 — Create a company folder**

```bash
mkdir company-<name>
cp base-data-analyst/resume.tex  company-<name>/resume.tex
```

**Step 3 — Tailor in this order (highest ATS impact first)**

| Priority | Section | What to change |
|---|---|---|
| 1 | PDF metadata `pdfkeywords` | Add all JD keywords |
| 2 | Header tagline | Swap in JD's role title and top 2 domain keywords |
| 3 | Professional Summary | Rewrite to mirror JD's language and responsibilities |
| 4 | Core Competencies skill row | Add exact JD keywords not already present |
| 5 | Experience bullets | Reframe 2–3 bullets to match JD responsibilities |
| 6 | Other skill rows | Add any remaining mandatory tool keywords |

**Step 4 — Build and check page count**

```bash
make company-<name> ROLE="RoleTitle"
```

The compiled log shows `(1 page, ...)` or `(2 pages, ...)`. Always target **1 page**. If it overflows:
- Shorten 1–2 long bullets (keep all keywords, just tighten phrasing)
- Reduce `itemsep` in the list settings from `2pt` to `1pt`

**Step 5 — ATS score check tips**

Run the compiled PDF through [Jobscan](https://www.jobscan.co) or [Resume Worded](https://resumeworded.com) for a keyword match score against the JD. Target 75%+ match.

Common reasons for low score:
- Missing exact phrase from JD (e.g., JD says "fraud detection", resume says "anomaly detection")
- Experience years mismatch
- Missing mandatory tool (e.g., HQL/Hive, Google Sheets)
- No location in header

---

### Git workflow

Only source `.tex` files are tracked. PDFs are gitignored.

#### Committing base profile changes

```bash
git add base-data-analyst/resume.tex
git commit -m "update base-data-analyst: add HQL/Hive, Google Sheets to skills"
```

#### Committing a new company profile

```bash
git add company-<name>/
git commit -m "add company-<name>: tailored for <Role> JD"
```

#### Checking what has changed

```bash
# See all unstaged changes across all resumes
git diff

# See changes to a specific profile
git diff company-swiggy/resume.tex

# See history of changes to a file
git log --oneline company-swiggy/resume.tex
```

#### Reverting a company resume to match its base

```bash
# Overwrite the company resume with the latest base
cp base-data-analyst/resume.tex company-<name>/resume.tex
```

---

## All Makefile Commands

| Command | Description |
|---|---|
| `make` | Show help + list all available profiles |
| `make list` | List all profiles |
| `make <profile>` | Compile a profile (profile name used as role label) |
| `make <profile> ROLE="Label"` | Compile with a custom role label in the filename |
| `make all` | Compile every profile sequentially |
| `make build` | Build (or rebuild) the shared Docker image |
| `make clean` | Delete all PDFs under `output/` |
| `make clean-image` | Remove the `resume-builder` Docker image |

### Output filename format

```
output/<profile>/<YYYYMMDD_HHMMSS>/SoumyaGupta_<ROLE>_<YYYYMMDD_HHMMSS>.pdf
```

Examples:
```
output/company-swiggy/20260306_121039/SoumyaGupta_Analyst_TrustSafety_20260306_121039.pdf
output/base-data-analyst/20260306_130000/SoumyaGupta_base-data-analyst_20260306_130000.pdf
```

---

## How to Add a New Base Profile

Use this when creating a resume for a **new role type** (e.g., Data Scientist, Product Analyst).

### Step 1 — Create the folder

```bash
mkdir base-data-scientist
```

### Step 2 — Create the resume

```bash
cp base-data-analyst/resume.tex base-data-scientist/resume.tex
# Edit base-data-scientist/resume.tex for the new role type
```

Key things to update:
- `pdftitle` and `pdfkeywords` in the metadata block
- Header tagline (role-specific tools and domains)
- Professional Summary (rewrite for new role)
- Skills rows (add/remove tools relevant to the new profile)
- Experience bullets (reframe for new role angle)

### Step 3 — Compile

```bash
make base-data-scientist
make base-data-scientist ROLE="DataScientist_v1"
```

No changes to `Makefile`, `compile.sh`, or `Dockerfile` needed — new folders are auto-discovered and share the root `Dockerfile`.

---

## How to Add a New Company

Use this when tailoring against a **specific JD**. Always derive from the closest base profile.

### Step 1 — Create the folder

```bash
mkdir company-zepto
```

### Step 2 — Copy from the relevant base

```bash
cp base-data-analyst/resume.tex  company-zepto/resume.tex
```

### Step 3 — Tailor to the JD

Edit `company-zepto/resume.tex` following the ATS tailoring priority order above. Keep all factual details (dates, company names, metrics) unchanged.

### Step 4 — Compile

```bash
make company-zepto ROLE="DataAnalyst_Growth"
```

PDF saved to:
```
output/company-zepto/SoumyaGupta_DataAnalyst_Growth_<timestamp>.pdf
```

---

## How compile.sh Works

`compile.sh` is the build engine invoked by the Makefile. You can also run it directly:

```bash
bash compile.sh <profile> [role]

# No args — shows available profiles
bash compile.sh
```

### What it does (6 steps)

1. **Validates** — checks the profile folder exists and contains `resume.tex`
2. **Builds** — creates a Docker image tagged `resume-builder` from the root `Dockerfile`
3. **Mounts** — runs the container with the profile folder mounted at `/workspace`
4. **Compiles** — runs `pdflatex` twice (pass 1 builds aux files; pass 2 resolves all references)
5. **Saves** — copies `resume.pdf` → `output/<profile>/SoumyaGupta_<role>_<timestamp>.pdf`
6. **Cleans** — removes `*.aux`, `*.log`, `*.out`, `*.pdf` from the profile folder

---

## Dockerfile Reference

There is a single `Dockerfile` at the project root, shared by all profiles. No per-profile copy is needed.

```dockerfile
FROM texlive/texlive:latest

WORKDIR /workspace

# Two-pass compilation: pass 1 builds aux files, pass 2 resolves them
CMD ["bash", "-c", \
     "pdflatex -interaction=nonstopmode resume.tex && \
      pdflatex -interaction=nonstopmode resume.tex && \
      echo '--- Compilation successful ---'"]
```

> Docker caches image layers — the first build per machine is slow (~2–3 min to pull TeX Live). All subsequent builds are fast (~5 sec) unless the Dockerfile changes.

To rebuild the image manually (e.g. after editing the Dockerfile):

```bash
make build
# or to also remove the old image first:
make clean-image && make build
```

---

## .gitignore Notes

| Ignored | Reason |
|---|---|
| `output/**/*.pdf` | Binary files — track source, not compiled output |
| `*.aux`, `*.log`, `*.out`, etc. | LaTeX build artifacts — auto-cleaned by `compile.sh` |
| `temp/` | Working scratch folder |
| `.DS_Store`, `Thumbs.db` | OS metadata |

Only `.tex`, root `Dockerfile`, `compile.sh`, `Makefile`, and `*.md` files are committed.

---

## Workflow Summary

```
Starting from scratch for a new application?
│
├── New role type (e.g., Data Scientist)?
│     └── mkdir base-data-scientist/
│           cp base-data-analyst/resume.tex base-data-scientist/
│           # edit resume.tex for new profile
│           make base-data-scientist
│
└── Same role, new company JD?
      └── mkdir company-<name>/
            cp base-data-analyst/resume.tex company-<name>/
            # tailor resume.tex to JD (summary → skills → bullets)
            make company-<name> ROLE="JobTitle"
            # check page count in PDF (must be 1 page)
            # run through Jobscan for ATS score
            git add company-<name>/ && git commit -m "add company-<name>"
```
