// Static Resource 'Test_Courses' (save as csv file and add as static resource)
// Note the "fake" Ids
Id,Name,Course_Description__c,Duration__c,Status__c
1,Test Course 1,This is a Test Course,5,Active
2,Test Course 2,This is a Test Course,5,Active
3,Test Course 3,This is a Test Course,5,Active

// Static Resource 'Test_CourseDeliveries' (save as csv file and add as static resource)
// The Course__c foreign key references the "fake" Ids above
Id,Course__c,Region__c,Location__c,Start_Date__c,Status__c
101,1,EMEA,London,2016-11-13,Scheduled
102,1,EMEA,London,2016-12-19,Scheduled
103,2,EMEA,London,2016-04-09,Scheduled
104,2,EMEA,London,2016-11-09,Scheduled

// Add test class then run test
@isTest
private class Course_Test {

    private static testmethod void testCourses() {
        Test.loadData(Course__c.sObjectType, 'Test_Courses');
        Test.loadData(Course_Delivery__c.sObjectType, 'Test_CourseDeliveries');

        List<Course__c> courses = [SELECT Id, Name, (SELECT Id, Name FROM Course_Deliveries__r) FROM Course__c];
        for ( Course__c course : courses ) {
        	for ( Course_Delivery__c cd : course.Course_Deliveries__r ) {
        		System.debug('Course Id/Name ' + course.Id + '/' + course.Name + ' has deliveries ' + cd.Id + '/' + cd.Name);
        	}
        }
    }
}

// Example Debug output
USER_DEBUG [11]|DEBUG|Course Id/Name a0036000001NPohAAG/Test Course 1 has deliveries a0136000000zOmjAAE/DELIVERY-100036
USER_DEBUG [11]|DEBUG|Course Id/Name a0036000001NPohAAG/Test Course 1 has deliveries a0136000000zOmiAAE/DELIVERY-100035
USER_DEBUG [11]|DEBUG|Course Id/Name a0036000001NPoiAAG/Test Course 2 has deliveries a0136000000zOmlAAE/DELIVERY-100038
USER_DEBUG [11]|DEBUG|Course Id/Name a0036000001NPoiAAG/Test Course 2 has deliveries a0136000000zOmkAAE/DELIVERY-100037
