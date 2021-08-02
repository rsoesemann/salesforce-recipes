import { executeQuery } from "lightning/analyticsWaveApi";
import { api, LightningElement } from "lwc";
import executeCallable from "@salesforce/apex/DynamicButtonCtrl.executeCallable";

export default class DynamicButton extends LightningElement {
    @api label;
    @api callableClass;

    handleClick(event) {
        executeCallable(this.callableClass);
    }
}