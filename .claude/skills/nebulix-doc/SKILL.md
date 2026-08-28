---
name: nebulix-doc
description: "Create or update the documentation page and the JSDoc of a nebulix component."
disable-model-invocation: true
---

Write or update a nebulix component's documentation page (`src/components/<rubrique>/pix-x.md`) and its JSDoc. Pages are written in French.

## Rules

- Every sentence must be traceable to the code, to the integration test, or to an existing page. Never invent.
- An existing page is authoritative on its tone and structure: add or correct, never rewrite: unless explicitly asked.
- One page per component usable on its own. Sub-components are documented in their parent's page. Components not exported from `src/index.js` only get their JSDoc.

## Procedure

1. Read `ember/nebulix/docs/developpement/document-component.md`: the reference for page skeleton, demo keywords, `<ComponentSignature>` and JSDoc typedefs.
2. Read, in this order: the integration test (`ember/test-app/tests/integration/components/<rubrique>/pix-x-test.js`), then the `.gjs` and its `.scss`, then a neighbouring page as a tone benchmark (`pix-icon.md` for a simple component, `pix-select.md` for one with options).
3. When creating or rewriting a page, propose the outline (section titles and what each one demonstrates) and wait for validation before writing. A targeted update goes straight through.
4. Write or update the JSDoc (`PixXxxArgs`, `PixXxxSignature`), then the page.
5. Verify: `pnpm --filter @1024pix/nebulix-ember build:types`, check `@module` and `@name` match the file generated in `declarations/`, then `pnpm --filter @1024pix/nebulix-ember lint:format`.
6. Close by pointing the user to `pnpm doc` for the visual review.

## Writing

French, vouvoiement, present tense, prose. One idea per section: a short paragraph followed by a demo. Aim for 80-120 lines.

Never:

- a hand-written argument table: `<ComponentSignature>` generates it;
- "il est recommandé de", "pensez à" and other advisory turns;
- generic accessibility or UX guidance not backed by the component;
- the JSDoc rephrased as prose;

## Demos

Only arguments declared in the JSDoc. Example data in French, from the Pix domain ("Rechercher un élève", "Parcours avancé"). Any state (`@onChange`, a selection) is taken from the integration test, never improvised.
