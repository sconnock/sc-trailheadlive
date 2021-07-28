@IsTest
private class AccountTrigger_Test {

    private static final Integer RECORDCOUNT = 1000;

    // Rating>1,000,000=Hot, Rating>100,000=Warm, otherise Cold
    private static final Double REVENUE = 500000.0;
    private static final String RATING = 'Warm';
    
    @IsTest(seeAllData=true)
    private static void testSwitchSetting() {
        
        // Load test data
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<RECORDCOUNT; i++) {
            Account a = new Account();
            a.Name = 'Test Account ' + i;
            a.AnnualRevenue = REVENUE;
            accounts.add(a);
        }
         
        // Do the test (insert the Account records)
        Test.startTest();
        
        insert accounts;
        
        Test.stopTest();
        
        // Check results
        List<Account> insertedAccounts = [SELECT Id, Name, AnnualRevenue, Rating FROM Account
                                          WHERE Rating=:RATING AND Name LIKE 'Test%'];
        System.assertEquals(RECORDCOUNT, insertedAccounts.size(),'ERROR: Some accounts not ' + RATING);
    }
}