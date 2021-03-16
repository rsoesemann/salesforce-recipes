import { LightningElement, api, wire } from 'lwc';

import getFieldsFromFieldSet from '@salesforce/apex/RecordFormCtrl.getFieldsFromFieldSet';
import { FlowNavigationFinishEvent } from 'lightning/flowSupport';

export default class RecordForm extends LightningElement {
    @api recordId;
    @api objectName;
    @api fieldSet;

    fields = [];

    @wire(getFieldsFromFieldSet, { objectName: '$objectName', fieldSet: '$fieldSet' })
    wiredFields({ error, data: result }) {
        if(result) {
            this.fields = result;
        }
    }


    closeModal(event) {
        // Note: LWC in Flow
        this.dispatchEvent( new FlowNavigationFinishEvent() );

        // Note: Aura Quickaction
        this.dispatchEvent( new CustomEvent("close", {
                                                bubbles: true,
                                                composed: true
                                            }) );
    }
}