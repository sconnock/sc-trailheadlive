/* Methods annotated with @future indicate that method should be executed asynchronously, when 
 * Salesforce has available resources. Only submitted for execution if apex transaction completes
 * successfully (no exceptions). Submitted for execution in post-commit step in save order of
 * execution. At time of writing up to 50 @future method calls per apex transaction. Method will
 * run in its own thread with its own set of governor limits. When testing - the test.stoptest()
 * call forces execution of any asynch code.
 * 
 * Must be static 
 * Can only return a void type
 * Can have only the following types of parameters
 * - Primitive data types
 * - Collections of primitive data types
 * - Can support an attribute, (callout=true), that allows a callout to a web service
 * - Multiple calls do not necessarily execute in the same order they are called.
 * - Cannot call another @future method.
 * - Supports higher governor limits for SOQL queries, heap size, and CPU time.
 * - Only executes after the originating transaction completes without aborting
 */
global class MyFutureClass {

  @future 
  static void myMethod(String a, Integer i) {
    System.debug('Method called with: ' + a + ' and ' + i);
    // Perform long-running code
  }

  @future (callout=true)
  public static void doCalloutFromFuture() {
   // Add code to perform web service callout
  }
}

/* You can use the @future annotation when making an asynchronous Web service callout to an external service. 
 * Without the annotation, the Web service callout is made from the same thread that is executing the Apex code, 
 * and no additional processing can occur until the callout is complete (synchronous processing).
 * 
 * Remember that any method using the @future annotation requires special consideration because the method 
 * does not necessarily execute in the same order it is called.
 * 
 * Methods with the @future annotation cannot be used in Visualforce controllers in either getMethodName 
 * or setMethodName methods, nor in the constructor.
 * 
 * You cannot call a method annotated with @future from a method that also has the @future annotation. 
 * 
 * The getContent and getContentAsPDFPageReference methods cannot be used in methods with the @future annotation.
 * 
 * Callouts originating from Triggers must use the @future annotation as synchronous callouts from triggers
 * are not allowed.
 * 
 * Winter '15 saw the introduction of Queueable Interface as an alternative process of controlling 
 * Asynchronous Apex. The ability to execute Asynchronous Apex on the Force.com platform is nothing new, 
 * Future Methods (@future) already allow for this ability. So what is the difference between asynchronous 
 * jobs submitted via the Queueable Interface and Future Methods?
 * 
 * There are 2 main differences:
 * 1. JobID is generated on submission of an asynchronous job. This JobID can in turn be used to
 * programatically query the status of the job via the 'AsyncApexJob' table. Alternatively, the 
 * job can be monitored via the UI (Setup->Monitoring->Apex Jobs)
 * 
 * 2. Asynchronous jobs submitted via the Queueable Interface can be chained, this means that you 
 * can add a job to the queue, and add a new job to the queue once the previous job has completed, 
 * something that is not possible via Future Methods
 */

// Example - Insert an account
public class AsyncInsertAccount implements System.Queueable {
	
	private String accountName;
	
	public AsyncInsertAccount(String s) {
		this.accountName = s;
	}
	
    public void execute(QueueableContext context) {
        Account a = new Account(Name=accountName,Phone='(415) 555-1212');
        insert a;       
    }
}

// To add this class as a job on the queue do this
ID jobID = System.enqueueJob(new AsyncInsertAccount('Acme Queued'));
System.debug('Job ID is ' + jobID);

/* After you submit your queueable class for execution, the job is added to the queue and 
 * will be processed when system resources become available. You can monitor the status of 
 * your job programmatically by querying AsyncApexJob or through the user interface in Setup 
 * by clicking Jobs | Apex Jobs.
 * 
 * To query information about your submitted job, perform a SOQL query on AsyncApexJob by 
 * filtering on the job ID that the System.enqueueJob method returns. This example uses the 
 * jobID variable that was obtained in the previous example.
 */
AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];

/* If you want to make callouts then you have to implement the "Database.AllowsCallouts" 
 * interface along with the "Queueable" interface to enable callouts (just like in batch 
 * apex and scheduled apex).
 */
 public class AsyncExecutionExample implements System.Queueable, Database.AllowsCallouts {
    public void execute(QueueableContext context) {
        //your code including the callout     
    }
}