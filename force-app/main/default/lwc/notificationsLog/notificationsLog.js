import { LightningElement, wire, track } from "lwc";
import { loadScript } from "lightning/platformResourceLoader";
import cometdlwc from "@salesforce/resourceUrl/cometd";
import getSessionId from '@salesforce/apex/MultiCommitCtrl.getSessionId';


export default class NotificationsLog extends LightningElement {
    libInitialized = false;
    @track sessionId;
    @track error;

    @wire(getSessionId)
    wiredSessionId({ error, data }) {
        if(data) {
            console.log(data);
            this.sessionId = data;
            this.error = undefined;
            loadScript(this, cometdlwc)
                .then(() => {
                    this.initializeCometD()
                });
        } 
        else if(error) {
            console.log(error);
            this.error = error;
            this.sessionId = undefined;
        }
    }

    initializeCometD() {
        if (this.libInitialized) {
            return;
        }

        this.libInitialized = true;

        var cometdlib = new window.org.cometd.CometD();

        //Calling configure method of cometD class, to setup authentication which will be used in handshaking
        cometdlib.configure({
            url: window.location.protocol + '//' + window.location.hostname + '/cometd/47.0/',
            requestHeaders: { Authorization: 'OAuth ' + this.sessionId },
            appendMessageTypeToURL: false,
            logLevel: 'debug'
        });

        cometdlib.websocketEnabled = false;

        cometdlib.handshake(function (status) {

            if (status.successful) {
                // Successfully connected to the server.
                // Now it is possible to subscribe or send messages
                console.log('Successfully connected to server');
            } else {
                /// Cannot handshake with the server, alert user.
                console.error('Error in handshaking: ' + JSON.stringify(status));
            }
        });
    }
}