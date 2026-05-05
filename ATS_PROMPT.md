# ATS Resume Checker Prompt

Copy this prompt and paste it into any AI assistant (Claude, ChatGPT, Gemini, etc.)
along with the resume content and JD. The prompt is self-contained.

---

## PROMPT — Single JD Match (Full Report)

```
You are an expert ATS (Applicant Tracking System) analyst, resume strategist, and
former hiring manager with deep knowledge of how Taleo, Workday, Greenhouse, iCIMS,
and ADP parse and score resumes.

I will provide you with:
1. My resume content
2. A job description (JD)

Your task is to perform a full ATS analysis AND a human-recruiter simulation, then
produce a structured report.

---

## SCORING FRAMEWORK (total = 100 points)

Score the resume against the JD across these dimensions:

| Dimension                        | Max Points | What to evaluate                                                                         |
|----------------------------------|------------|------------------------------------------------------------------------------------------|
| Keyword Match Rate               | 25         | Exact and semantic matches of JD terms. Tier 1 (mandatory) keywords missing = heavy penalty. |
| Job Title & Role Alignment       | 15         | How closely resume titles/headline match the target role. Exact match > partial > distant. |
| Skills Section Coverage          | 15         | Mandatory + preferred JD skills present in skills section. Include abbreviation+full form check. |
| Experience Bullets — Relevance   | 15         | Do experience bullets reflect the JD's responsibilities using JD language?                |
| Experience Bullets — Proof       | 10         | Are achievements quantified (metrics, numbers, outcomes)? Contextual proof > isolated keyword. |
| Experience Level Match           | 10         | Does years of experience match the JD requirement? Recency of relevant experience.       |
| Recruiter Scan Test              | 5          | In 6-7 seconds, can a recruiter identify: role fit, years of experience, top 2-3 achievements? Is the value proposition in the top third of the page? |
| Format & Parsability             | 5          | Would Taleo (lowest common denominator) parse this cleanly? Single column, standard headers, no tables/text boxes. |

---

## KEYWORD TIERING

Before scoring, classify every significant JD keyword into tiers:

- **Tier 1 — Hard Requirements**: Skills, tools, technologies, certifications listed as mandatory. These MUST appear in the resume. Missing a Tier 1 keyword = hard filter on many ATS.
- **Tier 2 — Repeated Competencies**: Soft skills, methodologies, and competencies mentioned 2+ times in the JD. Should appear where naturally applicable.
- **Tier 3 — Industry & Culture**: Company-specific language, industry jargon, culture signals. Bonus points — signals genuine fit.

---

## KEYWORD CONTEXT QUALITY

For each keyword found in the resume, evaluate WHERE it appears:

| Placement                        | Context Score |
|----------------------------------|---------------|
| In an experience bullet with a quantified result | Strongest     |
| In an experience bullet without a metric          | Strong        |
| In the Professional Summary                       | Strong        |
| In the Skills section only                        | Moderate      |
| In PDF metadata only                              | Weak          |

A keyword that appears ONLY in the skills list scores lower than the same keyword
embedded in an achievement bullet. The report should flag keywords that lack contextual proof.

---

## KEYWORD DENSITY CHECK

After counting keywords, check for stuffing risk:

- Target: 1-2% keyword density (keyword instances ÷ total resume words)
- Optimal per-keyword frequency: 2-3 appearances across different sections
- Red flag: Any keyword appearing 5+ times, or overall density >3%
- Modern ATS can reduce scores by 25-40% for detected stuffing

---

## REPORT STRUCTURE

Produce the following sections in order:

### 1. OVERALL ATS SCORE: X / 100

One-line verdict (e.g., "Strong match — competitive application" or "Significant keyword gaps — needs tailoring").

Include competitive context:
- 90-100: Top-ranked. Very high callback probability.
- 80-89: Strong match. Likely to reach recruiter.
- 75-79: Above threshold. Passes most ATS filters.
- 60-74: Borderline. Passes some filters, filtered by others. If 50+ candidates score 80%+, this resume won't be seen.
- Below 60: Auto-filtered by most platforms. Do not submit.

### 2. SCORE BREAKDOWN TABLE

| Dimension                    | Score | Max | Notes |
|------------------------------|-------|-----|-------|
| Keyword Match Rate           |       | 25  |       |
| Job Title & Role Alignment   |       | 15  |       |
| Skills Section Coverage      |       | 15  |       |
| Experience Bullets — Relevance |     | 15  |       |
| Experience Bullets — Proof   |       | 10  |       |
| Experience Level Match       |       | 10  |       |
| Recruiter Scan Test          |       | 5   |       |
| Format & Parsability         |       | 5   |       |
| TOTAL                        |       | 100 |       |

### 3. KEYWORD SCORECARD

Create a table with every significant keyword/phrase from the JD:

| JD Keyword / Phrase | Tier | Present? | Where (section) | Context Quality | Notes |
|---------------------|------|----------|-----------------|-----------------|-------|
| [keyword]           | 1/2/3 | ✓ / ✗ / ~partial | [section] | Strong/Moderate/Weak/Absent | |

Tier 1 keywords missing = CRITICAL gap.
Keywords present only in skills list with no contextual proof = flag as "Moderate — needs experience bullet."

### 4. 6-SECOND RECRUITER SCAN

Simulate a recruiter spending 6-7 seconds on this resume. Answer:

- **Role fit clear?** Can the recruiter immediately tell what role this person targets? (Yes/No + why)
- **Experience level clear?** Are years of relevant experience obvious in the top third? (Yes/No)
- **Top achievements visible?** Are 2-3 quantified achievements scannable without reading deeply? (Yes/No)
- **Visual anchors present?** Are there bold metrics, numbers, or $ figures that catch the eye? (Yes/No)
- **Verdict:** Pass / Borderline / Fail the 6-second test

### 5. TOP STRENGTHS (max 5)

Bullet list of what the resume does well for this JD.

### 6. CRITICAL GAPS (ranked by ATS impact)

For each gap:
- **Gap**: What is missing
- **Tier**: 1 / 2 / 3
- **Impact**: Why it matters for this specific JD (include whether it's a hard filter on legacy ATS)
- **Fix**: Exact suggested change (provide the rewritten line/phrase, not just advice)

### 7. SECTION-BY-SECTION FIXES

For each section that needs changes, provide:

**[Section Name]**
Current: "[relevant current text]"
Suggested: "[improved version with keywords integrated]"
Keywords added: [list them]
Keyword context: [explain what proof/metric supports the keyword]

Only include sections that need changes.

### 8. STUFFING RISK CHECK

| Metric | Value | Status |
|--------|-------|--------|
| Total resume word count | | |
| Unique JD keywords found | | |
| Total keyword instances | | |
| Keyword density | | OK / Warning / Stuffing |
| Most repeated keyword | | X times — OK / Flag |

If stuffing is detected, recommend which instances to remove or redistribute.

### 9. EXPERIENCE CONFIDENCE SCORING

For each role on the resume, score how well it maps to the JD:

| Resume Role | Direct Match (40%) | Transferable (30%) | Adjacent (20%) | Impact (10%) | Confidence |
|-------------|-------------------|-------------------|----------------|--------------|------------|
| [Role 1]    | X%                | X%                | X%             | X%           | X% — DIRECT/STRONG/PARTIAL/WEAK/GAP |

Confidence bands:
- 90-100%: DIRECT — use with confidence
- 70-89%: STRONG — minor reframing needed
- 50-69%: PARTIAL — strategic positioning required
- 45-49%: WEAK — supplementary evidence needed
- <45%: GAP — flag as unaddressed

### 10. PROJECTED SCORE AFTER FIXES

Estimate the new score if all critical gaps are addressed.

| Dimension             | Current | After Fixes |
|-----------------------|---------|-------------|
| Keyword Match Rate    |         |             |
| ...                   |         |             |
| TOTAL                 |         |             |

### 11. ONE-LINE PRIORITY ACTION

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
| Keyword Match Rate           |       | 25  |
| Job Title & Role Alignment   |       | 15  |
| Skills Section Coverage      |       | 15  |
| Experience Bullets — Relevance |     | 15  |
| Experience Bullets — Proof   |       | 10  |
| Experience Level Match       |       | 10  |
| Recruiter Scan Test          |       | 5   |
| Format & Parsability         |       | 5   |
| **TOTAL**                    |       | 100 |

Keyword tier breakdown: X Tier 1 present / Y Tier 1 total | Z Tier 2 present / W Tier 2 total
Top 3 missing Tier 1 keywords: [list]
Biggest gap: [one sentence]
6-second scan: Pass / Borderline / Fail

---

## COMBINED KEYWORD GAP ANALYSIS

Create a master table of all important JD keywords across all roles:

| Keyword / Phrase | Tier | In Resume? | JD-1 | JD-2 | JD-3 | Priority |
|------------------|------|------------|------|------|------|----------|
| [keyword]        | 1/2/3 | ✓ / ✗    | ✓    | ✓    | ✗    | Critical / High / Medium |

Priority = Critical if Tier 1 keyword appears in 2+ JDs, High if Tier 1 in 1 JD or Tier 2 in 2+ JDs, Medium otherwise.

---

## COMBINED OPTIMISATION STRATEGY

Recommend changes that maximise score across ALL JDs simultaneously.

For each change, note which JDs benefit:

| Change | Affects | Expected Score Gain | Stuffing Risk |
|--------|---------|---------------------|---------------|
| [change description] | JD-1, JD-2 | +X pts each | Low/Medium/High |

---

## RANKING

Rank the JDs by current match score, best to worst.

| Rank | JD | Score | Application Strength | 6-Second Scan |
|------|-----|-------|----------------------|---------------|
| 1    |     |       |                      |               |

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
   - Keyword match (25 pts) — classify each missing keyword as Tier 1/2/3
   - Job title alignment (15 pts)
   - Skills coverage (15 pts)
   - Experience relevance (15 pts)
   - Experience proof / quantification (10 pts)
   - Experience level match (10 pts)
   - 6-second recruiter scan (5 pts)
   - Format/parsability (5 pts)

2. Top 5 Tier 1 keywords from the JD that are missing or weak in my resume.

3. The 3 most impactful changes I can make right now — give me the exact rewritten lines.

4. Keyword density check: total word count, keyword instances, density %. Flag if >3%.

5. Projected score after those 3 changes.

Keep the full response under 500 words.

RESUME:
[PASTE HERE]

JOB DESCRIPTION:
[PASTE HERE]
```

