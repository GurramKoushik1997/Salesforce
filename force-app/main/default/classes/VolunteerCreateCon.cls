public WITH SHARING class VolunteerCreateCon {
	
    @AuraEnabled
    Public STATIC Id createVolunteer(String volName, Integer volHeight, Integer volWeight, String volMobile, String volEmail)
    {
        Volunteer__c volForIns = new Volunteer__c(Volunteer_Name__c=volName, Height_in_Cms__c=volHeight, Weight_in_kg__c=volWeight, Mobile__c=volMobile, Email__c=volEmail);
        insert volForIns;
        return volForIns.Id;
    }
    
}