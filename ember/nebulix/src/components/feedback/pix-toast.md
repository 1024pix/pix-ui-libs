# PixToast

Mount `<PixToastContainer />` once in your application, then inject the `pixToast`
service to send notifications.

## Usage

```gjs live preview
import { PixButton, PixToastContainer } from '@1024pix/nebulix-ember';
import { service } from '@ember/service';
import Component from '@glimmer/component';

export default class ToastDemo extends Component {
  @service pixToast;

  sendToast = () => {
    this.pixToast.sendSuccessNotification({ message: 'Your changes have been saved' });
  };

  <template>
    <PixButton @triggerAction={{this.sendToast}}>Send a toast</PixButton>

    <PixToastContainer @closeButtonAriaLabel="Close" />
  </template>
}
```
