({
    doInitHelper : function(htComp)
    {
        console.log("doInitHelper from HealthTipListHelper...");
        htComp.find("opText").set("v.value", "ALL HEALTH-TIPS");
        var htAction = htComp.get("c.returnAllHealthTips");
        htAction.setCallback(this,
                             function(htResp)
                              {
                                  htComp.set("v.healthTips", htResp.getReturnValue());
                                  console.log("server side ok");
                              });
        $A.enqueueAction(htAction);
        
    },
    
	searchHealthTipsHelper : function(htComp) {
		if(htComp.find("selCategory").get("v.value") == "" || htComp.find("selCategory").get("v.value") == null)
        {
            htComp.find("selCategory").set("v.errors", {message : "Select a Category to search Health-Tips"});
            htComp.find("opText").set("v.value",null);
            htComp.set("v.healthTips",null);
        }else
        {
            htComp.find("selCategory").set("v.errors", {message : null});
            console.log(htComp.find("selCategory").get("v.value"));
            console.log("searchHealthTipsHelper() from HealthTipsList Comp");
            var selCatValue = htComp.find("opText").set("v.value", "HEALTH-TIPS for "+htComp.find("selCategory").get("v.value"));
            var htAction = htComp.get("c.returnHealthTipsByCategory");
            htAction.setParam("Category", htComp.find("selCategory").get("v.value"));
            htAction.setCallback(this,
                                 function(htResp)
                                  {
                                      htComp.set("v.healthTips", htResp.getReturnValue());
                                      console.log("server side ok for HealthTips");
                                  });
            $A.enqueueAction(htAction);
        }
	}
})