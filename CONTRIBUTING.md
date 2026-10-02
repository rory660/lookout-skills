# Contributing

## Commit messages

This repo uses [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <imperative summary>
```

- **Types used here:** `feat` (new/changed skill behavior or frontmatter), `fix` (bug in a skill or doc), `docs` (README changes, badges, guides), `ci` (workflow changes), `chore` (license, scripts, repo housekeeping), `refactor`, `test`.
- **Scope is optional;** when used, name the skill (`feat(assumptions): ...`) or area (`docs(readme): ...`, `ci(workflow): ...`).
- **Subject:** imperative mood, no trailing period, ≤ 72 characters.
- **Body** optional; explain *why*, not just what. Reference issues as `#<n>`.

Examples from this repo's history:

```
feat: add metadata (author, version) to each skill's frontmatter
docs: add compatibility matrix
ci: validate SKILL.md frontmatter and size
chore: add MIT license
```

Non-conforming counterexamples (these slipped in; don't repeat the pattern):

```
Update skills count badge to 4            # → docs: update skills count badge to 4
Add assumptions skill: pre-answered ...   # → feat: add assumptions skill
```

## Skill changes

- Each skill lives at `skills/<name>/SKILL.md` with frontmatter `name`, `description` (used for triggering), `author`, `version`.
- `version` is repo-wide and release-scoped: every skill carries the same version, and it matches the latest release tag. Don't bump it by hand — run `scripts/release.sh vX.Y.Z`, which rewrites every SKILL.md, commits `chore(release): vX.Y.Z`, and tags. CI verifies all versions are equal on every PR and that they equal the tag on tag push.
- README claims (fires-when table, Usage, example output) must stay consistent with the SKILL.md they describe.