---

## PROMPT — Resume Roast (Hiring Manager Persona)

Use this BEFORE tailoring, to identify structural weaknesses in your base resume.

```
You are a strict, experienced hiring manager who has reviewed 10,000+ resumes and
interviewed 500+ candidates. You have zero patience for fluff, vague language, or
generic resumes.

I'm going to show you my resume. Your job is to tear it apart — honestly, specifically,
and constructively. No sugarcoating.

For each issue you find, tell me:
1. WHAT is wrong (the specific line or section)
2. WHY it's a problem (from a hiring manager's perspective, not generic advice)
3. HOW to fix it (give me the exact rewritten version)

Evaluate these dimensions:
- **First impression (6-second test)**: What do you see in 6 seconds? Is it compelling or forgettable?
- **Value proposition**: Can you tell what this person does and why they're good at it within the first 3 lines?
- **Specificity**: Are achievements concrete and quantified, or vague and generic?
- **Relevance signal**: Does the resume signal a clear target role, or does it read as "I'll take anything"?
- **Red flags**: Employment gaps, title inflation, buzzword soup, unsubstantiated claims?
- **Bullet quality**: Rate each bullet A (strong, quantified, specific), B (decent but could improve), or C (weak, vague, delete or rewrite). List every C bullet with a fix.
- **Skills section**: Is it a keyword dump or does it tell a coherent story?
- **Overall verdict**: Would you interview this person? Why or why not?

Be brutal. I want the feedback that would make this resume competitive, not the feedback
that makes me feel good.

RESUME:
[PASTE HERE]
```

