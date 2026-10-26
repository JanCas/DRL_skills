---
name: readable-run-scripts
description: Create or revise readable Python calling scripts for scientific simulations and analyses, with editable parameters directly in the file, grouped by physics into dataclasses, clear units and comments, and a simple main function. Use when writing model entry points or replacing argparse/JSON-driven run setup with an inspectable Python script. Does not require rewriting model internals or existing command-line interfaces outside the requested scope.
---

# Readable Run Scripts

Make the calling script a readable account of a complete run: the user should be able to inspect and edit its inputs, then follow how they reach the model.

## Parameter layout

- Place editable values above the execution code. Avoid requiring argparse, environment variables, or external input JSON unless the user requests that interface. Reading actual datasets or property tables is still appropriate.
- Group parameters by physics in small dataclasses. In a coupled flow/thermal model, use separate flow and heat-transfer groups. Add other groups only when they make the actual model easier to understand. Reuse existing configuration dataclasses when they already fit these groups.
- Instantiate the groups with visible named arguments and values. Show relevant initial conditions, boundary conditions, material properties, numerical tolerances, time limits, output sampling and output paths. Make consequential defaults explicit; explain deliberate `None` values and automatically derived quantities.
- Keep shared values in one place and reference them where needed, such as a reaction model's width referring to the flow geometry. Do not duplicate values that must remain consistent.
- State units beside values and explain ambiguous conventions: absolute versus differential pressure, full versus half aperture, concentration versus molality, and ordering of paired or array-valued inputs. Separate requested output times from adaptive integration steps.
- Preserve the source case's values and scientific labels. Use an existing accepted example when available; do not invent physical coefficients to fill gaps. Make assumptions and placeholder parameters visible.

## Execution layout

Use this general reading order, adapting groups to the actual task:

1. A short module docstring with purpose and a runnable command in the project's environment.
2. Imports and small parameter dataclasses.
3. Grouped, commented parameter instances and output settings.
4. An explicit adapter to the existing model interface, if necessary.
5. A simple `main()` that prepares inputs, runs the existing solver, saves results and actual inputs, and prints a concise summary.
6. The `if __name__ == '__main__': main()` guard.

Keep preparation, expensive property construction, integration and output writes inside `main()` or functions called from it. Importing the script should not launch a run or create output files. Lightweight configuration construction and validation can happen at module scope.

When the solver expects a combined configuration, map the physics groups into it with explicit named arguments. Keep initial conditions in their appropriate physics groups and pass them separately when the API requires that. Preserve any existing preparation/composition stage and validation before numerical integration.

Call existing model functions. A clearer entry point does not justify changing equations, numerical operation order, solver interfaces or model-selection behavior. Avoid new configuration frameworks, registries or duplicated solver code.

## Readability and provenance

Separate logical steps with blank lines. Expand long imports, calls and dictionaries across lines. Comments should explain the physical role, units, array layout, assumptions or reason for a step; avoid narrating obvious assignments.

Use the project's pinned formatter and settings. Where no standard exists, follow PEP 8 conventions with four-space indentation and readable multiline expressions; do not add a formatting dependency solely for a calling script. For the Silica project, use its pinned Black configuration: 88-character target and existing quote style preserved.

Save the actual edited parameters alongside results, including resolved model settings and applicable evidence/provenance labels. Output JSON is useful even when input JSON is unnecessary. Follow the project's output/versioning convention and preserve prior runs. Keep plotting optional unless requested or part of the established entry point.

## Scope and verification

Apply this style to newly requested calling scripts and substantial revisions. Preserve an existing CLI when a companion script is requested; do not migrate every historical script merely because this skill is active.

Check imports and configuration validation in the project's environment. When adapting a known case, compare the resulting model inputs against that case, including defaults and derived values. For formatting-only changes, an AST comparison can verify executable code is unchanged. Run a short representative solve when execution wiring changes warrant it; do not launch an expensive production simulation just to demonstrate readability. Report which checks ran and whether the full simulation was rerun.
