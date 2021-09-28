public class Spoonacular {
    Private Static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    Private Static final String API_KEY = '7a3bd00c744e4462a5cf52f0cb3cc0c7';
    
    @AuraEnabled
    public static String getRandomRecipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getstatuscode() == 200){
            return response.getBody();
        }else{
            return '';
        }
    }
    
    @AuraEnabled
    public static String getRecipe(String recipeId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/'+recipeId+'/information?apiKey='+API_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getstatuscode() == 200){
            return response.getBody();
        }else{
            return '';
        }
    }
    
    @AuraEnabled
    public static String getRecipeByIngredients(String ingredients){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/findByIngredients?apiKey='+API_KEY+'&ingredients='+ingredients);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if(response.getstatuscode() == 200){
            return response.getBody();
        }else{
            return '';
        }
    }
}