global class OpportunityProcessor implements Database.Batchable<sObject>, Database.Stateful {
    
    global set<id> allIds=new set<id>();
    global set<id> allFailedId=new set<id>();
    global Integer FailedRecords= allFailedId.size();
    global set<id> allSuccessId=new set<id>();
    global Integer SuccessfulRecords= allSuccessId.size();
    global Integer TotalRecordsProcessed = 0;
   
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        String query = 'SELECT Id, Name,Amount,CloseDate,StageName FROM Opportunity ';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> oppList){
        Integer j=0;
        for(Opportunity opp : oppList){
            
            if((j/5)==0){
                opp.Amount = 6000;
            }else{
                opp.Amount = 4000;
            }
           j++;
        }
       Database.SaveResult[] srList = database.update(oppList, false);
			 for(Integer i=0; i < srList.size(); i++) {
        if(srList.get(i).isSuccess()) {
            System.debug('Records are updated Successfully');
           SuccessfulRecords=SuccessfulRecords+1;
        } 
        else if(!srList.get(i).isSuccess()) {
            Database.Error errors =  srList.get(i).getErrors().get(0);
            System.debug('Error== '+errors.getMessage());
            System.debug('Failure Record Ids== '+srList.get(i).Id);
            FailedRecords=FailedRecords+1;
        }
    }
        TotalRecordsProcessed=TotalRecordsProcessed+oppList.size();
        /*System.debug('TotalRecordsProcessed==='+ TotalRecordsProcessed);
       
        System.debug('FailedRecords=='+FailedRecords);
       
        System.debug('SuccessfulRecords=='+SuccessfulRecords);*/

    }
    
    global void finish(Database.BatchableContext bc) {
        // execute any post-processing operations 
        System.debug('TotalRecordsProcessed==='+ TotalRecordsProcessed);
        System.debug('FailedRecords=='+FailedRecords);
        System.debug('SuccessfulRecords=='+SuccessfulRecords);

    }

}