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
        MetadataSchema.Option profile = option('Profile');


        // Exercise
        List<MetadataSchema.Option> results = new MetadataSchema().options(profile);


        // Verify
        System.assert(results.contains(option('loginIpRanges', 'ProfileLoginIpRange')));
        System.assert(results.contains(option('userPermissions', 'ProfileUserPermission')));
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