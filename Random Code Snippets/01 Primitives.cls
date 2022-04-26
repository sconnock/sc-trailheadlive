//Sample Datetime method
Datetime curDateTime = Datetime.now();
Date curUserDate = curDateTime.date();

Date myDate = Date.newinstance(1978, 11, 13);	// Year, Month, Day
Time myTime = Time.newInstance(18, 30, 2, 20);	// Hours, Minutes, Seconds, Milliseconds
System.debug(myDate);
System.debug(myTime);

Datetime myDateTime = Datetime.now();			// UT
System.debug('DateTime now is ' + myDateTime);
Date today = Date.today();
System.debug('Date today is ' + today);

Time t = DateTime.now().time();					// Local time of user
System.debug('Time now is ' + t);

Date myToday = Date.today();
Date myNext30 = myToday.addDays(30);
System.debug('myToday = ' + myToday);
System.debug('myNext30 = ' + myNext30);

//Sample String method
String userString = 'Hello World';
Boolean validString = userString.isAlphanumeric();
System.debug('Is this a valid alphanumeric string? ' + validString);

String myString = '  abcdef  ';
System.debug(myString);
System.debug(mystring.length());
System.debug(mystring.reverse());
System.debug(mystring.trim().length());

// Passing arguments to methods - see link
// https://developer.salesforce.com/blogs/developer-relations/2012/05/passing-parameters-by-reference-and-by-value-in-apex.html
public class SimonsClass {
    
    /* In Apex, all primitive data type arguments, such as Integer or String, are passed into 
     * methods by value. This means that any changes to the arguments exist only within the scope
     * of the method. When the method returns, the changes to the arguments are lost.
     * 
     * Run this from Execute Anonymous:
       Integer i = 1;
	   Integer j = SimonsClass.method1(i);
	   system.debug('>>> i = ' + i + ', j = ' + j);
	 */
    public static Integer method1(Integer i) {
        i++;
        return i;
    }
    
    /* Non-primitive data type arguments, such as collections and sObjects, are also passed into methods 
     * by value. This means that when the method returns, the passed-in argument still references the same 
     * object as before the method call, and can’t be changed to point to another object. However, the values 
     * of the object’s (or list's) fields can be changed in the method.
     * 
     * Run this from Execute Anonymous:
       List<String> strings = new List<String>();
	   strings.add('Tom says ');
	   strings.add('Jerry says ');
	   SimonsClass.method2(strings);
	   system.debug('>>> ' + strings);
	 */
    public static List<String> method2(List<String> strings) {
        Integer j = strings.size();
        for ( Integer i=0; i<j; i++ ) {
            strings[i] = strings[i] + 'Hello Simon';
        }
        return strings;
    }
}

// Thanks to Sigmund
List<String> fruits = new List<String>();
fruits.add('apple');
fruits.add('orange');
fruits.add('banana');
System.debug(fruits);

for (String fruit : fruits){
    fruit = 'cherry';
}
System.debug(fruits);

List<Sample__c> samps = new List<Sample__c>();
samps.add(new Sample__c(Description__c = 'Hello Simon'));
samps.add(new Sample__c(Description__c = 'Hello Simon'));
System.debug(samps);

for (Sample__c samp : samps) {
    samp.Description__c = 'Hello Sigmund';
}
System.debug(samps);

// Also see https://salesforce.stackexchange.com/questions/94864/update-liststring-in-a-for-loop