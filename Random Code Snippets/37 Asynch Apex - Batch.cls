/* Batch Apex - Asynchronous execution framework which can operate on up to 50 million records
 * May be run on a schedule or ad hoc. Implemented using the Database.Batchable interface and
 * initiated using Database.executeBatch method
 * 
 * Once batch is initiated then
 * - data is gathered for processing (start() method)
 * - business logic is applied to data in batches (execute() method)
 * - finalization logic if any executed once all batches have been processed (finish() method)
 * 
 * The Database.Batchable interface requires the following methods
 * Start() is usually made up of one or a few SOQL queries. Ultimately, a Database.QueryLocator 
 * needs to be created and returned. The QueryLocator describes the data that will be processed. 
 * 
 * Execute() is called multiple times by the platform. Each time it is called, the platform passes
 * in a new “scope”, which is typically a bundle of 200 records (by default). The programmer must 
 * tell the platform to 1) iterate over the sObjects in the scope and 2) for every sObject in the
 * scope, what is the business logic that should be executed. Remember, the platform takes care 
 * of breaking down the overall set of records into batches of records (scopes), and it takes 
 * care of calling the execute method on each scope.
 * 
 * Each execute method call gets its own governor limits
 * Note that when testing only one iteration of the code in the execute method is allowed.
 * 
 * Finish() must be implemented but it doesn’t have to have any code. It will get executed once 
 * the platform has finished all the iterations of Execute(), regardless of whether the business logic
 * in Execute() was successful for all of the records that needed to be processed. 
 */
 
// Batch Demo Class
global class BatchUpdateAccounts implements Database.Batchable<sObject>{

	// Gather the records for processing
	global Database.QueryLocator start(Database.BatchableContext dbc){
		return Database.getQueryLocator([SELECT Id, Name FROM Account]);
	}

	// Process the records
	global void execute(Database.BatchableContext dbc, List<Account> myAccounts){
		List<Account> la = new List<Account>();
		for(Account a : myAccounts){
			a.Name = a.Name + ' Batched';
			la.add(a);
		}
		update la;
	}

	// Do any tidy up
	global void finish(Database.BatchableContext dbc){
	}
}

// Anonymous block for batch
BatchUpdateAccounts bua = new BatchUpdateAccounts();
// Note that Database.executeBatch() causes a job to be queued (not necessarily executed) 
// at the time of the call.
database.executebatch(bua);  // Uses default batch size of 200 - max is 2000

// OR
ID AsyncApexJobID = Database.executeBatch(bua, 150); // Optional Integer parameter is batch size from 1-2000

// Can monitor in Setup | Jobs | Apex Jobs or programmatically
AsyncApexJob batchJobInfo = 
    [ SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
      FROM AsyncApexJob 
      WHERE ID = :AsyncApexJobID ]; 

// Can be made available for scheduling using the Schedulable interface
// Allows previous simple batch example to be scheduled
global class ScheduleAccountBatchUpdate implements Schedulable {
	
    global void execute(SchedulableContext sc) {
        BatchUpdateAccounts bua = new BatchUpdateAccounts(); 
        database.executebatch(bua);
     }
}

// Schedule via Setup | Develop | Apex Classes | Schedule Apex 
// or programmatically like this...
ScheduleAccountBatchUpdate accountBatchFeb13Run = new ScheduleAccountBatchUpdate(); 
String timing = '0 0 8 13 2 ?'; // run on February 13 at 8AM
system.schedule('One Time Pro', timing, accountBatchFeb13Run);

/* During regular, stateless Batch Apex, the object’s variables are re-initialized upon 
 * each call to the Execute method. This means that if you have a member variable called 
 * recordCounter and you initialize it to 0, then each time execute() is called, it will 
 * get reinitialized to 0. So, if you are processing 1,000 records in batches of 200, then 
 * recordCounter would be initialized to 0 five times.
 *
 * In stateful batch, you can retain the value of a variable by making it a non-static 
 * instance variable. This is useful if, for instance, you want to add a message in the 
 * log stating how many rows you processed in total. In the previous example, recordCounter 
 * would have only been initialized to 0 once, if Database.Stateful had been specified.
 *
 * The following code implements a stateful counter to show how this works. Run it from
 * execute anonymous with a small enough batch size to see multiple batches. You should
 * be able to see a log file generated per batch (as well as a final one).
 * 
 * NOTE static variables DO NOT retain state (so don't use the static keyword)
 */

global class BatchUpdateAccounts implements Database.Batchable<sObject>,Database.Stateful{
    global Integer recordCount = 0;

	// Gather the records for processing
	global Database.QueryLocator start(Database.BatchableContext dbc){
		return Database.getQueryLocator([SELECT Id, Name FROM Account]);
	}

	// Process the records
	global void execute(Database.BatchableContext dbc, List<Account> myAccounts){
		List<Account> la = new List<Account>();
		for(Account a : myAccounts){
			a.Name = a.Name + ' Batched';
			la.add(a);
            recordCount++;
		}
		update la;
        system.debug('Counted ' + recordCount + ' records so far.');
	}

	// Do any tidy up
	global void finish(Database.BatchableContext dbc){
        system.debug('Final record count ' + recordCount);
	}
}

/* If you want to make callouts then you have to implement the "Database.AllowsCallouts" 
 * interface to enable callouts 
 */


// Code to get rid of the string 'Batched' appended to the account name
List<Account> accounts = [SELECT Name FROM account];
for ( Account account : accounts ) {
    if ( account.Name.contains('Batched') ) {
        account.Name = account.Name.remove('Batched').trim();
        system.debug('Account ' + account.Name);
    }
}
update accounts;
