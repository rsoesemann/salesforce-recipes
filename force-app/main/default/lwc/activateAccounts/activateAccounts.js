import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import query from "@salesforce/apex/ActivateAccountCtrl.query";

export default class ActivateAccounts extends NavigationMixin(LightningElement) {
    @api
    accountIds;

    isLoading = false;
    accounts = [];
    columns = [
        { label: 'Name', fieldName: 'Name', fixedWidth: 125 },
        { label: 'Description', fieldName: 'Description', type: 'date', fixedWidth: 125 },
        { label: 'Last Modified By', fieldName: 'LastModifiedById', type: 'date', fixedWidth: 100}
    ]


    async connectedCallback() {
        this.isLoading = true;

        try {
            this.accounts = await query({ accountIds : this.accountIds })
        }
        catch(error) {
            this.showError(error);
        }

        this.template.querySelector('c-modal').toggleModal();

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