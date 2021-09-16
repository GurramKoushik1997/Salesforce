public WITH SHARING class SearchHealthTipsCon {
	@AuraEnabled
    Public STATIC List<HealthTip__c> returnAllHealthTips()
    {
        System.debug('lightning call ==> ');
        return [select Id, Name, Category__c, Description__c from HealthTip__c LIMIT 10];
    }
    
    @AuraEnabled
    Public STATIC List<HealthTip__c> returnHealthTipsByCategory(String Category)
    {
        System.debug('lightning call ==> ');
        return [select Id, Name, Category__c, Description__c from HealthTip__c WHERE Category__c =: Category LIMIT 100];
    }
}