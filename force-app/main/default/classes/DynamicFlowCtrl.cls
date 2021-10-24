public with sharing class DynamicFlowCtrl {

    @AuraEnabled
    public static String getFlowName(Id recordId, String flowType) {
        String result = null;

        try {
            System.debug(LoggingLevel.ERROR, recordId);
            Test__c record = [SELECT Id, Type__c FROM Test__c WHERE Id = :recordId];
            System.debug(LoggingLevel.ERROR, record);
            DynamicUi__mdt ui = [SELECT UiApiName__c FROM DynamicUi__mdt WHERE RecordType__c = :record.Type__c LIMIT 1];
            System.debug(LoggingLevel.ERROR, ui);
            result = ui.UiApiName__c;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }

        return result;
    }
}