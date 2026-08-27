import Route from '@ember/routing/route';
import type RouterService from '@ember/routing/router-service';
import type Transition from '@ember/routing/transition';
import { service } from '@ember/service';
import rehypeShikiFromHighlighter from '@shikijs/rehype/core';
import DemoFrame from 'docs-app/components/DemoFrame.gjs';
import type { Manifest } from 'kolay';
import { handlePotentialIndexVisit } from 'kolay';
import { setupKolay } from 'kolay/setup';
import { wrapDemos } from 'kolay/wrap-demos';
import { createHighlighterCore } from 'shiki/core';
import { createOnigurumaEngine } from 'shiki/engine/oniguruma';

export default class ApplicationRoute extends Route {
  @service declare router: RouterService;

  async model(): Promise<{ manifest: Manifest }> {
    const highlighter = await createHighlighterCore({
      themes: [import('shiki/themes/github-dark.mjs'), import('shiki/themes/github-light.mjs')],
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
        // `topLevelScope` only reaches markdown and `hbs` demos; a `gjs` demo
        // resolves what it imports, so documentation components are exposed
        // here rather than there.
        'docs-app/components/ColorPalette': () => import('docs-app/components/ColorPalette.gjs'),
        'docs-app/components/IconGallery': () => import('docs-app/components/IconGallery.gjs'),
        'docs-app/components/ShadowGallery': () => import('docs-app/components/ShadowGallery.gjs'),
        'docs-app/components/SpacingScale': () => import('docs-app/components/SpacingScale.gjs'),
      },
      topLevelScope: {
        DemoFrame,
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
        [
          wrapDemos,
          {
            componentName: 'DemoFrame',
            eachDemo: { behavior: 'opt-in', meta: 'nebulix' },
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
