# ATS Resume Checker Prompt

Copy this prompt and paste it into any AI assistant (Claude, ChatGPT, Gemini, etc.)
along with the resume content and JD. The prompt is self-contained.

---

## PROMPT — Single JD Match

```
You are an expert ATS (Applicant Tracking System) analyst and resume strategist.

I will provide you with:
1. My resume content
2. A job description (JD)

Your task is to perform a full ATS analysis and produce a structured report.

---

## SCORING FRAMEWORK

Score the resume against the JD across these dimensions (total = 100 points):

| Dimension                        | Max Points | What to evaluate                                                             |
|----------------------------------|------------|------------------------------------------------------------------------------|
| Keyword Match Rate               | 30         | Exact and semantic matches of JD terms in resume                             |
| Job Title & Role Alignment       | 20         | How closely resume titles match the target role                              |
| Skills Section Coverage          | 15         | Mandatory + preferred JD skills present in resume skills section             |
| Experience Bullets Relevance     | 15         | Do experience bullets reflect the JD's responsibilities?                     |
| Experience Level Match           | 10         | Does years of experience match the JD requirement?                           |
| Format & Parsability             | 5          | Would a real ATS parser read this cleanly?                                   |
| Summary Optimisation             | 5          | Does the Professional Summary lead with JD-relevant language?                |

---

## REPORT STRUCTURE

Produce the following sections in order:

### 1. OVERALL ATS SCORE: X / 100

One-line verdict (e.g., "Strong match — competitive application" or "Significant keyword gaps — needs tailoring").

### 2. SCORE BREAKDOWN TABLE

| Dimension                    | Score | Max | Notes |
|------------------------------|-------|-----|-------|
| Keyword Match Rate           |       | 30  |       |
| Job Title & Role Alignment   |       | 20  |       |
| Skills Section Coverage      |       | 15  |       |
| Experience Bullets Relevance |       | 15  |       |
| Experience Level Match       |       | 10  |       |
| Format & Parsability         |       | 5   |       |
| Summary Optimisation         |       | 5   |       |
| TOTAL                        |       | 100 |       |

### 3. KEYWORD SCORECARD

Create a table with every significant keyword/phrase from the JD:

| JD Keyword / Phrase | Present in Resume? | Where | Priority |
|---------------------|--------------------|-------|----------|
| [keyword]           | ✓ / ✗ / ~partial   | [section] | High/Medium/Low |

Mark priority as:
- **High** = mandatory/must-have in JD
- **Medium** = preferred or mentioned multiple times
- **Low** = nice-to-have or mentioned once

### 4. TOP STRENGTHS (max 5)

Bullet list of what the resume does well for this JD.

### 5. CRITICAL GAPS (ranked by ATS impact)

For each gap:
- **Gap**: what is missing
- **Impact**: why it matters for this specific JD
- **Fix**: exact suggested change (provide the rewritten line/phrase, not just advice)

### 6. SECTION-BY-SECTION FIXES

For each section that needs changes, provide:

**[Section Name]**
Current: "[relevant current text]"
Suggested: "[improved version with keywords integrated]"
Keywords added: [list them]

Only include sections that need changes.

### 7. PROJECTED SCORE AFTER FIXES

Estimate the new score if all critical gaps are addressed.

| Dimension             | Current | After Fixes |
|-----------------------|---------|-------------|
| Keyword Match Rate    |         |             |
| ...                   |         |             |
| TOTAL                 |         |             |

### 8. PAGE OVERFLOW RISK

State: No risk / Low risk / High risk
If high risk, suggest which content to trim.

### 9. ONE-LINE PRIORITY ACTION

The single most impactful change that would raise the ATS score the most.

---

## INPUT

### RESUME:
[PASTE RESUME TEXT HERE]

### JOB DESCRIPTION:
[PASTE FULL JD HERE — include all sections: role summary, responsibilities, requirements, preferred qualifications]
```

---

## PROMPT — Multiple JDs (Compare & Optimise)

Use this when you want to score against multiple JDs and find the best combined optimisation.

