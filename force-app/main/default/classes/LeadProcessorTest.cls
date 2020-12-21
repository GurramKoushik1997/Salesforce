@isTest
public class LeadProcessorTest {
    
   @isTest static void testLead1() {
        
        //Data Setup
        lead l=new lead();
        for(Integer i=0;i<1;i++){
        
			l.salutation='Mr.';
			l.lastname='Test'+i;
			l.company='Company';
        insert l;
        }
        //call function

        Test.startTest();
       LeadProcessor lProcessor = new LeadProcessor();
        Id batchId = Database.executeBatch(lProcessor);
       Test.stopTest();
       
        Lead l1 = [SELECT Id, Name,Company FROM Lead  WHERE Company =:'CompanyDreamforce'];
        //assert
        //System.assertEquals(expected, actual);
               
        System.assertEquals(l1.Company,'CompanyDreamforce');
    }
    
    @isTest static void testLead2() {
        
        //Data Setup
        
        for(Integer i=0;i<1;i++){
			lead l=new lead();
			l.salutation='Mr.';
			l.lastname='Test'+i;
			l.company='Company';
        insert l;
        }
        //call function

        Test.startTest();
       LeadProcessor lProcessor = new LeadProcessor();
        Id batchId = Database.executeBatch(lProcessor);
       Test.stopTest();
       
        Lead l1 = [SELECT Id, Name,Company FROM Lead  WHERE Company =:'CompanyDreamforce'];
        //assert
        //System.assertEquals(expected, actual);
               
        System.assertNotEquals(l1.Company,'Company Dreamforce');
    }
}