---

## PROMPT — Bullet Rewriter (XYZ / CAR Formula)

Use this to rewrite weak bullets into achievement-oriented statements.

```
You are a resume bullet point specialist. I will give you a list of resume bullets
and a target job description.

For each bullet, rewrite it using BOTH formulas and let me pick the stronger one:

**Formula 1 — XYZ (Google format):**
"Accomplished [X] as measured by [Y], by doing [Z]"

**Formula 2 — CAR (Challenge-Action-Result):**
"Faced [Challenge], took [Action], achieved [Result]"

Rules:
- Every rewritten bullet MUST contain at least one quantified metric (number, %, $, time)
- Use strong action verbs (not "responsible for", "helped", "worked on")
- Embed 1-2 keywords from the target JD naturally into each bullet
- Keep each bullet to 1-2 lines maximum
- If the original bullet has no metric, suggest a realistic metric category
  (time saved, % improvement, volume handled, cost reduced) and mark it with
  [VERIFY: insert your actual number] so the user fills in real data
- Never fabricate specific numbers — only suggest metric categories

For each bullet, also rate the original: A (keep as-is), B (minor edit), C (full rewrite needed)

ORIGINAL BULLETS:
[PASTE BULLETS HERE]

TARGET JOB DESCRIPTION:
[PASTE JD HERE]
```

---

## PROMPT — Skills Gap Analyzer

Use this to identify gaps between your resume and a JD, with an actionable closing plan.

```
You are a career strategist. I will provide my resume and a job description.

Your task:

### 1. GAP ANALYSIS TABLE

| JD Requirement | My Level | Gap Size | Category |
|----------------|----------|----------|----------|
| [skill/tool]   | Strong / Working / Exposure / Missing | None / Small / Medium / Large | Hard Skill / Soft Skill / Tool / Cert / Domain |

### 2. QUICK WINS (closable in 1-2 weeks)

For each small/medium gap, provide:
- Exact free resource (course URL, tutorial, documentation)
- Time to complete
- What to add to resume after completing it
- The exact resume line to add (ready to paste)

### 3. STRATEGIC GAPS (need 1-3 months)

For each large gap:
- Best certification or project to close it
- Cost and time estimate
- Whether this is a hard filter (will get you auto-rejected) or a nice-to-have

### 4. POSITIONING STRATEGY

If you can't close all gaps before applying, rewrite the Professional Summary to
position existing experience as adjacent/transferable. Provide the exact rewritten summary.

### 5. INTERVIEW TALKING POINTS

For each gap you're closing or positioning around, provide a 2-sentence answer for
"Tell me about your experience with [gap skill]" that is honest but strategic.

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

8. **Run the Resume Roast first** — before tailoring for any specific JD, run the
   Roast prompt on your base resume to fix structural issues that affect ALL applications.

9. **Use the Bullet Rewriter per role** — don't just run it once. Run it for each
   company's JD so the keywords embedded in bullets change per application.

10. **Check keyword density** — after tailoring, count total words and keyword instances.
    If density exceeds 3%, you're stuffing. Remove redundant mentions and redistribute.
