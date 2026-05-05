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
2. Then execute the chosen path: full flow (Steps 1-9) or a subset of steps.

## Workflow

### 0. Check for Existing Profile

Before starting, derive the company name from the JD and check if `company-<name>/resume.tex` already exists.

```bash
ls company-<name>/resume.tex 2>/dev/null
```

**If the file exists**, use the AskQuestion tool to ask the user:

- **Full rewrite** — start from a base profile and redo everything (Steps 1-9)
- **Update & re-score** — keep the existing resume, apply targeted keyword gap fixes against the new/updated JD, recompile, and re-score (Steps 1, 4-9; skip 2-3)
- **Re-score only** — read the existing resume and JD, produce a fresh ATS score report without editing (Steps 1, 8-9 only)
- **Compile only** — just recompile the existing resume.tex and save a new PDF (Step 6 only)

Then execute only the steps the user chose.

**If the file does not exist**, proceed with the full flow (Steps 1-9).

### 1. Extract & Tier JD Keywords

Read the full JD and classify keywords into three tiers:

**Tier 1 — Hard Requirements** (MUST appear in resume):
- Exact job title
- Mandatory skills (tools, technologies, certifications)
- Exact phrases from responsibilities (use these verbatim, not synonyms)
- Required experience (years, domains)

**Tier 2 — Repeated Competencies** (should appear where natural):
- Preferred skills
- Soft skills explicitly mentioned 2+ times
- Methodologies and frameworks
- Industry or domain language

**Tier 3 — Industry & Culture** (bonus — signals fit):
- Company-specific language and values
- Industry jargon mentioned once
- Nice-to-have qualifications

Count how many times each keyword appears in the JD — higher frequency = higher priority within its tier.

Target: capture ALL Tier 1 keywords, 80%+ of Tier 2, and as many Tier 3 as fit naturally.

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

#### 4a. PDF Metadata (pdfkeywords)
Add all Tier 1 and Tier 2 JD keywords to the metadata block.

#### 4b. Header Tagline
Swap in the JD's exact role title and top 2-3 domain keywords. This is the first thing both ATS and recruiters see — it must immediately signal role fit.

#### 4c. Professional Summary (3-4 lines max)
Rewrite to mirror JD language. This is the **highest-weighted ATS section** and the most-read section by human recruiters.

- Lead with exact job title + years of experience
- Include top 5-8 Tier 1 keywords
- Include 1-2 quantified achievements (bold the numbers)
- Keep to 3-4 lines
- This section must pass the 6-second test: a recruiter should be able to identify role fit, experience level, and top achievements by reading only this section

#### 4d. Core Competencies Skill Row
Add exact Tier 1 JD keywords that are not already present. Remove irrelevant terms. Reorder so the most JD-relevant terms appear first.

#### 4e. Remaining Skill Rows
Rename categories to match JD emphasis. Add missing Tier 1 tools. Include both abbreviation and full form: "SAP Analytics Cloud (SAC)".

Target: 15-25 skills total across all rows.

#### 4f. Experience Bullets — The Most Important Step

**Before rewriting**, do a quick metric inventory for each role:
- What numbers can the candidate defend? (volume, time saved, % improvement, team size, cost savings)
- What metric *categories* apply even if exact numbers aren't available? (use ranges: "~20-30", "10,000+")
- If the candidate can't explain where a number came from in 1-2 sentences, don't use it.

**Rewriting rules:**

Reframe 3-5 bullets per role using JD's exact language. For each bullet, use the stronger of these two formulas:

**XYZ (Google format):** "Accomplished [X] as measured by [Y], by doing [Z]"
**CAR (Challenge-Action-Result):** "Faced [Challenge], took [Action], achieved [Result]"

- 80%+ of bullets must contain a quantified metric
- Every bullet must contain at least 1 Tier 1 keyword
- Use strong action verbs (Led, Built, Drove, Achieved — never "Responsible for", "Helped", "Worked on")
- **70-80% of JD keywords should end up in this section** with contextual proof
- Keep each bullet to 1-2 compiled lines
- 4-6 bullets per role maximum (not 7-8)

#### 4g. Research/Project Section
Reframe with JD-relevant domain language. Embed Tier 1/2 keywords.

#### 4h. Education
Reframe transferable skills if applicable.

### 5. Keyword Density Verification

After all edits, before compiling, do a quick density check:

1. Count total words in the resume (approximate is fine)
2. Count total keyword instances (a keyword appearing in 3 sections = 3 instances)
3. Calculate density: instances ÷ total words

