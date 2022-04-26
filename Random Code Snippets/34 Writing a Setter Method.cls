public with sharing class MyCustomController2_CC {

    private String controllerName;
     
    public String getName() {
        if ( controllerName == null ) {
            controllerName = 'MySecondController';
        }
        return controllerName;
    }
    
    public void setName(String s) {
        controllerName = s;
    }
    
    public string test { get; set; }
    
    public Account getAccount() {
        return [SELECT Id, Name from Account
                WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    }
    
    public pagereference refresh(){
        return null;
    }
}

// MySecondControllerPage (needs account ID in the URL as before)
<apex:page controller="MyCustomController2_CC">
    This page is using the <b>{!name}</b> controller!<br/><br/>
       
    Account Id: {!Account.Id}, Name: {!Account.Name}<br/><br/>
    <apex:form >
        <apex:pageBlock >
            <apex:pageBlockSection columns="3">
                <apex:inputText value="{!Name}" label="Name"/>
                <apex:inputText value="{!Test}" label="Test"/>
                <apex:commandButton value="Refresh" action="{!Refresh}"/>              
            </apex:pageBlockSection>     
        </apex:pageBlock>
    </apex:form>          

    <apex:outputPanel rendered="{!Test != null}">
        <p>The value of the string Test is {!Test}</p>
    </apex:outputPanel>

</apex:page>