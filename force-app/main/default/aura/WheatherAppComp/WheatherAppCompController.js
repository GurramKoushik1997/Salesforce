({
	Input: function(component, event, helper) {
      component.set("v.Input", true);
      component.set("v.showResult", false); 
    },
    
    
    closeModel: function(component, event, helper) {
      component.set("v.Input", false);
      component.set("v.showResult", false);
       
       component.set("v.CityName"," ");
   },
 
   doSubmit : function(component, event, helper) {
		if((component.get("v.CityName") == null) || (component.get("v.CityName") == " ")){
            toastEvent.setParams({ "title": "Error!", "type": "Error", "message":"Please enter a valid City" });
            toastEvent.fire();   
        } else {
            //component.set("v.toggleSpinner", true);
            console.log('calling the server');
            var action = component.get("c.getTemparature");
            action.setParams({
                "City": component.get("v.CityName")
            });
        $A.enqueueAction(serverActionVar);
   }
   }
})