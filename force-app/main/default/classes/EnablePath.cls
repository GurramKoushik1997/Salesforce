public class EnablePath {
    
    public static void pathSetting(Boolean isEnable){
        List<MetadataService.OrganizationSettingsDetail> listOrgSetting = new List<MetadataService.OrganizationSettingsDetail>();
        MetadataService.OrganizationSettingsDetail orgSetting = new MetadataService.OrganizationSettingsDetail();
        orgSetting.settingName = 'PathAssistantsEnabled';
        orgSetting.settingValue = isEnable;
        listOrgSetting.add(orgSetting);
        
        MetadataService.OrgPreferenceSettings orp = new MetadataService.OrgPreferenceSettings();
        orp.fullName = 'PathAssistantsEnabled';
        orp.preferences = listOrgSetting;
        System.debug('-->'+updateMetadata(orp));
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
}
/*
 *Line: 13233, Column: 1
System.CalloutException: Web service callout failed: WebService returned a SOAP Fault: Must specify a {http://www.w3.org/2001/XMLSchema-instance}type attribute value for the {http://soap.sforce.com/2006/04/metadata}metadata element faultcode=soapenv:Client faultactor=
 */