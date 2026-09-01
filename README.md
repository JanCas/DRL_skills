# DRL Skills

A lab marketplace of reusable skills for Claude Code, ChatGPT, and Codex. Both
marketplace formats load the same plugin and skill files.

## Included plugin

The `drl-skills` plugin currently bundles:

- **figure-versioning** — files generated figures and their CSV, JSON, and NPZ
  outputs into traceable numbered versions with manifests and a shared index.

This repository is published under the GitHub account `JanCas`.

## Install in Claude Code

Run these commands in a terminal:

```sh
claude plugin marketplace add https://github.com/JanCas/DRL_skills.git
claude plugin install drl-skills@drl-lab
```

Restart Claude Code, or run `/reload-plugins` when prompted. Invoke the bundled
skill with:

```text
/drl-skills:figure-versioning
```

The same installation can be performed from an active Claude Code session:

```text
/plugin marketplace add https://github.com/JanCas/DRL_skills.git
/plugin install drl-skills@drl-lab
/reload-plugins
```

## Install in Codex

Run:

```sh
codex plugin marketplace add JanCas/DRL_skills
codex plugin add drl-skills@drl-lab
```

Start a new task so Codex loads the plugin. Invoke the skill with
`$figure-versioning`.

For workspace-wide ChatGPT distribution, an admin imports the repository URL
under **Admin → Plugins → Add → Import marketplace**. Leave **Path** blank
because `.agents/plugins/marketplace.json` is at the repository root.

## Clone or download the source

```sh
git clone https://github.com/JanCas/DRL_skills.git
cd DRL_skills
```

Alternatively, use GitHub's **Code → Download ZIP** and extract it.

## Direct install without a marketplace

From a clone or extracted download, run one of:

```sh
sh install.sh claude
sh install.sh codex
sh install.sh
```

The last command installs for both tools. It links every bundled skill into
`~/.claude/skills` and/or `~/.agents/skills`. Do not combine a direct install
with a marketplace install for the same tool, or the skill may appear twice.
Direct Claude installs use `/figure-versioning`; direct Codex installs use
`$figure-versioning`.

## Update

Claude Code marketplace installs:

```sh
claude plugin marketplace update drl-lab
claude plugin update drl-skills@drl-lab
```

Codex marketplace installs:

```sh
codex plugin marketplace upgrade drl-lab
```

Direct installs made from a clone update with `git pull`. Run `sh install.sh`
again only after a new skill is added. ZIP downloads cannot use `git pull`;
download a fresh ZIP and rerun the installer instead.

## Contribute a skill

Installing the marketplace does not clone a working copy of this repository.
Claude Code and Codex keep installed plugins in managed caches that may be
replaced during updates, so do not edit those cached files.

To contribute, fork the repository if needed, then clone the repository or your
fork and create a branch:

```sh
git clone https://github.com/JanCas/DRL_skills.git
cd DRL_skills
git switch -c add-my-skill
mkdir -p plugins/drl-skills/skills/my-skill
```

Add `plugins/drl-skills/skills/my-skill/SKILL.md` with at least:

```markdown
---
name: my-skill
description: Explain what the skill does and when to use it.
---

Skill instructions go here.
```

Optional assets and references belong inside the same skill folder:

```text
plugins/drl-skills/skills/my-skill/
├── SKILL.md
├── assets/
└── references/
```

Validate the plugin, then commit, push, and open a pull request:

```sh
claude plugin validate plugins/drl-skills --strict
git add plugins/drl-skills/skills/my-skill
git commit -m "Add my-skill"
git push -u origin add-my-skill
gh pr create
```

Contributors without a local clone can instead fork the repository and create
or upload the skill files through GitHub's web interface, then open a pull
request. A local clone is recommended because it allows validation before the
pull request.

Contributors should not change plugin versions in individual skill pull
requests. The maintainer bumps both manifests together when preparing a
release:

- `plugins/drl-skills/.claude-plugin/plugin.json`
- `plugins/drl-skills/.codex-plugin/plugin.json`

After the release, marketplace users receive the new skill through the update
commands above; they still do not need to clone the repository. The new skill
is invoked as `/drl-skills:my-skill` in Claude Code and `$my-skill` in Codex.
