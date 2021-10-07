public with sharing class EnabledFeatures {

    private Integer value = 0;

    // CTORS

    public EnabledFeatures() {
        this(new List<Integer>());
    }


    public EnabledFeatures(List<Integer> featureNumbers) {
        for(Integer feature : featureNumbers) {
            value = value | bitmask(feature);
        }
    }


    // PUBLIC

    public Integer bitmask(Integer featureNumber) {
        Double result =  Math.pow(Double.valueOf(2), Double.valueOf(featureNumber - 1));
        return Integer.valueOf(result);
    }


    public Boolean includesFeature(Integer featureNumber) {
        Integer bitmask = bitmask(featureNumber - 1);
        return (bitmask  == (value & bitmask));
    }


    public Integer asInteger() {
        return value;

    }
}


