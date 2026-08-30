#!/bin/sh
set -eu

: "${HOME:?HOME is not set}"

repo_dir=$(CDPATH= cd -P "$(dirname "$0")" && pwd)
claude_link=$HOME/.claude/skills/figure-versioning
codex_link=$HOME/.agents/skills/figure-versioning

mkdir -p "$HOME/.claude/skills" "$HOME/.agents/skills"

check_target() {
    target=$1
    if [ -L "$target" ]; then
        linked_dir=$(CDPATH= cd -P "$target" 2>/dev/null && pwd) || linked_dir=
        if [ "$linked_dir" != "$repo_dir" ]; then
            printf 'Refusing to overwrite unrelated symlink: %s\n' "$target" >&2
            return 1
        fi
    elif [ -e "$target" ]; then
        printf 'Refusing to overwrite existing path: %s\n' "$target" >&2
        return 1
    fi
}

check_target "$claude_link"
check_target "$codex_link"

[ -L "$claude_link" ] || ln -s "$repo_dir" "$claude_link"
[ -L "$codex_link" ] || ln -s "$repo_dir" "$codex_link"

printf 'Installed figure-versioning for Claude Code and Codex.\n'
printf '  %s -> %s\n' "$claude_link" "$repo_dir"
printf '  %s -> %s\n' "$codex_link" "$repo_dir"
