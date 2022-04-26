Contact withName= new Contact(LastName = 'Lee');
Contact noName= new Contact();
List<Contact> contacts = new List<Contact>();
contacts.add(withName);
contacts.add(noName);
List<Database.SaveResult> srs =  Database.insert(contacts, false);

for (Database.SaveResult sr : srs ) {

    if(sr.isSuccess() == FALSE) {

        List<Database.Error> errors = sr.getErrors();
        
        Integer i = 1;
        String debugString = 'Errors: '; 
        for (Database.Error e : errors) {
            debugString += i + '. ' + e.getMessage() + '; ';
            i++;
    	}

        System.debug(debugString);
    }
    else {
        System.debug('Successfully inserted record. ID is ' + sr.getId());
    }
}

// Example Debug Log
//10:43:27:190 USER_DEBUG [24]|DEBUG|Successfully inserted record. ID is 00361000007NAWXAA4
//10:43:27:192 USER_DEBUG [21]|DEBUG|Errors: 1. Required fields are missing: [LastName]; 