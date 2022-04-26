// Check Object CRUD
System.debug('Create in Object CRED? ' + Schema.sObjectType.Course__c.isCreateable());
System.debug('Read in Object CRUD? ' + Schema.sObjectType.Course__c.isAccessible());
System.debug('Update in Object CRUD? ' + Schema.sObjectType.Course__c.isUpdateable());
System.debug('Delete in Object CRUD? ' + Schema.sObjectType.Course__c.isDeletable());

// Check Field Level Security 
System.debug('Read in FLS? ' + Schema.sObjectType.Course__c.fields.Status__c.isAccessible());
System.debug('Edit in FLS? ' + Schema.sObjectType.Course__c.fields.Status__c.isUpdateable());

// Simple use case
String soqlString;
if (Schema.sObjectType.Course__c.fields.Status__c.isAccessible()) {
     soqlString = 'SELECT id, status__c FROM Course__c';
} else {
     soqlString = 'SELECT id FROM Course__c';
}
System.debug(soqlString);

// Check Record Access
//
// To find out if a particular user has Edit access to a record, use the UserRecordAccess object. 
// You can use SOQL to query this object to find out if the user has edit access to the record in question.

SELECT RecordId, HasEditAccess FROM UserRecordAccess 
   WHERE UserId = [single ID] AND RecordId = [single ID]

// If you want to check a batch of records you can use

SELECT RecordId FROM UserRecordAccess 
   WHERE UserId=:UserInfo.getUserId() AND HasReadAccess = true AND RecordId IN :allRecordIds LIMIT 200

// Make sure that allRecordIds is a LIST of IDs. It doesn't work if allRecordIds is a SET of IDs.
// Also, only a maximum amount of 200 recordIds can be checked in one query.

// Can also query an sObject directly
SELECT Id, Name, UserRecordAccess.HasReadAccess, UserRecordAccess.HasTransferAccess, UserRecordAccess.MaxAccessLevel 
  FROM Account

// For Example
Account acc = new Account(Name='Acc1');
insert acc;

List<UserRecordAccess> userAccess = [SELECT RecordId, HasReadAccess, HasEditAccess 
 									 FROM UserRecordAccess 
    								 WHERE UserId=:UserInfo.getUserId() AND RecordId = :acc.Id];
system.debug(userAccess);

delete acc;