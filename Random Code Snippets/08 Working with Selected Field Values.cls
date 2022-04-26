List<Case> cases = [SELECT CaseNumber FROM Case]; // Assume the list "cases" contains at least 1 case.

// FOR Loop 1
for (Case aCase : cases) {
    System.debug(aCase.Id + ' ' + aCase.CaseNumber);
}

// FOR Loop 2 - This will throw an exception
//    System.SObjectException: SObject row was retrieved via SOQL without 
//    querying the requested field: Case.Subject
for (Case theCase : cases) {
    System.debug(theCase.Subject);
}

// FOR Loop 3
for (Case currentCase : cases) {
    currentCase.Subject = 'Printer is jammed';
}
