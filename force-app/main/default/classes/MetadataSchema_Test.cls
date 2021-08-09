@IsTest
private class MetadataSchema_Test {

    private static Integer noCacheDuration = null;


    @IsTest
    private static void showsOnlyTopLevelTypes() {

        // Setup
        populateCache();


        // Exercise
        List<String> types = new MetadataSchema().types();


        // Verify
        System.assert(types.contains('Profile'));
        System.assert(types.contains('SecuritySettings'));
        System.assertEquals(false, types.contains('ProfileApplicationVisibility'));
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


    // HELPER

    private static void populateCache() {
        Test.setMock(WebServiceMock.class, new MdApiMock());

        Datetime before = Datetime.now();
        new MetadataSchema();
        noCacheDuration = elapsedSecsSince(before);
    }


    private static Integer elapsedSecsSince(Datetime start) {
        return Integer.valueOf((System.now().getTime() - start.getTime()) / 1000);
    }


    public class MdApiMock implements WebServiceMock {
        public void doInvoke(Object stub, Object request, Map<String, Object> response, String endpoint,
                            String soapAction, String requestName, String responseNS, String responseName, String responseType) {
            response.put('response_x', '<describeMetadataResponse><result><metadataObjects><xmlName>Profile</xmlName></metadataObjects><metadataObjects><xmlName>SecuritySettings</xmlName></metadataObjects></result></describeMetadataResponse>');
        }
    }
}
