public class Pipeline extends DomainBuilder {


    // CTORS

    public Pipeline(Repository rep) {
        super(copado__Deployment_Flow__c.SObjectType);

        setParent(copado__Deployment_Flow__c.copado__Git_Repository__c, rep);
    }


    public Pipeline() {
        this( new Repository() );
    }


    // BUILDER

    public Pipeline add(Connection con) {
        con.setParent(copado__Deployment_Flow_Step__c.copado__Deployment_Flow__c, this);
        return this;
    }
}