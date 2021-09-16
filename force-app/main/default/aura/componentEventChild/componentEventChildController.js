({
	doFire : function(component, event, helper) {
		var cmpEvt = component.getEvent("grtEvt");
        cmpEvt.setParams({"greetMessage" : component.get("v.msg")});
        cmpEvt.fire();
	}
})