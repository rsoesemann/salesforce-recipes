import { LightningElement, api, track } from "lwc";
import { FlowAttributeChangeEvent } from "lightning/flowSupport";
  

export default class EmbedInFlow extends LightningElement {
    @api test;

    handleChange(event) {
        this.test.Payload__c = event.target.value;
        this.dispatchEvent( new FlowAttributeChangeEvent('getTest', this.test) );
    }
}