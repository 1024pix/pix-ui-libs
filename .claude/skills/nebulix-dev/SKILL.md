---
name: nebulix-dev
description: "Create or modify a Nebulix Ember component: file layout, conventions, tests, changeset."
disable-model-invocation: true
---

Work happens in `ember/nebulix/src/components/<section>/`.
Ask to the user for the component name and section if not provided.
The repo docs are the source of truth — read them, do not guess.

## Before writing code

1. Read `ember/nebulix/docs/developpement/create-component.md`.
2. Read the `.gjs` + `.scss` + `.md` trio of a nearby component to match the real style:
   `layout/pix-block` for a presentational one, `forms/pix-checkbox` for a form one.

## New component

Follow `create-component.md`, but build it **test-first with the `tdd` skill**:
create the empty `.gjs` (+ `.scss`), declare the `.scss` in `src/components/index.scss` and
export the component from `src/index.js` right away, then red-green-refactor from
`ember/test-app/tests`.

The export comes first because a component missing from `src/index.js` makes its own test
fail: tests import from the public entrypoint `@1024pix/nebulix-ember`.

## Existing component

Drive the change with the `tdd` skill: a failing test for the new behaviour first.
Then add a changeset, picking the bump deliberately: a public API change must not break
consumers: deprecate instead (`docs/guidelines/conventions.md`).

## Documentation

The `.md` page and the JSDoc typedefs that type the component are **not written here**:
invoke the `nebulix-doc` skill once the component behaves as intended.

## What to read, when

| Situation                                     | Read                                   |
| --------------------------------------------- | -------------------------------------- |
| Writing or adapting the test                  | `docs/developpement/test-component.md` |
| Non-trivial styles                            | `docs/guidelines/responsive.md`        |
| Interactive component (keyboard, focus, ARIA) | `docs/guidelines/a11y.md`              |
| Public API change                             | `docs/guidelines/conventions.md`       |

## Non-negotiable

- No hardcoded values in SCSS: every value comes from a design token, `var(--pix-…)`.
- Root element carries `...attributes`; CSS classes are assembled in a `cssClass` getter,
  never in the template. BEM naming.
- Never mutate `this.args`. Defaults live in a getter; an invalid value triggers a
  `warn` from `@ember/debug` without breaking the render.

## Closing the task

While red-green-refactoring, run **only the component under test** — the full suite is far
too slow a feedback loop. From the repo root:

```bash
pnpm build                                       # only when src/index.js changed
pnpm --filter test-app exec vite build --mode development
pnpm --filter test-app exec ember test --path dist --filter "PixBlock"
```

Rebuild the app (`vite build`) after each source change, then replay the filtered `ember test`.
`--filter` matches the test name, `--module` an exact module name. Note the `exec` form:
`pnpm --filter test-app test -- --filter …` does not work, the flag lands after `--path dist`
and is ignored.

Then, once green, from the repo root: `pnpm lint`, then `pnpm test`.
`pnpm lint:fix` handles format, JS and templates: **`ember-tsc` type errors are never fixed
automatically**.
