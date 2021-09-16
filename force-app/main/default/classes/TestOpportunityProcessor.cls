@isTest
public class TestOpportunityProcessor {
    
     @isTest static void TestOpportunity1(){
        
        //Data setup
        Integer TotalRecords =0;
        List<Opportunity> lstopportunity = new list<Opportunity>();
		for(integer i=0; i<500; i++)
		{
			Opportunity a = new Opportunity(Name='batch Oppertunity'+i,stageName='Prospecting', closeDate=Date.today());
 		    lstopportunity.add(a);
		}
		insert lstopportunity ;
		System.debug('Records Inserted Succesfully');
         TotalRecords = lstopportunity.size();
         System.debug('TotalRecords =='+TotalRecords);
          List<Opportunity> opp1= [SELECT Id, Name,Amount FROM Opportunity ];
         System.debug('TOTAL >>> =='+opp1.size());
          List<Opportunity> opp= [SELECT Id, Name,Amount FROM Opportunity WHERE Amount != NULL];
          System.assert(opp.size()==0);

         
         //call function
        Test.startTest();
           OpportunityProcessor opportunityProcessor = new OpportunityProcessor();
           Database.executeBatch(opportunityProcessor);
       Test.stopTest();
          List<Opportunity> opp3= [SELECT Id, Name,Amount FROM Opportunity ];
         System.debug('TOTAL RESULT >>> =='+opp3.size());
         //assert
      List<Opportunity> result= [SELECT Id, Name,Amount FROM Opportunity WHERE Amount != NULL];
         
        //System.assertEquals(expected, actual);
       System.assert(result.size()>0);
     }
}