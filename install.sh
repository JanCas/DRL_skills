#!/bin/sh
set -eu

: "${HOME:?HOME is not set}"

repo_dir=$(CDPATH= cd -P "$(dirname "$0")" && pwd)
skills_dir=$repo_dir/plugins/drl-skills/skills
mode=${1:-all}

case $mode in
    all)
        claude_dir=$HOME/.claude/skills
        codex_dir=$HOME/.agents/skills
        destination_label='Claude Code and Codex'
        ;;
    claude)
        claude_dir=$HOME/.claude/skills
        codex_dir=
        destination_label='Claude Code'
        ;;
    codex)
        claude_dir=
        codex_dir=$HOME/.agents/skills
        destination_label='Codex'
        ;;
    *)
        printf 'Usage: %s [all|claude|codex]\n' "$0" >&2
        exit 2
        ;;
esac

[ -z "$claude_dir" ] || mkdir -p "$claude_dir"
[ -z "$codex_dir" ] || mkdir -p "$codex_dir"

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
    [ -z "$claude_dir" ] || check_target "$claude_dir/$skill_name" "$skill_dir"
    [ -z "$codex_dir" ] || check_target "$codex_dir/$skill_name" "$skill_dir"
    skill_count=$((skill_count + 1))
done

if [ "$skill_count" -eq 0 ]; then
    printf 'No skills found in %s\n' "$skills_dir" >&2
    exit 1
fi

for skill_dir in "$skills_dir"/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skill_name=${skill_dir##*/}
    [ -z "$claude_dir" ] || [ -L "$claude_dir/$skill_name" ] || ln -s "$skill_dir" "$claude_dir/$skill_name"
    [ -z "$codex_dir" ] || [ -L "$codex_dir/$skill_name" ] || ln -s "$skill_dir" "$codex_dir/$skill_name"
done

printf 'Installed %s skill(s) for %s.\n' "$skill_count" "$destination_label"
