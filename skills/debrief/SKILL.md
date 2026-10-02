---
name: debrief
metadata:
  author: Rory Brown (rory660)
  version: 1.0.0
description: Recall the work completed in this session and surface loose ends — related issues left unaddressed, unrelated issues noticed in passing, and improvement or refactor opportunities spotted while working. Use when the user asks for a debrief, wrap-up, loose ends, "what's left", or "what else did you notice".
---

You are debriefing the work already done in this conversation. This is a **recall exercise, not an investigation.** Code review investigates; refactoring executes; this reports what you already know.

If the user names an area in their request, scope the debrief to it.

If no substantive work happened in this conversation, say so and stop.

## Hard constraint: minimal further exploration

Everything you report must come from what you already saw while doing the work.

- **Always allowed:** `git status` / `git diff` over this session's own changes. Re-read your own work before recalling from memory — it is the best jog available.
- **Budget:** at most two further lookups, and only into files you edited or read this session. Beyond that, drop the item or mark it unverified.
- **Never:** fresh grep sweeps or codebase surveys, subagents, files you never touched.

If context was compacted this session, say which parts you can still speak to and which are lost. Do not present the tail of a long session as if it were the whole session.

## What to produce

Walk back through the session — the task, the detours, the things that were awkward, the things you deliberately skipped, the surprises — and sort what you remember into these buckets. Omit any bucket that is genuinely empty; do not pad.

### 1. Related issues not addressed
Problems in or adjacent to the code you changed, left alone: edge cases, callers not updated, tests not written, docs not touched, thin error paths, follow-on work the change implies. Say why each was left (out of scope, needed a decision, blocked, deferred). Inclusion test: would a reviewer of this change reasonably raise it? If not, drop it.

### 2. Unrelated issues found
Noticed in passing, nothing to do with the task: bugs, stale code, wrong-looking logic, dead files, misleading comments, config or dependency oddities, docs that contradict the code.

### 3. Improvements & refactors spotted
Duplication, awkward abstractions, types that fought you, patterns inconsistent with the rest of the codebase, misleading naming. Note if the friction actually cost you time this session — that is evidence, not speculation.

### 4. Notes on the work itself (optional)
Assumptions made, decisions that could have gone the other way, verification you could not complete, things the user should double-check. Assumptions whose answer would still redirect ongoing work mid-session belong to the `assumptions` skill, not here — this bucket holds what is already settled.

## Format

Group by bucket, at most five bullets each — keep the strongest and say how many you cut. Rank within each bucket by what you'd want looked at first.

Each finding gets a **class tag** so it can be acted on or turned into an issue without rework:

- **bug** — something observable is wrong now. Silent failure modes count: missing validation that lets things degrade quietly is a bug, not a gap.
- **gap** — correct for today, but a known hole that becomes a problem when X lands or scales.
- **cleanup** — refactor, polish, consistency, DX, or documentation. Documentation-only items say so ("a reminder, not an action item on its own").

- **`path/to/file.ts` — one-line summary.** `bug|gap|cleanup` · `S|M|L`. A sentence or two: what you saw, why it matters. Paths always; line numbers only if verified or read from the diff just now — a misremembered line number is worse than none.

Rules for the list itself:

- Merge related trivia into one bullet — one "test coverage" note, not one per file. Drop anything without a concrete path or commit and a falsifiable observation.
- Anything you already raised during the session: mark it as already raised, or leave it out.
- Every finding must stand on its own: a reader with no memory of this session should understand where it came from and why it matters.

If, after honest recall, there is nothing meaningful to report, say so plainly in a sentence. An empty debrief is a valid result; inventing findings to fill the template is not.

## Do not

- Do not fix anything. This skill reports; it does not edit.
- Do not re-summarise the work that was completed — the user was there. Lead with what was *not* done.
- Do not speculate about code you never looked at.
- Do not create issues, files, or artifacts as a side effect. If the user wants findings tracked, they will ask — then deduplicate against the existing backlog before filing anything.

## Hand off

Close by offering next steps the user can take with the report — file selected findings as issues (deduplicating against the backlog at that point), turn items into a plan, or note bucket 4 items worth remembering. Then stop.