({
	helperSearch : function(searchComponent) {
        console.log("--- helperSearch Method ---");
		var CategoryCmp = searchComponent.find("selCategory");
          var Category = CategoryCmp.get("v.value");
          //console.log(Category);
          var searchAction = searchComponent.get("c.returnVolunteersByCategory");
          searchAction.setParam("Category",Category);
        searchAction.setCallback(this, function(shahResp){console.log("sever-sside success");searchComponent.set("v.volunteerList", shahResp.getReturnValue());});
        $A.enqueueAction(searchAction);
	}
})