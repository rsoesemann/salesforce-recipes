@IsTest
private class ActivateAccounts_Test {

    @IsTest
    private static void failsWithException() {

        // Setup
        Exception expectedException = null;

        Account acc = (Account) new Account_t()
                                        .name('Acme Corp')
                                        .add( new Contact_t().first('Ron').last('Harris') )
                                        .persist();

        // Exercise
        try {
            new ActivateAccounts(acc).execute();
        }
        catch(ApplicationException ex) {
            expectedException = ex;
        }


        // Verify
        System.assertNotEquals(null, expectedException);
    }
}