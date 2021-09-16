({
	doHandle : function(component, event, helper) {
		console.log("child fired..... parent handled......");
        var paramFromChild = event.getParam("greetMessage");
        console.log(paramFromChild);
	}
})