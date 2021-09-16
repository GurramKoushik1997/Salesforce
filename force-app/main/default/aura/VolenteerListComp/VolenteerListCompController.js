({
	doSubmit : function(searchComp, searchEvent, searchHelper) {
		console.log("--- BEGIN doSubmit() ---");
        searchHelper.helperSearch(searchComp);
        console.log("--- i am back in client-side controller---");
	},
    
    doWaiting : function(searchComp, searchEvent, searchHelper)
    {
        searchComp.set("v.isSpinner", true);
    },
    
    doDoneWaiting : function(searchComp, searchEvent, searchHelper)
    {
       searchComp.set("v.isSpinner", false);
    },
})