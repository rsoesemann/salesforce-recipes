@IsTest
private class MetadataSchema_Test {

    static {
        Test.setMock(HttpCalloutMock.class, new MockWsdl());
    }


    @IsTest
    private static void topLevelNodes() {

        // Setup & Exercise
        List<MetadataSchema.Option> results = new MetadataSchema().options();


        // Verify
        System.assert(results.contains(node('AIApplication')));
        System.assert(results.contains(node('Profile')));
        System.assert(results.contains(node('SecuritySettings')));
        
        System.assert(!results.contains(node('AIApplicationStatus')));
        System.assert(!results.contains(node('ProfileApplicationVisibility')));
    }


    @IsTest
    private static void childNodes() {

        // Setup
        MetadataSchema.Option customObject = node('CustomObject');
        MetadataSchema.Option fields = node('fields', 'CustomField');
        MetadataSchema.Option filter = node('lookupFilter', 'LookupFilter');
        MetadataSchema.Option item = node('filterItems', 'FilterItem');
        MetadataSchema.Option value = node('value', 'string');

        MetadataSchema schema = new MetadataSchema();


        // Exercise & Verify
        System.assert(schema.options(customObject).contains(fields));
        System.assert(schema.options(fields).contains(filter));
        System.assert(schema.options(filter).contains(item));
        System.assert(schema.options(item).contains(value));
        System.assert(schema.options(value).isEmpty());
    }


    @IsTest
    private static void values() {

        // Setup
        MetadataSchema.Option flowTypes = node('FlowProcessType');
        MetadataSchema.Option autoLaunched = value('FlowProcessType', 'string', 'AutoLaunchedFlow');
        MetadataSchema.Option invocableProcess = value('FlowProcessType', 'string', 'InvocableProcess');
        MetadataSchema.Option workflow = value('FlowProcessType', 'string', 'Workflow');

        MetadataSchema schema = new MetadataSchema();


        // Exercise & Verify
        System.assert(schema.options(flowTypes).contains(autoLaunched), flowTypes);
        System.assert(schema.options(flowTypes).contains(invocableProcess), flowTypes);
        System.assert(schema.options(flowTypes).contains(workflow), flowTypes); 

        System.assert(schema.options(workflow).isEmpty());
    }


    // HELPER

    private static MetadataSchema.Option node(String name, String type){
        MetadataSchema.Option result = new MetadataSchema.Option();
        result.name = name;
        result.type = type;
        return result;
    }


    private static MetadataSchema.Option node(String name){
        return node(name, null);
    }


    private static MetadataSchema.Option value(String name, String type, String value){
        MetadataSchema.Option result = node(name, type);
        result.value = value;
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