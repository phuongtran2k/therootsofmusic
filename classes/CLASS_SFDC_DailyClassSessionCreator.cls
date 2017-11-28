global class CLASS_SFDC_DailyClassSessionCreator implements Schedulable {
    
    global void execute(SchedulableContext SC) {
      List<SFDC_Class__c> activeClasses;
      List<Class_SFDC_Session__c> newSessions = new List<Class_SFDC_Session__c>();
      String strToday = System.now().format('EEE');
      //private final List<Class_SFDC_Session_Attendance__c> currAttendanceList;
      // create new class sessions for active classes
      activeClasses = [SELECT Id, Monday__c, Tuesday__c, Wednesday__c, Thursday__c, Friday__c, 
                              Saturday__c, Sunday__c FROM SFDC_Class__c
                                WHERE Active__c = true];
       //int currentDay = 0;
       for (SFDC_Class__c currclass : activeClasses) {
           // Check if class is scheduled for today before creating the session
           if (strToday.equalsIgnoreCase('Mon') && currclass.Monday__c) {
               Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = currclass.Id, Start_Date_Time__C = DateTime.now());
            	newSessions.add(aSession);
           }
           else if (strToday.equalsIgnoreCase('Tue') && currclass.Tuesday__c) {
               Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = currclass.Id, Start_Date_Time__C = DateTime.now());
            	newSessions.add(aSession);
           } 
           else if (strToday.equalsIgnoreCase('Wed') && currclass.Wednesday__c) {
               Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = currclass.Id, Start_Date_Time__C = DateTime.now());
            	newSessions.add(aSession);
           } 
           else if (strToday.equalsIgnoreCase('Thu') && currclass.Thursday__c) {
               Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = currclass.Id, Start_Date_Time__C = DateTime.now());
            	newSessions.add(aSession);
           } 
           else if (strToday.equalsIgnoreCase('Fri') && currclass.Friday__c) {
               Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = currclass.Id, Start_Date_Time__C = DateTime.now());
            	newSessions.add(aSession);
           } 
           else if (strToday.equalsIgnoreCase('Sat') && currclass.Saturday__c) {
               Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = currclass.Id, Start_Date_Time__C = DateTime.now());
            	newSessions.add(aSession);
           } 
           else if (strToday.equalsIgnoreCase('Sun') && currclass.Sunday__c) {
               Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = currclass.Id, Start_Date_Time__C = DateTime.now());
            	newSessions.add(aSession);
           } // end else if
            
          } // end for  
       insert newSessions;
      // For all Sessions older than Class_SFDC_SessionRetentionDays
      Decimal retentionDays = [SELECT id, DeveloperName,Num_Days_Session_Retention__c 
                               FROM CLASS_SFDC_Settings__mdt  
                               WHERE DeveloperName = 'Default_Settings' LIMIT 1].Num_Days_Session_Retention__c;
      retentionDays = retentionDays * -1; // negate to subtract days
      Date dateToDelete = date.today().addDays(retentionDays.intValue());
      // session later than retention date

      List<CLASS_SFDC_Session__c> sessions = [SELECT id, CreatedDate
                                                FROM Class_SFDC_Session__c
                                                WHERE CreatedDate < :dateToDelete];
      // go through attendance list for all these sessions and if they do not have any student attendance records
      // that are filled out; remove the session
      List<CLASS_SFDC_Session__c> sessionsToDelete = new List<CLASS_SFDC_Session__c>() ;
      for (CLASS_SFDC_Session__c aSession : sessions)  {
          Boolean noAttendance = true;
          List<Class_SFDC_Session_Attendance__c> attend = [SELECT id, Attended__c
                                                          FROM Class_SFDC_Session_Attendance__c
                                                          WHERE Class_Session__c = :aSession.id];
          for (Class_SFDC_Session_Attendance__c attd : attend) {
              if (attd.Attended__c) {noAttendance = false;}
          } 
          if (noAttendance) {sessionsToDelete.add(aSession);}
      }
      Delete sessionsToDelete;
      
   } // end execute
    
}