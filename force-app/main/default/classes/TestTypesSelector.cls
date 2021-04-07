public with sharing class TestTypesSelector extends fflib_SObjectSelector {

    public Schema.SObjectType getSObjectType() {
        return TestType__mdt.SObjectType;
    }


    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            TestType__mdt.Id,
            TestType__mdt.DeveloperName,
            TestType__mdt.Label,
            TestType__mdt.RunOn__c,
            TestType__mdt.UiComponent__c
        };
    }


    public List<TestType__mdt> byName(String developerName) {
        return (List<TestType__mdt>) Database.query( newQueryFactory()
                                    .setCondition('DeveloperName = :developerName')
                                    .toSOQL() );
    }
}