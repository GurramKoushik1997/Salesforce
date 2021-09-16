public with sharing class OpportunityController

{

@AuraEnabled

public static List<Opportunity> getOpportunities(){

return [SELECT Id, Name,StageName,CloseDate,Amount FROM Opportunity Where Amount!= Null];

}

// This method used for reterived  the list of opportunity records based on the search string

@AuraEnabled

public static List<Opportunity> getByName(String searchKey) {
    if(String.isEmpty(searchKey)){
        return null;
    }
String name = '%' + searchKey + '%';

return [SELECT id, Name,StageName, CloseDate,Amount FROM Opportunity WHERE name LIKE :name and Amount!= Null];

}

}