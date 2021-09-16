({
	handleHashTagChanges : function(component, event, helper) {
		console.log("---- locationChange event got fired -----");
        var urlToken = event.getParam("token");
        console.log("HashTag value => "+urlToken);
	}
})