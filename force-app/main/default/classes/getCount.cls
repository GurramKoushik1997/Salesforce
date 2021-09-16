public class getCount {

    @AuraEnabled(cacheable=true)
    public static Integer getContacts(String accId){
         AggregateResult[] groupedResults = [SELECT count(Id),accountId FROM Contact Where accountId =:accId group by accountId];
         return groupedResults.size();
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Type, Rating, Phone FROM Account];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Title, Phone, Email FROM Contact];
    }
}