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
            if(!this.accountIds.length) {
                const closeQA = new CustomEvent("close", {   
                    bubbles: true,
                    composed: true
                });
                
                this.dispatchEvent(closeQA);

                this.showError('You need to select at least one Account.');
            }
            this.accounts = await query({ accountIds : this.accountIds });
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


    showToast(type, title, message) {
        const showToast = new CustomEvent("showToast", {  
                                                detail: { type, title, message },
                                                bubbles: true,
                                                composed: true
                                            });

        this.dispatchEvent(showToast);
    }
}