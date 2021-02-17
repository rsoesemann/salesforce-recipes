public class Connection extends DomainBuilder {

    public Connection(Pipeline pip) {
        super(copado__Deployment_Flow_Step__c.SObjectType);

        setParent(copado__Deployment_Flow_Step__c.copado__Deployment_Flow__c, pip);
    }


    public Connection() {
        this( new Pipeline() );
    }
}