global class WeatherService implements WeatherInterface {
    
     public static final String API_KEY     = '79737f1cef0c35dec68cf40084c712ef';
     public static final String END_POINT   = 'http://api.openweathermap.org/data/2.5/weather';
     public static final String METHOD_TYPE = 'GET';
    
    
     global Static String getWeather(String cityName){
         
        String apiKey            = API_KEY;
		String requestEndpoint   = END_POINT;
        
		requestEndpoint += '?q=' + cityName;
		requestEndpoint += '&units=metric';
		requestEndpoint += '&APPID=' + apiKey;
        
        Http http = new Http();
 
		// send HTTP request
		HttpRequest req = new HttpRequest();
		req.setEndpoint(requestEndpoint);
		req.setMethod(METHOD_TYPE);
 
		//  return a response
		HttpResponse res = http.send(req);
        String responseBody = res.getBody();
         
        return responseBody;
    }
}