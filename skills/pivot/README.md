# pivot

Mid-flight audit of the current approach. Part of
[lookout-skills](../../README.md).

Ask mid-session — "are we on track", "is this still worth it", "cut losses" —
and the agent steps back from what it is doing right now and delivers one
verdict backed by an effort ledger and a hypotheses board. It is not a
premortem (judges a plan before work starts) and not a debrief (recalls a
finished session): the verdict exists to change what happens next.

## What it returns

A dozen lines is normal. In order:

1. **Verdict** — exactly one of `continue`, `pivot`, `stop and ask`, stated
   first.
2. **Effort ledger** — tool calls and edits on the current approach, split
   into productive (confirmed or ruled out something specific) vs
   unproductive. Honest counts; this is the input the user cannot see.
3. **Hypotheses board** — what was tried, what each outcome ruled out, what
   remains untried — with cheap untried tests called out. Frequently the right
   verdict is "continue, but test H2 before anything else".
4. **Steelman** — the strongest honest argument for the current approach. If
   none can be constructed, that is said plainly; it is itself evidence.

Verdict semantics:

- `continue` needs named steps since the last checkpoint that reduced
  uncertainty — or an explicit argument for why the *next* steps will. Vague
  forward-looking optimism is not that.
- `pivot` needs a named alternative (not "a different approach"), the evidence
  condemning the current path, why the alternative dodges it, and the cost of
  switching. If the cost exceeds the evidence of failure, the honest verdict
  is `continue` — not a soft pivot.
- `stop and ask` when the evidence cannot distinguish the options or the fork
  is the user's (product, scope, taste). Never disguised as `continue` to
  avoid interrupting.

## Hard constraints

- **Evidence, not momentum.** Activity is not progress: "made changes",
  "cleaned up", "tried variants" count for nothing. Work already spent does
  not count against the approach (sunk cost), but what the spending *taught*
  counts as evidence.
- **Delivers the verdict and stops.** Executing a pivot is the user's call
  unless pre-authorized; it never silently resumes.
- **Does not manufacture doubt.** An honest `continue` on two confirming
  steps is a valid result; padding the ledger to look thorough is the same
  failure as inventing debrief findings.
- **Does not re-run unprompted.** Fires when asked or at a scheduled
  checkpoint.

Fires too early — before substantive work — and it says the sample is too
small and stops. The full contract lives in [SKILL.md](SKILL.md).
