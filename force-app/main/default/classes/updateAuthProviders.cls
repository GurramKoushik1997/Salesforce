public class updateAuthProviders implements Metadata.DeployCallback {
    
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug('Success Result');
        } else {
            System.debug('Failed Result');
        }
    }
    
    //Update Custom Metadata record
    public static void updateCustomMetadata(String accesTocken, String clientId){
        Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
        cMetadata.fullName = 'Auth_Provider__mdt' + '.' + 'RightRevAuthProvider';
        cMetadata.label = 'RightRevAuthProvider';
        
        String token = '----'+accesTocken+'----';
        Map<String, Object> metadataFieldValueMap = new Map<String, Object>();
        metadataFieldValueMap.put('Access_Tocken_Url__c', token);
        metadataFieldValueMap.put('Client_Id__c', clientId);
        
        for(String key : metadataFieldValueMap.keySet()){
            Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
            cMetadataValue.Field = key;
            cMetadataValue.Value = metadataFieldValueMap.get(key); 
            cMetadata.values.add(cMetadataValue);
        }
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(cMetadata);
        updateAuthProviders callback = new updateAuthProviders();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }
    /*
     //Updating the AuthProvider metadata Values.
//Parameters : String, String, String, String, String.
//Values to Pass as String : TenantId, ClientId, Client Secret, Username, Password.
public static void updateCustomMetadata(String TenantId, String clientId, String Client_Secret, String Username, String Password){
    Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
    cMetadata.fullName = 'Auth_Provider__mdt' + '.' + 'RightRevAuthProvider';
    cMetadata.label = 'RightRevAuthProvider';
    String accesTocken = 'https://authn.dev.rightrev.cloud/auth/realms/'+TenantId+'/protocol/openid-connect/token';
        
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
    PostInstallation callback = new PostInstallation();
    Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
}*/
}