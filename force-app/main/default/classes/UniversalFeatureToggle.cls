public class UniversalFeatureToggle {

    private static final String FMA_FIELD = 'UniversalFeatureToggle__c';
    private Integer fmaValue;
    

    // CONSTRUCTOR

    public UniversalFeatureToggle() {
        fmaValue = (Test.isRunningTest()) ? 0 : FeatureManagement.checkPackageIntegerValue(FMA_FIELD);
    }


    // PUBLIC

    public UniversalFeatureToggle enable(Feature feature) {
        fmaValue |= 1 << feature.ordinal();
        persist();

        return this;
    }


    public UniversalFeatureToggle disable(Feature feature) {
        fmaValue &= ~(1 << feature.ordinal());
        persist();

        return this;
    }


    public UniversalFeatureToggle toggle(Feature feature) {
        fmaValue ^= 1 << feature.ordinal();
        persist();

        return this;
    }


    public Boolean isEnabled(Feature feature) {
        return 0 != (fmaValue & 1 << feature.ordinal());
    }


    public Boolean isDisabled(Feature feature) {
        return !isEnabled(feature);
    }


    public Integer fmaValue() {
        return fmaValue;
    }


    // PRIVATE

    private void persist() {
        if( !Test.isRunningTest()) {
            FeatureManagement.setPackageIntegerValue(FMA_FIELD, fmaValue);
        }
    }


    // INNER

    public enum Feature { 
        TEST_APEX_WITHOUT_V2, // Add User Story Autoname for details
        UNUSED_2, // Add User Story Autoname for details
        UNUSED_3, // Add User Story Autoname for details
        UNUSED_4, // Add User Story Autoname for details
        UNUSED_5, // Add User Story Autoname for details
        UNUSED_6, // Add User Story Autoname for details
        UNUSED_7, // Add User Story Autoname for details
        UNUSED_8, // Add User Story Autoname for details
        UNUSED_9, // Add User Story Autoname for details
        UNUSED_10, // Add User Story Autoname for details
        UNUSED_11, // Add User Story Autoname for details
        UNUSED_12, // Add User Story Autoname for details
        UNUSED_13, // Add User Story Autoname for details
        UNUSED_14, // Add User Story Autoname for details
        UNUSED_15, // Add User Story Autoname for details
        UNUSED_16, // Add User Story Autoname for details
        UNUSED_17, // Add User Story Autoname for details
        UNUSED_18, // Add User Story Autoname for details
        UNUSED_19, // Add User Story Autoname for details
        UNUSED_20, // Add User Story Autoname for details
        UNUSED_21, // Add User Story Autoname for details
        UNUSED_22, // Add User Story Autoname for details
        UNUSED_23, // Add User Story Autoname for details
        UNUSED_24, // Add User Story Autoname for details
        UNUSED_25, // Add User Story Autoname for details
        UNUSED_26, // Add User Story Autoname for details
        UNUSED_27, // Add User Story Autoname for details
        UNUSED_28, // Add User Story Autoname for details
        //.. MAXIMUM 30 VALUES (Positive 32bit Integer)
        UNUSED_29, // Add User Story Autoname for details
        UNUSED_30, // Add User Story Autoname for details
        UNUSED_31 // Add User Story Autoname for details
    }
}