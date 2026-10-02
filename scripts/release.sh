#!/usr/bin/env bash
# Cuts a release: rewrites the version in every skills/*/SKILL.md, validates,
# commits as `chore(release): vX.Y.Z` if anything changed, and tags vX.Y.Z.
#
# Usage: scripts/release.sh vX.Y.Z   (leading 'v' optional)
#
# The version is repo-wide and lives only in the SKILL.md frontmatter; the
# tag and the frontmatter are forced to agree here and by CI on tag push.
# Pushing the tag triggers CI to verify versions and publish the GitHub
# release. Push with: git push origin main --follow-tags
set -euo pipefail

die() {
  echo "error: $*" >&2
  exit 1
}

[ $# -eq 1 ] || die "usage: scripts/release.sh vX.Y.Z"
version=$1
version=${version#v}
[[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "'$version' is not semver (expected vX.Y.Z)"
tag="v$version"

git rev-parse -q --verify "refs/tags/$tag" >/dev/null && die "$tag already exists"
[ -z "$(git status --porcelain)" ] || die "working tree not clean; commit or stash first"

here=$(cd "$(dirname "$0")" && pwd)

for f in skills/*/SKILL.md; do
  # Rewrite only inside the frontmatter: lines 2 up to the first closing '---'.
  sed -i "2,/^---\$/ s/^  version: .*/  version: $version/" "$f"
done

"$here/check-skills.sh"

if git diff --quiet -- skills; then
  echo "skill versions already $version; nothing to commit"
else
  git add skills
  git commit -m "chore(release): $tag"
fi

git tag -a "$tag" -m "$tag"
echo "tagged $tag; push with: git push origin main --follow-tags"