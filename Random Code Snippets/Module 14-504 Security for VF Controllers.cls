// Create a custom object Sample__c with field called Invisible__c
// Config CRED so that System Administrator and Sales User profiles have access
// Config FLS so only System Administrator profile has access

// Used by page SecurityExample
public with sharing class SecurityExample_CX {  // with sharing enforces record security
    public Sample__c s1 { get; set; }
    public Sample__c s2 { get; set; }
    Public String str { get; set; }

    public SecurityExample_CX(ApexPages.StandardController controller) {
        controller.addFields(new List<String>{'Name','Invisible__c'});
        s1 = (Sample__c) controller.getRecord();
        s2 = [SELECT ID, Name, Invisible__c FROM Sample__c WHERE ID = :s1.id];
        System.debug('Record from controller: ' + s1);
        System.debug('Record from query: ' + s2);
        str = 'The Invisible field is: ' + s2.Invisible__c;
    }
}

// SecurityExamplePage
<apex:page standardController="Sample__c" extensions="SecurityExample_CX">
    <apex:pageBlock >
        <apex:pageBlockSection columns="1">
            <apex:outputField value="{!Sample__c.Invisible__c}" />
            <apex:outputField value="{!s1.Id}" />
            <apex:outputField value="{!s1.Name}" />
            <apex:outputField value="{!s1.Invisible__c}" />
            <apex:outputField value="{!s2.Invisible__c}" />
            <apex:outputText value="{!str}" />
        </apex:pageBlockSection>
    </apex:pageBlock>
</apex:page>

// Give Sales User profile access to page AND class
// As System Administrator create a Sample record

// Logon as a sales user (Karen Adams) that does not have access (FLS) to Invisible__c
// First view record from page layout. Cannot see Invisible field
// Then view from /apex/SecurityExample page (need ID)
// The field will be protected by VF even though Apex is able to read it (i.e. first
// 3 outputfields are empty byt the final outputText shows the value)