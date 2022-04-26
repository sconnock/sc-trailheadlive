// Find the related certifications
SELECT Certification_Candidate__c , Certification_Element__r.Certification__c 
	FROM Certification_Attempt__c 
	WHERE Certification_Candidate__c IN (‘C1’,’C2’,...)

// Find the number of elements associated with each certification
SELECT COUNT() FROM Certification_Element__c 
	WHERE Certification__c = '123456789012345'

// Find the attempts each candidate has passed for each relevant certification
SELECT  Certification_Candidate__c , Certification_Element__r.Certification__c , Status__c 
	FROM Certification__Attempt__c 
	WHERE Status__c = ‘Complete/Pass’ 
		AND Certification_Candidate__c  IN (‘C1’,’C2’,...) 
		AND Certification_Element__r.Certification__c  IN (‘Cert1’,'Cert2',...)
