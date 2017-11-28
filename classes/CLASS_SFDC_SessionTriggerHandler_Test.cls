@isTest
public class CLASS_SFDC_SessionTriggerHandler_Test {
    
    public static testMethod void testCreateSessionTrigger() {
       //create test data
       RecordType rt = [SELECT id,DeveloperName FROM RecordType WHERE DeveloperName = 'ClassroomStudent'];
       Contact student1 = new Contact(lastname='laststudent1', recordtypeid=rt.id);
       insert student1;
        Contact student2 = new Contact(lastname='laststudent2',recordtypeid=rt.id);
       insert student2;
       SFDC_Class__c newClass = new SFDC_Class__c(Active__c=true, Name='Class1'); 
       insert newClass;
       student1 = [select id from contact limit 1];
       student2 = [select id from contact limit 1];
       newClass = [select id from SFDC_Class__c limit 1];
       sfdc_enrollment__c enroll1 = new sfdc_enrollment__c(class__c = newClass.Id, status__c='Registered', 
                                                          contact__c=student1.id);
       sfdc_enrollment__c enroll2 = new sfdc_enrollment__c(class__c = newClass.Id, status__c='Registered', 
                                                          contact__c=student2.id);
       insert enroll1;insert enroll2;
       Class_SFDC_Session__c aSession = new Class_SFDC_Session__c (Class__c = newClass.Id, Start_Date_Time__C = DateTime.now());
       insert aSession;
       System.assert([select count() from Class_SFDC_Session_Attendance__c] == 2);
        
    }
        

}