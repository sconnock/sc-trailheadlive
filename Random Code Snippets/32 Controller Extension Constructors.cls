// MyControllerExtensionPage (need to have an account ID in the URL)
<apex:page standardController="Account" extensions="MyControllerExtension_CX">
    {!greeting}<br/>
    <apex:form >
        <apex:inputText value="{!Account.Name}" size="30"/><br/>
        <apex:commandButton action="{!quicksave}" value="Save"/>
    </apex:form>
</apex:page>

// Controller extension class (for Account standard controller)
public with sharing class MyControllerExtension_CX {
    private Account acct;
    private String greeting;

    public MyControllerExtension_CX(ApexPages.StandardController stdController) {
        // Following line needed if Name property not already referenced on page
        //stdController.addFields(new String[]{'Name'});
        this.acct = (Account)stdController.getRecord();
    }

    public String getGreeting() {
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
}


public with sharing class MyControllerExtension1_CX {
    private Account acct;
    private String greeting;

    public MyControllerExtension1_CX(ApexPages.StandardController stdController) {
        acct = (Account)stdController.getRecord();
    }

    public String getGreeting() {
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
}