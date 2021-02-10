import { LightningElement, api } from 'lwc';

import { ShowToastEvent } from "lightning/platformShowToastEvent";

import query from "@salesforce/apex/ActivateAccountCtrl.query";

export default class ActivateAccounts extends LightningElement {
    @api
    accountIds;

    isLoading = false;
    accounts = [];
    columns = [
        { label: 'From Date', fieldName: 'fromDate', type: 'date', fixedWidth: 125 },
        { label: 'To Date', fieldName: 'toDate', type: 'date', fixedWidth: 100},
        { label: 'IMEI', fieldName: 'imei', fixedWidth: 150 },
        { label: 'PDP Type', fieldName: 'pdpType', fixedWidth: 100 },
        { label: 'Country', fieldName: 'country', fixedWidth: 100 },
        { label: 'Uploaded', fieldName: 'volumeUpload', fixedWidth: 120 },
        { label: 'Downloaded', fieldName: 'volumeDownload', fixedWidth: 125 },
        { label: 'Aggregated', fieldName: 'volumeAggregated', fixedWidth: 125 },
        { label: 'Sessions', fieldName: 'numberOfSessions', fixedWidth: 100 },
        { label: 'Failed Sessions', fieldName: 'failedSessions', fixedWidth: 150 }
    ]


    async connectedCallback() {
        this.isLoading = true;

        try {
            this.accounts = await query({ accountIds : this.accountIds })
        }
        catch(error) {
            this.showError(error);
        }

        this.isLoading = false;
    }

    
    showError(error) {
        const message = error.body ? error.body.message : (error.message ? error.message : error);
        const errorTitle = error.body ? error.body.exceptionType : "Error";

        this.showToast("error", errorTitle, message);
    }


    showToast(variant, title, message, mode = "dismissable") {
        const event = new ShowToastEvent({ variant, title, message, mode });

        this.dispatchEvent(event);
    }
}