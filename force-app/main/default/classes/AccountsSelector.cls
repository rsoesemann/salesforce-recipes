public class AccountsSelector extends fflib_SObjectSelector {
	
	public List<Schema.SObjectField> getSObjectFieldList() {
		return new List<Schema.SObjectField> {
			Account.Id,
			Account.Name,
			Account.Description
		};
	}


	public Schema.SObjectType getSObjectType() {
		return Account.sObjectType;
	}


	public List<Account> byId(Set<Id> ids){
		return (List<Account>) selectSObjectsById(ids);
	}
}