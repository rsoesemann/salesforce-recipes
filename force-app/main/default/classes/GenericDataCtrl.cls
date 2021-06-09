public with sharing class GenericDataCtrl {

    @AuraEnabled(cacheable=false)
    public static String load(Id recordId, String field) {
        String result = null;

        try {
            result = (String) Database.query(soqlToQuery(recordId, field))
                                .get(0).get(field);
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return result;
    }

    
    @AuraEnabled
    public static void store(Id recordId, String field, String data) {
        SObject record = recordId.getSobjectType().newSObject(recordId);
        record.put(field, data);
        update record;
    }


    // PRIVATE

    private static String soqlToQuery(Id recordId, String field) {
        return String.format('SELECT {0} FROM {1} WHERE Id = \'{3}\' LIMIT 1', 
                                    new List<String>{
                                        field, '' + recordId.getSobjectType(), recordId
                                    });
    }
}