import { LightningElement } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import startFlow from "@salesforce/apex/MultiCommitCtrl.startFlow";

export default class NotificationsLog extends LightningElement {
    subscription = {};
    events = [];

    connectedCallback() {
        subscribe('/event/NotificationReceived__e', -1, this.handleEvent).then(response => {
            this.subscription = response;
        });

        onError(error => {
            console.log('Received error from server: ', JSON.stringify(error));
        });

        startFlow();
    }


    disconnectedCallback() {
        unsubscribe(this.subscription, response => {
            console.log('Successfully unsubscribed');
        });
    }


    handleEvent(event) {
        debugger;
        this.events = this.events || [];
        this.events.push( { Id: "sdafs", txt_Status__c : "dsfgsds"} );
        this.events = JSON.parse(JSON.stringify(this.events));
    }
}