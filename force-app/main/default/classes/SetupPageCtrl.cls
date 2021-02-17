public with sharing class SetupPageCtrl extends SetupCtrl {

    public static final String DEV_NAME = 'Integration';

    public SetupNamedCredential credential { get; private set; }
    public SetupConnectedApp connectedApp { get; private set; }


    // CONSTRUCTOR

    public SetupPageCtrl() {
        credential = new SetupNamedCredential();
        connectedApp = new SetupConnectedApp();
    }


    // PUBLIC

    public override List<SetupStep> steps() {
        return new List<SetupStep>{ credential, connectedApp };
    }
}