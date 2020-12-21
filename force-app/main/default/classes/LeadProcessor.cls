global class LeadProcessor implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        String query = 'SELECT Id, Name,Company FROM Lead';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> leadList){
        
        for(Lead lead : leadList) {        
           
            // lead.Name = lead.Name + 'Dreamforce';
            lead.Company = lead.Company + 'Dreamforce';
            System.debug('lead.Company=='+lead.Company);
        }

            update leadList;
    }
    
    global void finish(Database.BatchableContext bc) {
        // execute any post-processing operations 
    }
    

}