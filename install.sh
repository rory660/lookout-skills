#!/usr/bin/env bash
# Symlink every skill in skills/ into agent skill roots.
#
# Usage:
#   ./install.sh            # project-level (cwd's repo)
#   ./install.sh --user     # user-level (~/.agents, ~/.claude)
#   ./install.sh --remove   # remove the symlinks instead
#
# Targets, one symlink per skill under skills/:
#   .agents/skills/<skill>  -> omp (native provider) + pi (project & user)
#   .claude/skills/<skill>  -> Claude Code (+ omp claude provider, deduped by name)
#
# idempotent: re-running refreshes the symlinks.

set -euo pipefail

BASE="$(cd "$(dirname "$0")" && pwd)"

MODE="project"
ACTION="install"
for arg in "$@"; do
  case "$arg" in
    --user)   MODE="user" ;;
    --remove) ACTION="remove" ;;
    -h|--help) grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown argument: $arg" >&2; exit 1 ;;
  esac
done

if [ "$MODE" = "user" ]; then
  roots=("$HOME/.agents/skills" "$HOME/.claude/skills")
else
  git_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
  if [ -z "$git_root" ]; then
    echo "error: not inside a git repository; run from the target project or use --user" >&2
    exit 1
  fi
  roots=("$git_root/.agents/skills" "$git_root/.claude/skills")
fi

installed=0
for skill_dir in "$BASE"/skills/*/; do
  [ -f "$skill_dir/SKILL.md" ] || continue
  skill_name="$(basename "$skill_dir")"
  for root in "${roots[@]}"; do
    link="$root/$skill_name"
    if [ "$ACTION" = "remove" ]; then
      if [ -L "$link" ]; then
        rm "$link"
        echo "removed $link"
      fi
      continue
    fi
    if [ -e "$link" ] && [ ! -L "$link" ]; then
      echo "error: $link exists and is not a symlink; refusing to overwrite" >&2
      exit 1
    fi
    mkdir -p "$root"
    ln -sfn "$skill_dir" "$link"
    echo "installed $link -> $skill_dir"
    installed=1
  done
done

if [ "$ACTION" = "install" ] && [ "$installed" = "1" ]; then
  echo
  echo "covered: omp (.agents + .claude), pi (.agents), Claude Code (.claude)"
fi