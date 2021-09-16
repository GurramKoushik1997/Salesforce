({
	doSubmitHelper : function(searchComp) {
		console.log("----- BEGIN OF doSubmitHelper() in searchBarComp Helper -----");
        	if(searchComp.find("selCategory").get("v.value") == "" || searchComp.find("selCategory").get("v.value") == null)
            {
                searchComp.find("selCategory").set("v.errors", {message : "Select a Category to search Seminars"});
            }else
            {
                searchComp.find("selCategory").set("v.errors", {message : null});
                console.log("selected Category ==> "+searchComp.find("selCategory").get("v.value"));
            }
        console.log("----- END OF doSubmitHelper() in searchBarComp Helper -----");
	}
})