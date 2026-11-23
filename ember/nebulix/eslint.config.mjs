/**
 * Debugging:
 *   https://eslint.org/docs/latest/use/configure/debug
 *  ----------------------------------------------------
 *
 *   Print a file's calculated configuration
 *
 *     npx eslint --print-config path/to/file.js
 *
 *   Inspecting the config
 *
 *     npx eslint --inspect-config
 *
 */
import pixRecommendedConfig from '@1024pix/eslint-plugin/config';
import babelParser from '@babel/eslint-parser';
import js from '@eslint/js';
import { defineConfig, globalIgnores } from 'eslint/config';
import ember from 'eslint-plugin-ember/recommended';
import { createNodeResolver, importX } from 'eslint-plugin-import-x';
import n from 'eslint-plugin-n';
import prettierRecommendedConfig from 'eslint-plugin-prettier/recommended';
import globals from 'globals';

const esmParserOptions = {
  ecmaFeatures: { modules: true },
  ecmaVersion: 'latest',
};

export default defineConfig([
  ...pixRecommendedConfig,
  globalIgnores(['dist/', 'dist-*/', 'declarations/', 'coverage/', '!**/.*']),
  js.configs.recommended,
  prettierRecommendedConfig,
  importX.flatConfigs.recommended,
  ember.configs.base,
  ember.configs.gjs,
  /**
   * https://eslint.org/docs/latest/use/configure/configuration-files#configuring-linter-options
   */
  {
    linterOptions: {
      reportUnusedDisableDirectives: 'error',
    },
  },
  {
    files: ['**/*.js'],
    languageOptions: {
      parser: babelParser,
    },
  },
  {
    files: ['**/*.{js,gjs}'],
    languageOptions: {
      parserOptions: esmParserOptions,
      globals: {
        ...globals.browser,
      },
    },
  },
  {
    files: ['src/**/*'],
    settings: {
      'import-x/resolver-next': [createNodeResolver({ extensions: ['.js', '.json', '.gjs'] })],
    },
    rules: {
      // require relative imports use full extensions
      'import-x/extensions': ['error', 'always', { ignorePackages: true }],
      // exported modules provided by ember-source
      'import-x/no-unresolved': ['error', { ignore: ['^@ember/', '^@glimmer/tracking$'] }],
    },
  },
  /**
   * CJS node files
   */
  {
    files: ['**/*.cjs'],
    plugins: {
      n,
    },

    languageOptions: {
      sourceType: 'script',
      ecmaVersion: 'latest',
      globals: {
        ...globals.node,
      },
    },
  },
  /**
   * ESM node files
   */
  {
    files: ['**/*.mjs'],
    plugins: {
      n,
    },

    languageOptions: {
      sourceType: 'module',
      ecmaVersion: 'latest',
      parserOptions: esmParserOptions,
      globals: {
        ...globals.node,
      },
    },
  },
]);
