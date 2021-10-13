@IsTest
private class UniversalFeatureToggle_Test {

    private static UniversalFeatureToggle.Feature feature = UniversalFeatureToggle.Feature.UNUSED_6;
    private static UniversalFeatureToggle.Feature otherFeature = UniversalFeatureToggle.Feature.UNUSED_7;


    @IsTest
    private static void enable() {

        // Setup 
        UniversalFeatureToggle toggle = new UniversalFeatureToggle();
        System.assert(toggle.isDisabled(feature));


        // Exercise & Verify
        toggle.enable(feature);
        System.assert(toggle.isEnabled(feature));
        toggle.enable(feature);
        System.assert(toggle.isEnabled(feature));
    }


    @IsTest
    private static void disable() {

        // Setup 
        UniversalFeatureToggle toggle = new UniversalFeatureToggle().enable(feature);
        System.assert(toggle.isEnabled(feature));


        // Exercise & Verify
        toggle.disable(feature);
        System.assert(toggle.isDisabled(feature));
        toggle.disable(feature);
        System.assert(toggle.isDisabled(feature));
    }


    @IsTest
    private static void isDisabled() {

        // Setup & Exercise
        UniversalFeatureToggle toggle = new UniversalFeatureToggle()
                                                    .disable(feature)
                                                    .enable(feature)
                                                    .toggle(feature)

                                                    .disable(otherFeature);
        // Verify
        System.assert(toggle.isDisabled(feature));
        System.assert(toggle.isDisabled(otherFeature));
    }


    @IsTest
    private static void isEnabled() {

        // Setup & Exercise
        UniversalFeatureToggle toggle = new UniversalFeatureToggle()
                                                    .enable(feature)
                                                    .disable(feature)
                                                    .toggle(feature)

                                                    .enable(otherFeature);
        // Verify
        System.assert(toggle.isEnabled(feature));
        System.assert(toggle.isEnabled(otherFeature));
    }


    @IsTest
    private static void fmaValue() {

        // Setup & Exercise & Verify
        UniversalFeatureToggle toggle = new UniversalFeatureToggle()  
                                                    .enable(UniversalFeatureToggle.Feature.UNUSED_2)
                                                    .enable(UniversalFeatureToggle.Feature.UNUSED_4)
                                                    .enable(UniversalFeatureToggle.Feature.UNUSED_6);
        System.assertEquals(42, toggle.fmaValue()); // 101010

        toggle.disable(UniversalFeatureToggle.Feature.UNUSED_2);
        System.assertEquals(40, toggle.fmaValue()); // 101000
    }


    @IsTest
    private static void maxValueOfFmaValue() {

        // Setup & Exercise
        UniversalFeatureToggle toggle = new UniversalFeatureToggle();
        for(UniversalFeatureToggle.Feature feature : UniversalFeatureToggle.Feature.values()) {
            toggle.enable(feature);
        }


        // Verify
        System.assertEquals(2147483647, toggle.fmaValue()); 
    }
}