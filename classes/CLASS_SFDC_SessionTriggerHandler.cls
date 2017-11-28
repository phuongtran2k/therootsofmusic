public with sharing class CLASS_SFDC_SessionTriggerHandler extends TriggerHandler {

public override void afterInsert() {
    
    //Create the initial attendance list after the Session is first created.  
    //Assumption is that user goes to create a new session for a class.  This fires and creates a new attendance list
    // so that users can mark the attendance in the session attendance related list objects
    for(Class_SFDC_Session__c session : (List<Class_SFDC_Session__c>) Trigger.new) {
        
        List<sfdc_enrollment__c> enrollments = [SELECT id, class__c, status__c, contact__c 
                                                FROM sfdc_enrollment__c 
                                                WHERE  class__c = :session.Class__c and 
                                                       status__c in ('Registered','Enrolled','Wait Listed')];
        List<Class_SFDC_Session_Attendance__c> attendanceList = new List<Class_SFDC_Session_Attendance__c>();
        for (SFDC_Enrollment__c enrolls : enrollments) {
            attendanceList.add(new Class_SFDC_Session_Attendance__c(Class_Session__c = session.id,
                                                                     Student_Name__c = enrolls.contact__c));
        }
        insert attendanceList;
    }
    
  }

}