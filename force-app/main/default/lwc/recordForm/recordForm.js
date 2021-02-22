import { LightningElement, api, wire } from 'lwc';

import getFieldsFromFieldSet from '@salesforce/apex/RecordFormCtrl.getFieldsFromFieldSet';

export default class RecordForm extends LightningElement {
    @api recordId;
    @api objectName;
    @api fieldSet;

    fields = [];

    @wire(getFieldsFromFieldSet, { objectName: '$objectName', fieldSet: '$fieldSet' })
    wiredFields({ error, data: fieldNames }) {
        // Note: lightning-record-form accepts fields as an array of this format: [{fieldApiName: "Name", objectApiName: "Account"}]
        if(fieldNames) {
            const objectApiName = this.objectName;
            this.fields = fieldNames.map(fieldApiName => ({ fieldApiName, objectApiName }));
        } 
        else {
            //... handle error
            console.error({error});
        }
    }


    handleSubmit(event){
        event.preventDefault();
        //... do stuff
        this.template.querySelector('lightning-record-form').submit(fields);
    }
}