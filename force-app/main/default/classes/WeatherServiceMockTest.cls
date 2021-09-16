@isTest
public class WeatherServiceMockTest {
    
    public static final String RESPONSE_BODY      = '{"coord":{"lon":80.28,"lat":13.09},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":31,"feels_like":32.94,"temp_min":31,"temp_max":31,"pressure":1007,"humidity":62}}';    
    public static final String ERROR_RESPONSE     = '{"cod":"404","message":"city not found"}';
    public static final Integer STATUS_CODE       = 200;
    public static final String POSITIVE_INPUT     = 'Chennai';
    public static final String NEGETIVE_INPUT     = 'xyz';
    
    @isTest
    static void weatherService_valid_CityName(){
        
        //Data setup
        String cityName = POSITIVE_INPUT;
        
     	//call function
        WeatherInterface wi = new WeatherServiceMock();
        Test.setMock(HttpCalloutMock.class, new CalloutMock());  
        String result = null;
        Test.startTest();
        	result = wi.getWeather(cityName);
   		Test.stopTest();
        
        //Assertion
        System.assertEquals(RESPONSE_BODY, result, 'The response should match');
        
    }
    
    @isTest
    static void weatherService_InValid_CityName(){
        
        
        //Data setup
        String cityName = NEGETIVE_INPUT;
        
     	//call function
        WeatherInterface wi = new WeatherServiceMock();
        Test.setMock(HttpCalloutMock.class, new CalloutMock());  
        String result = null;
        Test.startTest();
        	result = wi.getWeather(cityName);
   		Test.stopTest();
        
        //Assertion
        System.assertEquals(ERROR_RESPONSE, result, 'The response should match');
        
    }
    public class CalloutMock implements HttpCalloutMock{
        
        public HttpResponse respond(HttpRequest request){
            HttpResponse response = new HttpResponse();
            if(request.getEndpoint().containsIgnorecase(NEGETIVE_INPUT)) {
               response.setBody(ERROR_RESPONSE);
            }else{
                response.setBody(RESPONSE_BODY);
            }
        	response.setStatusCode(STATUS_CODE);
            return response;
        }
    }
}