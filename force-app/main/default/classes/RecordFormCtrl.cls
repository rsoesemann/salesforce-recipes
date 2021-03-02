public with sharing class RecordFormCtrl {

    @AuraEnabled(cacheable=true)
    public static List<String> getFieldsFromFieldSet(String objectName, String fieldSet) {
        List<String> result = new List<String>();

        for(FieldSetMember field : fflib_SObjectDescribe.getDescribe(objectName).getDescribe()
                                                                                    .fieldSets.getMap()
                                                                                    .get(fieldSet).getFields()) {
            result.add( field.getFieldPath() );
        }
        
        return result;
    }
}