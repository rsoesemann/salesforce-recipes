public class Project extends DomainBuilder {

    public Project() {
        super(copado__Project__c.SObjectType);

        name('Project');
    }


    public Project name(String value) {
        return (Project) set(copado__Project__c.Name, value);
    }


    public Project add(Release rel) {
        return (Project) rel.setParent(copado__Release__c.copado__Project__c, this);
    }


    public Project add(Pipeline pip) {
        setParent(copado__Project__c.copado__Deployment_Flow__c, pip);
        return this;
    }
}