List<Contact> contacts = new List<Contact>();
Contact noName = new Contact();
Contact anotherNoName = new Contact();

Contacts.add(noName);
Contacts.add(anotherNoName);

try {
    insert contacts;
} catch (DMLException e){
    System.debug('Caught exception.'); 
}

// More Examples
public class Exceptiontest {
    public static void printError(string s, Exception e){
        System.debug('CUSTOM ERR MSG:   ' + s);
        System.debug('ERROR TYPE:   ' + e.getTypeName());
        System.debug('ERROR MESSAGE:    ' + e.getMessage());
    }

    public static void myDivision(integer dividend, integer divisor){
        try { 
            System.debug(dividend / divisor);
        }
        catch (MathException e) { 
            printError('Math Error', e); 
        }       
        catch (NullPointerException e) { 
            printError('Null divisor or dividend.', e);  
        }
        catch (Exception e) { 
            printError('Unknown exception ', e);
        }
        finally { 
            System.debug('Exiting myDivision()'); 
        }
    } 
}

// From anonymous block
ExceptionTest.myDivision(null,2);

// Custom Exception - you can create and throw your own exceptions
//
// Custom exception class
public class ContactException extends Exception {
}

public class ContactUtility {
    public static void mainProcessing() {
        try {
            insertContact();
        } catch(ContactException me) {
            System.debug('Message: ' + me.getMessage());    
            System.debug('Cause: ' + me.getCause());    
            System.debug('Line number: ' + me.getLineNumber());    
            System.debug('Stack trace: ' + me.getStackTraceString());    
        }
    }
    
    public static void insertContact() {
        try {
            // Insert Contact without required name field
            Contact noName = new Contact();
            insert noName;
        } catch(DmlException e) {
            // Something happened that prevents the insertion
            // of Contact object, so throw a more
            // specific exception.
            throw new ContactException(
                'Contact could not be inserted!', e);
        }
    }
}

// Run in anonymous block using:
ContactUtility.insertContact(); // Just pops up the custom exception message

// or
ContactUtility.mainProcessing(); // Writes the custom message and DML exception stuff to the debug log