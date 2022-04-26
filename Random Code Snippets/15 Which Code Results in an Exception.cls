// Block A - No exception (perhaps surprisingly!)
List<Contact> contacts = new List<Contact>(); // Empty List
insert contacts;

// Block B - Exception: Required field missing
// Line: 4, Column: 1
// System.DmlException: Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, 
// Required fields are missing: [LastName]: [LastName]
List<Contact> contacts = new List<Contact>();
Contact noName = new Contact();
Contacts.add(noName);
insert contacts;

// Block C - Exception: null sObject
// Line: 5, Column: 1
// System.ListException: DML statment found null SObject at position 0
List<Contact> contacts = new List<Contact>();
Contact newContact = new Contact(LastName = 'Benett');
Contacts.add(newContact);
Contacts[0] = null;
insert contacts;

// Block D - Exception: Governor limits
// Line: 3, Column: 1
// System.LimitException: Too many DML statements: 151
for (Integer i = 0; i<175; i++) {
    Contact testContact = new Contact(LastName = 'Test' + i);
    insert testContact; // LIMIT for DML commands in a single transaction = 150
}

// Block E - Exception: String too long
// Line: 5, Column: 1
// System.DmlException: Insert failed. First exception on row 0; first error: STRING_TOO_LONG, Last Name: 
// data value too large: 00085chars00085chars00085chars00085chars00085chars00085chars00085chars00085chars00085
// (max length=80): [LastName]
List<Contact> contacts = new List<Contact>();
Contact longName = new Contact(LastName = 
    '00085chars00085chars00085chars00085chars00085chars00085chars00085chars00085chars00085');
Contacts.add(longName);
insert contacts; //LastName is a Text(80) field
