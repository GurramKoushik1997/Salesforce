trigger countContacts on Contact(after insert,after update,after delete)
{
    set<Id> accontIds = new set<Id>{};    
    list<Account> AccIds = new list<Account>();
     
    if(trigger.isInsert || trigger.isUpdate) 
    { 
        for(Contact c:trigger.new)       
        accontIds.add(c.accountId);
    }   
     
    if(trigger.isDelete) 
    { 
        for(Contact c1:trigger.old)       
        accontIds.add(c1.accountID);
     }  

    AggregateResult[] groupedResults = [select accountid,count(id) countt from Contact where accountid in :accontIds group by accountid];
    
    for (AggregateResult ar : groupedResults)        
        AccIds.add(new Account(id=(ID)ar.get('accountid'),Count__c = (Integer)ar.get('countt'))); 
                   
    update AccIds;
}