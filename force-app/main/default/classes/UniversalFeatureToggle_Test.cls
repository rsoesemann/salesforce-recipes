@IsTest
private class UniversalFeatureToggle_Test {

    @IsTest
    private static void asBitmask() {

        // Setup
        UniversalFeatureToggle toggle = new UniversalFeatureToggle();

        // Exercise & Verify
        System.assertEquals(1, toggle.bitmask(1));
        System.assertEquals(2, toggle.bitmask(2));
        System.assertEquals(4, toggle.bitmask(3));
        System.assertEquals(8, toggle.bitmask(4));
        System.assertEquals(1073741824, toggle.bitmask(31));
    }


    @IsTest
    private static void asInteger() {

        // Setup
        UniversalFeatureToggle toggle 
            = new UniversalFeatureToggle().enable(new List<Integer>{ 1, 2 });


        // Verify
        System.assertEquals(1, toggle.asInteger());

    }


    @IsTest
    private static void isEnabled() {

        // Setup
        UniversalFeatureToggle toggle 
            = new UniversalFeatureToggle().enable(new List<Integer>{ 1, 3, 6 });


        // Verify
        System.assert(toggle.isEnabled(1));
        System.assert(toggle.isEnabled(3));
        System.assert(toggle.isEnabled(6));
        System.assert( !toggle.isEnabled(2));
        System.assert( !toggle.isEnabled(31));
    }
}
