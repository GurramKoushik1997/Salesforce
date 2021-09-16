trigger TotalCount on Contact (after insert, after delete, after update) {
    
    Integer count;
    set<id>accid=new set<id>();
    List<Account> accList = new List<Account>();
    if(Trigger.isInsert || Trigger.isUpdate){
        for(Contact con : Trigger.New){
            accid.add(con.AccountId);
        }
    }
    List<Account> acc=[select Name , (Select LastName from contacts) from Account where Id = :accId];
    for(Account acct:acc){
        count = acct.contacts.size();
        acct.Number_of_Contacts__c = count;
        accList.add(acct);
    }
    System.debug('count=='+count);
    update accList;   
}