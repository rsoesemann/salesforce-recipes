import { LightningElement, api, wire } from 'lwc';

import getFieldsFromFieldSet from '@salesforce/apex/RecordFormCtrl.getFieldsFromFieldSet';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';


export default class RecordForm extends LightningElement {
    @api recordId;
    @api objectName;
    @api fieldSet;

    field = REVENUE_FIELD;

    @wire(getFieldsFromFieldSet, { objectName: '$objectName', fieldSet: '$fieldSet' })
    fields;

    handleSubmit(event){
        event.preventDefault();
        //... do stuff
        this.template.querySelector('lightning-record-form').submit(fields);
    }


    connectedCallback() {
        debugger;
    }
}