| Check | Target | Action if Failed |
|-------|--------|-----------------|
| Unique JD keywords present | 15+ | Add missing Tier 1 keywords |
| Per-keyword frequency | 2-3× across sections | Redistribute if any keyword >4× |
| Overall density | 1-3% | Remove redundant mentions if >3% |
| Tier 1 coverage | 100% | Critical — add every missing Tier 1 keyword |
| Tier 2 coverage | 80%+ | Add where natural |

If stuffing is detected (>3% density or any keyword appearing 5+ times), remove redundant mentions. Modern ATS can reduce scores by 25-40% for detected stuffing.

### 6. Compile and Verify

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

### 7. Update SUMMARY.md

Add a row to the Changelog table and update the Variants table.

### 8. ATS Score Report

After the resume is compiled, **always** produce an ATS score report. Read `ATS_PROMPT.md` and `ATS_TIPS.md` for the scoring framework and methodology, then score the tailored resume against the JD.

Use this scoring framework (total = 100 points):

| Dimension | Max Points |
|---|---|
| Keyword Match Rate | 25 |
| Job Title & Role Alignment | 15 |
| Skills Section Coverage | 15 |
| Experience Bullets — Relevance | 15 |
| Experience Bullets — Proof | 10 |
| Experience Level Match | 10 |
| Recruiter Scan Test (6-second) | 5 |
| Format & Parsability | 5 |

Produce this report:

**a) Overall ATS Score: X / 100** with a one-line verdict and competitive context (at 200+ applicants, what percentile does this score likely fall in?).

**b) Score Breakdown Table** with score per dimension and brief notes.

**c) Keyword Scorecard** — a table of every significant JD keyword showing:
- Tier (1 / 2 / 3)
- Whether it is present in the resume (yes / no / partial)
- Which section it appears in
- Context quality (Strong = in bullet with metric, Moderate = in skills list, Weak = metadata only)

**d) 6-Second Recruiter Scan** — Can a recruiter identify role fit, experience level, and top achievements in 6-7 seconds? Pass / Borderline / Fail with explanation.

**e) Keyword Density Check** — total word count, unique keywords found, total instances, density %. Flag if >3%.

**f) Top 3 Strengths** — what the resume does well for this JD.

**g) Critical Gaps** — any missing Tier 1 keywords or weak areas, ranked by impact. For each gap, provide the exact fix (rewritten line, not just advice).

**h) Projected Score After Fixes** — estimated score if all gaps are addressed.

Target scores (from ATS_TIPS.md):
- 75% minimum for any application
- 80%+ for standard roles
- 85%+ for competitive / Fortune 500 roles
- Never submit below 60%

If the score is below 75%, immediately apply the fixes, recompile, and re-score.

### 9. Output Summary

At the very end, always provide a final summary to the user in this exact table format:

| Field | Value |
|---|---|
| Company | [Company name] |
| Role | [Exact job title from JD] |
| Profile Folder | `company-<name>/` |
| Headline | [The tagline used under the name] |
| Summary Reframed For | [Top 3-4 Tier 1 keywords the summary was rewritten around] |
| Skills Clusters | [Number of skill rows and their category names] |
| Bullets Reframed | [Number of bullets changed and key JD phrases used] |
| Keyword Coverage | [X Tier 1 / Y total Tier 1] [Z Tier 2 / W total Tier 2] |
| Keyword Density | [X% — OK / Warning / Stuffing] |
| 6-Second Scan | [Pass / Borderline / Fail] |
| ATS Score | [X / 100 — one-line verdict] |
| Output PDF | `output/company-<name>/<date>/SoumyaGupta_<ROLE>_<timestamp>.pdf` |
| Compile Command | `make company-<name> ROLE="RoleTitle"` |

## Rules

- Never fabricate skills, tools, or metrics.
- Use exact JD phrases, not synonyms, for hard skills and tools.
- Top Tier 1 keywords should appear 2-3 times across sections (summary, skills, bullets).
- Include both spelled-out form and abbreviation: "SAP Analytics Cloud (SAC)".
- Bold all metrics with `\textbf{}`.
- Keep every bullet to 1-2 compiled lines.
- Escape LaTeX special characters: `\%` for percent, `\&` for ampersand, `\textbar{}` for pipe.
- 80%+ of bullets must contain a quantified metric.
- Use strong action verbs — never "Responsible for", "Helped", "Worked on".
- 70-80% of JD keywords should be in the experience section with contextual proof.
- Overall keyword density must stay between 1-3%.
- If a metric can't be explained in 1-2 sentences, don't use it.

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
