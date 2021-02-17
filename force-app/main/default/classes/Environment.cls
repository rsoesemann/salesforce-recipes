public class Environment extends DomainBuilder {

    // CTORS

    public Environment() {
        super(copado__Environment__c.SObjectType);
    }


    // BUILDER

    public Environment add(Credential cred) {
        cred.setParent(copado__Org__c.copado__Environment__c, this);
        return this;
    }
}