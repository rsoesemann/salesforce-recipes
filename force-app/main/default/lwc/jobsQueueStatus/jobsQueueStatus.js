import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import queryJobs from "@salesforce/apex/JobsQueueCtrl.queryJobs";

export default class JobsQueueStatus extends NavigationMixin(LightningElement) {

    @api
    jobIds;

    steps = [];

    async connectedCallback() {
        try {
            this.steps = await queryJobs({ jobIds : this.jobIds });
            debugger;
        }
        catch(error) {
            this.showError(error);
        }
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