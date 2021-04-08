public class TestsSelector extends fflib_SObjectSelector {
	
	public List<Schema.SObjectField> getSObjectFieldList() {
		return new List<Schema.SObjectField> {
			Test__c.Id,
			Test__c.Name,
			Test__c.Type__c,
			Test__c.AcceptanceCriteria__c,
            Test__c.txl_Payload__c,
			Test__c.pkl_Status__c
		};
	}


	public Schema.SObjectType getSObjectType() {
		return Test__c.sObjectType;
	}


	public List<Test__c> byId(Set<Id> ids){
		return (List<Test__c>) selectSObjectsById(ids);
	}
}