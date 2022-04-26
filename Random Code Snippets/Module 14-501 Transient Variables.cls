// TransientExamplePage
<apex:page controller="MyCustomController5_CC">
  T1: {!t1}
  <br/> T2: {!t2}
  <br/>
  <apex:form>
    <apex:commandLink value="refresh" />
  </apex:form>
</apex:page>

public with sharing class MyCustomController5_CC {

    DateTime t1;
    transient DateTime t2;
    
    public String getT1() {
        if (t1 == null) t1 = System.now();
        return '' + t1;
    }
    
    public String getT2() {
        if (t2 == null) t2 = System.now();
        return '' + t2;
    }    
}

// The example contains both a Visualforce page and a custom controller. 
// Clicking the refresh button on the page causes the transient date to be 
// updated because it is being recreated each time the page is refreshed. 
// The non-transient date continues to have its original value, which has 
// been deserialized from the view state, so it remains the same.