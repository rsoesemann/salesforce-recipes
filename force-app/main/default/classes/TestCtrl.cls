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
}