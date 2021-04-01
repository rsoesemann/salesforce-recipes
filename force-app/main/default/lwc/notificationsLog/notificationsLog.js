import { LightningElement, track } from "lwc";

export default class NotificationsLog extends LightningElement {

    events = [];

    handleMessage(event){
        this.events.push( event.detail.payload.data.payload );
        this.events = JSON.parse(JSON.stringify(this.events));
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