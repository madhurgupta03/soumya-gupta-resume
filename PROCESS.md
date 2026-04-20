# Standard Resume Tailoring Process

Step-by-step instructions for creating a tailored resume for any new job application.

---

## Prerequisites

- Docker Desktop must be running on your machine.
- The resume repository is cloned and you are in the project root.

---

## Step 1: Read the Job Description

Read the full JD carefully and extract:

- The exact job title (e.g., "Analyst I, Classifications").
- Mandatory skills — every tool, technology, methodology, and certification explicitly required.
- Preferred skills — nice-to-have keywords mentioned.
- Exact phrases used in responsibilities (e.g., "classify pharmaceutical information", "secondary research from credible sources"). Use these exact phrases, not synonyms.
- Experience requirement — years and domains.
- Soft skills specifically mentioned (e.g., "mentor junior colleagues", "collaborate across teams").
- Industry or domain language (e.g., "pharmaceutical product lifecycle", "regulatory sources").

Prioritise: mandatory requirements come first, then preferred skills, then nice-to-have.

---

## Step 2: Create the Company Folder

Pick a short, lowercase name for the company. Create a folder and copy the closest base profile into it.

```
mkdir company-<name>
cp base-data-analyst/resume.tex company-<name>/resume.tex
```

If the role is closer to a Data Engineer, copy from base-data-engineer/ instead.

---

## Step 3: Tailor the Resume

Open company-<name>/resume.tex and edit in this exact order, from highest ATS impact to lowest:

### 3a. PDF Metadata (pdfkeywords block near the top)

Add every important keyword from the JD into the pdfkeywords list. Include the role title, mandatory tools, domain terms, and soft skills. This block is indexed by some ATS parsers.

### 3b. Header Tagline (the line under the name)

Replace with the JD's role title and top 2-3 domain keywords. For example, change "Data Analyst | Risk & Business Analytics" to "Research & Data Classification Analyst | Data Validation | Secondary Research".

### 3c. Professional Summary (3-4 lines max)

Rewrite this paragraph to mirror the JD's language. Lead with the job title and years of experience. Include the top 5-8 keywords from the JD. Include 1-2 quantified achievements. This is the highest-weighted ATS section.

### 3d. Core Competencies Skill Row

Add exact JD keywords that are not already present. Remove or deprioritise keywords that are irrelevant to this specific role. Reorder so the most JD-relevant terms appear first.

### 3e. Remaining Skill Rows

Reorganise and rename skill row categories to match the JD's emphasis. For example, if the JD emphasises Microsoft Office, create a "Microsoft Office & BI" row and list Excel, Word, PowerPoint, Outlook, Teams prominently.

### 3f. Experience Bullets

Reframe 3-5 bullets to use the JD's exact language. Do not fabricate metrics or experience. Only reframe real work. For example, if the JD says "review and classify information", rewrite "built a data cleaning pipeline" as "built a classification and validation pipeline". If the JD says "mentor new analysts", add or surface a mentoring bullet. Use the Google XYZ format: strong action verb, then what was accomplished, then the quantified result.

### 3g. Research or Project Section

Reframe project descriptions to use JD-relevant domain language. For example, if the JD is in life sciences, emphasise the medical/health aspects of any research work.

### 3h. Education

If the UPSC or other non-traditional education section can be reframed to show JD-relevant transferable skills (e.g., "secondary research", "analytical writing"), do so briefly.

### Rules During Tailoring

- Never fabricate skills, tools, or metrics you don't have.
- Use exact phrases from the JD, not synonyms, for hard skills and tools.
- Top priority keywords should appear 2-3 times across different sections (summary, skills, bullets).
- Include both the spelled-out form and the abbreviation for any acronym: "SAP Analytics Cloud (SAC)".
- Keep every bullet to 1-2 compiled lines maximum.
- Bold all quantified metrics with \textbf{}.

---

## Step 4: Compile and Check Page Count

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

- Shorten 1-2 of the longest bullets. Keep all keywords, just tighten phrasing.
- Remove the least relevant bullet entirely if needed.
- Trim the skill rows by removing the least relevant terms.
- Shorten the UPSC or education description.
- As a last resort, reduce itemsep from 2pt to 1pt in the list settings.

