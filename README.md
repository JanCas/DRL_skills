# DRL Skills

A lab marketplace of reusable skills for ChatGPT, Codex, and Claude Code.

## Included plugin

The `drl-skills` plugin currently bundles:

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

## Install the plugin

For local Codex use after this repository is published:

```sh
codex plugin marketplace add OWNER/DRL_skills
codex plugin add drl-skills@drl-lab
```

Start a new task after installation so Codex loads the plugin.

For workspace-wide lab distribution, an admin imports the repository URL under
**Admin → Plugins → Add → Import marketplace**. Leave **Path** blank because
`.agents/plugins/marketplace.json` is at the repository root.

## Direct skill install

Claude Code users can install only the Claude skill links:

```sh
sh install.sh claude
```

The installer also supports `codex` or `all` for direct, non-plugin installs:

```sh
sh install.sh
sh install.sh codex
```

It links every bundled skill into:

- Claude Code: `~/.claude/skills/<skill-name>`
- Codex: `~/.agents/skills/<skill-name>`

Do not combine a direct Codex install with the plugin install, or the same skill
may appear twice. Invoke `figure-versioning` with `/figure-versioning` in Claude
Code or `$figure-versioning` in Codex.

## Add a skill

Add it at `plugins/drl-skills/skills/<skill-name>/SKILL.md` and update the
version in `plugins/drl-skills/.codex-plugin/plugin.json` before release.

## Update

Workspace imports sync from GitHub automatically. Local Codex users can run
`codex plugin marketplace upgrade drl-lab`; direct installs update with
`git pull`, followed by `sh install.sh` when a new skill is added.
