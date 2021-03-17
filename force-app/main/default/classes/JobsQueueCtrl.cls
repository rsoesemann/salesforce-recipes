public with sharing class JobsQueueCtrl {

    public String serializedJobIds { get; private set; }

    // CONSTRUCTORS

    public JobsQueueCtrl(ApexPages.StandardController ctrl) {
        // Note: Needed for VF Quickaction
    }


    // PUBLIC

    public void enqueue() {
        List<Id> jobIds = new RunJob('CommitMetadata', 4)
                                .then( new RunJob('CommitProfilesAndPermSets', 7) )
                                .then( new RunJob('CommitDestructiveChanges', 3))
                                .execute();

        serializedJobIds = JSON.serialize(jobIds);
    }

    
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @AuraEnabled
    public static List<AsyncApexJob> queryJobs(List<Id> jobIds) {
        List<AsyncApexJob> result = new List<AsyncApexJob>();

        try {
            result = [SELECT Id, ApexClass.Name, Status 
                      FROM AsyncApexJob WHERE Id IN :jobIds ];
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }

        return result;
    }


    public PageReference redirectToList() {
        return new ApexPages.Action('{!List}').invoke();
    }


    // INNER

    public class Job {
        @AuraEnabled public String label;
        @AuraEnabled public String value;
    }
}