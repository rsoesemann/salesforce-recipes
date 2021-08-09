@IsTest
private class MetadataSchema_Test {

    private static Integer noCacheDuration = null;


    @IsTest
    private static void showsOnlyTopLevelTypes() {

        // Setup
        initCache();


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
        initCache();


        // Exercise
        List<MetadataSchema.Property> properties = new MetadataSchema().properties('Profile');


        // Verify
        System.assert(properties.contains(new MetadataSchema.Property('loginIpRanges')));
        System.assert(properties.contains(new MetadataSchema.Property('userPermissions')));
    }
   

    @IsTest
    private static void isCachedOnSecondLoad() {

        // Setup
        initCache();


        // Exercise
        Datetime before = Datetime.now();
        new MetadataSchema();
        Integer withCacheDuration = elapsedSecsSince(before);


        // Verify
        System.assert(noCacheDuration > withCacheDuration, 'No Cache: ' + noCacheDuration + ' <-> ' + 'With Cache: ' + withCacheDuration);
    }


    // HELPER

    private static void initCache() {
        Test.setMock(WebServiceMock.class, new MdApiMock()
                                                .with('Profile')
                                                .with('SecuritySettings'));
        Datetime before = Datetime.now();
        new MetadataSchema();
        noCacheDuration = elapsedSecsSince(before);
    }


    private static Integer elapsedSecsSince(Datetime start) {
        return Integer.valueOf((System.now().getTime() - start.getTime()) / 1000);
    }


    public class MdApiMock implements WebServiceMock {
        
        private MetadataService.describeMetadataResponse_element element;

        private MdApiMock() {
            element = new MetadataService.describeMetadataResponse_element();
            element.result = new MetadataService.DescribeMetadataResult();
            element.result.metadataObjects = new List<MetadataService.DescribeMetadataObject>();
        }

        private MdApiMock with(String xmlName) {
            MetadataService.DescribeMetadataObject type = new MetadataService.DescribeMetadataObject();
            type.xmlName = xmlName;
            element.result.metadataObjects.add(type);
            return this;
        }

        public void doInvoke(Object stub, Object request, Map<String, Object> response, String endpoint,
                            String soapAction, String requestName, String responseNS, String responseName, String responseType) {
            
            response.put('response_x', response.put('response_x', element));
        }
    }
}