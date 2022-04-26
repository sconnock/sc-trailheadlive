// Add the class
public class MyTestClass {
    
    //@Future // Asynch is higher (200/600)
    public static void MyTestMethod() {
        List<Account> accounts = [SELECT Name, (SELECT LastName FROM contacts) FROM account];
        System.debug('Found ' + accounts.size() + ' accounts');
        
        Integer contactCount = 0;
        for ( Account account : accounts ) {
            contactCount = contactCount + account.Contacts.size();
        }
        System.debug('Found ' + contactCount + ' contacts');
    }
    
}

// Run from execute anonymous
MyTestClass.MyTestMethod();