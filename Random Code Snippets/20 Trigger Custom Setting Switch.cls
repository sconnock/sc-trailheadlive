/* Create a new List Custom Setting called TriggerSwitch
 *
 * Setup | Develop | Custom Settings
 *
 * Label:    Trigger Switch
 * Name:     TriggerSwitch
 * API Name: TriggerSwitch__c
 *
 * Add new checkbox custom field called Active Flag (API name Active_Flag__c, default value true)
 *
 * Manage custom setting - add new entry
 *
 * Name:           CourseDeliveryTrigger
 * Active_Flag__c: True
 *
 * Modify CourseDeliveryTrigger code as follows:
 */
trigger CourseDeliveryTrigger on Course_Delivery__c (before insert, before update) {
    
    // Only call business logic if custom setting switch allows it. 
    // Note: Check for a null custom setting as not visible to testMethod 
    TriggerSwitch__c tsw = TriggerSwitch__c.getInstance('CourseDeliveryTrigger');
    if ( tsw == null || tsw.Active_Flag__c ) {
		CourseDeliveryTriggerHandler.preventInvalidCourseDeliveries(trigger.new);       
    }
}

// Test that it still works. Change value of Active_Flag__c to False and check that
// business logic no longer runs

/* OR - same thing with Custom Metadata Type
 *
 * Setup | Custom Code | Custom Metadata Types
 *
 * Label:        Trigger Switch
 * Plural Label: Trigger Switches
 * API Name:     Trigger_Switch_mdt
 *
 * Fields:
 *
 * SOBject_Name__c (text 80)
 * Active_Flag__c (checkbox - default ticked)
 *
 * Add data
 * Label: Course Delivery Trigger
 * SObject Name: Course_Delivery__c
 * Active Flag: Ticked (true)
 * 
 *
 */
trigger CourseDeliveryTrigger on Course_Delivery__c (before insert, before update) {

	// Querying a custom metadata type does not count against governor limits unless
	// they contain long text area fields
    Trigger_Switch__mdt tsw = [SELECT Active_Flag__c FROM Trigger_Switch__mdt WHERE SOBject_Name__c='Course_Delivery__c'];
    if (tsw.Active_Flag__c) {
        system.debug('Course_Delivery__c trigger active');
		CourseDeliveryTriggerHandler.preventInvalidCourseDeliveries(Trigger.new, Trigger.oldMap);
    }
}
