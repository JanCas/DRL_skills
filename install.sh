#!/bin/sh
set -eu

: "${HOME:?HOME is not set}"

repo_dir=$(CDPATH= cd -P "$(dirname "$0")" && pwd)
skills_dir=$repo_dir/skills
claude_dir=$HOME/.claude/skills
codex_dir=$HOME/.agents/skills

mkdir -p "$claude_dir" "$codex_dir"

check_target() {
    target=$1
    source=$2
    if [ -L "$target" ]; then
        linked_dir=$(CDPATH= cd -P "$target" 2>/dev/null && pwd) || linked_dir=
        if [ "$linked_dir" != "$source" ]; then
            printf 'Refusing to overwrite unrelated symlink: %s\n' "$target" >&2
            return 1
        fi
    elif [ -e "$target" ]; then
        printf 'Refusing to overwrite existing path: %s\n' "$target" >&2
        return 1
    fi
}

skill_count=0
for skill_dir in "$skills_dir"/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skill_name=${skill_dir##*/}
    check_target "$claude_dir/$skill_name" "$skill_dir"
    check_target "$codex_dir/$skill_name" "$skill_dir"
    skill_count=$((skill_count + 1))
done

if [ "$skill_count" -eq 0 ]; then
    printf 'No skills found in %s\n' "$skills_dir" >&2
    exit 1
fi

for skill_dir in "$skills_dir"/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skill_name=${skill_dir##*/}
    [ -L "$claude_dir/$skill_name" ] || ln -s "$skill_dir" "$claude_dir/$skill_name"
    [ -L "$codex_dir/$skill_name" ] || ln -s "$skill_dir" "$codex_dir/$skill_name"
done

printf 'Installed %s skill(s) for Claude Code and Codex.\n' "$skill_count"
