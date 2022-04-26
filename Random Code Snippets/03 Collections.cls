// Lists - An ordered, indexed collection of elements
List<Account> accounts = new List<Account>();
accounts.add(new Account(name='Account 1'));
accounts.add(new Account(name='Account 2'));
accounts.add(new Account(name='Account 1'));
System.debug('First account is ' + accounts.get(0));
System.debug('Second account is ' + accounts[1]); 

// Sets - An unordered collection of elements that does not contain duplicates
Set<String> names = new Set<String>();
names.add('Acme');
names.add('Salesforce');
names.add('Salesforce');
System.debug('Does the set contain Pardot? ' + names.contains('Pardot'));
System.debug('The size of the set is: ' + names.size()); 

// Maps - A collection of key value pairs where each unique key maps to a single value
Map<String, Integer> counts= new Map<String, Integer>();
counts.put('Acme', 200);
counts.put('Salesforce', 400);
counts.put('NewCorp', 200);
counts.put('Acme', 600);
System.debug('The size of the map is: ' + counts.size());
System.debug('The count for Acme is ' + 
			(counts.containsKey('Acme') ? counts.get('Acme') : 0));
// The two sides of the ":" must match type
//System.debug('The count for Acme is ' + 
//	(counts.containsKey('Acme') ? String.valueof(counts.get('Acme')) : 'Not available'));

// NOTE: Map keys of type String are case-sensitive.

// Collection Methods

// add		Adds an element e to the end of the list. For example:
List<Integer> myList = new List<Integer>();
myList.add(47);
Integer myNumber = myList.get(0);
system.assertEquals(myNumber, 47);

List<Integer> myList = new Integer[6];
myList.add(0, 47);
myList.add(1, 52);
system.assertEquals(myList.get(1),52);

// addAll	Adds all of the elements in a set or list to the list that calls the method. 
//			Note that both lists (or set) must be of the same type.
//
// clear	Removes all elements from a list, consequently setting the list's length to zero
//
// clone 	Makes a duplicate copy of a list. Note that if this is a list of sObject records, 
//			the duplicate list will only be a shallow copy of the list.
//			That is, the duplicate will have references to each object, but the sObject
//			records themselves will not be duplicated. For example:
Account a = new Account(Name='Acme', BillingCity='New York');
Account b = new Account();
Account[] q1 = new Account[]{a,b};
Account[] q2 = q1.clone();
q1[0].BillingCity = 'San Francisco';
System.assertEquals(q1[0].BillingCity,'San Francisco');
System.assertEquals(q2[0].BillingCity,'San Francisco');

// deepClone	Makes a duplicate copy of a list of sObject records, including the sObject
//				records themselves. For example:
Account a = new Account(Name='Acme', BillingCity='New York');
Account b = new Account(Name='Salesforce');
Account[] q1 = new Account[]{a,b};
Account[] q2 = q1.deepClone();
q1[0].BillingCity = 'San Francisco';
System.assertEquals(q1[0].BillingCity,'San Francisco');
System.assertEquals(q2[0].BillingCity,'New York');

//				Note: deepClone only works with lists of sObjects, not with lists of primitives.
//				The optional opt_preserve_id argument determines whether the IDs of the original 
//				objects are preserved or cleared in the duplicates. If set to true, the IDs are 
//				copied to the cloned objects. The default is false, that is, the IDs are cleared.
//				Note: For Apex saved using Salesforce API version 22.0 or earlier, the default 
//				value for the opt_preserve_id argument is true, that is, the IDs are preserved.
//
//				The optional opt_preserve_readonly_timestamps argument determines whether the
//				read-only timestamp and user ID fields are preserved or cleared in the duplicates.
//				If set to true, the read-only fields CreatedById, CreatedDate, LastModifiedById, 
//				and LastModifiedDate are copied to the cloned objects. The default is false, that is, 
//				the values are cleared.
//
//				The optional opt_preserve_autonumber argument determines whether the autonumber fields
//				of the original objects are preserved or cleared in the duplicates. If set to true, 
//				auto number fields are copied to the cloned objects. The default is false, that is, 
//				auto number fields are cleared.This example is based on the previous example and shows 
//				how to clone a list with preserved read-only timestamp and user ID fields.
insert q1;
List<Account> accts = [SELECT CreatedById, CreatedDate, LastModifiedById, LastModifiedDate, BillingCity 
						FROM Account WHERE Name='Acme' OR Name='Salesforce'];
// 				Clone list while preserving	timestamp and user ID fields.
Account[] q3 = accts.deepClone(false,true,false);
// 				Verify timestamp fields are preserved for the first list element.
System.assertEquals(q3[0].CreatedById, accts[0].CreatedById); 
System.assertEquals(q3[0].CreatedDate, accts[0].CreatedDate); 
System.assertEquals(q3[0].LastModifiedById, accts[0].LastModifiedById);
System.assertEquals(q3[0].LastModifiedDate,accts[0].LastModifiedDate);

//				To make a shallow copy of a list without duplicating the sObject records it 
//				contains, use the clone method.

// get 		Returns the list element stored at index i. For example,
List<Integer> myList = new List<Integer>();
myList.add(47);
Integer myNumber = myList.get(0);
system.assertEquals(myNumber, 47);

// 			Also possible:
List<String> colors = new String[3];
colors[0] = 'Red';
colors[1] = 'Blue';
colors[2] = 'Green';

