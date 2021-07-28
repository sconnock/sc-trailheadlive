trigger AccountTrigger on Account (before insert, before update) {

    // If no trigger switch defined or the active flag set then call the handler method
    if (AccountTriggerHandler.tsw == null || AccountTriggerHandler.tsw.Active_Flag__c) { 
        AccountTriggerHandler.setRating(Trigger.new);
    }
    
    System.debug('tsw: ' + AccountTriggerHandler.tsw);
    System.debug('Number of queries: ' + Limits.getQueries());
    System.debug('Number of rows: ' + Limits.getQueryRows());
}