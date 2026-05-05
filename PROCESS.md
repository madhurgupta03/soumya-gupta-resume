# Standard Resume Tailoring Process

Step-by-step instructions for creating a tailored resume for any new job application.

---

## Prerequisites

- Docker Desktop must be running on your machine.
- The resume repository is cloned and you are in the project root.

---

## Step 1: Read the Job Description

Read the full JD carefully and classify keywords into three tiers:

### Tier 1 — Hard Requirements (MUST appear in resume)
- The exact job title (e.g., "Analyst I, Classifications").
- Mandatory skills — every tool, technology, methodology, and certification explicitly required.
- Exact phrases used in responsibilities (e.g., "classify pharmaceutical information", "secondary research from credible sources"). Use these exact phrases, not synonyms.
- Experience requirement — years and domains.

### Tier 2 — Repeated Competencies (should appear where natural)
- Preferred skills and methodologies mentioned 2+ times.
- Soft skills specifically mentioned (e.g., "mentor junior colleagues", "collaborate across teams").
- Industry or domain language (e.g., "pharmaceutical product lifecycle", "regulatory sources").

### Tier 3 — Industry & Culture (bonus — signals fit)
- Company-specific language and values.
- Industry jargon mentioned once.
- Nice-to-have qualifications.

Count how many times each keyword appears in the JD — higher frequency = higher priority.

Target: capture ALL Tier 1 keywords, 80%+ of Tier 2, and Tier 3 where they fit naturally.

---

## Step 2: Create the Company Folder

Pick a short, lowercase name for the company. Create a folder and copy the closest base profile into it.

```
mkdir company-<name>
cp base-data-analyst/resume.tex company-<name>/resume.tex
```

If the role is closer to a Data Engineer, copy from base-data-engineer/ instead.

---

## Step 3: Metric Inventory

Before touching the resume, do a quick audit of available metrics for each role on the resume:

| Category | Question to Ask | Example |
|----------|----------------|---------|
| Volume | How many records/users/reports/tickets? | "20,000+ rows", "400+ test scenarios" |
| Time | Hours saved per week? Cycle time reduced? | "12+ hrs/week", "reduced from 4 weeks to 2" |
| Money | Budget managed? Revenue generated? Cost savings? | "$1.2M annual revenue" |
| Quality | Error rate reduced? Accuracy improved? | "40% improvement in data quality" |
| Growth | Adoption rate? Conversion? Retention? | "35% conversion boost" |
| Scale | Team size? Regions? Stakeholders? | "across all regions", "3 cross-functional teams" |

Rules:
- If you have exact numbers, use them.
- If you have approximate numbers, use ranges: "~20-30", "10,000+".
- If you can't explain where a number came from in 1-2 sentences, don't use it.
- Never fabricate specific numbers.

---

## Step 4: Tailor the Resume

Open company-<name>/resume.tex and edit in this exact order, from highest ATS impact to lowest:

### 4a. PDF Metadata (pdfkeywords block near the top)

Add every Tier 1 and Tier 2 keyword from the JD into the pdfkeywords list. Include the role title, mandatory tools, domain terms, and soft skills. This block is indexed by some ATS parsers.

### 4b. Header Tagline (the line under the name)

Replace with the JD's exact role title and top 2-3 domain keywords. For example, change "Data Analyst | Risk & Business Analytics" to "Research & Data Classification Analyst | Data Validation | Secondary Research".

This is the first thing both ATS and recruiters see — it must immediately signal role fit.

### 4c. Professional Summary (3-4 lines max)

Rewrite this paragraph to mirror the JD's language. This is the **highest-weighted ATS section** and the most-read section by human recruiters.

- Lead with the exact job title and years of experience.
- Include the top 5-8 Tier 1 keywords from the JD.
- Include 1-2 quantified achievements (bold the numbers).
- Must pass the 6-second test: a recruiter reading ONLY this section should be able to identify your role fit, experience level, and top achievement.

### 4d. Core Competencies Skill Row

Add exact Tier 1 JD keywords that are not already present. Remove or deprioritise keywords that are irrelevant to this specific role. Reorder so the most JD-relevant terms appear first.

### 4e. Remaining Skill Rows

Reorganise and rename skill row categories to match the JD's emphasis. For example, if the JD emphasises Microsoft Office, create a "Microsoft Office & BI" row and list Excel, Word, PowerPoint, Outlook, Teams prominently.

Target: 15-25 skills total across all rows, using exact JD terminology.

