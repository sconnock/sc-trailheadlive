@isTest
private class MyClass_Test {
    @testSetup
    private static void testDataSetup() {
        Profile p = // Write a query to select a profile
        User u = new User(Lastname = 'Foo', ProfileId = p.id);
        insert u;
    }
      
    private static testMethod void myClassTestUser() {
        User testUser = // Find Foo, who has set up above
        System.runAs(testUser) {
        // Now, the rest of test runs as testUser.
        // Otherwise the test would run as System.
       }
    }
) 


// See also http://developer.force.com/cookbook/recipe/using-system-runas-in-test-methods

@IsTest
public class TestRunAs {
    
    @testSetup
    public static void setData() {
        // This code runs as system user
        System.debug('Current User: ' + UserInfo.getUserName());
       	Profile p = [SELECT Id, Name FROM Profile WHERE Name='Standard User'];
        System.debug('p: ' + p);
        List<User> users = new List<User>();
        users.add(new User(Alias = 'stand0', 
                           Email='standarduser0@testorg.com',
                           EmailEncodingKey='UTF-8', 
                           LastName='Testing0',   
                           LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', 
                           ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles',  
                           UserName='standuser0@testorg0.com'));
		    users.add(new User(Alias = 'stand1', 
                           Email='standarduser1@testorg.com',
                           EmailEncodingKey='UTF-8', 
                           LastName='Testing1',   
                           LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', 
                           ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles',  
                           UserName='standuser1@testorg1.com'));
		    users.add(new User(Alias = 'stand2', 
                           Email='standarduser2@testorg.com',
                           EmailEncodingKey='UTF-8', 
                           LastName='Testing2',   
                           LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', 
                           ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles',  
                           UserName='standuser2@testorg2.com'));
        insert users;
        
        // This code runs as user2
        System.RunAs(users[2]) {
            System.debug('Current User: ' + UserInfo.getUserName());
		        System.debug('Current Profile: ' + UserInfo.getProfileId());
            System.debug('Current User ID: ' + UserInfo.getUserId());
            Account acc = new Account(Name='Acc1');
            insert acc;
        }
    }

	public static testMethod void testRunAs() {
        
      List<Account> accs = [SELECT Name, OwnerId FROM Account];
      List<User> users = [SELECT Name FROM User WHERE UserName IN ('standuser0@testorg0.com',
                                                             'standuser1@testorg1.com',
                                                             'standuser2@testorg2.com')];
      system.debug('Accounts ' + accs); // Account owned by User 2
      system.debug('Users ' + users);

      System.runAs(users[0]) {
        // The following code runs as user0.
        System.debug('Current User: ' + UserInfo.getUserName());
        System.debug('Current Profile: ' + UserInfo.getProfileId());

        // The following code runs as user1.
        System.runAs(users[1]) {
          System.debug('Current User: ' + UserInfo.getUserName());
          System.debug('Current Profile: ' + UserInfo.getProfileId());
        }
        // Any additional code here would run as user u0.
      }
    }
}