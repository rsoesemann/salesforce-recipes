public with sharing class Accounts extends fflib_SObjectDomain {

    // CONSTRUCTOR

    public Accounts(List<Account> records) {
        super(records);
    }

    // PUBLIC
    
    public void wrong_Name() {
        System.debug('Here');
        for(Integer i=0; i<2; i++) {
         Account a = [SELECT Id FROM Account];
        }
    }

    public override void onBeforeUpdate(Map<Id, SObject> old) {
        new ActivateAccounts(records).execute();
    }


    // INNER

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> records) {
            return new Accounts(records);
        }
    }
}
