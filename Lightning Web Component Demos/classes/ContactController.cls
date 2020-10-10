public with sharing class ContactController {

	@AuraEnabled(cacheable=true)
    public static List<Contact> getContactsForAccount(String accountName) {
		List<Contact> contacts = new List<Contact>();

		try {
			contacts = [SELECT Id, FirstName, LastName, Email FROM Contact 
			            WHERE Account.Name = :accountName WITH SECURITY_ENFORCED ORDER BY FirstName ASC];
		}
		catch (QueryException e) {
			throw new SecurityException('You don\'t have the access required');
		}

		return contacts;
    }
}