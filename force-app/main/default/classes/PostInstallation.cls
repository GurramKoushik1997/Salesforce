public class PostInstallation{
    
    public static Map<String,String> authProviderConfiguration = new Map<String,String>();
    
    public static void newUserAndPermissionSet( String email, String Profile){
        
        Profile profileId = [select Id from Profile where name=:Profile limit 1];
        User usr = new User(LastName = 'Integration Admin',
                            FirstName= 'RightRev',
                            Alias = 'admin',
                            Email = email,
                            Username = 'RightRev Integration Admin',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US');
        insert usr;
        
        List<SetupEntityAccess> setupEntityAccessList = [SELECT Id, ParentId, SetupEntityId, SetupEntityType FROM SetupEntityAccess];        
        Set<ID> PermissionSetList = new Set<ID> ();
        
        for (SetupEntityAccess sea : setupEntityAccessList) {
            PermissionSetList.add(sea.ParentId);
        }
        List<PermissionSet> PermissionSetWithProfileIdList = [SELECT Id, Name, IsOwnedByProfile, Profile.Name,ProfileId FROM PermissionSet WHERE IsOwnedByProfile = true AND Id IN :PermissionSetList];   
        
        Set<ID> ProfileList = new Set<ID> ();
        for (PermissionSet per : PermissionSetWithProfileIdList) {
            ProfileList.add(per.ProfileId);
        }
        List<User> UserList = [SELECT Id FROM User where ProfileId IN :ProfileList AND Username =:'RightRev Integration Admin'];
        List<PermissionSet> PermissionSetToAssignList = [SELECT Id, Name, NamespacePrefix FROM PermissionSet WHERE Name=:'RightRev Admin'];
        PermissionSet PermissionSetToAssign = PermissionSetToAssignList[0];
        List<PermissionSetAssignment> PermissionSetAssignmentList = new List<PermissionSetAssignment>();
        for (User us : UserList) {
            PermissionSetAssignment psa = new PermissionSetAssignment();
            psa.PermissionSetId = PermissionSetToAssign.id;
            psa.AssigneeId = us.id;
            PermissionSetAssignmentList.add(psa);
        }
        insert PermissionSetAssignmentList;
    }
    
    //code for custom settings RevenuePrefix__c
    public static void insertRevenuePrefix(String barPrefix){
        RevenuePrefix__c revPrefix = new RevenuePrefix__c();
        revPrefix.BarPrefix__c = barPrefix;
        revPrefix.SetupOwnerId = UserInfo.getOrganizationId();
        Insert revPrefix;
    }
    
    //code for custom settings LicenseInformation__c    
    public static void insertLicenseInformation(String licenseKey){
        LicenseInformation__c licInfo = new LicenseInformation__c();
        licInfo.License_Key__c = licenseKey;
        licInfo.SetupOwnerId = UserInfo.getOrganizationId();
        Insert licInfo;
    }
}

/*
//Step-1 Enable Path Setting in the Org.
// To enable path setting in org
// I found this to enable the path setting in Org.
project.json.
{
"orgName": "Dev Company",
"country": "IN",
"edition": "Developer Edition",
"hasSampleData": "true",
"orgPreferences": {
"enabled": ["PathAssistantsEnabled"],
}
}
*/