getSObjectType Schema.SObjectType
//			Returns the token of the sObject type that makes up a list of sObjects. 
//			Use this with describe information to determine if a list contains sObjects 
//			of a particular type. For example:

Account a = new
Account(name='test');
insert a;
// 			Create a generic sObject variable s
SObject s = Database.query('SELECT Id FROM Account ' + 'LIMIT 1');
// 			Verify if that sObject variable is an Account token
System.assertEquals(s.getSObjectType(), Account.sObjectType);

// 			Create a list of generic sObjects
List<sObject> q = new Account[]{};

// 			Verify if the list of sObjects contains Account tokens
System.assertEquals(q.getSObjectType(),Account.sObjectType);


// isEmpty 	Boolean Returns true if the list has zero elements

// remove	Removes the element that was stored at the ith index of a list, 
//			returning the element that was removed. For example:
List<String> colors = new String[3];
colors[0] = 'Red';
colors[1] = 'Blue';
colors[2] = 'Green';
String S1 = colors.remove(2);
system.assertEquals(S1, 'Green');

// set		Assigns e to the position at list index i. For example:
List<Integer> myList = new Integer[6];
myList.set(0, 47);
myList.set(1, 52);
system.assertEquals(myList.get(1),52);

//			To set an element of a one-dimensional list of primitives or 
//			sObjects, you can also follow the name of the list with the 
//			element's index position in square brackets. For example:
List<String> colors = new String[3];
colors[0] = 'Red';
colors[1] = 'Blue';
colors[2] = 'Green';

// size		Returns the number of elements in the list. For example:
List<Integer> myList = new List<Integer>();
Integer size = myList.size();
system.assertEquals(size, 0);
List<Integer> myList2 = new Integer[6];
Integer size2 = myList2.size();
system.assertEquals(size2, 6);

// sort		Sorts the items in the list in ascending order. You can only use this
//          method with lists composed of primitive data types. In the following 
//          example, the list has three elements. When the list is sorted, the first
//          element is null because it has no value assigned while the second element
//          has the value of 5:

List<Integer> q1 = new Integer[3];
// 			Assign values to the first two elements
q1[0] = 10;
q1[1] = 5;
q1.sort();
// 			First element is null, second is 5
system.assertEquals(q1.get(1), 5);


// add		Adds an element to the set if it is not already present
// addAll	Set OR List	Adds all of the elements in the specified set/list to the set if they are not already present. 
//          This method results in the union of the list and the set/list. The set/list must be of the same type as the
//          set that calls the method. This method returns true if the original set changed as a result of the call.
set<string> myString = new Set<String>{'a', 'b'};
set<string> sString = new Set<String>{'c'};
Boolean result1;
result1 = myString.addAll(sString);
system.assertEquals(result1, true);

// contains Returns true if the set contains the specified element.
Boolean result;
result = myString.contains('z');
system.assertEquals(result, false);

set<string> myString = new Set<String>{'a', 'b'};
Boolean result;
result = myString.contains('z');
system.assertEquals(result, false);

// containsAll	Set OR List	Returns true if the set contains all of the elements in the specified set/list. 
//              The set/list must be of the same type as the set that calls the method.
set<string> rString = new Set<String>{'a', 'b', 'c'};
Boolean result2;
result2 = myString.containsAll(rString);
system.assertEquals(result2, true);

set<string> myString =
new Set<String>{'a', 'b'};
set<string> sString =
new Set<String>{'c'};
set<string> rString = new Set<String>{'a', 'b', 'c'};
Boolean result1, result2;
result1 = myString.addAll(sString);
system.assertEquals(result1, true);
result2 = myString.containsAll(rString);
system.assertEquals(result2, true);

// clear	Removes all of the elements from the set

// isEmpty	Returns true if the set has zero elements. For example:
Set<integer> mySet = new Set<integer>();
Boolean result;
result = mySet.isEmpty();
system.assertEquals(result, true);

// remove		Removes the specified element from the set if it is present. This method returns true if the 
//              original set changed as a result of the call.Returns true if the set contains the specified element.
// removeAll 	List or Set	Removes the elements in the specified list/set from the set if they are present. 
//              This method results in the relative complement of the two sets. The list/set must be of the same 
//              type as the set that calls the method. This method returns true if the original set changed
//              as a result of the call. For example:
Set<integer> mySet = new Set<integer>{1, 2, 3};
List<integer> myList = new List<integer>{1, 3};
Boolean result = mySet.removeAll(myList);
System.assertEquals(result, true);
Integer result2 = mySet.size();
System.assertEquals(result2, 1);

// retainAll 	List or Set	Retains only the elements in this set that are contained in the specified list/set. 
//              This method results in the intersection of the list/set and the set. The list/set must be of the
//              same type as the set that calls the method. This method returns true if the original set changed
//              as a result of the call. For example:
Set<integer> mySet = new Set<integer>{1, 2, 3};
List<integer> myList = new List<integer>{1, 3};
Boolean result = mySet.retainAll(myList);
System.assertEquals(result, true);

// size()		Returns the number of elements in the set (its cardinality). For example:
Set<integer> mySet = new Set<integer>{1, 2, 3};
List<integer> myList = new List<integer>{1, 3};
Boolean result = mySet.retainAll(myList);
System.assertEquals(result, true);
Integer result2 = mySet.size();
System.assertEquals(result2, 2);