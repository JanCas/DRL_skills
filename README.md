# DRL Skills

A collection of reusable skills for Claude Code and Codex.

## Skills

- **figure-versioning** — files generated figures and their CSV, JSON, and NPZ
  outputs into traceable numbered versions with manifests and a shared index.

## Get it

Clone the repository after it is published:

```sh
git clone https://github.com/OWNER/DRL_skills.git
cd DRL_skills
```

Alternatively, use GitHub's **Code → Download ZIP**, extract it, and open the
extracted directory in a terminal.

## Install

```sh
sh install.sh
```

The installer links every directory under `skills/` into both:

- Claude Code: `~/.claude/skills/<skill-name>`
- Codex: `~/.agents/skills/<skill-name>`

Invoke `figure-versioning` with `/figure-versioning` in Claude Code or
`$figure-versioning` in Codex.

## Add a skill

Add it at `skills/<skill-name>/SKILL.md`, then rerun `sh install.sh`.

## Update

Run `git pull`, then rerun `sh install.sh` so newly added skills are linked.
Existing linked skills update immediately.
