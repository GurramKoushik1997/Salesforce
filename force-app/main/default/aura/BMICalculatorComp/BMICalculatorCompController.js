({
	calculateBMI : function(bmiComp, bmiEvent, bmiHelper) {
		console.log("--------------- START OF calculateBMI -----------------");
        var gNameCmp = bmiComp.find("gName");
        var gNameCmpValue = gNameCmp.get("v.value");
        console.log("gname is => "+gNameCmpValue);
        //gNameCmp.set("v.label","Enter Guest Name Please");
        
        if(gNameCmpValue.length < 6)
        {
            gNameCmp.set("v.errors" , [{message : "You have to type min 5 chars."}]);
            
        }
        else
        {
            gNameCmp.set("v.errors", null);
            var gHeight = bmiComp.get("v.guestHeight");
            var gWeight = bmiComp.get("v.guestWeight");
            var BMI = gWeight / ( gHeight / 100 * gHeight / 100)
            var BMIRound = Math.round(BMI*10)/10;
            console.log(BMIRound);
            var gCategory;
            if(BMIRound < 18.5)
            {
                gCategory = "UNDER-WEIGHT";
            }else if(BMIRound > 18.5 && BMIRound < 25)
            {
                gCategory = "NORMAL-WEIGHT";
            }else
                gCategory = "OVER-WEIGHT";
            
            bmiComp.set("v.BMICategory",gCategory);
            console.log(gCategory);
    	}
	},
    
    doNavigate : function(bmiComp, event, helper) {
        var gName   = bmiComp.find("gName").get("v.value");
	    var gHeight = bmiComp.get("v.guestHeight");
        var gWeight = bmiComp.get("v.guestWeight");
        var paramstag = "?vName="+gName+"&vHeight="+gHeight+"&vWeight="+gWeight;
        var urlEvent = $A.get("e.force:navigateToURL");
     urlEvent.setParams({"url": "https://complete-lightning-dev-ed--c.na50.visual.force.com/apex/createVolunteerPage" + paramstag});
    urlEvent.fire();
	},
    
    navigateToComp : function(bmiComp, event, helper) {
        var gName   = bmiComp.find("gName").get("v.value");
	    var gHeight = bmiComp.get("v.guestHeight");
        var gWeight = bmiComp.get("v.guestWeight");
        var paramstag = "?vName="+gName+"&vHeight="+gHeight+"&vWeight="+gWeight;
        var cmpEvent = $A.get("e.force:navigateToComponent");
        cmpEvent.setParams({componentDef: "c:createVolunteer",
                            componentAttributes : {volunteerName : gName, volunteerHeight : gHeight, volunteerWeight : gWeight}
                           });
        cmpEvent.fire();
	},
        
        
    
})