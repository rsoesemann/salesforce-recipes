import { LightningElement, api } from "lwc";

export default class NotificationsLog extends LightningElement {
    @api
    contextId;

    events = [];

    handleMessage(event) {
        const payload = event.detail.payload.data.payload;

        if(this.isRelevant(payload)) {
            this.events.push(payload);
            this.events = JSON.parse(JSON.stringify(this.events));
        }
    }

    isRelevant(payload) {
        return (payload.ext_JobId__c == this.contextId);
    }

    handleError(event){
        console.log( JSON.stringify(event.detail.error) );
    }

    restart(){
        cometD.subscribe();
    }

    destroy(){
        cometD.unsubscribe();
    }

    cometD() {
        return this.template.querySelector('.cometD');
    }
}