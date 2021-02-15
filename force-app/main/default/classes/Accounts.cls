public with sharing class Accounts extends fflib_SObjectDomain {

    // CONSTRUCTOR

    public Accounts(List<Account> records) {
        super(records);
    }


    // PUBLIC

    public override void onValidate(Map<Id, SObject> old) {
        // new VerifyThat(records).useConsitentNaming();
        // new VerifyThat(records).useValidCreditCards();
    }


    public override void onBeforeUpdate(Map<Id, SObject> old) {
        new ActivateAccounts(records).execute();
        // new SynchronizeWithMulesoft(records).execute();
        // new UpdateMergedContacts(records).execute
    }


    // INNER

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> records) {
            return new Accounts(records);
        }
    }
}