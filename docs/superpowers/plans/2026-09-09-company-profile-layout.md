# Company Profile Layout Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Put tailored company resume folders under `company/` while retaining root base profiles.

**Architecture:** Move the existing `company-*` directories without changing their contents. Make profile identifiers include `company/`, and update active instructions to match.

**Tech Stack:** GNU Make, Bash, LaTeX, Markdown

**Spec:** `docs/superpowers/specs/2026-09-09-company-profile-layout-design.md`

## Global Constraints

- Keep `base-data-analyst/` and `base-data-engineer/` at the repository root.
- Preserve every `company-<name>/resume.tex` unchanged apart from its location.
- Use `company/company-<name>` for company source and output profile paths.
- Do not rewrite historical conversation records.

---

### Task 1: Move company profiles and update build discovery

**Files:**

- Create: `company/`
- Move: `company-*/` → `company/company-*/`
- Modify: `Makefile`, `compile.sh`

- [x] **Step 1: Move all company profile folders**

```bash
mkdir -p company
git mv company-* company/
```

- [x] **Step 2: Discover root base profiles and nested company profiles**

```make
PROFILES := $(patsubst ./%,%,$(shell { find . -maxdepth 1 -type d -name 'base-*'; find company -mindepth 1 -maxdepth 1 -type d -name 'company-*'; } | sort))
```

- [x] **Step 3: Update shell profile listing**

```bash
for d in "$ROOT_DIR"/base-* "$ROOT_DIR"/company/company-*; do
  [ -d "$d" ] && echo "  ${d#"$ROOT_DIR"/}"
done
```

- [x] **Step 4: Verify profile discovery**

Run: `make list && bash compile.sh`

Expected: both base profiles and all company profiles list with `company/` prefixes; the no-argument invocation exits with usage.

### Task 2: Update active documentation and assistant instructions

**Files:**

- Modify: `README.md`, `PROCESS.md`, `SUMMARY.md`, `.cursor/skills/resume-tailoring/SKILL.md`

- [x] **Step 1: Replace active company source paths and commands**

```text
company-<name>/resume.tex → company/company-<name>/resume.tex
make company-<name> → make company/company-<name>
output/company-<name> → output/company/company-<name>
```

- [x] **Step 2: Preserve base paths and historical records**

```text
base-data-analyst/ and base-data-engineer/ remain unchanged.
.cursor/memory/conversation-history.md is not modified.
```

- [x] **Step 3: Verify active references**

Run: `rg -n 'company-[^/ ]+/' README.md PROCESS.md SUMMARY.md .cursor/skills/resume-tailoring/SKILL.md`

Expected: each active company source path has the `company/` parent.

### Task 3: Validate and deliver

**Files:**

- Modify: migrated files and active docs only

- [x] **Step 1: Check scripts and Make parsing**

```bash
bash -n compile.sh
make list
```

- [x] **Step 2: Confirm no root-level company profile directories remain**

```bash
find . -maxdepth 1 -type d -name 'company-*'
```

- [x] **Step 3: Review the diff, commit named files, and push `main`.**
