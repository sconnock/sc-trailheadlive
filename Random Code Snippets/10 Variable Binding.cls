Account A = new Account(Name='xxx');
insert A;
Account B;

// A simple bind
B = [SELECT Id FROM Account WHERE Id = :A.Id];

// A bind with arithmetic
B = [SELECT Id FROM Account
		WHERE Name = :('x' + 'xx')];

String str1 = 'A';
String str2 = 'CME';
List<Account> acc = [SELECT Id FROM Account WHERE Name = :(str1 + str2)];
System.debug(acc.size());

String s = 'XXX';

// A bind with expressions
B = [SELECT Id FROM Account
			WHERE Name = :'XXXX'.substring(0,3)];

// A bind with an expression that is itself a query result
B = [SELECT Id FROM Account
		WHERE Name = :[SELECT Name FROM Account
				WHERE Id = :A.Id].Name];

Contact C = new Contact(LastName='xxx', AccountId=A.Id);
insert new Contact[]{C, new Contact(LastName='yyy', accountId=A.id)};

// Binds in both the parent and aggregate queries
B = [SELECT Id, (SELECT Id FROM Contacts WHERE Id = :C.Id)
				FROM Account
				WHERE Id = :A.Id];
// One contact returned
Contact D = B.Contacts;

// A limit bind
Integer i = 1;
B = [SELECT Id FROM Account LIMIT :i];

// An IN-bind with an Id list. Note that a list of sObjects
// can also be used--the Ids of the objects are used for
// the bind
Contact[] cc = [SELECT Id FROM Contact LIMIT 2];
Task[] tt = [SELECT Id FROM Task WHERE WhoId IN :cc];


// An IN-bind with a String list
String[] ss = new String[]{'a', 'b'};
Account[] aa = [SELECT Id FROM Account WHERE AccountNumber IN :ss];

// Even works with LIKE
Set<String> emails = new Set<String>{'first.last1%','first.last2%'};
List<User> users = [SELECT Id, Email FROM User WHERE Email like :emails];

// Apex bind variables aren’t supported for the units parameter in 
// DISTANCE or GEOLOCATION functions. This query doesn’t work.
String units = 'mi';
List<Account> accountList = [SELECT ID, Name, BillingLatitude, BillingLongitude FROM Account
        	     WHERE DISTANCE(My_Location_Field__c, GEOLOCATION(10,10), :units) < 10];