({ 
    getWheather: function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({ "title": "Success!", "type": "Success", "message":"Message is From Submit Button" });
        //toastEvent.setParams({ "title": "Error!", "type": "Error", "message": "This"+$A.get("$Label.c.DemoLabel")});
        toastEvent.fire();
    }
})