public with sharing class CLASS_SFDC_EnrollmentTriggerHandler extends TriggerHandler{

public override void afterInsert() {
    
    // Purpose is after the insert of a new Enrollment, look through all active sessions for the class of the enrollment
    //  and add the new student to the attendance list for the sessions so that instructors can mark the attendance
    //  of the new student.
    // List of new attendances to be inserted for new enrollment
    List<Class_SFDC_Session_Attendance__c> newAttendanceList = new List<Class_SFDC_Session_Attendance__c>();
    for(SFDC_Enrollment__c enroll : (List<SFDC_Enrollment__c>) Trigger.new) {
        // Get sessions for the class of this enrollment
        List<CLASS_SFDC_Session__c> sessions = [SELECT id, Class__c, Start_Date_Time__c
                                                FROM Class_SFDC_Session__c
                                                WHERE Class__c = :enroll.Class__c];
        
        for (CLASS_SFDC_Session__c aSession : sessions)  {
          // get the current attendance list. See if student is in active attendance lists
          // add student to attendance list if they are not in active attendance roster for sessions of the class
          List<Class_SFDC_Session_Attendance__c> attend = [SELECT id,Student_Name__c
                                                          FROM Class_SFDC_Session_Attendance__c
                                                          WHERE Class_Session__c = :aSession.id];
          Map<Id, Class_SFDC_Session_Attendance__c> attendanceMap = new Map<Id, Class_SFDC_Session_Attendance__c>();
          for (Class_SFDC_Session_Attendance__c attd : attend) {
            attendanceMap.put(attd.Student_Name__c, attd);
          }  
          if (!attendanceMap.containsKey(enroll.contact__c))    
              newAttendanceList.add(new Class_SFDC_Session_Attendance__c(student_Name__c=enroll.contact__c,
                                                                         Class_Session__c = aSession.id));
          
        } // end for session
       
    } // end for enrollments trigger.new
    insert newAttendanceList;
    
  } // end after insert

} // end class