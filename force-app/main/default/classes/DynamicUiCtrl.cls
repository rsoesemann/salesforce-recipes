public with sharing class DynamicUiCtrl {

    @AuraEnabled
    public static Component getUiComponent(Id recordId, String uiLocation) {
        Test__c record = [SELECT Id, Type__c FROM Test__c WHERE Id = :recordId];
System.debug(LoggingLevel.ERROR, record);

        DynamicUi__mdt ui = [SELECT UiApiName__c, UiType__c FROM DynamicUi__mdt 
                             WHERE RecordType__c = :record.Type__c AND UiLocation__c = :uiLocation LIMIT 1];
System.debug(LoggingLevel.ERROR, ui);

        Component result = new Component();
        result.type = ui.UiType__c;
        result.fqName = ui.UiApiName__c;
  
System.debug(LoggingLevel.ERROR, result);
        return result;
    }


    // INNER

    public class Component {
        @AuraEnabled public String type;
        @AuraEnabled public String fqName;
    }
}