### 4f. Experience Bullets

This is the **most important step for ATS scoring**. 70-80% of your JD keywords should end up in this section, embedded in achievement statements (not isolated).

For each bullet, use the stronger of these formulas:

**XYZ (Google format):** "Accomplished [X] as measured by [Y], by doing [Z]"
**CAR (Challenge-Action-Result):** "Faced [Challenge], took [Action], achieved [Result]"

Reframe 3-5 bullets per role to use the JD's exact language. Do not fabricate metrics or experience. Only reframe real work.

Bullet quality checklist:
- [ ] 80%+ of bullets contain a quantified metric from the Step 3 inventory
- [ ] Every bullet starts with a strong action verb (Led, Built, Drove, Achieved)
- [ ] Every bullet contains at least 1 Tier 1 keyword
- [ ] Each bullet is 1-2 compiled lines maximum
- [ ] 4-6 bullets per role (not 7-8)

### 4g. Research or Project Section

Reframe project descriptions to use JD-relevant domain language. For example, if the JD is in life sciences, emphasise the medical/health aspects of any research work. Embed Tier 1/2 keywords.

### 4h. Education

If the UPSC or other non-traditional education section can be reframed to show JD-relevant transferable skills (e.g., "secondary research", "analytical writing"), do so briefly.

### Rules During Tailoring

- Never fabricate skills, tools, or metrics you don't have.
- Use exact phrases from the JD, not synonyms, for hard skills and tools.
- Top Tier 1 keywords should appear 2-3 times across different sections (summary, skills, bullets).
- Include both the spelled-out form and the abbreviation for any acronym: "SAP Analytics Cloud (SAC)".
- Keep every bullet to 1-2 compiled lines maximum.
- Bold all quantified metrics with \textbf{}.
- Never use "Responsible for", "Helped", or "Worked on" — use strong action verbs.

---

## Step 5: Keyword Density Verification

After all edits, before compiling, verify keyword density:

1. Count total words in the resume (approximate is fine — ~400-600 for a 1-page resume).
2. Count unique JD keywords present in the resume (target: 15+).
3. Count total keyword instances across all sections (a keyword in 3 sections = 3 instances).
4. Calculate density: total instances ÷ total words.

| Check | Target | Action if Failed |
|-------|--------|-----------------|
| Unique JD keywords | 15+ | Add missing Tier 1 keywords |
| Per-keyword frequency | 2-3× across sections | Redistribute if any keyword >4× |
| Overall density | 1-3% | Remove redundant mentions if >3% |
| Tier 1 coverage | 100% | Add every missing Tier 1 keyword — these are hard filters |
| Tier 2 coverage | 80%+ | Add where natural |

