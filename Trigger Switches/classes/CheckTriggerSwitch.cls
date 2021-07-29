public class CheckTriggerSwitch {
    
    public class ActiveRequest {
        @InvocableVariable public String sObjectName;
    }
    
    public class ActiveResult {
        @InvocableVariable public Boolean activeFlag;
    }
    
    @InvocableMethod
    public static List<ActiveResult> checkFlag(List<ActiveRequest> request) {
        String sObjectName = request[0].sObjectName;
        ActiveResult result = new ActiveResult();
        
    	// Custom Setting List
    	TriggerSwitches__c tsw = TriggerSwitches__c.getInstance(sObjectName);
        result.activeFlag = tsw.Active_Flag__c;

    	// Custom Setting Hierarchy
        //if (sObjectName == 'Account') {
    	//	TriggerSwitchAccount__c tsw = TriggerSwitchAccount__c.getOrgDefaults();
    	//	result.activeFlag = tsw.Active_Flag__c;            
        //}

	    // Custom Metadata Type
    	//Trigger_Switch__mdt tsw = Trigger_Switch__mdt.getInstance(sObjectName); 
    	//result.activeFlag = tsw.Active_Flag__c;   
    	
        List<ActiveResult> results = new List<ActiveResult>{result};
        return results;
    }
}