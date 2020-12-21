public WITH SHARING class volunteerSearchCon {
	@AuraEnabled 
    Public STATIC List<Volunteer__c> returnVolunteersByCategory(String Category)
    {
        return [select Id, Volunteer_Name__c, Height_in_Cms__c, Weight_in_kg__c, BMI__c, Category__c, Mobile__c, Email__c from Volunteer__c where Category__c =: Category];
    }
}