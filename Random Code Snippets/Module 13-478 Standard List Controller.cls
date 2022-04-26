// ListAccountsPage
<apex:page standardController="Account" recordSetVar="accounts" lightningStylesheets="true">
    <apex:pageBlock >
        <apex:pageBlockTable value="{!accounts}" var="acc">
            <apex:column value="{!acc.name}"/>
            <apex:column value="{!acc.Owner.Name}" headerValue="Owner Name"/>
        </apex:pageBlockTable>
    </apex:pageBlock>
</apex:page>

// Go to accounts tab and select All Accounts listview then show this page
// Go to accounts tab and select another list view. Show (or refresh) this page again
