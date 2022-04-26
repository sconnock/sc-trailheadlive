// Can load data just doing insert. Data is NOT persisted in SF database
@IsTest
private class MyTestClass {

	private static void testSetupObjectDataFactory1() {
		List<Holiday> hols = new List<Holiday>();
		hols.add(new Holiday(Name='New Years Eve',ActivityDate=Date.newInstance(2015, 12, 31)));
		hols.add(new Holiday(Name='Christmas Day',ActivityDate=Date.newInstance(2015, 12, 25)));
		insert hols;
		System.debug([SELECT Id, ActivityDate, Name FROM Holiday]);	
	}

// OR use a Static resource. Data is NOT persisted in SF database
//
// Note - you can delete the static resource - SF does not prevent that though of course
// the test will fail!

	private static void testSetupObjectDataFactory2() {
		Test.loadData(Holiday.sObjectType, 'Test_Holidays');
		System.debug([SELECT Id, ActivityDate, Name FROM Holiday]);
	}

	private static void testmethod myTestMethod() {
		
		// Load test data
		testSetupObjectDataFactory1();
		//testSetupObjectDataFactory2();

		// Do Test

		// Verify results
	}
}
