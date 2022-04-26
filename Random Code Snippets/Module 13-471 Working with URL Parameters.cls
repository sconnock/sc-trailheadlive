// Code to generate PDF and attach to course record (can run from execute anon)
// Uses page created in Exercise 15-2

// Get a course
Course__c course = [SELECT Id, Name FROM Course__c LIMIT 1];
System.debug('Course name ' + course.Name);

// Get the CourseCertificate page
PageReference pdfPage = Page.CourseCertificate;
             
// Add the course's ID to the URL the page exepcts
pdfPage.getParameters().put('Id',course.id);
             
// Render the page and store as a blob
Blob pdfBlob = pdfPage.getContent();
             
// Create an attachment object for the course and insert
Attachment att = new Attachment(parentId = course.id, name = course.name + '.pdf', body = pdfBlob);
insert att;
System.debug('Attachment Id ' + att.Id);

// To be really fancy create the following Controller Extension class and page and modify the
// Course Certificate button to call this page (attachPDF) rather than CourseCertificate. Means
// that when you press the Course Certificate button it will call the attachPDF page which generates
// the PDF and attaches it to the course record. The attachPDF page then calls CourseCertificate so
// the user can see it too

// Controller extension class for below page
public with sharing class AttachPDF_CX {
    private Course__c course;

    public AttachPDF_CX(ApexPages.StandardController controller) {
        this.course = (Course__c)controller.getRecord();
    }
    
    public PageReference attachPDF () {
    
        // Get the CourseCertificate page
        PageReference pdfPage = Page.CourseCertificate;
             
        // Add the course's ID to the URL the page exepcts
        pdfPage.getParameters().put('id',course.id);
             
        // Render the page and store as a blob
        Blob pdfBlob = pdfPage.getContent();
             
        // Create an attachment object for the course and insert
        Attachment att = new Attachment(parentId = course.id, name = course.name + '-Certificate.pdf', body = pdfBlob);
        insert att;
        
        // Show it to the user
        PageReference certPage = Page.CourseCertificate;
        certPage.getParameters().put('id',course.id);
        certPage.setRedirect(true);
        return certPage;
    }
}

// Page AttachPDF
<apex:page standardController="Course__c" action="{!attachPDF}" extensions="AttachPDF_CX">
	<b>Rendering Course Certificate for Course {!Course__c.name} Id {!Course__c.Id}...</b>
</apex:page>
