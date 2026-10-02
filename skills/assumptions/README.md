# assumptions

Mid-session recall for coding-agent sessions. Part of
[lookout-skills](../../README.md).

Ask "what did you assume", "what would you have asked me", or run it after a
decision-heavy stretch, and the agent reports the points where it picked
between plausible readings of your intent and proceeded without asking. It
does not doubt the approach (that is [pivot](../pivot/README.md)) and does not
report loose ends (that is [debrief](../debrief/README.md)) — it reports
unspoken decisions, while the answers can still redirect the work.

## What it returns

A flat ranked list, at most five, of pre-answered questions — one word from
you confirms the default or redirects:

```
Retries in loader.ts — Assumed: idempotent-by-design; the retry loop is
built on it. Alternative: fail-fast until the queue consumer lands.
Default: keep. Override: reply "fail-fast" (redo: retry loop, ~30 min).
Evidence since: undermines — the consumer writes look non-idempotent.
```

Every finding states the assumed answer, the alternative not taken, the redo
cost if overturned, and whether anything seen since the decision supports,
undermines, or leaves untested the assumption. Undermined assumptions rank
first — those are not questions anymore.

An assumption only makes the report if answering it now would still change
what happens next in this session; that filter is the boundary with debrief's
"notes on the work itself" bucket. At wrap-up, the natural result is an empty
report and a pointer to a debrief.

## Hard constraints

- **Recall, not investigation.** The session's own `git diff` plus at most two
  further lookups into files the session already touched. No fresh sweeps, no
  subagents — the code is always self-consistent with whatever was chosen, so
  reviewing it cannot recover an intent assumption.
- **Pre-answered or dropped.** If the agent cannot state the assumed answer
  and the alternative in two clauses, it has not understood the decision.
- **An empty report is a valid result.** Inventing questions to justify the
  invocation is the named failure mode.
- **Reports; does not act.** The agent presents; only the user's answer
  changes anything.

Fires on: "what did you assume", "what would you have asked me", "did you
make any assumptions", or after a decision-heavy stretch before more work
builds on the assumptions. The full contract lives in
[SKILL.md](SKILL.md).
