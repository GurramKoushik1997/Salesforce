public class WeatherServiceMock implements WeatherInterface {
    
    public static final String NELLORE_RESPONSE   = '{"coord":{"lon":79.97,"lat":14.43},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":32,"feels_like":32.62,"temp_min":32,"temp_max":32,"pressure":1003,"humidity":64,"sea_level":1003,"grnd_level":1001}}';
    public static final String CHENNAI_RESPONSE   = '{"coord":{"lon":80.28,"lat":13.09},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":31,"feels_like":32.94,"temp_min":31,"temp_max":31,"pressure":1007,"humidity":62}}';
    public static final String BENGALURU_RESPONSE = '{"coord":{"lon":77.6,"lat":12.98},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":28.06,"feels_like":31.82,"temp_min":27,"temp_max":29.44,"pressure":1011,"humidity":74}}';
    public static final String ERROR_RESPONSE     = '{"cod":"404","message":"city not found"}';
    public static final String NELLORE_CITY       = 'Nellore';
    public static final String CHENNAI_CITY       = 'Chennai';
    public static final String BENGALURU_CITY     = 'Bengalore';
    
    public String getWeather(String cityName){
        
        String responseBody = null;
        
        if(cityName == NELLORE_CITY){
           responseBody = NELLORE_RESPONSE;
        }else if(cityName == CHENNAI_CITY){
            responseBody = CHENNAI_RESPONSE;
        }else if(cityName == BENGALURU_CITY){
            responseBody = BENGALURU_RESPONSE;
        }else{
            responseBody = ERROR_RESPONSE;
        }
        System.debug('cityName===='+cityName+'====');
        System.debug('responseBody===='+responseBody);
        return responseBody;
    }
}