```
You are an expert ATS analyst and resume strategist.

I will provide:
1. My resume
2. Multiple job descriptions (JD-1, JD-2, JD-3...)

Your task: score the resume against EACH JD and then produce a combined optimisation strategy.

---

## PER-JD SCORING (repeat for each JD)

For each JD, produce a compact scorecard:

**[Company / Role Name] — JD-N**

| Dimension                    | Score | Max |
|------------------------------|-------|-----|
| Keyword Match Rate           |       | 30  |
| Job Title & Role Alignment   |       | 20  |
| Skills Section Coverage      |       | 15  |
| Experience Bullets Relevance |       | 15  |
| Experience Level Match       |       | 10  |
| Format & Parsability         |       | 5   |
| Summary Optimisation         |       | 5   |
| **TOTAL**                    |       | 100 |

Top 3 missing keywords: [list]
Biggest gap: [one sentence]

---

## COMBINED KEYWORD GAP ANALYSIS

Create a master table of all important JD keywords across all roles:

| Keyword / Phrase | In Resume? | JD-1 | JD-2 | JD-3 | Priority |
|------------------|------------|------|------|------|----------|
| [keyword]        | ✓ / ✗      | ✓    | ✓    | ✗    | High     |

Columns JD-1, JD-2, JD-3 = ✓ if the keyword appears in that JD, ✗ if not.
Priority = High if keyword appears in 2+ JDs, Medium if 1 JD.

---

## COMBINED OPTIMISATION STRATEGY

Recommend changes that maximise score across ALL JDs simultaneously.

For each change, note which JDs benefit:

| Change | Affects | Expected Score Gain |
|--------|---------|---------------------|
| [change description] | JD-1, JD-2 | +X pts each |

---

## RANKING

Rank the JDs by current match score, best to worst.

| Rank | JD | Score | Application Strength |
|------|-----|-------|----------------------|
| 1    |     |       |                      |

---

## INPUT

### RESUME:
[PASTE RESUME TEXT HERE]

### JD-1 — [Company / Role]:
[PASTE JD-1 HERE]

### JD-2 — [Company / Role]:
[PASTE JD-2 HERE]

### JD-3 — [Company / Role]:
[PASTE JD-3 HERE]
```

---

## PROMPT — Quick Score (Fast Version)

Use this for a rapid score when you just need a number and top gaps, not a full report.

```
Act as an ATS system. Score my resume against the job description below.

Give me:
1. A score out of 100 using this breakdown:
   - Keyword match (30 pts)
   - Job title alignment (20 pts)
   - Skills coverage (15 pts)
   - Experience relevance (15 pts)
   - Experience level match (10 pts)
   - Format/parsability (5 pts)
   - Summary optimisation (5 pts)

2. Top 5 keywords from the JD that are missing or weak in my resume.

3. The 3 most impactful changes I can make right now — give me the exact rewritten lines.

4. Projected score after those 3 changes.

Keep the full response under 400 words.

RESUME:
[PASTE HERE]

JOB DESCRIPTION:
[PASTE HERE]
```

---

## TIPS FOR USING THESE PROMPTS

1. **Paste the full JD** — include the company description, responsibilities, requirements,
   AND preferred qualifications. ATS keywords appear in all sections.

2. **Paste resume as plain text** — copy the text content of the PDF, not the LaTeX source.
   Use the compiled PDF text for the most accurate analysis.

3. **Run per application** — your ATS score is JD-specific. A 84/100 for Swiggy T&S
   may only be 60/100 for the same resume against a different JD.

4. **Act on the exact rewrites** — ask the AI for the specific rewritten line, not just
   advice. Then update resume.tex with that exact change.

5. **Verify page count after every edit** — run `make <profile>` after changes to confirm
   the resume is still 1 page.

6. **Cross-check with Jobscan** — after applying the AI suggestions, run the compiled
   PDF through https://www.jobscan.co for an independent ATS score.

7. **Never fabricate** — only reframe real experience. Do not add skills, tools, or
   metrics you don't have.
```
