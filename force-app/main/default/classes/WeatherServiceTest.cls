@isTest
public class WeatherServiceTest {
    
    @isTest
    static void ServiceTest(){
        
        //Data Setup
        String city = 'Chennai';
        
        //Call Function
        Test.startTest();
        WeatherInterface wi = new WeatherService();
        String weather = wi.getWeather(city);
        Test.stopTest();
        
        //Assertion
        System.assert(String.isNotEmpty(weather));
        
    }

}