# Org Setup Script

Create the following:

## 1.   Enable Custom List Settings: Setup | Data | Schema Settings

Enable "Manage list custom settings type".

## 2.   Define Custom Settings: Setup | Custom Code | Custom Settings

Create a new List Custom Setting called TriggerSwitch

    Label:        Trigger Switches
    Name:         TriggerSwitches (API Name: TriggerSwitch__c)
    Setting Type: List
    Description:  Holds records for each sObject where we may need to disable Triggers

Add new checkbox custom field:

    Field Label:   Active Flag
    Default Value: Checked
    Field Name:    Active_Flag (API Name: Active_Flag__c)
    Description:   Set to true to enable triggers for this sObject	 

Manage records adding:

    Name		Active Flag
    Account		True
    Contact		True

Add a new List View to show the Active Flag field.

## 3.   Define Custom Settings: Setup | Custom Code | Custom Settings
 
Create a new Hierarchy Custom Setting called TriggerSwitchAccount

    Label:        Trigger Switch Account
    Name:         TriggerSwitchAccount (API Name: TriggerSwitchAccount__c)
    Setting Type: Hierarchy
    Description:  Used to enable/disable trigger on the Account sObject

Add new checkbox custom field:

    Field Label:   Active Flag
    Default Value: Checked
    Field Name:    Active_Flag (API Name: Active_Flag__c)
    Description:   Set to true to enable triggers for this sObject	 

Manage records setting:

    Default Organization Level Value:	True
    Profile: System Administrator:		True
    Profile: Standard User:				True
    User: <you>                         True

Add a new List View to show the Active Flag field.
 
## 4.   Define Custom Metadata Types: Setup | Custom Code | Custom Metadata Types

Create a new Custom Metadata Type called Trigger Switch

    Label:        Trigger Switch
    Plural Label: Trigger Switches
    Name:         Trigger_Switch (API Name: Trigger_Switch__mdt)
    Description:  Holds records for each sObject where we may need to disable Triggers

Add new checkbox custom field:

    Field Label:   Active Flag
    Default Value: Checked
    Field Name:    Active_Flag (API Name: Active_Flag__c)
    Description:   Set to true to enable triggers for this sObject

Manage records adding:

    Label				Trigger Switch Name		Active Flag
    Account Trigger		Account					True
    Contact Trigger		Contact					True

Add a new List View to show the Active Flag field.

## 5.   Add an Apex trigger handler class for the Account sObject

## 6.   Add an Apex trigger on the Account sObject

## 7.   Add an Apex test class to evaluate the trigger behaviour

Run multiple tests using Custom Settings/Custom Metadata Type.

## 8.   Add the Set Rating flow to the org and test using flow debugger

Flow is initially setup to using Custom Setting in the Get Record step. Pssible to replace wih the CheckTriggerSwitch Apex action which uses Apex to retrieve the Custom Setting.