public class Release extends DomainBuilder {

    public Release(Project prj) {
        super(copado__Release__c.SObjectType);

        setParent(copado__Release__c.copado__Project__c, prj);
    }

    public Release() {
        this( new Project() );
    }
}