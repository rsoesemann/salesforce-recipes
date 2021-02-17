public class Credential extends DomainBuilder {

    public Credential(Environment env) {
        super(copado__Org__c.SObjectType);

        setParent(copado__Org__c.copado__Environment__c, env);
    }


    public Credential() {
        this(new Environment() );
    }
}