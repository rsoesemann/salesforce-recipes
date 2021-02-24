public with sharing class RecordFormCtrl {

    @AuraEnabled(cacheable=true)
    public static List<String> getFieldsFromFieldSet(Id recordId, String fieldSet) {
        List<String> result = new List<String>();

        String objectName = getSObjectName(recordId);

        for(FieldSetMember field : fflib_SObjectDescribe.getDescribe(objectName).getDescribe()
                                                                                    .fieldSets.getMap()
                                                                                    .get(fieldSet).getFields()) {
            result.add( field.getFieldPath() );
        }
        
        return result;
    }


    @AuraEnabled(cacheable=true)
    public static String getSObjectName(Id recordId) {
        return '' + recordId.getSobjectType();
    }
}