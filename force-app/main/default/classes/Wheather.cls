public with sharing class Wheather {
    
    public static final String WEATHER_SERVICE_MOCK_ENABLED = 'IsMockEnabled';
    public static final String FROM_WEATHER_SERVICE         = 'This service is from WeatherService Report';
    public static final String FROM_MOCK_SERVICE            = 'This service is from Mock';
    public static final String NO_Value						= null;
    public static final Boolean ENABLE                      = true;
    public static final Boolean NOT_ENABLE                  = false;
    
    
    @AuraEnabled
    public static String getTemparature(String cityName) {
        
        config__c isMockEnable = config__c.getInstance(WEATHER_SERVICE_MOCK_ENABLED);
        String cName           = cityName;
        String result          = null;
        
        WeatherInterface wi = null;
        if(isMockEnable.Check_Box_Value__c == NOT_ENABLE){
            System.debug('this is mock');
            wi = new WeatherServiceMock();
        }else{
            System.debug('this is weather');
            wi = new WeatherService();
        }
        result               = wi.getWeather(cityName);
		WeatherReport report = (WeatherReport) JSON.deserialize(result, WeatherReport.class);
		System.debug('report===='+report);		        
        String City                      = cityName;
        ResponseJSONWrapper responseJSON = new ResponseJSONWrapper();
        responseJSON.cName               = City;
        if(report.main != null){
            responseJSON.temperature = report.main.temp;
            responseJSON.humidity    = report.main.humidity;
            responseJSON.pressure    = report.main.pressure;
        }else{
            responseJSON.temperature = 0.0;
            responseJSON.humidity    = 0;
            responseJSON.pressure    = 0;
            responseJSON.error       = '\n\n'+report.message;
        }
        
        if(isMockEnable.Check_Box_Value__c != false){
            responseJSON.service = FROM_MOCK_SERVICE;
        }else{
            responseJSON.service = FROM_WEATHER_SERVICE;
        }
        return JSON.serialize(responseJSON);
    }
    
    public class ResponseJSONWrapper {
      public String cName         = null;
      public Decimal temperature  = null;
      public Integer humidity     = null;
      public Integer pressure     = null;
      public String service       = null;
      public String error		  = null;
    }
}