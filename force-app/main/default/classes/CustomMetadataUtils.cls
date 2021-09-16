public class CustomMetadataUtils implements Metadata.DeployCallback {
    
    //Inteface method 
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            //Success
            System.debug('Success Result-' + result);
        } else {
            //Failed
            System.debug('Failed Result-' + result);
        }
    }
    
    //Create Custom Metadata record
    public static void createCustomMetadata(String accessToken,String AuthProviderName,String ClientId, String clientSecrect, String username, String password){
        
        Map<String, String> metadataFieldValueMap = new Map<String, String>();
        metadataFieldValueMap.put('Access_Token_Url__c',accessToken );
        metadataFieldValueMap.put('Auth_Provider_Name__c', AuthProviderName);
        metadataFieldValueMap.put('Client_Id__c', ClientId);
        metadataFieldValueMap.put('Client_Secret__c',clientSecrect );
        metadataFieldValueMap.put('Username__c', username);
        metadataFieldValueMap.put('Password__c', password);
        
        String recordDevName = 'RightRevAuthProvider'.replaceAll(' ', '_');
        Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
        cMetadata.fullName = 'Auth_Provider__mdt' + '.' + recordDevName;
        cMetadata.label = 'RightRevAuthProvider';
        
        for(String key : metadataFieldValueMap.keySet()){
            Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
            cMetadataValue.Field = key;
            cMetadataValue.Value = metadataFieldValueMap.get(key); 
            cMetadata.values.add(cMetadataValue);
        }
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(cMetadata);
        CustomMetadataUtils callback = new CustomMetadataUtils();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }
    
    //Update Custom Metadata record
    public static void updateCustomMetadata(String accessToken,String AuthProviderName,String ClientId, String clientSecrect, String username, String password){
        
        Map<String, String> metadataFieldValueMap = new Map<String, String>();
        metadataFieldValueMap.put('Access_Token_Url__c',accessToken );
        metadataFieldValueMap.put('Auth_Provider_Name__c', AuthProviderName);
        metadataFieldValueMap.put('Client_Id__c', ClientId);
        metadataFieldValueMap.put('Client_Secret__c',clientSecrect );
        metadataFieldValueMap.put('Username__c', username);
        metadataFieldValueMap.put('Password__c', password);
        
        Metadata.CustomMetadata cMetadata = new Metadata.CustomMetadata();
        cMetadata.fullName = 'Auth_Provider__mdt' + '.' + 'RightRevAuthProvider';
        cMetadata.label = 'RightRevAuthProvider';
        
        for(String key : metadataFieldValueMap.keySet()){
            Metadata.CustomMetadataValue cMetadataValue = new Metadata.CustomMetadataValue();
            cMetadataValue.Field = key;
            cMetadataValue.Value = metadataFieldValueMap.get(key); 
            cMetadata.values.add(cMetadataValue);
        }

        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(cMetadata);
        CustomMetadataUtils callback = new CustomMetadataUtils();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }
}