# Worked example: the IX validation output directory

Adapted from `Results/BreakThroughCurves/IX/`. It is worth reading because it
shows the two things the templates cannot: how much detail a configuration table
needs to be useful a month later, and what a version history looks like when it
is *not* a clean progression.

The directory holds validation of an ion-exchange column model against four
published experiments. Its layout:

```text
Results/BreakThroughCurves/IX/
  figures/
    INDEX.md
    v1/ MANIFEST.md + 1 png + CSV/JSON/NPZ outputs
    v2/ MANIFEST.md + 5 png + CSV/JSON/NPZ outputs
    v3/ MANIFEST.md + 3 png + CSV/JSON/NPZ outputs
    v4/ MANIFEST.md + 8 png + CSV/JSON/NPZ outputs
    v5/ MANIFEST.md + 8 png + CSV/JSON/NPZ outputs
    v6/ MANIFEST.md + 1 png + CSV/JSON/NPZ outputs
```

## The index

Its discriminating columns are `Floor` and `Zhang LiOH C0` — the two settings
that actually moved across versions in this study. Nothing else earned a column.

```markdown
| Version | Date | Scope | Floor | Zhang LiOH C0 | Figures | Status |
|---|---|---|---|---|---:|---|
| [v1](v1/) | 2026-08-06 | Ooi only | 2 mg/g | n/a | 1 | historical |
| [v2](v2/) | 2026-08-07 | Zhang only | 0 | 300 mg/L assumed | 5 | **superseded** |
| [v3](v3/) | 2026-08-07 | Xiao 2015 sensitivities | 2 mg/g | n/a | 3 | current for that study |
| [v4](v4/) | 2026-08-19 | All eight cases | 0 | 87.37 mg/L from pH | 8 | **current, zero floor** |
| [v5](v5/) | 2026-08-19 | All eight cases | 2 mg/g | 87.37 mg/L from pH | 8 | **current, 2 mg/g floor** |
| [v6](v6/) | 2026-08-19 | Mole balance | derived | 87.37 mg/L from pH | 1 | **current** |
```

Three things to notice:

- **Four versions are simultaneously "current."** v3 is current for the Xiao
  sensitivity study; v4 and v5 are both current because they are the two arms of
  a deliberate floor comparison a reader may want side by side; v6 is current
  post-processing. Only v2 is superseded. Forcing a single "latest" would have
  destroyed real information.
- **`n/a` appears only twice.** Had it appeared in five of six rows, that column
  belonged in the manifests instead.
- **Status carries the qualifier**, not just the word — `current, 2 mg/g floor`
  tells a reader which of two current versions they want.

Its prose section does the work the table cannot:

```markdown
- **v1 → v2 → v3** are three separate single-study runs from early August, not a
  progression of the same figures. Each covers different cases.
- **v2 → v4** is the substantive correction: Zhang's LiOH feed concentration
  moved from an assumed 300 mg/L to 87.37 mg/L, derived from the paper's own
  reported pH 12.1 via `[Li+] = [OH-]`. Zhang LiOH RMSE improved `0.2202 → 0.1185`
  and R2 `0.269 → 0.788`. The v2 breakthrough panels are superseded; its Figure 6
  equilibrium diagnostics are not affected.
- **v4 → v5** changes only the equilibrium floor, `0 → 2 mg Li/g`. Its effect is
  small: the largest metric change is Ooi NaOH, RMSE `0.1017 → 0.0893`.
- **v6** is post-processing over v4 and v5, not a new solve.
```

The v2 entry is the model for a supersession note: it says what was wrong, what
replaced it, how much it mattered in metric terms, and — crucially — that
*part* of v2 survives. A blanket "superseded" would have implied the Figure 6
diagnostics were also invalid.

## A manifest of a fresh run

`v5/MANIFEST.md`:

````markdown
# v5 — Full eight-case suite, 2 mg/g floor, corrected Zhang feed

Generated: 2026-08-19  
Git commit: `ca4d66d3e`  

## Configuration

| Setting | Value |
|---|---|
| Cases | all eight |
| Equilibrium floor | 2 mg Li/g = 0.288184 mol/kg |
| Chemistry closure | Ooi titration for Ooi; ideal water elsewhere |
| Zhang LiOH C0 | 12.5893 mol/m3 = 87.37 mg/L, derived from reported pH 12.1 |

## Produced by

```bash
validate_ix.py --equilibrium-floor-mg-g 2.0 --output-dir Results/BreakThroughCurves/IX/floor_2mg_g
```

## Figures

- `ooi_2016_validation.png`
- ... (eight in total)

## Data outputs

- `experimental_curves.csv`
- `simulation_curves.csv`
- `validation_metrics.csv`
- `validation_results.json`

## Note

Differs from v4 only in the equilibrium floor. Direct comparison is in floor_2mg_g/README.md.
````

Four rows, and each one earns its place. Two give values in both the flag's units
and the model's internal units, so a reader checking the code against the table
does not have to convert. One records where a derived number came from. One
states a closure that applies to some cases and not others — exactly the kind of
thing that is obvious while running and unrecoverable later.

The note is one sentence because one sentence is all the version needs: it names
the single axis of difference from v4 and points at the comparison.

## A manifest of derived figures

`v6/MANIFEST.md` covers a figure that came from post-processing, not a solve:

```markdown
| Setting | Value |
|---|---|
| Cases | all eight |
| Derived from | the v4 and v5 curve data; no new solve |
| Plotted run | the 2 mg/g floor set (v5) |
| Zhang LiOH C0 | 12.5893 mol/m3 = 87.37 mg/L |
```

with the note: *"Post-processing of v4/v5 outputs, not an independent simulation.
Regenerate whenever v4 or v5 is regenerated."*

That last sentence is the whole reason to flag derived versions. Nothing in the
directory structure records that v6 depends on v4 and v5, so regenerating them
would silently leave v6 stale. The manifest is the only place that dependency can
live.

## Where the honesty shows

`v6` records `Git commit: unknown`. The figures were made from uncommitted work
and the exact commit was not recoverable. Writing a nearby plausible SHA would
have been worse than useless — it would have sent a future reader to code that
did not produce the figure. `unknown` is a real answer.
