# <study or model name> output versions

Every figure and its CSV, JSON, and NPZ outputs produced from <the thing> live
here in a numbered version folder. Nothing from a versioned run is left loose
in the results directory.

**A version is one set of outputs generated under one configuration.** Version
numbers are chronological and mean nothing beyond creation order — `v5` is not
"better" than `v3`, it is only later. When you generate graphs under a
configuration that differs from the newest version, create the next `vN` rather
than overwriting.

The convention, including what counts as a configuration change, is in the
`figure-versioning` skill.

| Version | Date | Scope | <config axis 1> | <config axis 2> | Figures | Status |
|---|---|---|---|---|---:|---|
| [v1](v1/) | <YYYY-MM-DD> | <what it covers> | <value> | <value> | <count> | <status> |
| [v2](v2/) | <YYYY-MM-DD> | <what it covers> | <value> | <value> | <count> | <status> |

## What changed between versions

- **v1 → v2** <what actually changed, and its numerical effect where there is one:
  `RMSE 0.2202 → 0.1185`. Say plainly when two adjacent versions are unrelated
  runs rather than a progression.>

## Reading a version

Each folder carries a `MANIFEST.md` giving the configuration that produced it,
the command that generated it, the git commit, and inventories of its figures
and data outputs.
