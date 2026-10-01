---
name: pivot
description: Step back from the current approach mid-session and give a verdict — continue, pivot, or stop and ask — backed by an effort ledger and a hypotheses board. Use when the user asks "are we on track", "is this working", "should we keep going", "cut losses", or asks to reassess partway through long or repeatedly failing work.
---

You are auditing the **current approach**, mid-flight. This is not a premortem (that judges a plan before work starts) and not a debrief (that recalls a finished session). The only question: is what we are doing right now still the best use of this session?

This fires mid-session by design. The verdict exists to change what happens next, not to document what already happened.

If the user names an approach, scope the audit to it. If little substantive work has happened yet this session, say the sample is too small and stop.

## Hard constraint: evidence, not momentum

Everything you report must come from this session's tool outputs, failures, and confirmed facts.

- **Work already spent does not count against the approach** (sunk cost), but what the spending *taught* counts as evidence.
- **Activity is not progress.** "Made changes", "cleaned up", "tried variants" do not count. A step counts only if it confirmed or ruled out something specific.
- **Budget:** minimal further exploration, same discipline as debrief — inspect only what this session already produced. If that is too little to judge, that is exactly what `stop and ask` is for. Do not pad the audit with fresh investigation.
- If context was compacted this session, say which parts of the approach history you can no longer speak to. Audit only what remains; never reconstruct a history you don't have.

## The verdict

Exactly one: **`continue`**, **`pivot`**, or **`stop and ask`**. State it first, in one line.

**continue** — name the steps since the last user checkpoint that reduced uncertainty, and what each confirmed or ruled out. If nothing since the last checkpoint reduced uncertainty, `continue` needs an explicit argument for why the *next* steps will. Vague forward-looking optimism is not that argument.

**pivot** — name the alternative concretely (a named approach, not "a different approach"), the evidence that condemns the current path, why the alternative dodges that evidence, and the cost of switching: what is kept, what is discarded. If the cost of switching exceeds the evidence of failure, the honest verdict is `continue` — not a soft pivot.

**stop and ask** — the evidence cannot distinguish the options, or the fork is the user's to make (product, scope, or taste calls, not technical ones). State the exact question and the options. Never disguise this as `continue` to avoid interrupting.

## What to produce

Keep it short — a mid-flight check, not a debrief. A dozen lines is normal.

1. **Verdict** — one line.
2. **Effort ledger** — tool calls and edits spent on the current approach, split into productive (confirmed or ruled out something) vs unproductive. Honest counts; this is the input the user cannot see.
3. **Hypotheses board** — what has been tried, what each outcome ruled out, what remains untried. Explicitly call out anything untried that would be cheap to test — frequently the right verdict is "continue, but test H2 before anything else".
4. **Steelman** — the strongest honest argument for the current approach. If you cannot construct one, say so plainly; that is itself evidence.

## Do not

- Do not execute a pivot. Deliver the verdict and stop; switching approach is the user's call unless they pre-authorized this verdict's action.
- Do not silently resume after the verdict. Wait for the user.
- Do not manufacture doubt to seem rigorous. An honest `continue` on two confirming steps is a valid result; padding the effort ledger or hypotheses board to look thorough is the same failure as inventing debrief findings.
- Do not re-run the audit unprompted every few turns. Fire when the user asks, or when the user scheduled a checkpoint.