import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { handlePotentialIndexVisit } from 'kolay';
import { setupKolay } from 'kolay/setup';

import rehypeShikiFromHighlighter from '@shikijs/rehype/core';
import type RouterService from '@ember/routing/router-service';
import type Transition from '@ember/routing/transition';
import type { Manifest } from 'kolay';
import { createHighlighterCore } from 'shiki/core';
import { createOnigurumaEngine } from 'shiki/engine/oniguruma';

export default class ApplicationRoute extends Route {
  @service declare router: RouterService;

  async model(): Promise<{ manifest: Manifest }> {
    const highlighter = await createHighlighterCore({
      themes: [
        import('shiki/themes/github-dark.mjs'),
        import('shiki/themes/github-light.mjs'),
      ],
      langs: [
        import('shiki/langs/javascript.mjs'),
        import('shiki/langs/typescript.mjs'),
        import('shiki/langs/bash.mjs'),
        import('shiki/langs/css.mjs'),
        import('shiki/langs/html.mjs'),
        import('shiki/langs/markdown.mjs'),
        import('shiki/langs/glimmer-js.mjs'),
        import('shiki/langs/glimmer-ts.mjs'),
        import('shiki/langs/handlebars.mjs'),
        import('shiki/langs/jsonc.mjs'),
      ],
      engine: createOnigurumaEngine(() => import('shiki/wasm')),
    });

    const manifest = await setupKolay(this, {
      modules: {
        '@1024pix/nebulix-ember': () => import('@1024pix/nebulix-ember'),
      },
      rehypePlugins: [
        [
          rehypeShikiFromHighlighter,
          highlighter,
          {
            defaultColor: 'light',
            themes: {
              light: 'github-light',
              dark: 'github-dark',
            },
          },
        ],
      ],
    });
    return { manifest };
  }

  redirect(_model: void, transition: Transition): void {
    handlePotentialIndexVisit(this, transition);
  }
}
