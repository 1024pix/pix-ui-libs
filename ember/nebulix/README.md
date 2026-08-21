# Pix Nebulix Ember

Nebulix Ember est l'implémentation du design system de Pix

# Utiliser l'addon

```bash
  npm install -D @1024pix/nebulix-ember@<version>
```

Dans `ember-cli-build.js`, rendre les styles de l'addon resolvables :

```js
sassOptions: {
  includePaths: ['node_modules/@1024pix/nebulix-ember/dist/styles'],
},
```

Charger les styles explicitement, **en premier** dans `app/styles/app.scss` :

```scss
@use 'nebulix-styles' as *;

// ... les styles de l'application ensuite
```

# Développer dans l'addon

```bash
git clone https://github.com/1024pix/pix-ui-libs.git
cd pix-ui-libs
pnpm install
pnpm dev
```
- Aller sur http://localhost:4200 (ou autre port)
