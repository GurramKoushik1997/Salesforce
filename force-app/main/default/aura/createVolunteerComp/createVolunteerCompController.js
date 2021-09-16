({
	doSubmit : function(component, event, helper) {
		console.log("---- doSubmit invoked -----");
        var vName   = component.get("v.volunteerName");
        var vHeight = component.get("v.volunteerHeight");
        var vWeight = component.get("v.volunteerWeight");
        var vMobile = component.get("v.volunteerMobile");
        var vEmail  = component.get("v.volunteerEmail");
        
        var serverActionVar = component.get("c.createVolunteer");
        serverActionVar.setParams({"volName":vName,
                                   "volHeight" : vHeight,
                                   "volWeight" : vWeight,
                                   "volMobile" : vMobile,
                                   "volEmail"  : vEmail
                                  });
        serverActionVar.setCallback(this, function(callBackResp){
            console.log("--- server side call success:: volunteer created ---");
            component.set("v.volId", callBackResp.getReturnValue());
        });
        $A.enqueueAction(serverActionVar);
        
	}
})