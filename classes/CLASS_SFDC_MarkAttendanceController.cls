// Controller used by the CLASS_SFDC_MarkAttendance visualforce page to constructo the data in the initial page
// as well as saving the attendance changes from the form
public with sharing class CLASS_SFDC_MarkAttendanceController  {

    private final SFDC_Class__c currClass;
    private final Class_SFDC_Session__c currClassSession;
    private final List<Class_SFDC_Session_Attendance__c> currAttendanceList;
    private String QS_id;
    private boolean success=false;


    // constructor
    public CLASS_SFDC_MarkAttendanceController() {
        // Get the class session from the id from the querystring
            QS_id = ApexPages.currentPage().getParameters().get('id');
            // see if qs param is a class session id - coming from session page
            if ([Select id FROM Class_SFDC_Session__c 
                 WHERE Name = :QS_id].size() > 0) {
            	currClassSession = [SELECT Id, Name, Class__c, Start_Date_Time__c FROM Class_SFDC_Session__c
                                WHERE Name = :QS_id limit 1];
                // Get the Class of the class session
            	currClass = [SELECT Id, Name, Section__c, Contact__c, Contact__r.Name FROM SFDC_Class__c
                                WHERE Id = :currClassSession.Class__c limit 1];
             
                     // Get the list of students/contacts that are registered, enrolled, and waitlisted.  Initial list
        			// was created from post insert trigger of the class session
       				 // Pull that list and add any additional students that were added after the initial 
        			// creation of the attendance list
       			currAttendanceList = [SELECT Id, Name, Class_Session__c, Student_Name__c, Student_Name__r.Name, 
                                        Student_Friendly_Name__c, attended__c
                             FROM Class_SFDC_Session_Attendance__c
                             WHERE Class_Session__c = :currClassSession.Id];
       		
             }
            // see if the id is a class id, then coming from the class page.  create new session to mark attendance
             else if ([Select id FROM SFDC_Class__c 
                 WHERE Name = :QS_id].size() > 0) {
                // Get the Class from id sent in from qs (from class page)
            	currClass = [SELECT Id, Name, Section__c, Contact__c, Contact__r.Name FROM SFDC_Class__c
                                WHERE Name = :QS_id limit 1];
                // get the latest created class session - sessions are created every day by batch job for the days
                // that are marked in the class object
                currClassSession = [SELECT Id, Name, Class__c, Start_Date_Time__c, CreatedDate FROM Class_SFDC_Session__c
                                WHERE Class__c = :currClass.Id and CreatedDate = Today
                                ORDER BY Start_Date_Time__c DESC nulls last limit 1];
               // Get the list of students/contacts that are registered, enrolled, and waitlisted.  Initial list
        			// was created from post insert trigger of the class session
       				 // Pull that list and add any additional students that were added after the initial 
        			// creation of the attendance list
       			currAttendanceList = [SELECT Id, Name, Class_Session__c, Student_Name__c, Student_Name__r.Name, 
                                        Student_Friendly_Name__c, attended__c
                             FROM Class_SFDC_Session_Attendance__c
                             WHERE Class_Session__c = :currClassSession.Id];      
        	}
        else {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'No Sessions have been created for this class, please create a session for this class'));
            success=false;
            //exit;
        }
           


        //success=true;
 
    }
	
    // getter for class of the session
    public SFDC_Class__c  getCurrClass() {
        return currClass;
    }
	
    // getter for the current session marked for attendance
    public Class_SFDC_Session__c   getCurrClassSession() {
        return currClassSession;
    }

    // getter for list of students being marked for attendance
    public List<Class_SFDC_Session_Attendance__c>   getCurrAttendanceList() {
        return currAttendanceList;
    }    
    
        // getter for success failure of controller
    public boolean  success() {
        return success;
    } 
     // getter for querystring param
    public String   getQS_ID() {
        return QS_id;
    } 
    // save the attendance list from changes in the visual force page    
    public PageReference save() {
        update currAttendanceList;
        success=true;
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Saved Successfully'));
        return null;
    }
    
}