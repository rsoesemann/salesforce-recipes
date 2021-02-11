public with sharing class ActivateAccountCtrl {

    public String serializedAccountIds { get; private set; }
    private Set<Id> accountIds = new Set<Id>();

    // CONSTRUCTORS

    public ActivateAccountCtrl(ApexPages.StandardController ctrl) {
        accountIds = new Set<Id>{ ctrl.getId() };
        serializedAccountIds = JSON.serialize(accountIds);
    }


    public ActivateAccountCtrl(ApexPages.StandardSetController ctrl) {
        List<Account> records = ctrl.getSelected();
        if(records.isEmpty()) {
            records = ctrl.getRecords();
        }

        accountIds = new Map<Id, Account>(records).keySet();
        serializedAccountIds = JSON.serialize(accountIds);
    }


    // PUBLIC

    public PageReference redirectToList() {
        return new ApexPages.Action('{!List}').invoke();
    }


    public void fromVisualforce() {
        try {
            new ActivateAccounts(accountIds).execute();
        }
        catch(Exception ex) {
            ApexPages.addMessages(ex);
        }
    }


    @AuraEnabled
    public static void fromAura(Id accountId) {
        try {
            new ActivateAccounts(new Set<Id>{ accountId }).execute();
        }
        catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }


    @AuraEnabled
    public static List<Account> query(List<Id> accountIds) {
        try {
            return new AccountsSelector().byId( new Set<Id>(accountIds) );
        }
        catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }


    @InvocableMethod(label='Activate Account' description='Method description' category='Account')
    public static List<String> fromFlow(List<Id> accountIds) {
        new ActivateAccounts( new Set<Id>(accountIds) ).execute();
        return new List<String>();
    }
}