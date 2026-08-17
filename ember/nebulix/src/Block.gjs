import Component from '@glimmer/component';

/**
 * @typedef {object} BlockArgs
 * @property {string} name Dis à qui tu veux faire coucou !
 */

/**
 * @extends {Component<{ Args: BlockArgs; Element: HTMLDivElement }>}
 */
export default class Block extends Component {
  <template>
    <div ...attributes>Hello {{@name}}</div>
  </template>
}
