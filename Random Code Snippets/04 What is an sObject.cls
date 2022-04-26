// Code from Slide. First example shows standard Account sObject
Account acctToAdd = new Account(name = 'Feldman Associates');
insert acctToAdd;

// Second example shows custom Course_Delivery__c sObject
public void updateLocation(List<Course_Delivery__c> deliveriesToCheck){
    List<Course_Delivery__c> deliveriesToUpdate = new List<Course_Delivery__c>();
    for (Course_Delivery__c delivery: deliveriesToCheck) {
        if (delivery.location__c == 'Tokyo') {
            delivery.region__c = 'JAPA';
            deliveriesToUpdate.add(delivery);
        }
    }
    update deliveriesToUpdate;
}    

// sObject superclass example
sObject anObject = new Account();
Account anAccount = (Account)anObject; // an Account record is an sObject
Course__c aCourse = new Course__c();  // a Course record is an sObject
sObject[] allObjects = new List<sObject> {anObject, anAccount, aCourse};
System.debug('allObjects' + allObjects);

// DML on sObjects
sObject accsObject = new Account(Name='Account 1');
sObject consObject = new Contact(LastName='Smith');
List<sObject> sObjs = new List<sObject>();
sObjs.add(accsObject);
sObjs.add(consObject);
insert sObjs;

// Output
// 10:14:39:027 USER_DEBUG [5]|DEBUG|allObjects (Account:{}, Account:{}, Course__c:{})

// Same but add name fields
sObject anObject = new Account();
Account anAccount = (Account)anObject; // an Account record is an sObject
anAccount.Name = 'An Account';
Course__c aCourse = new Course__c();  // a Course record is an sObject
aCourse.Name = 'A Course';
sObject[] allObjects = new List<sObject> {anObject, anAccount, aCourse};
System.debug('allObjects' + allObjects);

// Name the superclass
anObject.Name = 'An Object'; // Won't work
anObject.put('Name','An Object'); // sObject class objects have a map of (fieldname, fieldvalue)

// Can even insert a list of sObjects
List<sObject> items = new List<sObject>{
                new Account(Name='FooBar'),
                new Contact(FirstName='Foo',LastName='Bar'),
                new Lead(FirstName='Foo',LastName='Bar',Company='FooBar')
				};
insert items;

// Get all the fields belonging to an sObject
public static Set<String> getAllFields(String sObjectName) {
	if ( Schema.getGlobalDescribe().containsKey(sObjectName) ) 
		return Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap().keySet();
	return null;
}