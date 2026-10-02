---
name: assumptions
metadata:
  author: Rory Brown (rory660)
  version: 1.0.0
description: Surface the decision points where you assumed the user's intent and proceeded without asking, presented as pre-answered questions the user can confirm or overturn in one word. Use when the user asks what you assumed, "what would you have asked", or after a decision-heavy stretch before more work builds on those assumptions.
---

You are reviewing decisions already made in this conversation for the questions that were never asked. This is a recall exercise, not an investigation — same contract as debrief. What it finds is not loose ends (that is debrief) and not doubt about the approach (that is pivot): it is the specific points where you picked between plausible readings of the user's intent and did not stop to ask.

This fires mid-session by design. Every finding is worth reporting only while the answer can still change what happens next — an assumption surfaced after the work is a post-mortem, not a question.

If the user names an area, scope the audit to it. If little substantive work has happened this session, say the sample is too small and stop.

## Hard constraint: minimal further exploration

- **Always allowed:** `git status` / `git diff` over this session's changes. Re-read your own work before recalling decisions from memory — it is the best jog available.
- **Budget:** at most two further lookups, and only into files you edited or read this session. Beyond that, mark the item unverified and move on.
- **Never:** fresh repo surveys, code reviews, subagents, files you never touched. The code is always self-consistent with whatever you chose — reviewing the current state cannot recover an intent assumption. The session's own decisions are the evidence.
- If context was compacted this session, say which decision ranges you can no longer speak to. A compacted-away decision point is unrecoverable — mark it as lost; never reconstruct a plausible one from the surviving tail.

## The four-part test

An unasked question exists only where **all** of these hold:

1. **A plausible alternative existed.**
2. **The user's intent was not derivable** from the repo or its conventions — the codebase already answered it.
3. **You proceeded without asking.**
4. **Answering it now would change what happens next in this session.**

Condition 4 is the boundary with debrief: an assumption whose answer would only reshape a report is debrief material, not this. If you are at wrap-up and nothing is still changeable, say so in one sentence and point the user to a debrief.

## What to produce

Walk these recall buckets silently — they are scaffolds for finding decision points, not sections in the report:

1. **Ambiguous words** — interpretations you chose among plausible readings ("make it consistent" — with the callers or with the schema?).
2. **Scope boundaries drawn** — in/out calls you made unilaterally (tests, docs, callers, error paths).
3. **Preference calls** — defensible-either-way tradeoffs: blocking vs async, where a file lives, flag vs config, format of output.
4. **Silent risks** — anything a cautious user might have vetoed: edits beyond named files, deletions, dependency changes, irreversible steps.

Then emit a flat ranked list, strongest first, at most five — state how many you cut.

### Format per finding

```
Retries in loader.ts — Assumed: idempotent-by-design; the retry loop is
built on it. Alternative: fail-fast until the queue consumer lands.
Default: keep. Override: reply "fail-fast" (redo: retry loop, ~30 min).
Evidence since: undermines — the consumer writes look non-idempotent.
```

Rules:

- **Pre-answered.** Every finding states the assumed answer and the alternative so the user can reply with one word. If you cannot state both sides in two clauses, you have not understood the decision.
- **Cost is mandatory.** "Would change the approach" is not actionable; a redo scope and a rough time is.
- **Undermined first.** If anything you saw after the decision contradicts the assumption, that is not a question — it is a defect in the assumption, and it ranks first regardless of the other ordering.
- Rank the rest by P(the user answers differently) × cost of being wrong.
- The single strongest finding may stand alone as the whole report if the rest fail the four-part test.

If nothing passes the test, say so plainly in a sentence. Inventing questions to justify the invocation is the named failure mode; the test for every candidate is whether you would have chosen differently with full knowledge.

## Do not

- Do not act on your own findings. You present; the user answers; only then does anything change.
- Do not manufacture doubt to seem rigorous. An honest "nothing was load-bearing" in one sentence is a valid result.
- Do not re-ask anything actually asked during the session, and do not flag choices the repo or user already settled.
- Do not frame findings as if asked before the work ("would you like me to…"). You are reporting assumptions already acted on, in plain past tense, with stated defaults.
- Do not re-run the audit unprompted every few turns. Fire when the user asks, or when the user scheduled a checkpoint.

## Hand off

If the user answers findings: restate the plan under the new answers, then stop and wait. If they answer nothing: stop — silence means the defaults stand, and you may say so in one clause. Anything failing the changeable-now test belongs in a debrief.
