// Slide example
String criteria = '';
Boolean lookForOpenCases = false;

if (lookForOpenCases) {
    criteria = 'Status = \'Working\'';
} else {
    criteria = 'ClosedDate < TODAY';
}

List<Case> theCases = Database.query('SELECT Id, Subject FROM Case WHERE ' + criteria);
System.debug(theCases);

// A more sophisticated example using the Id.getSobjectType method to return the sObject's Token
// (a lightweight reference to the sObject) then using the token's getDescribe method to
// find its name. See docs for more info.
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_describe_objects_understanding.htm
public class DynamicQuery {
    
    public static String getFieldOnRecord(Id recordId, String fieldName){
        
        String qry = 'SELECT ' + fieldName + 
                     ' FROM ' + recordId.getSobjectType().getDescribe().getLocalName() + 
                     ' WHERE Id = :recordId';
        
        List<sObject> sObjs = database.query(qry);
        
        return (sObjs.size() >= 1 ? string.valueOf(sObjs[0].get(fieldName)) : 'Record not found');
    }
}

// Execute via anonymous block like this (need to get a real ID)
System.Debug(DynamicQuery.getFieldOnRecord('a051500000JBkdi', 'Name'));

// Selecting records in the re-cycle bin
// Create an account and then delete (so we have something to work with)

// ALL ROWS is only intended for use in Apex SOQL queries. The documentation for ALL ROWS 
// is in the Apex code documentation. The equivalent of ALL ROWS in the API is to call 
// queryAll() instead of query(). You can't use that in Developer Console's Query Editor 
// as the query editor doesn't execute it as Apex Code, it executes directly as a REST query API call

List<Account> accs = [SELECT ID, Name, IsDeleted FROM ACCOUNT WHERE IsDeleted = TRUE ALL ROWS]; // Won't work from Query Editor

for (Account acc : accs) {
    system.debug(acc);
}
