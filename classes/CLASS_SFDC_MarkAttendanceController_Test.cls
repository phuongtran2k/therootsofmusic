@isTest
public class CLASS_SFDC_MarkAttendanceController_Test {

    public static testMethod void testMyController() {
        
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
       newClass = [select id, name from SFDC_Class__c limit 1];
       sfdc_enrollment__c enroll1 = new sfdc_enrollment__c(class__c = newClass.Id, status__c='Registered', 
                                                          contact__c=student1.id);
       sfdc_enrollment__c enroll2 = new sfdc_enrollment__c(class__c = newClass.Id, status__c='Registered', 
                                                          contact__c=student2.id);
       insert enroll1;insert enroll2;
       Class_SFDC_Session__c aSession = new Class_SFDC_Session__c 
           					(Class__c = newClass.Id, Start_Date_Time__C = DateTime.now());
       insert aSession;
       Class_SFDC_Session__c newSession = [select id, name from Class_SFDC_Session__c limit 1];
        
     //   PageReference pageRef = Page.success;
    //    Test.setCurrentPage(pageRef);
      
        
        // Add parameters to page URL
        // test when passing a session
        ApexPages.currentPage().getParameters().put('id', newSession.name);
        CLASS_SFDC_MarkAttendanceController controller = new CLASS_SFDC_MarkAttendanceController();
        controller.save();
        
        // test when passing a class id
        ApexPages.currentPage().getParameters().put('id', newClass.name);
        controller = new CLASS_SFDC_MarkAttendanceController();
        controller.save();

        // Verify that page fails without parameters
    //    System.assertEquals('/apex/failure?error=noParam', nextPage);


      
        // Instantiate a new controller with all parameters in the page
 /*       controller = new thecontroller(); 
        controller.setLastName('lastname');
        controller.setFirstName('firstname');
        controller.setCompany('acme');
        controller.setEmail('firstlast@acme.com');
        nextPage = controller.save().getUrl();*/

        // Verify that the success page displays
     //   System.assertEquals('/apex/success', nextPage);
    //    Lead[] leads = [select id, email from lead where Company = 'acme'];
 //       System.assertEquals('firstlast@acme.com', leads[0].email);
    }


}