@IsTest
private class MetadataSchema_Test {

    @IsTest
    private static void topLevelOptions() {

        // Setup & Exercise
        List<MetadataSchema.Option> results = new MetadataSchema().options();


        // Verify
        System.assert(results.contains( option('AIApplication') ));
        System.assert(results.contains( option('Profile') ));
        System.assert(results.contains( option('SecuritySettings') ));
        
        System.assert(!results.contains( option('AIApplicationStatus') ));
        System.assert(!results.contains( option('ProfileApplicationVisibility') ));
    }


    @IsTest
    private static void childOptions() {

        // Setup & Exercise
        List<MetadataSchema.Option> results = new MetadataSchema().options( option('Profile') );


        // Verify
        System.assert(results.contains( option('loginIpRanges') ));
        System.assert(results.contains( option('userPermissions') ));
    }


    // HELPER

    private static MetadataSchema.Option option(String name) {
        return new MetadataSchema.Option(name);
    }
}