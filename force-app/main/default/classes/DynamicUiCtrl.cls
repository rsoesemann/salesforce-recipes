public with sharing class DynamicUiCtrl {

    @AuraEnabled
    public static Component getUiComponent(Id recordId, String uiLocation) {
        DynamicUi__mdt ui = [SELECT UiApiName__c, UiType__c FROM DynamicUi__mdt 
                             WHERE UiLocation__c = :uiLocation LIMIT 1];

        Component result = new Component();
        result.type = ui.UiType__c;
        result.fqName = ui.UiApiName__c;
        return result;
    }


    // INNER

    public class Component {
        @AuraEnabled public String type;
        @AuraEnabled public String fqName;
    }
}