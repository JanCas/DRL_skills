# Figure Versioning

`figure-versioning` keeps generated figures and their CSV, JSON, and NPZ data
traceable by filing each run in a numbered `figures/vN/` directory with a
manifest and a shared index.

## Get it

Clone the repository after it is published:

```sh
git clone https://github.com/OWNER/figure-versioning.git
cd figure-versioning
```

Alternatively, use GitHub's **Code → Download ZIP**, extract it, and open the
extracted directory in a terminal.

## Install

Run the installer from the repository:

```sh
sh install.sh
```

It installs the skill for both tools by linking this repository at:

- Claude Code: `~/.claude/skills/figure-versioning`
- Codex: `~/.agents/skills/figure-versioning`

Invoke it with `/figure-versioning` in Claude Code or `$figure-versioning` in
Codex.

## Update

Run `git pull` inside this repository. Both installations use symlinks, so they
immediately see the updated files.