Recompile after each change until it fits on 1 page.

---

## Step 5: Review the PDF

Open the compiled PDF from the output folder:

```
output/company-<name>/<YYYYMMDD>/SoumyaGupta_<ROLE>_<YYYYMMDD_HHMMSS>.pdf
```

Check:

- All text is readable and not cut off.
- Metrics are bolded.
- Contact info is correct.
- No LaTeX errors or formatting issues.
- Content fills the page well — not too much whitespace at the bottom, not cramped.

---

## Step 6: ATS Score Check (Optional but Recommended)

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

- Check which mandatory JD keywords are missing from the resume.
- Add exact JD phrases you missed.
- Rewrite the summary if the job title alignment score is low.
- Recompile and re-check.

---

## Step 7: Commit to Git

Once the resume is finalised:

```
git add company-<name>/
git commit -m "add company-<name>: tailored for <Role> at <Company>"
```

Only .tex files are tracked. PDFs are gitignored.

---

## Step 8: Update SUMMARY.md

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

- [ ] Resume is tailored to this specific JD, not generic.
- [ ] Professional Summary is rewritten with JD keywords.
- [ ] All mandatory skills from JD are present in the resume.
- [ ] Job title in the summary matches or is close to the JD title.
- [ ] Location is present in the contact header.
- [ ] Single-column layout with standard section headers.
- [ ] No tables, text boxes, graphics, or images.
- [ ] Date formats are consistent throughout.
- [ ] All metrics are bolded.
- [ ] Resume is exactly 1 page.
- [ ] ATS score is 75% or higher.
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
- The 6 factors that drive your ATS score and their weights: keyword match rate (40%), job title match (20%), skills section completeness (15%), experience keyword density (15%), format and parsing quality (5-10%), education and certifications (variable).
- Keyword strategy — where to place keywords, density rules, how to extract keywords from a JD.
- Formatting rules — what ATS can parse cleanly and what kills your score (two-column layouts, tables, text boxes, headers/footers, images, scanned PDFs, creative section headers).
- Section-by-section optimisation guidance for contact info, summary, skills, experience, and education.
- Common ATS mistakes and how to fix them.
- Best free ATS checker tools for 2026 (Jobscan, Resume Worded, Teal HQ, SkillSyncer, Rezi, VMock).
- Pre-submission checklist.
- ATS score targets by employer type.

Refer to ATS_TIPS.md when you want to understand how ATS systems work, what score to target, or what formatting rules to follow.

### ATS_PROMPT.md

Ready-to-use prompts for scoring your resume against a JD using AI tools. Contains three prompts:

- Single JD Match — a detailed prompt that produces a full report with score breakdown, keyword scorecard, strengths, gaps, section-by-section fixes, and projected score after fixes.
- Multiple JDs (Compare and Optimise) — scores against multiple JDs and produces a combined optimisation strategy.
- Quick Score (Fast Version) — a short prompt for a rapid score, top 5 missing keywords, and 3 most impactful changes in under 400 words.
- Tips for using the prompts — paste the full JD, use plain text from the PDF, run per application, act on exact rewrites.

Refer to ATS_PROMPT.md when you want to score a compiled resume against a JD using ChatGPT, Claude, or any other AI assistant.

### IMPROVEMENT_GUIDE.md

A skill gap analysis and 6-month action plan. Covers:

- Current skill levels — what is on the resume and at what proficiency.
- Skill gaps prioritised into three tiers: learn first (asked in 80% of interviews), learn next (high value over 3-6 months), and nice to have (after getting a job).
- A month-by-month 6-month action plan.
- Resume quick wins — GitHub profile, LinkedIn featured section, PL-300 cert, adding numbers to projects.
- Top certifications for the role with cost, time, and priority.
- AI tools to use right now at zero cost.

Refer to IMPROVEMENT_GUIDE.md when you want to know what skills to learn next, what certifications to pursue, or how to strengthen the resume beyond tailoring.
