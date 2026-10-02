# debrief

Session-end recall for coding-agent sessions. Part of
[lookout-skills](../../README.md).

Ask for a debrief, wrap-up, "loose ends", or "what else did you notice" after
a working session, and the agent reports what the work left behind. It does
not re-summarize what you already watched happen, and it does not fix
anything — it leads with what was *not* done.

## What it returns

Four buckets, each omitted when genuinely empty:

1. **Related issues not addressed** — in or adjacent to the changed code,
   with why each was left (out of scope, needs a decision, blocked, deferred).
2. **Unrelated issues found** — noticed in passing, unrelated to the task.
3. **Improvements & refactors spotted** — duplication, awkward abstractions,
   friction that actually cost time this session.
4. **Notes on the work itself** (optional) — assumptions, forks that could
   have gone the other way, verification you couldn't complete. Assumptions
   whose answer would still redirect ongoing work mid-session belong to the
   [assumptions](../assumptions/README.md) skill, not here.

Every finding carries a class tag so it can be acted on without rework:

```
- src/config/loader.ts — env vars validated only for the two new keys. `gap` · S
  Pre-existing keys still load unvalidated; left alone, out of scope.
```

`bug` (observable wrongness now, silent failure included) · `gap` (correct
today, a known hole when X lands) · `cleanup` (refactor, polish, docs —
docs-only items say so). Size `S|M|L`. At most five bullets per bucket,
strongest kept, cuts counted. Line numbers only if verified just now — a
misremembered line number is worse than none.

## Hard constraints

- **Recall, not investigation.** The session's own `git diff` plus at most two
  further lookups into files the session already touched. No fresh sweeps, no
  subagents, nothing it never opened.
- **Compaction honesty.** After context compaction it says which parts of the
  session it can still speak to, rather than presenting the tail as the whole.
- **An empty debrief is a valid result.** Inventing findings to fill the
  template is the named failure mode.
- **Reports and stops.** No edits, no issues filed as a side effect. It closes
  by offering next steps — file findings as issues, turn them into a plan —
  and waits.

Fires on: "debrief", "wrap up", "loose ends", "what's left", "what else did
you notice". An optional area scopes it. The full contract lives in
[SKILL.md](SKILL.md).
