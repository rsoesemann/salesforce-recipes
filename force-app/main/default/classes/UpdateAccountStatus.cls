public with sharing class UpdateAccountStatus {

    // PUBLIC

    public void execute(List<Opportunity> records) {
        List<Account> accounts = new AccountsSelector().byOpportunities(records);

        for(Account account : accounts) {
            String state = null;
            // ..
            account.BillingState = state;
        }

        update accounts;
    }
}