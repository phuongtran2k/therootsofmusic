@isTest
public class CLASS_SFDC_DailyClassSessionCreator_Test {
    
    static final Integer maxClasses = 10;
    public static testMethod void testschedule() {
       
        List<SFDC_Class__c> classes = new List<SFDC_Class__c>();
        
        for (Integer i=0; i<maxClasses; i++) {
            SFDC_Class__c newClass = new SFDC_Class__c(Active__c=true, Monday__c=true, Tuesday__c=true,
                                                      Wednesday__c=true, Thursday__c=true, Friday__c=true,
                                                      Saturday__c=true, Sunday__c=true, Name='Class'+i);
            classes.add(newClass);
        }
        insert classes;

        Test.StartTest();
        CLASS_SFDC_DailyClassSessionCreator dailyBatch = new CLASS_SFDC_DailyClassSessionCreator();
		String sch = '0 0 23 * * ?'; 
        system.schedule('Test Daily Session Batch', sch, dailyBatch); 
        Test.stopTest(); }

}