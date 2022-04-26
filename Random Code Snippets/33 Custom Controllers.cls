// MyCustomControllerPage (needs an Account ID in the URL)
<apex:page controller="MyCustomController1_CC">
    This page is using the {!name} controller!<br/>
    Account Id: {!Account.Id}, Name: {!Account.Name}
</apex:page>

// Custom Controller
public with sharing class MyCustomController1_CC {
    public String getName() {
        return 'MyCustomController';
    }
    
    public Account getAccount() {
        return [SELECT Id, Name from Account
                WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    }
}