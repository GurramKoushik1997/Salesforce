public class GetPerson {
  public String name {get;set;}
  public Integer age {get;set;}
  public Car car {get;set;}
  
  public class Car {
    public String model {get;set;}
    public String year {get;set;}
  }
}

//String input1 = '{"name":"paulo","age":42, "married":true, "car" : {"model" : "outlander", "year" : "2016"}}';