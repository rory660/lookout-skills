---
name: contamination
description: Audit what this session wrote into files — comments, docs, test names, error messages, instruction files — for claims that were never verified and that future sessions will read as ground truth. Use when the user asks what this session left behind, "did you write anything unverified", or before committing or handing off agent-written work.
---

You are auditing the claims **this session wrote down** — not the ones it said. A comment, doc line, or test name outlives the session and is read later by humans and agents as ground truth. Stale documentation was once true and drifted; contamination was never true — only plausible when written. Only you know which is which, and only now: once the session ends, that provenance is unrecoverable by anyone.

This is a recall exercise, not an investigation — same contract as debrief.

If the user names an area, scope the audit to it. If this session wrote nothing to any file, say so and stop.

## Hard constraint: minimal further exploration

- **Always allowed:** `git status` / `git diff` over this session's changes. The diff is the inventory of what was written — re-read your own work before recalling from memory.
- **Budget:** at most two further lookups, and only into files you edited or read this session. Beyond that, mark the item unverified and move on.
- **Never:** fresh repo surveys, subagents, files you never touched.
- If context was compacted this session, say which writes you can no longer speak to. Do not audit from a reconstructed memory of what you might have written.

## Scope: written surfaces, ranked by blast radius

What future readers inherit, most authoritative first:

1. **Instruction files** — CLAUDE.md, AGENTS.md, SKILL.md files written or edited this session. Highest authority a written claim can carry.
2. **Docs & README** — usage claims, version claims, "supports X" claims, especially those written before the code was ever exercised.
3. **Error and log messages** — asserting causes the code did not establish ("authentication failed" when the check only tested for null).
4. **Test names** — describing intent broader than what the test asserts (`test_user_can_delete_own_record` passing on a 200 for *any* deletion).
5. **Comments & docstrings** — "safe because…", "idempotent", "race-free", "mirrors the behavior of X".
6. **TODO/FIXME** — encoding an assumption as an established fact.
7. **Commit messages** — claiming verification ("fixes flaky test") that never ran.

## What counts as verified

Tag every written assertion that goes beyond what tool output directly proved:

- **verified** — backed by tool output this session: a run, a build, an lsp query, a command. "It compiled" verifies compilation and nothing else. A passing test verifies the test.
- **inferred** — reasoned from evidence seen this session, but never independently checked. Quote the reasoning in one clause.
- **guessed** — plausible-sounding, with no supporting evidence at all.

The report is about `inferred` and `guessed`. A surface that is fully verified earns one line saying so — that is a good result, not an empty one.

## Format

Group by file, ranked by blast radius within the file. At most eight findings — merge related trivia into one bullet, keep the strongest, and say how many you cut. Each finding:

- **`path/to/file.ts:NN` — the claim, quoted.** `inferred|guessed` · who reads this next · the cheap check that would verify it, where one exists (one command or one test).

Where a rewording fixes it, include the suggestion — e.g. `// retries are safe here` → `// TODO: verify retries are safe here` — but do not apply it.

If everything written this session was verified before writing, say so plainly in a sentence. Inventing findings to fill the template is precisely the contamination this skill exists to prevent.

## Do not

- Do not fix, reword, or delete anything. This skill reports; edits happen only if the user asks, and then only to the flagged claims.
- Do not flag the code's correctness, style, or naming — only the gap between what is written and what was proven.
- Do not flag spoken claims. They evaporate with the session and are out of scope.
- Do not flag scratch artifacts the session already deleted or deliberately left out of the tree.