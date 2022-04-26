System.debug('NUMBER OF SOQL QUERIES ISSUED :         ' + Limits.getQueries());

Integer i = [ SELECT Count() FROM Contact ];
System.debug('Counted ' + i + ' Contacts');

System.debug('NUMBER OF SOQL QUERIES ISSUED :         ' + Limits.getQueries());
System.debug('NUMBER OF SOQL QUERIES ALLOWED PER TX : ' + Limits.getLimitQueries());
System.debug('NUMBER OF QUERIED ROWS :                ' + Limits.getQueryRows());
System.debug('NUMBER OF QUERIED ROWS ALLOWS PER TX :  ' + Limits.getLimitQueryRows());

// Code Defensively
Integer queryRowsRemaining = Limits.getLimitQueryRows() - Limits.getQueryRows();
List<Course_Attendee__c> courseAttendees = [SELECT ID, Name, Status__c 
                                              FROM Course_Attendee__C
                                              LIMIT :queryRowsRemaining];
if (courseAttendees.size() == queryRowsRemaining) {
    displayErrorMessage('Refine your query criteria');
} else {
	
}
