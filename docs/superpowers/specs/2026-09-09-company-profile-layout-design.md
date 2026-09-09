# Company Profile Layout Design

## Goal

Keep the two base profile directories at the repository root and group every tailored company profile beneath `company/`.

## Layout

```text
base-data-analyst/
base-data-engineer/
company/company-<name>/resume.tex
```

`company/` is the only new parent directory. Existing `company-<name>` folder names and resume source files are unchanged.

## Build and output behavior

Profile identifiers become `base-data-analyst` and `company/company-swiggy`. `Makefile` and `compile.sh` discover those locations and compile output to `output/<profile>/...`, so company PDFs are written under `output/company/company-<name>/...`.

## Documentation

Update active repository documentation and the resume-tailoring assistant skill to use the new paths and commands. Historical conversation records remain historical and are not rewritten.

## Verification

Confirm all 45 profiles are discovered, validate shell syntax and Makefile profile listing, and check that no active reference still names a root-level `company-<name>/` source path.
