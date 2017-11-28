trigger CLASS_SFDC_Session on Class_SFDC_Session__c (after insert) {
    // delegate the handling to the trigger handler
    new CLASS_SFDC_SessionTriggerHandler().run();
}