If density exceeds 3%: remove the weakest instance of the most-repeated keyword (e.g., remove from PDF metadata if it's already in summary + skills + bullet).

---

## Step 6: Compile and Check Page Count

Run:

```
make company-<name> ROLE="RoleTitle"
```

For example:

```
make company-norstella ROLE="Analyst_Classifications"
```

The compile log will show "Output written on resume.pdf (1 page, ...)" or "(2 pages, ...)". The resume must be exactly 1 page.

If it overflows to 2 pages:

- Shorten 1-2 of the longest bullets. Keep all Tier 1 keywords, just tighten phrasing.
- Remove the least relevant bullet entirely if needed.
- Trim the skill rows by removing the least relevant terms.
- Shorten the UPSC or education description.
- As a last resort, reduce itemsep from 2pt to 1pt in the list settings.

Recompile after each change until it fits on 1 page.

---

## Step 7: Review the PDF

Open the compiled PDF from the output folder:

```
output/company-<name>/<YYYYMMDD>/SoumyaGupta_<ROLE>_<YYYYMMDD_HHMMSS>.pdf
```

### Standard Review
- All text is readable and not cut off.
- Metrics are bolded.
- Contact info is correct.
- No LaTeX errors or formatting issues.
- Content fills the page well — not too much whitespace at the bottom, not cramped.

### 6-Second Recruiter Scan Test
Glance at the resume for 6 seconds. Can you immediately answer:
- What role does this person target? _(headline + summary)_
- How many years of relevant experience? _(summary first line)_
- What are the top 2-3 achievements? _(bold metrics visible without reading deeply)_

If any answer is unclear → revise the headline, summary, or metric bolding.

### Parse Test
Copy all text from the PDF and paste into a plain text editor. If the content appears in logical order with all sections intact, parsing will succeed. If text is garbled or out of order, the LaTeX PDF has encoding issues — test on Jobscan before submitting.

---

## Step 8: ATS Score Check

Copy the text content from the compiled PDF and paste it, along with the full JD, into one of these:

- Jobscan (jobscan.co) — 5 free scans per month, most accurate.
- Resume Worded (resumeworded.com) — 5 free uploads per month.
- Or use the ATS prompt from ATS_PROMPT.md: paste the prompt, the resume text, and the JD into ChatGPT or Claude for a detailed score.

Target scores:

- 75% minimum for any application.
- 80%+ for standard roles.
- 85%+ for competitive or Fortune 500 roles.
- Never submit below 60%.

If the score is low:

- Check which Tier 1 JD keywords are missing from the resume.
- Add exact JD phrases you missed.
- Rewrite the summary if the job title alignment score is low.
- Check if keywords are only in skills list — re-embed them in experience bullets with proof.
- Verify keyword density is in the 1-3% range.
- Recompile and re-check.

---

## Step 9: Commit to Git

Once the resume is finalised:

```
git add company-<name>/
git commit -m "add company-<name>: tailored for <Role> at <Company>"
```

Only .tex files are tracked. PDFs are gitignored.

---

## Step 10: Update SUMMARY.md

Add a new row to the Changelog table in SUMMARY.md with the version, date, and a description of what was tailored. Update the Variants table with the new company entry.

---

## Quick Reference — Command Cheat Sheet

```
make                                  Show help and list all profiles
make list                             List all available profiles
make <profile>                        Compile a profile
make <profile> ROLE="Label"           Compile with a custom role label
make all                              Compile every profile
make build                            Rebuild the Docker image
make clean                            Delete all output PDFs
make clean-image                      Remove the Docker image
```

---

## Pre-Submission Checklist

### ATS Optimisation
- [ ] Resume is tailored to this specific JD, not generic.
- [ ] Professional Summary is rewritten with Tier 1 JD keywords.
- [ ] All mandatory (Tier 1) skills from JD are present in the resume.
- [ ] Job title in the headline matches or is close to the JD title.
- [ ] 15+ unique JD keywords present across resume.
- [ ] Keyword density is between 1-3% (not stuffing).
- [ ] Top keywords appear 2-3× across different sections.
- [ ] 70-80% of keywords are in experience section with contextual proof.
- [ ] ATS score is 75% or higher.

### Bullet Quality
- [ ] 80%+ of bullets contain quantified metrics.
- [ ] Every bullet starts with a strong action verb.
- [ ] Every bullet contains at least 1 Tier 1 keyword.
- [ ] All metrics are bolded.
- [ ] 4-6 bullets per role, each 1-2 lines.

### Formatting
- [ ] Location is present in the contact header.
- [ ] Single-column layout with standard section headers.
- [ ] No tables, text boxes, graphics, or images.
- [ ] Date formats are consistent throughout.
- [ ] Resume is exactly 1 page.

### Human Review
- [ ] 6-second scan test: role, experience, and top achievements visible immediately.
- [ ] Copy-paste test: PDF text pastes in logical order.
- [ ] All metrics are defensible (can explain in 1-2 sentences).
- [ ] Spell check and grammar check are done.
- [ ] PDF is compiled and saved with a timestamped filename.
- [ ] SUMMARY.md updated with changelog entry.

---

## Existing Profiles

| Role | Folder | Compile Command |
|---|---|---|
| Data / Business Analyst (base) | base-data-analyst/ | make base-data-analyst |
| Data Engineer (base) | base-data-engineer/ | make base-data-engineer |
| Swiggy — Analyst, Trust & Safety | company-swiggy/ | make company-swiggy ROLE="Analyst_TrustSafety" |
| Honeywell | company-honeywell/ | make company-honeywell |
| NetApp | company-netapp/ | make company-netapp |
| Norstella — Analyst I, Classifications | company-norstella/ | make company-norstella ROLE="Analyst_Classifications" |
| PwC — Data Engineer, MS Fabric/PySpark/SQL | company-pwc/ | make company-pwc ROLE="DataEngineer_MSFabric" |

---

## Reference Documents

This repository contains several supporting documents. Here is what each one covers and when to refer to it.

### README.md

The main project documentation. Covers:

- Requirements (Docker, make).
- Full repository structure and naming conventions (base-* vs company-*).
- Quick start commands.
- Day-to-day editing workflow (edit, build, review, repeat).
- How resume.tex is structured — the 8 sections and their order.
- Key LaTeX commands used in this codebase (\role, \skillrow, \textbf, \textbar, etc.).
- How to edit each section: Professional Summary, skills, experience bullets, contact details, PDF metadata.
- The full ATS and JD matching workflow with tailoring priority order.
- Git workflow — how to commit base profile changes and new company profiles.
- All Makefile commands and output filename format.
- How to add a new base profile from scratch.
- How to add a new company-tailored profile.
- How compile.sh works internally (6 steps).
- Dockerfile reference.
- .gitignore notes.

Refer to README.md when you need to understand the project setup, how the build system works, or the exact LaTeX commands to use.

### SUMMARY.md

The changelog and history of every resume version. Covers:

- Variants table — all existing profiles with their folders and output paths.
- Changelog — every version from v1.0 to the latest, with date and description.
- Original resume content — the raw text from the original PDF before any changes.
- Full update log — detailed breakdown of what changed in each version (keywords added, bullets rewritten, formatting changes, template experiments).
- Current ATS scorecard — checklist of all ATS factors and their status.
- Current file structure.
- How to compile (legacy instructions).
- Next steps and recommendations.

Refer to SUMMARY.md when you want to see what has changed over time, what the original resume said, or what ATS factors have been addressed.

### ATS_TIPS.md

A research guide on how ATS systems work. Covers:

- What an ATS score is and what the score thresholds mean (90-100, 80-89, 75-79, 60-74, 40-59, below 40).
- The 5 stages of ATS scoring: document parsing, entity extraction, JD keyword extraction, matching algorithm, ranking and threshold filtering.
- ATS platform comparison: Taleo, Workday, iCIMS, Greenhouse, Lever, ADP — market share, parsing capability, and per-platform strategy.
- The 7 factors that drive your ATS score and their weights.
- Keyword strategy — tiering (Tier 1/2/3), where to place keywords with section weights, context quality scoring, density formula and limits.
- The 6-second recruiter scan — what recruiters look for, pass/fail criteria.
- Bullet point quality — XYZ and CAR formulas, metric categories for "I don't have numbers" situations.
- Formatting rules — what ATS can parse cleanly and what kills your score.
- Section-by-section optimisation guidance.
- Common ATS mistakes and how to fix them.
- ATS parse testing methods (copy-paste, Jobscan, LinkedIn Easy Apply, Google Docs).
- Pre-submission checklist.
- ATS score targets by employer type and likely ATS platform.

Refer to ATS_TIPS.md when you want to understand how ATS systems work, what score to target, or what formatting rules to follow.

### ATS_PROMPT.md

Ready-to-use prompts for scoring and improving your resume using AI tools. Contains:

- **Single JD Match (Full Report)** — detailed prompt with 11-section report: score breakdown, tiered keyword scorecard with context quality, 6-second recruiter scan simulation, stuffing risk check, experience confidence scoring, section-by-section fixes, and projected score after fixes.
- **Multiple JDs (Compare & Optimise)** — scores against multiple JDs and produces combined strategy with tier analysis.
- **Quick Score (Fast Version)** — rapid score with top 5 missing Tier 1 keywords and density check in under 500 words.
- **Resume Roast (Hiring Manager Persona)** — brutal pre-tailoring review that rates every bullet A/B/C and evaluates the 6-second test.
- **Bullet Rewriter (XYZ / CAR Formula)** — rewrites each bullet using both formulas, embeds JD keywords, flags metrics that need verification.
- **Skills Gap Analyzer** — gap analysis with quick wins (1-2 week), strategic gaps (1-3 month), positioning strategy, and interview talking points.
- Tips for using all prompts effectively.

Refer to ATS_PROMPT.md when you want to score a compiled resume against a JD, roast your base resume, rewrite bullets, or analyse skill gaps.

### IMPROVEMENT_GUIDE.md

A skill gap analysis and 6-month action plan. Covers:

- Current skill levels — what is on the resume and at what proficiency.
- Skill gaps prioritised into three tiers: learn first (asked in 80% of interviews), learn next (high value over 3-6 months), and nice to have (after getting a job).
- A month-by-month 6-month action plan.
- Resume quick wins — GitHub profile, LinkedIn featured section, PL-300 cert, adding numbers to projects.
- Top certifications for the role with cost, time, and priority.
- AI tools to use right now at zero cost.

Refer to IMPROVEMENT_GUIDE.md when you want to know what skills to learn next, what certifications to pursue, or how to strengthen the resume beyond tailoring.
