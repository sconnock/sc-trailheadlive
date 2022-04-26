Account[] accounts = [ SELECT Name, BillingCountry FROM Account 
      					WHERE NOT(BillingCountry Like 'Can%') ];
for (Account currentAccount : accounts) {
    System.debug('Billing Country: ' + currentAccount.BillingCountry + 
                 ' ::: Name: ' + currentAccount.Name);
}

// Other Examples

SELECT FirstName, LastName FROM Contact WHERE FirstName != null

SELECT FirstName, LastName FROM Contact WHERE LastName != 'Jones'

SELECT Name, Amount, StageName, leadSource FROM Opportunity WHERE Amount <= 20000

SELECT Name, Amount FROM Opportunity WHERE Amount > 1000 AND Amount < 100000

SELECT Name, Amount, Account.Name FROM Opportunity WHERE Name LIKE 'Acm%'

SELECT FirstName, LastName FROM Contact WHERE FirstName IN ('Edward', 'Leanne', 'Marc')

SELECT FirstName, LastName FROM Contact WHERE FirstName NOT IN ('Edward', 'Leanne', 'Marc')

SELECT Name, Industry FROM Account WHERE Name = 'Acme' OR Name = 'Global Media'

SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE MarketRegion__c INCLUDES ('Asia', 'Africa')
//Note that MarketRegion__C must be a multi-picklist
//Also works with EXCLUDES

SELECT Id FROM Employee__c WHERE Joining_Date__c = YESTERDAY

SELECT Id FROM Employee__c WHERE Joining_Date__c = NEXT_MONTH

SELECT Id FROM Employee__c WHERE Joining_Date__c > NEXT_N_DAYS:15

SELECT Id FROM Employee__c WHERE Joining_Date__c = LAST_N_DAYS:15

SELECT Id FROM Employee__c WHERE Joining_Date__c = N_DAYS_AGO:15

SELECT Id FROM Employee__c WHERE Joining_Date__c < NEXT_QUARTER

SELECT Title FROM Position__c WHERE CALENDAR_MONTH(Date_Closed__c) = 2;  // February

SELECT Id FROM Employee__c WHERE BirthDate = 1999-01-30  // No quotes and format is YYYY-MM-DD

SELECT Id FROM Position__c WHERE ClosedDate > 2005-10-08T10:15:03-08:00  // DateTime (offset for SF)

SELECT Id FROM Position__c WHERE IsClosed = TRUE // Boolean (again no quotes)

// No NOT LIKE but can do this
SELECT Id, Type, RecordTypeId, Status, Subject, Priority, 
       IsClosed, ClosedDate, CreatedDate, Product_Category__c
    FROM Case 
	WHERE NOT (Subject LIKE '%printer%')