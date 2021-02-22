public with sharing class RecordFormCtrl {

    @AuraEnabled(cacheable=false)
    public static List<String> getFieldsFromFieldSet(String objectName, String fieldSet) {
        List<String> result = new List<String>();

        for(FieldSetMember field : fflib_SObjectDescribe.getDescribe(objectName).getDescribe()
                                                    .fieldSets.getMap().get(fieldSet).getFields()) {
            result.add(objectName + '.' + field.getFieldPath());
        }
System.debug(LoggingLevel.ERROR, result);

        return result;
    }
}