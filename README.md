# DRL Skills

A lab marketplace of reusable skills for Claude Code, ChatGPT, and Codex. Both
marketplace formats load the same plugin and skill files.

## Included plugin

The `drl-skills` plugin currently bundles:

- **figure-versioning** — files generated figures and their CSV, JSON, and NPZ
  outputs into traceable numbered versions with manifests and a shared index.

Replace `OWNER` below with the GitHub user or organization that publishes this
repository.

## Install in Claude Code

Run these commands in a terminal:

```sh
claude plugin marketplace add OWNER/DRL_skills
claude plugin install drl-skills@drl-lab
```

Restart Claude Code, or run `/reload-plugins` when prompted. Invoke the bundled
skill with:

```text
/drl-skills:figure-versioning
```

The same installation can be performed from an active Claude Code session:

```text
/plugin marketplace add OWNER/DRL_skills
/plugin install drl-skills@drl-lab
/reload-plugins
```

## Install in Codex

Run:

```sh
codex plugin marketplace add OWNER/DRL_skills
codex plugin add drl-skills@drl-lab
```

Start a new task so Codex loads the plugin. Invoke the skill with
`$figure-versioning`.

For workspace-wide ChatGPT distribution, an admin imports the repository URL
under **Admin → Plugins → Add → Import marketplace**. Leave **Path** blank
because `.agents/plugins/marketplace.json` is at the repository root.

## Clone or download the source

```sh
git clone https://github.com/OWNER/DRL_skills.git
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

Direct installs update with `git pull`. Run `sh install.sh` again only after a
new skill is added.

## Add a skill

Add it at `plugins/drl-skills/skills/<skill-name>/SKILL.md` and bump the version
in both plugin manifests before release:

- `plugins/drl-skills/.claude-plugin/plugin.json`
- `plugins/drl-skills/.codex-plugin/plugin.json`
