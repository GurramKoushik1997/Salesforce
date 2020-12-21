@isTest
public class WheatherTest {
    
  /*  @isTest 
    static void isMock(){
        
        //Data setup
        Boolean enable = false;
        config__c customField    =  new config__c(Name = 'isMock' ,Value__c = enable);
		insert customField;
        System.debug('customField====='+customField.Value__c);
        
        String values = '{"tempe":31.0,"press":1007,"isMock":"This is From Mock Service","hum":62,"cName":"Chennai"}';    
        
        String cityName = 'Chennai';
        
        //call function
        Test.startTest();
        String weather = Wheather.getTemparature(cityName);
        Test.stopTest();
        
        System.debug('weather==='+weather);
        //Assertion
        System.assert(weather == values);
    }*/
}