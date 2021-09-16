@isTest
public class TestOppertunityController {
    
    @isTest static void getOpportunity(){
        
        //Data setup
        Opportunity a = new Opportunity(Name='Test Oppertunity', amount=250,stageName='Prospecting', closeDate=Date.today());
        insert a;
        
        //call function to test
        List<Opportunity> lo =	OpportunityController.getOpportunities();
       //List<Opportunity> lo1 =	OpportunityController.getByName('Test');
       
       //assert
        System.assert(!lo.isEmpty());
        System.assert(lo.size()==1);
		System.assertEquals(a.id,lo[0].id);
        //System.assertEquals('Test', a.Name);
        
    }
    
    @isTest static void getOpportunityShouldNotReturnNoAmountRecords(){
        //Opportunity opp = new Opportunity();
        Opportunity a = new Opportunity(Name='Test Oppertunity',stageName='Prospecting', closeDate=Date.today());
        insert a;
        List<Opportunity> lo =	OpportunityController.getOpportunities();
       // List<Opportunity> lo1 =	OpportunityController.getByName('Test');
        System.assert(lo.isEmpty());
        
       
        
    }
    @isTest static void getByName(){
        //Opportunity opp = new Opportunity();
        Opportunity a = new Opportunity(Name='Test Oppertunity', amount=250,stageName='Prospecting', closeDate=Date.today());
        insert a;
        //List<Opportunity> lo =	OpportunityController.getOpportunities();
       List<Opportunity> lo =	OpportunityController.getByName('Test');
        System.assert(!lo.isEmpty());
        System.assert(lo.size()==1);
		System.assertEquals(a.id,lo[0].id);
    }
    
    @isTest static void getByNameWithEmptyString(){
        //Opportunity opp = new Opportunity();
        Opportunity a = new Opportunity(Name='Test Oppertunity',amount=52,stageName='Prospecting', closeDate=Date.today());
        insert a;
        //List<Opportunity> lo =	OpportunityController.getOpportunities();
       List<Opportunity> lo =	OpportunityController.getByName('');
        System.assert(lo == null);
        //System.assert(lo.size()==1);
		//System.assertEquals(a.id,lo[0].id);
    }
}