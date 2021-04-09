public with sharing class TestCtrl {

    @AuraEnabled
    public static String getComponentForRecord(Id recordId) {
        String result = null;

        try {
            Test__c record = new TestsSelector().byId(new Set<Id>{ recordId })[0];
            TestType__mdt type = new TestTypesSelector().byName(record.Type__c)[0];

            result= type.UiComponent__c;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }

        return result;
    }


    @AuraEnabled(cacheable=false)
    public static String fetchConfiguration(Id recordId) {
        String result = null;

        try {
            Test__c record = new TestsSelector().byId(new Set<Id>{ recordId })[0];
            result = record.txl_Payload__c;
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return result;
    }

    
    @AuraEnabled(cacheable=false)
    public static void storeConfiguration(Id recordId, String configuration) {
        Test__c record = new Test__c(Id = recordId);
        record.txl_Payload__c = configuration;
        upsert record;
    }
}