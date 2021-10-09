@IsTest
private class UniversalFeatureToggle_Test {

    private static UniversalFeatureToggle.Feature feature = UniversalFeatureToggle.Feature.UNUSED_6;
    private static UniversalFeatureToggle.Feature otherFeature = UniversalFeatureToggle.Feature.UNUSED_7;


    @IsTest
    private static void isDisabled() {

        // Setup & Exercise
        UniversalFeatureToggle toggle = new UniversalFeatureToggle()
                                                    .enable(feature)
                                                    .toggle(feature)
                                                    .disable(otherFeature)
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
                                                    .enable(otherFeature)
                                                    .disable(feature)
                                                    .toggle(feature);
        // Verify
        System.assert(toggle.isEnabled(feature));
        System.assert(toggle.isEnabled(otherFeature));
    }
}
