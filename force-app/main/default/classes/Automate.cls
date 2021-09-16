public class Automate implements Metadata.DeployCallback {
    
    public static void executeAll(){
        pathSetting(true);
        updateRemoteSiteSettings('https://123SiteURL.com');
        updateNamedCredentials('https://google.com', 'RightRevAuthProvider');
        insertRevenuePrefix('barPrefix');
        insertLicenseInformation('licenseKey');
        updateCustomMetadaRecords('URL', 'TenantId', 'clientId', 'Client_Secret', 'Username', 'Password');
        //newUserAndPermissionSet('gurrumkoushik1997@gmail.com', 'Standard User', 'koushikDev@dev.com');        
    }
    
    //The following code is used to enable the path setting in the salesforce org
    //Parameter : Boolean.
    //Input :True to enable, False to disable.
    public static void pathSetting(Boolean isEnable){
        List<MetadataService.OrganizationSettingsDetail> listOrgSetting = new List<MetadataService.OrganizationSettingsDetail>();
        MetadataService.OrganizationSettingsDetail orgSetting = new MetadataService.OrganizationSettingsDetail();
        orgSetting.settingName = 'PathAssistantsEnabled';
        orgSetting.settingValue = isEnable;
        listOrgSetting.add(orgSetting);
        
        MetadataService.OrgPreferenceSettings ops = new MetadataService.OrgPreferenceSettings();
        ops.fullName = 'PathAssistantsEnabled';
        ops.preferences = listOrgSetting;
        updateMetadata(ops);
    }
    
    //Creating a new User and assigning a permission set.
    //Parameters : String, String, String.
    @future
    public static void newUserAndPermissionSet(String email, String Profile, String username){
        
        Profile profileId = [select Id from Profile where name=:Profile limit 1];
        User SysAdmin= [SELECT Id,TimeZoneSidKey,LanguageLocaleKey,LocaleSidKey FROM User WHERE Profile.Name = 'System administrator' AND IsActive = true];
        User usr = new User(LastName = 'Integration Admin',
                            FirstName= 'RightRev',
                            Alias = 'admin',
                            Email = email,
                            Username = username,
                            ProfileId = profileId.id,
                            TimeZoneSidKey = SysAdmin.TimeZoneSidKey,
                            LanguageLocaleKey = SysAdmin.LanguageLocaleKey,
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = SysAdmin.LocaleSidKey);
        insert usr;
        
        PermissionSet PermissionSetToAssign = [SELECT Id,Name FROM PermissionSet WHERE Name=:'RightRev_Admin' LIMIT 1];
        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.PermissionSetId = PermissionSetToAssign.id;
        psa.AssigneeId = usr.id;
        insert psa;
    }
    
    //Custom settings RevenuePrefix__c
    //Inserting the RevenuePrefix__c values.
    //Parameters : String.
    @future
    public static void insertRevenuePrefix(String barPrefix){
        
        RevenuePrefix__c revPrefix = new RevenuePrefix__c();
        revPrefix.BarPrefix__c = barPrefix;
        revPrefix.SetupOwnerId = UserInfo.getOrganizationId();
        insert revPrefix;
    }
    
    //Inserting the LicenseInformation__c values.
    //Parameters : String.
    @future
    public static void insertLicenseInformation(String licenseKey){
        
        LicenseInformation__c licInfo = new LicenseInformation__c();
        licInfo.License_Key__c = licenseKey;
        licInfo.SetupOwnerId = UserInfo.getOrganizationId();
        insert licInfo;
    }
    
    //This method will Update Custom Metadata Values and Create new Auth.Provider.
    //Parameters : String, String, String, String, String, String, String.
    //Input: URL, TenantId, ClientId, Client Secret, Username, Password.
    @future(callout=true)
    public static void updateCustomMetadaRecords(String URL,String TenantId, String clientId, String Client_Secret, String Username, String Password){
        
        Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
        cMetadata.fullName = 'Auth_Provider__mdt' + '.' + 'RightRevAuthProvider';
        cMetadata.label = 'RightRevAuthProvider';
        String accesTocken = URL+'/realms/'+TenantId+'/protocol/openid-connect/token';
        
        Map<String, Object> metadataFieldValueMap = new Map<String, Object>();
        metadataFieldValueMap.put('Access_Token_Url__c', accesTocken);
        metadataFieldValueMap.put('Auth_Provider_Name__c', 'RightRevAuthProvider');
        metadataFieldValueMap.put('Client_Id__c', clientId);
        metadataFieldValueMap.put('Client_Secret__c', Client_Secret);
        metadataFieldValueMap.put('Username__c', Username);
        metadataFieldValueMap.put('Password__c', Password);
        
        for(String key : metadataFieldValueMap.keySet()){
            Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
            cMetadataValue.Field = key;
            cMetadataValue.Value = metadataFieldValueMap.get(key);
            cMetadata.values.add(cMetadataValue);
        }
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(cMetadata);
        Automate callback = new Automate();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }
    
    //This method will Update Custom Metadata Values and Create new Auth.Provider.
    //Parameters : String, String, String, String, String, String, String.
    //Input: URL, TenantId, ClientId, Client Secret, Username, Password.
    @future(callout=true)
    public static void updateCustomMetadaRecords1(String URL,String TenantId, String clientId, String Client_Secret, String Username, String Password){
        
        String accesTocken = URL+'/realms/'+TenantId+'/protocol/openid-connect/token';
        try{
            Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
            Metadata.CustomMetadata metadataRec =  new Metadata.CustomMetadata();
            metadataRec.fullName = 'Auth_Provider__mdt' + '.' + 'RightRevAuthProvider';
            metadataRec.label = 'RightRevAuthProvider';
            Map<String, Object> metadataFieldValueMap = new Map<String, Object>();
            metadataFieldValueMap.put('Access_Token_Url__c', accesTocken);
            metadataFieldValueMap.put('Auth_Provider_Name__c', 'RightRevAuthProvider');
            metadataFieldValueMap.put('Client_Id__c', clientId);
            metadataFieldValueMap.put('Client_Secret__c', Client_Secret);
            metadataFieldValueMap.put('Username__c', Username);
            metadataFieldValueMap.put('Password__c', Password);
            
            for(String key : metadataFieldValueMap.keySet()){
                Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
                cMetadataValue.Field = key;
                cMetadataValue.Value = metadataFieldValueMap.get(key);
                metadataRec.values.add(cMetadataValue);
                mdContainer.addMetadata(metadataRec);
            }
            system.debug('mdContainer-->'+mdContainer);            
            // Enqueue custom metadata deployment
            // jobId is the deployment ID
            Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, null);
            system.debug('jobId-->'+jobId);                                   
        }catch(exception ex){
            system.debug('exception '+ex.getMessage());                                 
        }
    }
    
    //Creating new AuthProvider.
    //Parameters : String.
    //Imput : Name of the Auth. Provider.
    @future(callout=true)
    public static void createAuthProvider(String Name){
        
        List<MetadataService.Metadata> allMetadataList = new List<MetadataService.Metadata>();
        MetadataService.AuthProvider authProvider = new MetadataService.AuthProvider();
        authProvider.fullName = Name;
        authProvider.friendlyName = Name;
        authProvider.providerType = 'Custom';
        authProvider.plugin = 'RevenueAuthProvider';
        authProvider.sendClientCredentialsInHeader = true;
        authProvider.customMetadataTypeRecord = 'Auth_Provider__mdt.RightRevAuthProvider';
        authProvider.executionUser = UserInfo.getUserName();
        allMetadataList.add(authProvider);
        if(allMetadataList.size()>0){
            MetadataService.MetadataPort service = createService();
            List<MetadataService.UpsertResult> results = service.upsertMetadata(allMetadataList);
            for(MetadataService.UpsertResult result: results){
                if(result.success){
                    system.debug('AuthProvider created success='+result);
                }else{
                    system.debug('error while creating AuthProvider:'+result.errors[0].message);
                }
            }
        }
    }
    
    //updateNamedCredntials is used to update existing Named Credentials.
    //Parameter: String, String.
    //Input: Endpoint URL, AuthProvider Name.
    @future(callout=true)
    public static void updateNamedCredentials(String Endpoint, String AuthProvider){
        
        MetadataService.NamedCredential credential = new MetadataService.NamedCredential();
        credential.fullName = 'RightRev';
        credential.label = 'RightRev';
        credential.endpoint = Endpoint;
        credential.principalType = 'NamedUser';
        credential.protocol = 'OAuth';
        credential.authProvider = AuthProvider;
        credential.oauthScope = 'Profile';
        credential.generateAuthorizationHeader = True;
        updateMetadata(credential);        
    }
    
    //updateRemoteSiteSettings is used to update the existing remote site settings.
    //Parameter: String.
    //Input: URL.
    public static void updateRemoteSiteSettings(String SiteURL){
        
        Map<string,string> RemoteSiteMap = new Map<string,string>();
        RemoteSiteMap.put('RightRevTokenEndpoint ',SiteURL);
        List<MetadataService.Metadata> allMetadataList = new List<MetadataService.Metadata>();
        for(string site: RemoteSiteMap.keyset()){
            MetadataService.RemoteSiteSetting remoteSiteDetails = new MetadataService.RemoteSiteSetting();
            remoteSiteDetails.fullName = site;
            remoteSiteDetails.description = 'Allow listing right rev token endpoint';
            remoteSiteDetails.disableProtocolSecurity  = false;
            remoteSiteDetails.isActive  = true;
            remoteSiteDetails.url=RemoteSiteMap.get(site);
            allMetadataList.add(remoteSiteDetails);
        }
        if(allMetadataList.size()>0){
            MetadataService.MetadataPort service = createService();
            List<MetadataService.UpsertResult> results = service.upsertMetadata(allMetadataList);
            for(MetadataService.UpsertResult result: results){
                if(result.success){
                    system.debug('Remote site settings updated success->'+result);
                }else{
                    system.debug('Error while updating remote site settings->'+result.errors[0].message);
                }
            }
        }
    }
    
    public static void updateCustomMetadata1(){
        
        String accesTocken = 'URL'+'/realms/'+'TenantId'+'/protocol/openid-connect/token';
        List<MetadataService.Metadata> allMetadataList = new List<MetadataService.Metadata>();
        
        MetadataService.CustomMetadata metadataRec =  new MetadataService.CustomMetadata();
        metadataRec.fullName = 'Auth_Provider__mdt' + '.' + 'RightRevAuthProvider';
        metadataRec.label = 'RightRevAuthProvider';
        Map<String, Object> metadataFieldValueMap = new Map<String, Object>();
        metadataFieldValueMap.put('Access_Token_Url__c', accesTocken);
        metadataFieldValueMap.put('Auth_Provider_Name__c', 'RightRevAuthProvider');
        metadataFieldValueMap.put('Client_Id__c', 'clientId1212');
        metadataFieldValueMap.put('Client_Secret__c', 'Client_Secret1212');
        metadataFieldValueMap.put('Username__c', 'Username1212');
        metadataFieldValueMap.put('Password__c', 'Password1212');
        
        List<MetadataService.CustomMetadataValue> lstcMetadataValue = new List<MetadataService.CustomMetadataValue>();
        for(String key : metadataFieldValueMap.keySet()){
            MetadataService.CustomMetadataValue cMetadataValue = new MetadataService.CustomMetadataValue();
            cMetadataValue.Field = key;
            cMetadataValue.Value = String.valueOf(metadataFieldValueMap.get(key));
            lstcMetadataValue.add(cMetadataValue);
            
        }
        metadataRec.values = lstcMetadataValue;
        System.debug('lstcMetadataValue-->'+lstcMetadataValue.size());
        System.debug('metadataRec-->'+metadataRec.values.size());
        allMetadataList.add(metadataRec);
        
        MetadataService.AuthProvider authProvider = new MetadataService.AuthProvider();
        authProvider.fullName = 'RightRevAuthProvider';
        authProvider.friendlyName = 'RightRevAuthProvider';
        authProvider.providerType = 'Custom';
        authProvider.plugin = 'RevenueAuthProvider';
        authProvider.sendClientCredentialsInHeader = true;
        authProvider.customMetadataTypeRecord = 'Auth_Provider__mdt.RightRevAuthProvider';
        authProvider.executionUser = UserInfo.getUserName();
        allMetadataList.add(authProvider);
        if(allMetadataList.size()>0){
            MetadataService.MetadataPort service = createService();
            List<MetadataService.UpsertResult> results = service.upsertMetadata(allMetadataList);
            for(MetadataService.UpsertResult result: results){
                if(result.success){
                    system.debug('AuthProvider created success='+result);
                }else{
                    system.debug('error while creating AuthProvider:'+result.errors[0].message);
                }
            }
        }
        
    }
    
    private static MetadataService.MetadataPort createService(){
        
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
    static List<MetadataService.SaveResult> updateMetadata(MetadataService.Metadata input){
        return createService().updateMetadata(new List<MetadataService.Metadata> { input });
    }
    
    //When deployment of custom metadata is completed handleResult method get called.
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug('Success Result-'+result);
            createAuthProvider('RightRevAuthProvider');
        } else {
            System.debug('Failed Result-'+result);
        }
    }
}