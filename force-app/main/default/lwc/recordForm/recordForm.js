import { LightningElement, api, wire } from 'lwc';

import getFieldsFromFieldSet from '@salesforce/apex/RecordFormCtrl.getFieldsFromFieldSet';

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
        const closeQA = new CustomEvent("close", {
            bubbles: true,
            composed: true
        });

        this.dispatchEvent(closeQA);
    }
}