import pixRecommendedConfig from '@1024pix/eslint-plugin/config';
import js from '@eslint/js';
import { defineConfig, globalIgnores } from 'eslint/config';
import prettierRecommendedConfig from 'eslint-plugin-prettier/recommended';
import vue from 'eslint-plugin-vue';
import globals from 'globals';
import ts from 'typescript-eslint';

export default defineConfig([
  ...pixRecommendedConfig,
  globalIgnores(['dist/', 'declarations/', 'coverage/', '!**/.*']),
  js.configs.recommended,
  ...ts.configs.recommended,
  ...vue.configs['flat/recommended'],
  prettierRecommendedConfig,
  {
    linterOptions: {
      reportUnusedDisableDirectives: 'error',
    },
  },
  {
    // Several packages of the workspace have a tsconfig: pin this one's.
    languageOptions: {
      parserOptions: { tsconfigRootDir: import.meta.dirname },
    },
  },
  {
    files: ['**/*.vue'],
    languageOptions: {
      parserOptions: { parser: ts.parser },
    },
  },
  {
    files: ['src/**/*.{ts,vue}'],
    languageOptions: {
      globals: { ...globals.browser },
    },
  },
  {
    files: ['*.{js,mjs,ts}'],
    languageOptions: {
      globals: { ...globals.node },
    },
  },
]);
