trigger SFDC_Enrollment on SFDC_Enrollment__c (after insert) {
     // delegate the handling to the trigger handler
    new CLASS_SFDC_EnrollmentTriggerHandler().run();
}