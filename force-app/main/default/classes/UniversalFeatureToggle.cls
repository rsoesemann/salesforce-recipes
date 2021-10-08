public with sharing class UniversalFeatureToggle {

    private Integer value = 0;


    // PUBLIC

    public UniversalFeatureToggle enable(List<Integer> featureNumbers) {
        for(Integer feature : featureNumbers) {
            value = value | bitmask(feature);
        }

        return this;
    }


    public UniversalFeatureToggle enable(Integer featureNumber) {
        return enable(new List<Integer>{ featureNumber });
    }

    
    // PUBLIC

    public Boolean isEnabled(Integer featureNumber) {
        Integer bitmask = bitmask(featureNumber - 1);
        return (bitmask  == (value & bitmask));
    }


    public Integer asInteger() {
        return value;

    }

    // PRIVATE

    @TestVisible
    private Integer bitmask(Integer featureNumber) {
        Double result =  Math.pow(Double.valueOf(2), Double.valueOf(featureNumber - 1));
        return Integer.valueOf(result);
    }
}


