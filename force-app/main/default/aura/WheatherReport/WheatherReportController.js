({
   processInput: function(component, event, helper) {
      component.set("v.showInput", true);
      component.set("v.showResult", false);
      component.set("v.cName","");
      component.set("v.showCity", true);
   },
   closeModel: function(component, event, helper) {
      component.set("v.showInput", false);
      component.set("v.showResult", false);
      component.set("v.cName","");
   },
    
    ClosePopup: function(component, event, helper) {
      component.set("v.showInput", false);
      component.set("v.showResult", false);
    },
   showResults: function(component, event, helper) {
      component.set("v.showInput", false);
      component.set("v.showResult", true);
   },
    OnSubmit: function(component, event, helper) {
      component.set("v.showInput", false);
      component.set("v.showResult", true);
      component.set("v.showInput", true);
      
   },

    getWheather: function(component, event, helper) {

        var toastEvent = $A.get("e.force:showToast");
        
       // var input = Pattern.matches("^[0-9]+$", component.get("v.cName"));
        //console.log('*****'+input+'*******');
        console.log('====='+component.get("v.cName")+'======');
        if((component.get("v.cName") == null) || (component.get("v.cName") == "")){
            toastEvent.setParams({ "title": "Error!", "type": "Error", "message":"City Name Should not be EMPTY" });
            //toastEvent.setParams({ "title": "Error!", "type": "Error", "message": "This"+$A.get("$Label.c.DemoLabel")});

            toastEvent.fire();
        }else {
            console.log('====='+component.get("v.cName")+'======');
            console.log('calling the server');
            var action = component.get("c.getTemparature");
            
            action.setParams({'cityName' : component.get("v.cName")});
            action.setCallback(this, function(response) {
                var state = response.getState();
                var r = response;
                console.log('===='+state+'====');
                if(state === 'SUCCESS') {
                    component.set("v.showCity", false);
                    component.set("v.Result",response.getReturnValue());
                    var responseObj = JSON.parse(response.getReturnValue());
                    
                    var Temp = responseObj.temperature;
                    component.set("v.Temperature",Temp);
                    console.log('temp==='+Temp);
                    
                    var humidity = responseObj.humidity;
 					component.set("v.Humidity",humidity);
                    console.log('humidity==='+humidity);
                    
                    var feels_like = responseObj.feels_like;
 					component.set("v.Feels_Like",feels_like);
                    console.log('feels_Like==='+feels_like);
                    
                    var pressure = responseObj.pressure;
                    component.set("v.Pressure",pressure);
                    console.log('pressure==='+pressure);
                    
                    var service = responseObj.service;
                    component.set("v.Mock",service);
                    console.log('service==='+service);
                    
                    var errormsg = responseObj.error;
                    component.set("v.error",errormsg);
                    console.log('errormsg==='+errormsg);
                    //console.log('Result======',response.getReturnValue());
                    console.log('response----'+JSON.stringify(responseObj));
                    //var res = responseObj.result;
                    //console.log('result==='+JSON.Stringify(res));
                    
                    
                   // alert('successfully fetched data from server');
                } else {
                   //alert('Unable to fetch data from server');
                }               
            });
            $A.enqueueAction(action);
        }
    }
})