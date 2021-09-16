({
    doInitHelper : function(semComp)
    {
        semComp.find("opText").set("v.value", "ALL SEMINARS");
        var semAction = semComp.get("c.returnAllSeminars");
        semAction.setCallback(this,
                             function(semResp)
                              {
                                  semComp.set("v.seminars", semResp.getReturnValue());
                                  console.log("server side ok");
                              });
        $A.enqueueAction(semAction);
    },
    
	searchSeminarsHelper : function(semComp) {
		if(semComp.find("selCategory").get("v.value") == "" || semComp.find("selCategory").get("v.value") == null)
        {
            semComp.find("selCategory").set("v.errors", {message : "Select a Category to search Seminars"});
            semComp.find("opText").set("v.value",null);
            semComp.set("v.seminars",null);
        }else
        {
            semComp.find("selCategory").set("v.errors", {message : null});
            console.log(semComp.find("selCategory").get("v.value"));
            console.log("searchSeminars() from SeminarList Comp");
            var selCatValue = semComp.find("opText").set("v.value", "Seminars on "+semComp.find("selCategory").get("v.value"));
            var semAction = semComp.get("c.returnSeminarsByCategory");
            semAction.setParam("Category", semComp.find("selCategory").get("v.value"));
            semAction.setCallback(this,
                                 function(semResp)
                                  {
                                      semComp.set("v.seminars", semResp.getReturnValue());
                                      console.log("server side ok");
                                  });
            $A.enqueueAction(semAction);
        }
	}
})