public class AccountTriggerHandler {
    
    // Custom Setting List
    public static TriggerSwitches__c tsw = TriggerSwitches__c.getInstance('Account');
    //public static TriggerSwitches__c tsw = [SELECT Active_Flag__c FROM TriggerSwitches__c WHERE Name='Account'];

    // Custom Setting Hierarchy
    //public static TriggerSwitchAccount__c tsw = TriggerSwitchAccount__c.getOrgDefaults();
    //public static TriggerSwitchAccount__c tsw = TriggerSwitchAccount__c.getInstance();

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
