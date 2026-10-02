#!/usr/bin/env bash
# Validates every skills/<name>/SKILL.md.
#
# Checks, per skill: frontmatter delimited by '---', name matching the
# directory, non-empty description within the agentskills spec limit, a
# semver version, and body size. Across skills: all versions must be equal.
#
# Set EXPECTED_VERSION=<x.y.z> to additionally require each version to equal
# it. The release workflow sets this from the pushed tag.
set -euo pipefail

DESCRIPTION_MAX=1024 # agentskills spec limit
BODY_MAX_LINES=500

die() {
  echo "error: $*" >&2
  exit 1
}

expected=${EXPECTED_VERSION:-}

shopt -s nullglob
dirs=(skills/*/)
if [ ${#dirs[@]} -eq 0 ]; then
  die "no skill directories under skills/"
fi

versions=""
for dir in "${dirs[@]}"; do
  name=${dir#skills/}
  name=${name%/}
  f="skills/${name}/SKILL.md"

  first=$(sed -n '1p' "$f")
  [ "$first" = "---" ] || die "$f: frontmatter must start with '---'"
  closing=$(awk 'NR==1 { next } /^---$/ { print NR; exit }' "$f")
  [ -n "$closing" ] || die "$f: frontmatter not closed with '---'"
  fm=$(awk -v c="$closing" 'NR > 1 && NR < c' "$f")

  skill_name=$(sed -n 's/^name: *//p' <<<"$fm")
  [ -n "$skill_name" ] || die "$f: 'name' missing or empty"
  [ "$skill_name" = "$name" ] || die "$f: name '$skill_name' does not match directory '$name'"

  desc=$(sed -n 's/^description: *//p' <<<"$fm")
  [ -n "$desc" ] || die "$f: 'description' missing or empty"
  [ ${#desc} -le "$DESCRIPTION_MAX" ] || die "$f: description is ${#desc} chars (limit $DESCRIPTION_MAX)"

  version=$(sed -n 's/^  version: *//p' <<<"$fm")
  [ -n "$version" ] || die "$f: 'version' missing or empty"
  [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "$f: version '$version' is not semver"
  if [ -n "$expected" ] && [ "$version" != "$expected" ]; then
    die "$f: version '$version' does not match expected '$expected'"
  fi
  versions="${versions}${version}"$'\n'

  total=$(wc -l <"$f")
  body_lines=$((total - closing))
  [ "$body_lines" -lt "$BODY_MAX_LINES" ] || die "$f: body is $body_lines lines (limit $BODY_MAX_LINES)"

  echo "ok: $f ($body_lines body lines, description ${#desc} chars, version $version)"
done

if [ "$(printf '%s' "$versions" | sort -u | wc -l)" -gt 1 ]; then
  die "SKILL.md versions differ across skills:
$(printf '%s' "$versions" | sort -u | sed 's/^/  /')"
fi

if [ -n "$expected" ]; then
  echo "all skill versions match $expected"
fi
echo "validated ${#dirs[@]} skills"