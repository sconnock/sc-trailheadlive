// SOSL testing needs a call to the Test.setFixedSearchResults() to work

@IsTest
private class SOSLFixedResultsTest {
	
  @IsTest
  static void testSOSLFixedResults2() {
   	// Setup test data
   	List<Account> accounts = new List<Account>();
   	accounts.add(new Account(Name='Account Test 1',NumberOfEmployees=10));
   	accounts.add(new Account(Name='Account Test 2',NumberOfEmployees=10));
   	accounts.add(new Account(Name='Account Test 3',NumberOfEmployees=20));
   	insert accounts;

   	List<Id> Ids = new List<Id>();
   	for (Account account : accounts) {
   		ids.add(account.Id);
   	}

    Test.setFixedSearchResults(Ids); // Need to do this to get SOSL to work in Test mode

    // Do the SOSL search
    Test.startTest();
   	List<List<SObject>> searchList = [FIND 'anytext' IN ALL FIELDS RETURNING 
                                        Account(id, name, NumberOfEmployees WHERE NumberOfEmployees<=10)];
    Test.stopTest();

    // Validate results
    List<Account> foundAccounts = searchList[0];
    System.assertEquals(2,foundAccounts.size(),'Expected 2 records');
  }
}