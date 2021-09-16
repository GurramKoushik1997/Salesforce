global class WeatherService implements WeatherInterface {
    
     public static final String API_KEY     = '79737f1cef0c35dec68cf40084c712ef';
     public static final String END_POINT   = 'http://api.openweathermap.org/data/2.5/weather';
     public static final String METHOD_TYPE = 'GET';
    
    @AuraEnabled
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
        System.debug('responseBody ====== '+responseBody);

        return responseBody;
    }
}

/*
  -------------------- RESPONSE JSON FROM WEB SERVICE -----------------------
 {
  "coord": {
    "lon": 79.97,
    "lat": 14.43
  },
  "weather": [
    {
      "id": 802,
      "main": "Clouds",
      "description": "scattered clouds",
      "icon": "03d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 28.22,
    "feels_like": 28.14,
    "temp_min": 28.22,
    "temp_max": 28.22,
    "pressure": 1014,
    "humidity": 62,
    "sea_level": 1014,
    "grnd_level": 1012
  },
  "visibility": 10000,
  "wind": {
    "speed": 5.56,
    "deg": 70
  },
  "clouds": {
    "all": 29
  },
  "dt": 1609306817,
  "sys": {
    "country": "IN",
    "sunrise": 1609290244,
    "sunset": 1609330862
  },
  "timezone": 19800,
  "id": 1261529,
  "name": "Nellore",
  "cod": 200
}
--------------WHEN CITY NOT FOUND-----------------------
{"cod":"404","message":"city not found"}
*/