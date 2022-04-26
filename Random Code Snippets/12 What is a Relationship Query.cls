// Which courses have deliveries in June of this year?
SELECT course__r.name, start_date__c FROM course_delivery__c 
	WHERE start_date__c >= 2022-06-01 AND 
	      start_date__c <= 2022-06-30

// OR
SELECT Course__r.Name, start_date__c FROM Course_Delivery__c 
	WHERE CALENDAR_YEAR(start_date__c) = 2022 AND 
          CALENDAR_MONTH(start_date__c) = 6
// OR
SELECT Course__r.Name, start_date__c FROM Course_Delivery__c 
	WHERE CALENDAR_MONTH(start_date__c) = 6 AND 
          start_date__c = THIS_YEAR

// OR (no dupes)
SELECT Course__r.Name FROM Course_Delivery__c 
	WHERE CALENDAR_MONTH(start_date__c) = 6 AND 
          start_date__c = THIS_YEAR
    GROUP BY course_r.Name

// OR (starting from the other end)
SELECT Name FROM Course__c WHERE Id IN (
		SELECT Course__c FROM Course_Delivery__c 
		WHERE CALENDAR_MONTH(start_date__c) = 6 AND 
	          start_date__c = THIS_YEAR
	)

// Which courses did attendees attend?
SELECT Student__r.Name, Course_Delivery__r.Course__r.Name 
	FROM Course_Attendee__c 
	ORDER BY Student__r.Name
