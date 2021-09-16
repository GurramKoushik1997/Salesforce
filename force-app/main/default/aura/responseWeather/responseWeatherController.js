({
    showMyToast : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Please Enter City",
        "type": "info",
        "message": 'To check Weather in another valid City',
    });
    toastEvent.fire();
},
    processInput: function(component, event, helper) {
      var action = component.get('c.showMyToast');
      $A.enqueueAction(action);
      component.set("v.cName","");
      component.set("v.showInput", false);
        
      component.set("v.city","");
      component.set("v.temperature","");
      component.set("v.feel","");
   },
    closeModel: function(component, event, helper) {
      component.set("v.showInput", false);
      component.set("v.cName","");
        
      component.set("v.city","");
      component.set("v.temperature","");
      component.set("v.feel","");
   },
	getW: function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        
        if((component.get("v.cName") == null) || (component.get("v.cName") == "")){
            toastEvent.setParams({ "title": "Error!", "type": "Error", "message":"City Name Should not be EMPTY" });
            toastEvent.fire();
        }else {
        
        	component.set("v.showInput", true);
            var action = component.get("c.getWeather");
            action.setParams({'cityName' : component.get("v.cName")});
            action.setCallback(this, function(response) {
                var state = response.getState();
                console.log('===='+state+'====');
                var responseObj = JSON.parse(response.getReturnValue());                
                var r = JSON.stringify(responseObj.cod);
                if(state === 'SUCCESS') {
                    console.log('--inside if 1--');
                    if(r == 200){
                    
                    var city = JSON.stringify(responseObj.name);
                    component.set("v.city",city);
                    var temp = JSON.stringify(responseObj.main.temp);
                    component.set("v.temperature",temp);
                    var feel = JSON.stringify(responseObj.main.feels_like);
                    component.set("v.feel",feel);
                    component.set("v.showData", true);
                    component.set("v.showlay", false);
                    
                    }else{
                    	component.set("v.city","");
                    	component.set("v.temperature","");
                    	component.set("v.feel","");
                        
                        component.set("v.showlay", true);
                        component.set("v.showData", false);
                        toastEvent.setParams({ "title":component.get("v.cName"), "type": "Error", "message":"PLEASE Enter a valid City Name"});
                        toastEvent.fire();
                    }
                } else {
                   alert('Unable to fetch data from server');
                }      
            });
            $A.enqueueAction(action);
        }
    }
})