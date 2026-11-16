---
name: sprint-portfolio
description: Build a portfolio-ready web case study for a student by scanning their design-sprint project folder (brief, resources, research, decisions, versions, metrics). Reconstructs the story — decisions, rejected directions and why, pivots, and metric movement — and renders a self-contained RTL HTML case-study page. Use at the END of a design sprint, when Hani or a student says "build the portfolio", "/build-portfolio", "תבנה את תיק העבודות", "סכם את הספרינט לקייס סטאדי", or points an agent at a project folder to compile. Composes the hani-case-study anatomy; sources the metric from the folder, never from a live question.
---

# Sprint Portfolio — compile a project folder into a case study

You turn a **design-sprint project folder** (the append-only journal produced by the `design-journal` skill) into a **portfolio-ready web case study**. You are **stateless**: everything you need is in the folder. You do not rely on memory of any conversation — you *read the folder*.

The deliverable's power is the stuff that normally gets lost: **the rejected directions and why, the pivots, and what moved which metric.** Protect that material above all.

## Step 0 — Locate & read the whole folder
Ask for the project folder path if not given. Then read **all** of it:
- `brief.md` — the challenge, the user, the North-Star metric + baseline.
- `resources/*` — background context: product, persona, competitors/benchmark, brand. Feeds the Challenge and the overall framing.
- `research/*` — qualitative learning: usability-test summaries, interviews, findings, **verbatim quotes**. Feeds Evidence in Process and the qualitative side of Impact.
- `decisions/*.md` — every decision record (frontmatter + 7 fields). Sort by `id`.
- `versions/*/` — iteration artifacts + each `notes.md`.
- `metrics/*.md` — before/after numbers and their source.
- `journal.md` — if present, the timeline index.

These folders may not all exist — read whatever is present, and don't invent content for a missing one. Cross-link: a finding in `research/` often explains a decision's Evidence and produced a number in `metrics/`.

Build an internal model:
- **Timeline** — order decisions by `id`/`date`/`stage`.
- **Causality graph** — follow `driven_by` (what pushed a decision) and `pivot_from` (which earlier record it replaced). This graph is how you narrate "X moved Y".
- **Rejected directions** — every `Options Considered` bullet marked rejected, with its "why", and every record of `type: rejected-direction`.

## Step 1 — Metric gate (MANDATORY, before writing)
Apply the **`hani-case-study` metric discipline**, but **source the number from `metrics/`**, not from a live question:
- Find the North-Star metric and its **before/after + source** in `metrics/` (cross-check against `brief.md`).
- The metric may be: usability results (time/steps A→B, task success, errors), conversion, ROI, or product clarity.
- **If the number is missing or has no baseline/source:** do **not** invent, estimate, or round. Ask the user **once** for the exact before/after figure and its source. If there is genuinely no number, use the closest real evidence (a user quote, a bug report, a decision the work caused) and **mark the Impact section as qualitative, saying so in the draft**.
- The confirmed metric becomes the **hook of the Overview**.

Never fabricate a number — a recruiter spots it immediately.

## Step 2 — Map the folder onto the case-study anatomy
Produce the 6 sections of `hani-case-study`, sourced like this:

1. **Overview** — title + one-liner (from `brief.md`); role/team, timeline/scope (from brief + stages); **key metric as the hook** (Step 1).
2. **Challenge** — problem, user pain, constraints, why it mattered (from `brief.md` + the product/persona context in `resources/`).
3. **Process** — the heart. From `research/` + `decisions/`: research & findings (the `research/` summaries and quotes, plus each record's Evidence), **ideation breadth including the rejected directions and the "why they were rejected"** (Options Considered), key decisions & rationale (Decision + Reasoning), iteration (the timeline across versions). Where a decision cites a benchmark or competitor, pull it from `resources/`. **Narrate the pivots** using the causality graph ("after round-1 testing moved task-success from 50%→X, we pivoted from direction 001 to 004 because …").
4. **Solution** — final design walkthrough + key interactions (latest `versions/`), how it answers the challenge, design-system/technical notes. Use real screenshots from `versions/`, not mockups.
5. **Impact** — the `metrics/` number **with before/after and source**; qualitative results (the findings and verbatim quotes from `research/`); business impact; what they'd do differently.
6. **Reflection** — learnings, challenges overcome, skills developed.

Keep the narrative honest to what's in the folder. If a section is thin because the journal is thin, say so briefly rather than padding — and note what to capture next time.

## Step 3 — Render the web case study
Output a **single self-contained HTML file** (`portfolio.html` in the project folder), portfolio-ready:
- **RTL, Hebrew-first**, responsive, works at phone width, print/PDF-ready.
- A hero that leads with the **metric hook**. Clear section headings for the 6 parts.
- **Show the journey:** a visual **before/after** from `versions/`, a compact **decision/pivot timeline** (the causality graph), and callouts for the rejected directions ("ניסינו X — נפסל כי Y").
- Embed the real screenshots from `versions/` (reference them by relative path, or inline as needed).
- Define colors as CSS variables; give `body` an explicit background. Keep it elegant and scannable — short paragraphs, first person for the student's own contributions.

For a higher-craft visual pass you may apply the project's design skills (e.g. `design-taste-frontend` / `high-end-visual-design`). The case study must stand on its own, opened directly in a browser.

## Quality bar
- Every claim traces to a file in the folder. No invented metrics, no invented decisions.
- The rejected directions and the pivots are visible, not buried — that is what distinguishes this from a generic portfolio.
- The metric is the hook, with its real before/after and source.
