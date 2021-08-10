@IsTest
private class MetadataSchema_Test {

    @IsTest
    private static void topLevelOptions() {

        // Setup & Exercise
        List<MetadataSchema.Option> results = new MetadataSchema().options();


        // Verify
        System.assert(contains(results, 'AIApplication'));
        System.assert(contains(results, 'Profile'));
        System.assert(contains(results, 'SecuritySettings'));
        
        System.assert(!contains(results, 'AIApplicationStatus'));
        System.assert(!contains(results, 'ProfileApplicationVisibility'));
    }


    @IsTest
    private static void childOptions() {

        // Setup
        MetadataSchema.Option profile = new MetadataSchema.Option('Profile');


        // Exercise
        List<MetadataSchema.Option> results = new MetadataSchema().options(profile);


        // Verify
        System.assert(contains(results, 'loginIpRanges'));
        System.assert(contains(results, 'userPermissions'));
    }


    // HELPER

    private static Boolean contains(List<MetadataSchema.Option> results, String name) {
        return new Set<MetadataSchema.Option>(results).contains(new MetadataSchema.Option(name));
    }
}