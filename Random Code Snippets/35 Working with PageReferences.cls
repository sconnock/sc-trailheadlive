// NOTE: No explicit setter for Account
public class MyCustomController3_CC {
    private Account account;

    // If the ID of an account record is found - return that account.
    // Otherwise create a new account
    public Account getAccount() {
        ID accId = ApexPages.currentPage().getParameters().get('Id');
        if ( accId != null )
            account = [SELECT Id, Name FROM Account WHERE Id = :accId];
        else if ( account == null ) 
            account = new Account();
        return account;
    }

    public String getName() {
        return 'MyThirdController';
    }

    public PageReference save() {
        upsert account;
        //PageReference acctPage = new PageReference('/' + account.id);
        PageReference acctPage = new apexPages.standardController(account).view();
        return acctPage;
    }
}

// MyThirdControllerPage
<apex:page controller="MyCustomController3_CC">
    Controller name: {!Name}
    <apex:form >
        <apex:inputField value="{!Account.Name}"/>
        <apex:commandButton action="{!Save}" value="Update" rendered="{!NOT($CurrentPage.parameters.Id == null)}"/>  
        <apex:commandButton action="{!Save}" value="Create" rendered="{!($CurrentPage.parameters.Id == null)}"/>  
    </apex:form>
</apex:page>