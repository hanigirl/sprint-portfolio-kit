---
name: design-journal
description: Capture design decisions live during a design sprint into a project folder, so the end-of-sprint portfolio has the real story — rejected directions and why, pivots, and metric movements — instead of only the surviving final design. Use when starting a student's sprint project ("set up the project folder", "התחל ספרינט"), and at every decision moment ("log this decision", "/log-decision", "תעד את ההחלטה", "פסלנו כיוון", "היה פיבוט", "המדד זז"). Writes design-rationale-style decision records. Pairs with the sprint-portfolio skill, which compiles the folder at the end.
---

# Design Journal — capture the sprint as it happens

The end-of-sprint portfolio is only as good as what gets captured **at the moment a decision falls**. The rejected directions, the "why we dropped them", and what moved a metric are ephemeral — a folder scanned at the end holds only what *survived*. Your job is to fight that loss: write the decision down **now**, not later.

This skill uses the project folder as an **append-only journal**. Nothing lives in model memory — it lives in files.

## Mode A — Start a sprint (initialize the folder)
When a student begins, scaffold their project folder from the skeleton:
- Copy `templates/project-skeleton/` (next to this skill) into the student's project path. It already contains the subfolders `resources/`, `research/`, `decisions/`, `versions/`, `metrics/` — one project folder, named subfolders, nothing scattered.
- Fill `brief.md` with them: the problem, the user, and the **North-Star metric + baseline** (this is what the portfolio's hook will later be measured against — get a real baseline number now if one exists).
- Delete the `EXAMPLE.md` placeholders once real content starts.
- Tell them where things live: **background** (product, persona, competitors, brand) → `resources/`; **what they learn** (test summaries, interviews, quotes, findings) → `research/`; **the raw numbers** → `metrics/`. Everything goes *inside this folder* — a file left outside it is invisible to the portfolio agent.

## Mode B — Log a decision (the core loop)
Trigger at every natural decision moment, or on explicit `/log-decision`. **Also proactively offer** to log when you notice a decision, a rejected direction, or a pivot happening in the work — don't wait to be asked.

### How to surface the prompt (interface, not a lost text question)
When you detect a decision, **do not** ask a free-text question that scrolls away in the chat. Surface a **structured choice card** (the `AskUserQuestion` tool) so the moment can't be missed. Keep every student-facing word plain — never expose jargon like "chips", "frontmatter", or "record".

1. **Detection card — two options only: yes or skip.** Pre-fill the title you guessed and ask simply "לתעד את ההחלטה הזאת?":
   - `תעד` — you draft the full record from context and write it.
   - `לא עכשיו` — skip; never force it.
   Do **not** offer "approve" vs "edit" as an upfront fork (e.g. a second "כן, אבל אתקן" button). Two yes-buttons that both document, differing only by whether the student edits, confuse people — editing is not a mode chosen in advance.
2. **After you draft — show it, then invite precision.** Present the drafted decision back in plain language and ask one simple thing: "זה מדויק? אפשר לתקן או להוסיף." Two paths, always open here:
   - **Confirm the parts you guessed** with a plain question in the student's own language — e.g. "אילו כיוונים נפסלו?" listing the candidates you detected as pickable options + "אחר". Never label these "chips".
   - **The student's own words** — a free-text field so they can dictate precise details they insist be recorded. Preserve their wording **verbatim** (as a quote), never paraphrased — sometimes the exact framing *is* the point. Keep it in the relevant field or a short `## In the student's words` note. Also available on demand anytime ("document this, in my words: …").

Detection is still your judgment — the card solves "the question got lost", not "when to open it". Keep `/log-decision` as the student's manual safety net at any moment.

### The content to capture
Interview the student briefly (don't make them write — extract it from them), filling the record from `templates/decision-record.md`:
1. **Decision** — what exactly was chosen.
2. **Context** — the problem/constraint that prompted it.
3. **Options Considered** — all the alternatives, **including the ones rejected and why**. Push here: the rejected directions are the most valuable material in the whole portfolio. If they only name the winner, ask "what else did you consider, and why not that?".
4. **Evidence** — research, data, usability finding, benchmark.
5. **Reasoning** — why this over the others (user need / business goal / principle / feasibility).
6. **Trade-offs** — what was compromised or deprioritized.
7. **Validation Plan** — which metric/feedback will confirm it (link to `metrics/`).

Then set the **frontmatter graph** — this is what later lets the portfolio say "X moved Y":
- `id` — next running number; `title`, `date`, `stage` (sprint day/phase).
- `type` — `decision` | `rejected-direction` | `pivot` | `metric-move`.
- `affects_version` — which version this changes.
- `driven_by` — the metric id or finding that pushed this (e.g. `metric/usability-r1`). Leave empty if self-initiated.
- `pivot_from` — the `id` of the earlier record this supersedes, when it's a pivot.

Write to `decisions/NNN-slug.md` (zero-padded id + short kebab title). Append a one-line entry to `journal.md` (create it if absent): `NNN · date · stage · title`.

## Mode C — Log a metric move
**Detect it in conversation — don't wait for a tidy result.** A metric move usually arrives as an aside, not a report: "the test showed time dropped to 6 minutes", "conversion went up", "4 out of 6 finished the task", "it went from 50% to 92%", "sales doubled this week". The moment you hear a number change — a before and an after, a test/analytics/sales result, a success rate — **proactively surface the same capture card as Mode B**, so the number can't scroll away:

1. **Detection card — two options: yes or skip.** Pre-fill the metric you heard and ask plainly, e.g. "לתעד את המדד הזה?":
   - `תעד` — you draft the metric record from what was said and write it.
   - `לא עכשיו` — skip; never force it.
2. **After you draft — show it, invite precision.** Present it back plainly and ask "זה מדויק?" — confirm the parts you guessed and let the student fix the exact numbers. Keep every word plain; never expose "frontmatter", "record", or "metric id" to the student.

Then write/update a file in `metrics/` (from the metrics example): the metric name, **before/after, sample, and source**. On the decision records it validates or overturns, set their `driven_by` to this metric id — and if it caused a pivot, create a `pivot` record linking `pivot_from`. **Never invent a number** — if the student gives an after but no baseline, capture what they said and mark the baseline as unknown; don't guess one. `/log-decision` stays the manual fallback for a metric mentioned outside the session.

**Split the metric from the story.** `metrics/` holds only the tight numbers. When the student also has a **fuller test summary** — what they saw, where users got stuck, verbatim quotes — write that to `research/` (one file per round, e.g. `research/usability-r1.md`), and keep the matching number in `metrics/`. The two cross-link: the finding in `research/` is the Evidence; the number in `metrics/` is the proof. Offer to capture both when a test wraps.

## Mode D — File a resource or a learning
**Detect learnings in conversation too — the same active reflex as Modes B and C.** A finding rarely arrives labeled; it slips out as "I noticed users kept looking for a back button", "she said she didn't trust it", "turns out people skip onboarding", "the competitor does X and it works". The moment you hear an observation, an insight, or a **verbatim user quote**, surface the same two-option capture card ("לתעד את זה?" → `תעד` / `לא עכשיו`), then draft it back plainly and confirm before writing. Preserve any quote **word-for-word** — the exact framing is often the point.

Route it to the right folder:
- **A learning / finding / user quote** → `research/` (append to the current round's file, e.g. `research/usability-r1.md`, or start one).
- **Background** the student hands you (product context, persona, competitor/benchmark notes, brand) → a named file in `resources/` (`persona.md`, `competitors.md`, …). Summarize rather than dumping; link the source.

Never invent context — if they don't have it, leave the file out. `/log-decision` (or just "document this") stays the manual fallback for anything mentioned outside the session.

## Rules
- **Capture during the decision, not after** (per design-rationale best practice). A record written a week later is already lossy.
- **Never invent** a rejected option, a reason, or a number to make the story neater. Empty is better than fabricated — the portfolio depends on this being true.
- Keep records short but complete: specific enough to be useful months later, to someone who wasn't there.
- Store everything **alongside the design files**, in the project folder — that folder is the single source of truth the `sprint-portfolio` skill will read.
