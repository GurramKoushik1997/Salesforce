public class WeatherReport {
    public Coordinates coord {get;set;}
    public MainParameters main {get;set;}
    
    public String message {get;set;}
    public Integer cod    {get;set;}
    
    
    public class Coordinates{
        public Decimal lon {get;set;}
        public Decimal lat {get;set;}
    }
    public class MainParameters{
     public Decimal temp      {get;set;}
	 public Integer pressure  {get;set;}
     public Integer humidity  {get;set;}
  }
}

//{"cod":"404","message":"city not found"}