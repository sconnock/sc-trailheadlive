public class TheController {
    String searchText;

    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String s) {
        searchText = s;
    }

    public List<Lead> Results { get; set;}

    public PageReference doSearch() {
        results = (List<Lead>)[ FIND :searchText 
                                RETURNING Lead(Name, Email) ][0];
        return null;
    }
}

// Page called /apex/TheController. May need to enter a lead to get something returned
<apex:page controller="TheController">
    <apex:form >
        Search Leads for: <apex:inputText value="{!searchText}"/><br/>
        <apex:commandButton action="{!doSearch}" value="Search"/>
        <apex:pageBlock >
            <apex:pageBlockTable value="{!results}" var="leads">
                <apex:column value="{!leads.Name}"/>
                <apex:column value="{!leads.Email}"/>
            </apex:pageBlockTable>
        </apex:pageBlock>
    </apex:form>  
</apex:page>