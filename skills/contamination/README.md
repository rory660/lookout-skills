# contamination

Audits what this session *wrote into files* — comments, docs, test names,
error messages, instruction files — for claims that were never verified and
that future sessions will read as ground truth. Part of
[lookout-skills](../../README.md).

The distinction it draws: stale documentation was once true and drifted;
contamination was never true — only plausible when written. And the reason it
must run *now*: only the session knows which is which. Once the session ends,
that provenance is unrecoverable by anyone.

## What it returns

Written surfaces, ranked by blast radius — instruction files (CLAUDE.md,
AGENTS.md, SKILL.md) first, then docs and READMEs, error and log messages,
test names, comments and docstrings, TODO/FIXME, commit messages.

Every written assertion beyond what tool output directly proved is tagged:

- `verified` — backed by a run, build, lsp query, or command this session.
  "It compiled" verifies compilation and nothing else.
- `inferred` — reasoned from evidence seen this session, never independently
  checked; the reasoning is quoted in one clause.
- `guessed` — plausible-sounding, no supporting evidence at all.

The report is about `inferred` and `guessed`. A fully verified surface earns
one line saying so — that is a good result, not an empty one.

Each finding, at most eight per report:

```
src/config/loader.ts:41 — "// retries are safe here — idempotent by design."
  guessed · next reader: whoever adds the queue consumer · cheap check: none
  in-repo. Suggest: "// TODO: verify retries are safe here" (not applied).
```

Where a rewording fixes it, the suggestion is included — never applied.

## Hard constraints

- **Recall, not investigation.** Same budget as debrief: the session's own
  `git diff`, plus at most two further lookups into files the session
  touched. Never fresh repo surveys or subagents.
- **Reports; does not fix.** No rewording or deletion — edits happen only if
  the user asks, and only to flagged claims.
- **Written claims only.** Spoken claims evaporate with the session; code
  correctness, style, and naming are out of scope.
- **If this session wrote nothing unverified, it says so in a sentence.**
  Inventing findings to fill the template is precisely the contamination this
  skill exists to prevent.

Fires on: "what did you leave behind", "did you write anything unverified",
or routinely before committing or handing off agent-written work. The full
contract lives in [SKILL.md](SKILL.md).
