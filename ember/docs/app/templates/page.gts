import Component from "@glimmer/component";
import { service } from "@ember/service";

import { OopsError, PageLayout } from "@universal-ember/docs-support";



export default class DocsPage extends Component {
  @service router;

  <template>
    <PageLayout>
      <:logoLink>
        <Logo />
      </:logoLink>
      <:error as |error|>
        <OopsError @error={{error}} />
      </:error>
      <:editLink as |Link|>
        <Link @href={{ this.router.currentURL}}>
          Edit this page
        </Link>
      </:editLink>
    </PageLayout>
  </template>
}


const Logo = <template>
  <svg xmlns="http://www.w3.org/2000/svg" width="100"   fill="none" viewBox="0 0 145 109">
    <path fill="url(#a)" d="m119.839 69.376 2.202-2.665c1.96-2.254 3.352-4.43 4.178-6.573l16.762 20.414c3.043 3.888 2.898 4.609-2.173 4.609h-1.738c-5.071 0-6.954-1.009-9.997-4.61zm0-27.77 9.234-11.176c3.043-3.6 4.926-4.61 9.997-4.61h1.738c5.071 0 5.216.721 2.173 4.61l-16.762 20.414c-.826-2.144-2.218-4.32-4.178-6.574z"/>
    <path fill="url(#b)" d="M94.24 85.16c-5.071 0-5.216-.72-2.174-4.608l17.386-21.173c1.303-1.584 2.028-2.88 2.028-3.888 0-1.153-.725-2.449-2.028-3.889L92.066 30.43c-3.042-3.889-2.897-4.61 2.173-4.61h1.74c5.07 0 6.953 1.01 9.996 4.61l13.328 16.13c5.65 6.482 5.65 11.38 0 17.86l-13.328 16.132c-3.043 3.6-4.926 4.609-9.997 4.609z"/>
    <path fill="url(#c)" d="M0 103.625c0 4.3 1.081 5.375 5.407 5.375h1.442c4.325 0 5.406-1.075 5.406-5.375V78.66c3.245 5.136 9.132 7.764 17.663 7.764 16.7 0 24.991-8.72 24.991-26.04V49.994c0-17.32-8.891-25.443-27.514-25.443C10.093 24.55 0 32.912 0 49.993zm42.534-43.001c0 10.033-3.364 14.214-15.02 14.214-11.894 0-15.259-4.3-15.259-14.214V50.35c0-10.034 3.605-14.334 15.26-14.334 11.895 0 15.019 4.3 15.019 14.334z"/>
    <path fill="url(#d)" d="M66.467 79.642c0 4.3 1.08 5.375 5.406 5.375h1.562c4.326 0 5.407-1.075 5.407-5.375V31.146c0-4.3-1.081-5.375-5.407-5.375h-1.562c-4.325 0-5.407 1.075-5.407 5.375zm.84-66.771c3.004 2.866 7.81 2.866 10.694 0 3.004-2.987 3.004-7.765 0-10.631-2.884-2.987-7.69-2.987-10.693 0-3.004 2.866-3.004 7.644 0 10.63"/>
    <defs>
      <linearGradient id="a" x1="132.42" x2="132.42" y1="25.821" y2="85.161" gradientUnits="userSpaceOnUse">
        <stop stop-color="#12a3ff"/>
        <stop offset="1" stop-color="#3d68ff"/>
      </linearGradient>
      <linearGradient id="b" x1="100.55" x2="100.55" y1="25.821" y2="85.161" gradientUnits="userSpaceOnUse">
        <stop stop-color="#ffbe00"/>
        <stop offset="1" stop-color="#ff9f00"/>
      </linearGradient>
      <linearGradient id="c" x1="27.455" x2="27.455" y1="24.55" y2="86.24" gradientUnits="userSpaceOnUse">
        <stop stop-color="#12a3ff"/>
        <stop offset="1" stop-color="#3d68ff"/>
      </linearGradient>
      <linearGradient id="d" x1="72.654" x2="72.654" y1="24.113" y2="85.017" gradientUnits="userSpaceOnUse">
        <stop stop-color="#12a3ff"/>
        <stop offset="1" stop-color="#3d68ff"/>
      </linearGradient>
    </defs>
  </svg>


</template>
