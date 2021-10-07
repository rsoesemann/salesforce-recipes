@IsTest
private class EnabledFeatures_Test {

    @IsTest
    private static void asBitmask() {

        // Setup
        EnabledFeatures enabled = new EnabledFeatures();

        // Exercise & Verify
        System.assertEquals(1, enabled.bitmask(1));
        System.assertEquals(2, enabled.bitmask(2));
        System.assertEquals(4, enabled.bitmask(3));
        System.assertEquals(8, enabled.bitmask(4));
        System.assertEquals(1073741824, enabled.bitmask(31));
    }


    @IsTest
    private static void asInteger() {
        System.assertEquals(1, new EnabledFeatures(new List<Integer>{ 1, 2}).asInteger());

    }


    @IsTest
    private static void includesFeature() {

        // Setup
        EnabledFeatures enabled 
            = new EnabledFeatures(new List<Integer>{ 1, 3, 6 });

        // Verify
        System.assert(enabled.includesFeature(1));
        System.assert(enabled.includesFeature(3));
        System.assert(enabled.includesFeature(6));
        System.assert( !enabled.includesFeature(2));
        System.assert( !enabled.includesFeature(31));
    }
}
