public with sharing class RevenueAuthProvider extends Auth.AuthProviderPluginClass{
    //public static final String NAMESPACE='RR';
    public static final string CUSTOM_MDT_NAME='Auth_Provider__mdt';
    public static final string AUTH_PROVIDER_FIELD='Auth_Provider_Name__c';
    public static final string RESOURCE_CALLBACK='/services/authcallback/';
    public static final string DUMMY_CODE='dummycode';
    public static final string CLIENT_ID='client_id';
    public static final string CLIENT_ID_FIELD='Client_Id__c';
    public static final string CLIENT_SECRET='client_secret';
    public static final string CLIENT_SECRET_FIELD='Client_Secret__c';
    public static final string USER_NAME='username';
    public static final string USER_NAME_FIELD='Username__c';
    public static final string PASSWORD='password';
    public static final string PASSWORD_FIELD='Password__c';
    public static final string GRANT_TYPE='grant_type';
    public static final string GRANT_TYPE_VALUE='password';
    public static final string GRANT_TYPE_REFRESH_VALUE='refresh_token';
    public static final string ACCESS_TOKEN_URL_FIELD='Access_Token_Url__c';
    public static final string URL_ENCODE_FORMAT='UTF-8';
    public static final string CALLOUT_METHOD='POST';
    public static final string CONTENT_TYPE_VALUE='application/x-www-form-urlencoded';
    public static final string CONTENT_TYPE_HEADER='Content-Type';
    public static final string REFRESH_TOKEN='refresh_token';
    public static final string ENCRYPTION_ALGORITHM='AES128';
    public static final string NO_SECRET='Unable to find any secret key';
    
    /**
     * @description: get the field/object name with proper namespace
     * 
     **/
    private String getNameSpacedName(String fieldName){
        /*if(NAMESPACE!=null)
            return NAMESPACE+'_'+fieldName;
        else
            return fieldName;*/
        return CUSTOM_MDT_NAME;
    }
    /**
        Name of custom metadata type to store this auth provider configuration fields
    **/
    public String getCustomMetadataType() {
        return getNameSpacedName(CUSTOM_MDT_NAME);
    } 
    
    /**
     * @description: Since the framewaork support Wes Server flow and since here is not authorization URL 
     *               to re-direct to, the method directs back to callback URL so the admin does not get the
     *               Auth page.
     * @params : Map<string,string>-config - metadata field value map
     *           Sring-state - state to send. The same would be returned in callback.
     * @return : PageReference-the url of oAuth Page. This Case callback url itself.
     */
    public PageReference initiate(Map<string,string> config, String stateToSend) {
        final String generatedUrl = URL.getSalesforceBaseUrl().toExternalForm() + RESOURCE_CALLBACK + config.get(getNameSpacedName(AUTH_PROVIDER_FIELD));
        Pagereference pgRef=new Pagereference(generatedUrl);
        pgRef.getParameters().put('state',stateToSend);
        pgRef.getParameters().put('code',DUMMY_CODE);
        return pgRef;
    }
    /**
     * @description: Actuall callout method to make request to get Access Token.
     * @params : Map<string,string>-config - metadata field value map
     *           Auth.AuthProviderCallbackState -state - state received on callback.
     * @retuen : AuthProviderTokenResponse - containig token.
     */
    public Auth.AuthProviderTokenResponse handleCallback(Map<string,string> config, Auth.AuthProviderCallbackState state ) {
        Auth.AuthProviderTokenResponse authProviderTokenResponse=null;
        try{
            HttpResponse response=makeCallout(config,null,false);
            if(response.getStatusCode()!=200){
                throw new Auth.AuthProviderPluginException(response.getBody());
            }
            TokenResponse tokenRes=(TokenResponse)JSON.deserialize(response.getBody(),TokenResponse.class);
            authProviderTokenResponse=new Auth.AuthProviderTokenResponse(config.get(getNameSpacedName(AUTH_PROVIDER_FIELD)),
                                                                    tokenRes.access_token,
                                                                    tokenRes.refresh_token,
                                                                    state.queryParameters.get('state'));
        }catch(Exception e){
            throw new Auth.AuthProviderPluginException(e.getMessage());
        }
        return authProviderTokenResponse;
    }
    /**
     * @description: method to make API callout to get token
     */
    private HttpResponse makeCallout(Map<string,string> config,String refreshToken,Boolean isRefreshFlow){
        HttpRequest request=new HttpRequest();
        request.setEndpoint(config.get(getNameSpacedName(ACCESS_TOKEN_URL_FIELD)));
        request.setMethod(CALLOUT_METHOD);
        request.setHeader(CONTENT_TYPE_HEADER, CONTENT_TYPE_VALUE);
        if(!isRefreshFlow){
            request.setBody(getRequestBody(config));
        }else{
            request.setBody(getRequestBody(refreshToken,config));
        }
        return new Http().send(request);
    }
    /**
     * @description: method to get request body for Access Token
     */
    private String getRequestBody(Map<string,string> config){
        String body=GRANT_TYPE+'='+GRANT_TYPE_VALUE+'&';
        body+=CLIENT_ID+'='+config.get(getNameSpacedName(CLIENT_ID_FIELD))+'&';
        body+=CLIENT_SECRET+'='+getDecrypted(config.get(getNameSpacedName(CLIENT_SECRET_FIELD)))+'&';
        body+=USER_NAME+'='+config.get(getNameSpacedName(USER_NAME_FIELD))+'&';
        body+=PASSWORD+'='+getDecrypted(config.get(getNameSpacedName(PASSWORD_FIELD)));
        //return EncodingUtil.urlEncode(body,URL_ENCODE_FORMAT);
        return body;
    }

    /**
     * @description: method to get request body for Refresh Token
     */
    private String getRequestBody(String refreshToken,Map<string,string> config){
        String body=GRANT_TYPE+'='+GRANT_TYPE_REFRESH_VALUE+'&';
        body+=CLIENT_ID+'='+config.get(CLIENT_ID_FIELD)+'&';
        body+=CLIENT_SECRET+'='+getDecrypted(config.get(getNameSpacedName(CLIENT_SECRET_FIELD)))+'&';
        body+=REFRESH_TOKEN+'='+refreshToken;
        return body;
    }

    /**
     * @description: Get new accessToken for received refreshToken
     */
    public override Auth.OAuthRefreshResult refresh(Map<String,String> config, String refreshToken) {
        Auth.OAuthRefreshResult refreshResult=null;
        String error=null;
        TokenResponse tokenRes;
        try{
            HttpResponse response=makeCallout(config,refreshToken,true);
            if(response.getStatusCode()==200){
                tokenRes=(TokenResponse)JSON.deserialize(response.getBody(),TokenResponse.class);
            }else{
                response=makeCallout(config,null,false);
                if(response.getStatusCode()==200){
                    tokenRes=(TokenResponse)JSON.deserialize(response.getBody(),TokenResponse.class);
                }else{
                    error=response.getBody(); 
                    throw new Auth.AuthProviderPluginException(error);
                }
            }
        }catch(Exception e){
            error=e.getMessage();
            throw new Auth.AuthProviderPluginException(error);
        }
        if(tokenRes!=null){
            refreshResult=new Auth.OAuthRefreshResult(
                                                  tokenRes.access_token,
                                                  tokenRes.refresh_token,
                                                  error
                                                  );
        }
        return refreshResult;
    }

    /**
     * @description: Get decrypted passowrds
     */
    private String getDecrypted(String encodedCipher){
        List<Revenue_Key__mdt> secretStore=[Select Key__c FROM Revenue_Key__mdt  WHERE DeveloperName ='Secret' WITH SECURITY_ENFORCED];
        if(secretStore.isEmpty())throw new AuthException(NO_SECRET);
        String secretKey=secretStore[0].Key__c;
        Blob key=Blob.valueOf(LicenseInformation__c.getOrgDefaults().License_Key__c.left(16));
        Blob iv=Blob.valueOf(secretKey.left(16));
        Blob encrypted=EncodingUtil.base64Decode(encodedCipher);
        Blob decrypted = Crypto.decrypt(ENCRYPTION_ALGORITHM, key,iv,encrypted);
        return decrypted.toString();
    }
    
    /**
     * @description: Get decrypted passowrds
     */
    public static String getEncrypted(String decodedCipher){
        List<Revenue_Key__mdt> secretStore=[Select Key__c FROM Revenue_Key__mdt  WHERE DeveloperName ='RR_Tenant_Secret' WITH SECURITY_ENFORCED];
        if(secretStore.isEmpty())throw new AuthException(NO_SECRET);
        //String secretKey=secretStore[0].Key__c;
        String secretKey = EncodingUtil.base64Decode(secretStore[0].Key__c).toString();
        Blob key=Blob.valueOf(LicenseInformation__c.getOrgDefaults().License_Key__c.left(16));
        Blob iv=Blob.valueOf(secretKey.left(16));
        Blob encrypted = Crypto.encrypt(ENCRYPTION_ALGORITHM, key,iv,Blob.valueof(decodedCipher));
        String encryptedCipher=EncodingUtil.base64Encode(encrypted);
        return encryptedCipher;
    }

    /**
     * @description: Returns information from the custom authentication provider about the current user. 
     * Not very applicable for the current flow. Returning a dummy user.
     */
    public Auth.UserData getUserInfo(Map<string,string> config, Auth.AuthProviderTokenResponse response) {
        return new Auth.UserData(
                              config.get(getNameSpacedName(CUSTOM_MDT_NAME)) // identifier
                            , null // firstName
                            , null // lastName
                            , null // fullName
                            , null // email
                            , null // link
                            , config.get(getNameSpacedName(USER_NAME_FIELD)) // userName
                            , null  //locale
                            , config.get(getNameSpacedName(CUSTOM_MDT_NAME)) //provider
                            , null // siteLoginUrl
                            , new Map<String,String>());
    }

    public class TokenResponse{
         public String access_token;
         public Integer expires_in;
         public Integer refresh_expires_in;
         public String refresh_token;
         public String token_type;
         public String scope;
    }
    
    public class AuthException extends Exception{}

}