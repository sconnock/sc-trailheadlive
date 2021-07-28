public class AccountTriggerHandler {
    
    // Custom Setting List
    public static TriggerSwitches__c tsw = TriggerSwitches__c.getInstance('Account');
    //public static TriggerSwitches__c tsw = [SELECT Active_Flag__c FROM TriggerSwitches__c WHERE Name='Account'];

    // Custom Setting Hierarchy
    //public static TriggerSwitchAccount__c tsw = TriggerSwitchAccount__c.getOrgDefaults();
    //public static TriggerSwitchAccount__c tsw = TriggerSwitchAccount__c.getInstance('00e4L000001OoAPQA0'); // Admin Profile ID
    //public static TriggerSwitchAccount__c tsw = [SELECT Active_Flag__c FROM TriggerSwitchAccount__c WHERE SetupOwnerId='00D4L000000rOEPUA2']; // Org Id

    // Custom Metadata Type
    //public static Trigger_Switch__mdt tsw = Trigger_Switch__mdt.getInstance('Account');    
    //public static Trigger_Switch__mdt tsw = [SELECT Active_Flag__c FROM Trigger_Switch__mdt WHERE DeveloperName='Account'];

    public static void setRating(List<Account> accounts) {
        System.debug('Set Rating');
    
        // Set rating depending on annual revenue
        for (Account a : accounts) {
            if (a.AnnualRevenue > 1000000) {
                a.Rating = 'Hot';
            } else if (a.AnnualRevenue > 100000) {
                a.Rating = 'Warm';
            } else {
                a.Rating = 'Cold';
            }
        }               
    }
}