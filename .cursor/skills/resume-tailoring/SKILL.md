---
name: resume-tailoring
description: >-
  Tailor a LaTeX resume for a specific job description and score it for ATS.
  Use when the user pastes a job posting, asks to create a resume for a
  company, mentions tailoring, ATS optimisation, or wants to build a new
  company profile. Always performs two actions: creates the tailored resume
  AND produces an ATS score report.
---

# Resume Tailoring

When the user provides a job description:

1. **Always start with Step 0** — check if a profile already exists for this company and ask the user what to do.
2. Then execute the chosen path: full flow (Steps 1-8) or a subset of steps.

## Workflow

### 0. Check for Existing Profile

Before starting, derive the company name from the JD and check if `company-<name>/resume.tex` already exists.

```bash
ls company-<name>/resume.tex 2>/dev/null
```

**If the file exists**, use the AskQuestion tool to ask the user:

- **Full rewrite** — start from a base profile and redo everything (Steps 1-8)
- **Update & re-score** — keep the existing resume, apply targeted keyword gap fixes against the new/updated JD, recompile, and re-score (Steps 1, 4-8; skip 2-3)
- **Re-score only** — read the existing resume and JD, produce a fresh ATS score report without editing (Steps 1, 7-8 only)
- **Compile only** — just recompile the existing resume.tex and save a new PDF (Step 5 only)

Then execute only the steps the user chose.

**If the file does not exist**, proceed with the full flow (Steps 1-8).

### 1. Extract JD Keywords

Read the full JD and identify:
- Exact job title
- Mandatory skills (tools, technologies, certifications)
- Preferred skills
- Exact phrases from responsibilities (use these verbatim, not synonyms)
- Experience requirement (years, domains)
- Soft skills explicitly mentioned
- Industry or domain language

Prioritise: mandatory > preferred > nice-to-have.

### 2. Choose Base Profile

Read the base profiles to pick the closest starting point:
- `base-data-analyst/resume.tex` — for analyst, business analyst, research roles
- `base-data-engineer/resume.tex` — for engineering, ETL, pipeline roles

### 3. Create Company Folder

```bash
mkdir company-<name>
cp <chosen-base>/resume.tex company-<name>/resume.tex
```

Use a short lowercase company name (e.g., `company-norstella`, `company-swiggy`).

### 4. Tailor resume.tex

Edit in this order (highest ATS impact first):

1. **pdfkeywords** — add all JD keywords to the metadata block
2. **Header tagline** — swap in JD role title and top 2-3 domain keywords
3. **Professional Summary** — rewrite to mirror JD language; lead with title + years; include top 5-8 keywords and 1-2 quantified achievements; keep to 3-4 lines
4. **Core Competencies skill row** — add exact JD terms, reorder by relevance
5. **Remaining skill rows** — rename categories to match JD emphasis; add missing mandatory tools
6. **Experience bullets** — reframe 3-5 bullets using JD's exact phrases; use Google XYZ format (verb + accomplishment + metric)
7. **Research/Project section** — reframe with JD-relevant domain language
8. **Education** — reframe transferable skills if applicable

### 5. Compile and Verify

```bash
make company-<name> ROLE="RoleTitle"
```

The resume **must be exactly 1 page**. Check the compile log for "(1 page, ...)".

If it overflows to 2 pages, trim in this order:
- Shorten longest bullets (keep keywords, tighten phrasing)
- Remove the least relevant bullet
- Trim skill rows
- Shorten education descriptions
- Reduce `itemsep` from 2pt to 1pt as last resort

Recompile after each change.

### 6. Update SUMMARY.md

Add a row to the Changelog table and update the Variants table.

### 7. ATS Score Report

After the resume is compiled, **always** produce an ATS score report. Read `ATS_PROMPT.md` and `ATS_TIPS.md` for the scoring framework and methodology, then score the tailored resume against the JD.

Use this scoring framework (total = 100 points):

| Dimension | Max Points |
|---|---|
| Keyword Match Rate | 30 |
| Job Title & Role Alignment | 20 |
| Skills Section Coverage | 15 |
| Experience Bullets Relevance | 15 |
| Experience Level Match | 10 |
| Format & Parsability | 5 |
| Summary Optimisation | 5 |

Produce this report:

**a) Overall ATS Score: X / 100** with a one-line verdict.

**b) Score Breakdown Table** with score per dimension and brief notes.

**c) Keyword Scorecard** — a table of every significant JD keyword showing:
- Whether it is present in the resume (yes / no / partial)
- Which section it appears in
- Priority (High = mandatory, Medium = preferred, Low = nice-to-have)

**d) Top 3 Strengths** — what the resume does well for this JD.

**e) Critical Gaps** — any missing keywords or weak areas, ranked by impact. For each gap, provide the exact fix (rewritten line, not just advice).

**f) Projected Score After Fixes** — estimated score if all gaps are addressed.

Target scores (from ATS_TIPS.md):
- 75% minimum for any application
- 80%+ for standard roles
- 85%+ for competitive / Fortune 500 roles
- Never submit below 60%

If the score is below 75%, immediately apply the fixes, recompile, and re-score.

### 8. Output Summary

At the very end, always provide a final summary to the user in this exact table format:

| Field | Value |
|---|---|
| Company | [Company name] |
| Role | [Exact job title from JD] |
| Profile Folder | `company-<name>/` |
| Headline | [The tagline used under the name] |
| Summary Reframed For | [Top 3-4 keywords the summary was rewritten around] |
| Skills Clusters | [Number of skill rows and their category names] |
| Bullets Reframed | [Number of bullets changed and key JD phrases used] |
| ATS Score | [X / 100 — one-line verdict] |
| Output PDF | `output/company-<name>/<date>/SoumyaGupta_<ROLE>_<timestamp>.pdf` |
| Compile Command | `make company-<name> ROLE="RoleTitle"` |

## Rules

- Never fabricate skills, tools, or metrics.
- Use exact JD phrases, not synonyms, for hard skills and tools.
- Top keywords should appear 2-3 times across sections (summary, skills, bullets).
- Include both spelled-out form and abbreviation: "SAP Analytics Cloud (SAC)".
- Bold all metrics with `\textbf{}`.
- Keep every bullet to 1-2 compiled lines.
- Escape LaTeX special characters: `\%` for percent, `\&` for ampersand, `\textbar{}` for pipe.

## LaTeX Commands Reference

| Command | Renders |
|---|---|
| `\role{Title}{Company, Location}{Date}` | Job title block with right-aligned date |
| `\skillrow{Category}{items}` | Bold label + comma-separated skill list |
| `\textbf{30\%}` | **30%** |
| `\textbar{}` | Pipe separator |
| `\textasciitilde` | Tilde (~) |

## Reference Documents

- For full project setup and build system details, see [README.md](../../../README.md)
- For ATS scoring framework and prompts, see [ATS_PROMPT.md](../../../ATS_PROMPT.md)
- For ATS research and formatting rules, see [ATS_TIPS.md](../../../ATS_TIPS.md)
- For skill gap analysis and learning plan, see [IMPROVEMENT_GUIDE.md](../../../IMPROVEMENT_GUIDE.md)
- For version history and changelog, see [SUMMARY.md](../../../SUMMARY.md)
- For the full step-by-step process with checklists, see [PROCESS.md](../../../PROCESS.md)
