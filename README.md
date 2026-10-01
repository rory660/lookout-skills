# lookout-skills

[![License](https://img.shields.io/github/license/rory660/lookout-skills)](LICENSE)
[![validate-skills](https://img.shields.io/github/actions/workflow/status/rory660/lookout-skills/validate-skills.yml?branch=main&label=validate%20skills)](https://github.com/rory660/lookout-skills/actions/workflows/validate-skills.yml)
[![Skills](https://img.shields.io/badge/skills-3-8A2BE2)](skills/)
[![Agent Skills](https://img.shields.io/badge/spec-agentskills.io-blue)](https://agentskills.io)

A redistributable [Agent Skills](https://agentskills.io) collection: flight
instruments for coding-agent sessions. Each skill is a report-only recall
discipline — it observes the session, never edits code or files issues as a
side effect.

| Skill | Fires | Question it answers |
|---|---|---|
| **debrief** | session end | What loose ends and incidental findings did the work leave behind? |
| **pivot** | mid-session | Is the current approach still worth continuing, and on what evidence? |
| **contamination** | before commit / handoff | What did this session write that was never verified and will be read as ground truth? |

## Why

Four constraints are shared by all three skills, and they are the point of the
collection — each one is a discipline, not a prompt template:

- **Instruments, not autopilots.** Every skill ends in a report and stops.
  Debrief reports loose ends without filing issues; pivot delivers a verdict
  without executing it; contamination flags claims without rewording them.
  Acting on the report is always the user's call.
- **Recall, not investigation.** Each skill runs under a hard exploration
  budget — the session's own diff plus at most two further lookups into files
  the session already touched. No fresh sweeps, no subagents. A debrief that
  turns into a code review has failed, whichever findings it produces.
- **Empty is a valid result.** An honest "nothing to report" or a bare
  `continue` is a first-class outcome; inventing findings or padding the
  effort ledger to look thorough is the named failure mode in every SKILL.md.
- **Compaction honesty.** Long sessions lose context. Each skill must say
  which parts of the session it can no longer speak to rather than
  reconstruct a plausible history from what remains.

## Install

Primary (recommended) — the [skills CLI](https://github.com/vercel-labs/skills),
the package manager for the open agent skills ecosystem (75+ agents):

```sh
npx skills add rory660/lookout-skills              # project-level, auto-detects installed agents
npx skills add rory660/lookout-skills -g           # user-level, all projects
npx skills add rory660/lookout-skills -a claude-code -a pi   # specific agents
```

The CLI symlinks each agent's skills directory to a canonical copy (`--copy`
for independent copies). Project paths it writes (`.claude/skills/`,
`.agents/skills/`) are exactly what Claude Code, pi, and omp read natively.

Also installable with the [GitHub CLI](https://cli.github.com/manual/gh_skill_install):

```sh
gh skill install rory660/lookout-skills
```

No Node/npm: clone this repo and symlink each `skills/<name>/` into your
agent's skills root (`.agents/skills/` for omp and pi, `.claude/skills/` for
Claude Code).

Uninstall via the CLI: `npx skills remove debrief && npx skills remove pivot && npx skills remove contamination`.

## Compatibility

| Agent | Install | Skills directory | Invoke |
|---|---|---|---|
| Claude Code | `npx skills add` (auto-detected) or `-a claude-code` | `.claude/skills/` | natural language |
| omp | `npx skills add` (auto-detected) | `.agents/skills/` | `/skill:debrief` or natural language |
| pi | `npx skills add` (auto-detected) | `.agents/skills/` | `/skill:debrief` or natural language |
| other Agent Skills hosts | `npx skills add` — the CLI auto-detects and writes the paths each agent reads | agent-specific | natural language |
| no Node/npm | manual symlink of `skills/<name>/` into the agent's skills root | agent-specific | natural language |

Slash commands are verified for debrief; pivot and contamination follow the
same `/skill:<name>` pattern but have not each been run in every agent above.

## Usage

**debrief** — ask for a debrief, wrap-up, loose ends, or "what did you notice"
after a working session. In omp you can also run `/skill:debrief`; pi exposes
`/skill:debrief` similarly. An optional area can be named to scope the debrief.

**pivot** — ask mid-session "are we on track", "is this still worth it",
"cut losses", or to reassess the current approach. Returns one verdict —
continue / pivot / stop and ask — with the effort ledger and hypotheses board
behind it.

**contamination** — ask "what did you leave behind", "did you write anything
unverified", or run it before committing or handing off agent-written work.
Returns every written claim the session did not verify before writing.

## Example output

Trimmed and illustrative; real reports depend on the session.

**debrief** — after a session that reworked config loading:

```
### 1. Related issues not addressed
- src/config/loader.ts — env vars validated only for the two new keys. `gap` · S
  Pre-existing keys still load unvalidated; left alone, out of scope.
- tests/config/ — no test covers the malformed-TOML path. `gap` · M

### 2. Unrelated issues found
- scripts/release.sh — pins node 18; CI runs 22. `bug` · S
(2 trivial findings cut)
```

**pivot** — asked mid-session, forty minutes into a flaky-test hunt:

```
Verdict: continue, but test H2 before anything else.

Effort ledger — 9 productive / 6 unproductive. Productive: reproduced the
failure (ruled out a flaky environment), bisected to the retry loop,
confirmed the timeout hypothesis. Unproductive: three reformat-only edits.

Hypotheses board — H1 timeout under load: confirmed. H2 duplicate suite
registration: untried, one log-grep to test. H3 upstream runner change:
untried, needs a repro outside this repo.

Steelman — the retry loop is load-bearing for two other callers; ripping
it out now trades a bounded failure for an unbounded one.
```

**contamination** — before committing the same session's work:

```
src/config/loader.ts:41 — "// retries are safe here — idempotent by design."
  guessed · next reader: whoever adds the queue consumer · cheap check: none
  in-repo. Suggest: "// TODO: verify retries are safe here" (not applied).

README.md — "supports Node 18+" · inferred · next reader: users wiring CI ·
  reasoned from the engines field, never ran the matrix. Cheap check: one CI
  run on Node 18.

docs/ and tests/ — every written claim verified before writing.
```

## Layout

```
skills/
├── debrief/
│   └── SKILL.md   # session-end recall: loose ends and incidental findings
├── pivot/
│   └── SKILL.md   # mid-session sunk-cost audit: continue / pivot / stop
└── contamination/
    └── SKILL.md   # unverified claims this session wrote into files
```

`skills/<name>/SKILL.md` is the standard container layout the skills CLI
discovers first-class; per-agent skill folders must sit one level under the
agent's skills root.

