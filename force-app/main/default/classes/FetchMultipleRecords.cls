public class FetchMultipleRecords {
    @AuraEnabled
    public static List<Account> search() {
	return [SELECT Id,Industry, Name ,Type,(SELECT id, Name FROM contacts) FROM Account LIMIT 10];        
    }
}