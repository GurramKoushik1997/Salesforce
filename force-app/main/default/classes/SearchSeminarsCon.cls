public WITH SHARING class SearchSeminarsCon {
	@AuraEnabled
    Public STATIC List<Seminar__c> returnAllSeminars()
    {
        System.debug('lightning call ==> ');
        return [select Id, Name, Category__c, Speaker__c, Venue__c, Day__c, Time__c from Seminar__c LIMIT 10];
    }
    
    @AuraEnabled
    Public STATIC List<Seminar__c> returnSeminarsByCategory(String Category)
    {
        System.debug('lightning call ==> ');
        return [select Id, Name, Category__c, Speaker__c, Venue__c, Day__c, Time__c from Seminar__c WHERE Category__c =: Category LIMIT 100];
    }
}