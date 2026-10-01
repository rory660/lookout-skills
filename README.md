# lookout-skills

A redistributable [Agent Skills](https://agentskills.io) collection: flight
instruments for coding-agent sessions. Each skill is a report-only recall
discipline — it observes the session, never edits code or files issues as a
side effect.

| Skill | Fires | Question it answers |
|---|---|---|
| **debrief** | session end | What loose ends and incidental findings did the work leave behind? |
| **pivot** | mid-session | Is the current approach still worth continuing, and on what evidence? |
| **contamination** | before commit / handoff | What did this session write that was never verified and will be read as ground truth? |

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

## Provenance

Merged from two per-repo skills:

- **vrcompare** — the recall discipline: minimal further exploration, compaction
  honesty, the four buckets, ranked report format, empty-debrief validity.
- **wordhoppr** — the classification taxonomy (bug / gap / cleanup) and the
  evidence-per-finding rules. Its issue-filing pipeline was deliberately left
  out; filing happens only if the user asks afterward.