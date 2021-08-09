@IsTest
private class MetadataSchema_Test {

    private static Integer noCacheDuration = null;
   
    @IsTest
    private static void isCachedOnSecondLoad() {

        // Setup
        populateCache();


        // Exercise
        Datetime before = Datetime.now();
        new MetadataSchema();
        Integer withCacheDuration = elapsedSecsSince(before);


        // Verify
        System.assert(noCacheDuration > withCacheDuration, 'No Cache: ' + noCacheDuration + ' <-> ' + 'With Cache: ' + withCacheDuration);
    }


    @IsTest
    private static void types() {

        // Setup
        populateCache();


        // Exercise
        List<String> types = new MetadataSchema().types();


        // Verify
        System.assert(types.contains('Profile'));
    }


    @IsTest
    private static void properties() {

        // Setup
        populateCache();


        // Exercise
        List<MetadataSchema.Property> properties = new MetadataSchema().properties('Profile');


        // Verify
        System.assert(properties.contains(new MetadataSchema.Property('loginIpRanges')));
        System.assert(properties.contains(new MetadataSchema.Property('userPermissions')));
    }


    // HELPER

    private static void populateCache() {
        Datetime before = Datetime.now();
        new MetadataSchema();
        noCacheDuration = elapsedSecsSince(before);
    }


    private static Integer elapsedSecsSince(Datetime start) {
        return Integer.valueOf((System.now().getTime() - start.getTime()) / 1000);
    }
}
