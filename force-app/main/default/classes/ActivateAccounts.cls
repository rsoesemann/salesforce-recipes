public with sharing class ActivateAccounts {
    
    private List<Account> accounts;


    // CONSTRUCTORS

    public ActivateAccounts(List<Account> accounts) {
        this.accounts = accounts;
    }

    public ActivateAccounts(Account account) {
        this(new List<Account>{ account });
    }


    public ActivateAccounts(Set<Id> accountIds) {
        this( new AccountsSelector().byId(accountIds) );
    }


    public ActivateAccounts(Id accountId) {
        this( new Set<Id>{ accountId });
    }


    // PUBLIC

    public void execute() {
        throw new ApplicationException('If you nicely see this in the UI then everything is fine.');
    }
}
