// SELECT Id, LastName, LeadSource FROM Contact WHERE LeadSource ='Trade Show'

List<Contact> oldLeadSourceContacts = 
    [SELECT LeadSource FROM Contact WHERE LeadSource ='Trade Show'];

Set<Id> oldLeadSourceContactsIds = new Set<Id>(); 
for (Contact c : oldLeadSourceContacts) {
    c.LeadSource = 'Other';
    oldLeadSourceContactsIds.add(c.Id);
}

update oldLeadSourceContacts;

List<Contact> updatedLeadSourceContacts = 
    [SELECT LeadSource FROM Contact WHERE Id IN :oldLeadSourceContactsIds];
for (Contact c : updatedLeadSourceContacts) {
    if (c.LeadSource <> 'Other')
        System.debug('Update failed');
}


// Upserting using an external ID. First add a record (using dummy Sample object)
Sample__c sample = new Sample__c();
sample.Name = 'My Sample';
sample.Description__c = 'My Sample description';
sample.External_Identifier__c = 'SAMP1';
insert sample;

// Then modify it
Sample__c samp = new Sample__c();
samp.Description__c = 'Modified description';
samp.External_Identifier__c = 'SAMP1';

// either
upsert samp External_Identifier__c;

// or
Schema.SObjectField extID = Sample__c.Fields.External_Identifier__c;
database.upsert(samp, extId);
//database.upsert(samp, extId, true); // Optionally can add the AllOrNone boolean on the end

// Selecting from the recycle bin - delete previously added sample__c record
// Need to use ALL ROWS to see stuff in recycle bin BUT Query will not parse when run from query editor
SELECT Id, Name, IsDeleted FROM Sample__c WHERE IsDeleted = true ALL ROWS

// Only works from code
List<Sample__c> samps = [SELECT Id FROM Sample__c WHERE IsDeleted = true ALL ROWS];
system.debug(samps);
undelete samps;

// Crafty trick to load related data
//
// Also, you can populate map key-value pairs when the map is declared by using curly brace ({}) syntax. 
// Within the curly braces, specify the key first, then specify the value for that key using =>. For example:
Map<String, Account> accounts = new Map<String, Account>{
    'Account 1' => new Account(Name = 'Account 1'),
    'Account 2' => new Account(Name = 'Account 2'),
	'Account 3' => new Account(Name = 'Account 3')
    };
insert accounts.values();

Map<String, Contact> contacts = new Map<String, Contact>{
	'Kurebayashi' => new Contact(FirstName = 'Mariko', LastName = 'Kurebayashi', AccountId = accounts.get('Account 1').Id),
	'Matsumura' => new Contact(FirstName = 'Seiya', LastName = 'Matsumura', AccountId = accounts.get('Account 1').Id),
	'Sakai' => new Contact(FirstName = 'Yuki', LastName = 'Sakai', AccountId = accounts.get('Account 2').Id),
	'Morales' => new Contact(FirstName = 'Clara', LastName = 'Morales', AccountId = accounts.get('Account 2').Id),
	'Moreau' => new Contact(FirstName = 'Leo', LastName = 'Moreau', AccountId = accounts.get('Account 3').Id)
	};
insert contacts.values();

