@IsTest
private class MetadataSchema_Test {

    @IsTest
    private static void topLevelOptions() {

        // Setup & Exercise
        List<MetadataSchema.Option> options = new MetadataSchema().options();


        // Verify
        System.assert(options.contains( new MetadataSchema.Option('Profile') ));
        System.assert(options.contains( new MetadataSchema.Option('SecuritySettings')) );
        
        System.assertEquals(false, options.contains( new MetadataSchema.Option('ProfileApplicationVisibility')) );
    }


    @IsTest
    private static void childOptions() {

        // Setup & Exercise
        List<MetadataSchema.Option> options = new MetadataSchema().options( new MetadataSchema.Option('Profile') );


        // Verify
        System.assert(options.contains( new MetadataSchema.Option('loginIpRanges') ));
        System.assert(options.contains( new MetadataSchema.Option('userPermissions') ));
    }
}