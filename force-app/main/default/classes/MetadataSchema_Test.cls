@IsTest
private class MetadataSchema_Test {

    static {
        Test.setMock(HttpCalloutMock.class, new MockWsdl());
    }


    @IsTest
    private static void topLevelOptions() {

        // Setup & Exercise
        List<MetadataSchema.Option> results = new MetadataSchema().options();


        // Verify
        System.assert(results.contains(option('AIApplication')));
        System.assert(results.contains(option('Profile')));
        System.assert(results.contains(option('SecuritySettings')));
        
        System.assert(!results.contains(option('AIApplicationStatus')));
        System.assert(!results.contains(option('ProfileApplicationVisibility')));
    }


    @IsTest
    private static void childOptions() {

        // Setup
        MetadataSchema.Option customObject = option('CustomObject');
        MetadataSchema.Option fields = option('fields', 'CustomField');
        MetadataSchema.Option filter = option('lookupFilter', 'LookupFilter');
        MetadataSchema.Option item = option('filterItems', 'FilterItem');
        MetadataSchema.Option value = option('value', 'string');

        MetadataSchema schema = new MetadataSchema();


        // Exercise & Verify
        System.assert(schema.options(customObject).contains(fields));
        System.assert(schema.options(fields).contains(filter));
        System.assert(schema.options(filter).contains(item));
        System.assert(schema.options(item).contains(value));
    }


    // HELPER

    private static MetadataSchema.Option option(String name){
        return option(name, null);
    }

    private static MetadataSchema.Option option(String name, String type){
        MetadataSchema.Option result = new MetadataSchema.Option();
        result.name = name;
        result.type = type;
        return result;
    }


    public class MockWsdl implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest request) {
            HTTPResponse result = new HTTPResponse();
            
            Blob localWsdl = [SELECT Body FROM StaticResource WHERE Name = 'metadata_wsdl' LIMIT 1].Body;
            result.setBodyAsBlob(localWsdl);
            
            return result;
        }
    }
}