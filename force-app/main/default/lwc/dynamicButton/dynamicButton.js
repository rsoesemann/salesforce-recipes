import { api, LightningElement } from "lwc";
import executeCallable from "@salesforce/apex/DynamicButtonCtrl.executeCallable";

export default class DynamicButton extends LightningElement {
    @api label;
    @api callableClass;

    async handleClick(event) {
        await executeCallable({ callableClass : this.callableClass });
    }
}