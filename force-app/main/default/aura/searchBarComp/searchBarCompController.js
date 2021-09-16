({
	doSubmit : function(searchComp, searchEvent, searchHelper) {
		console.log("----- BEGIN OF doSubmit() in searchBarComp client-side Controller -----");
        	searchHelper.doSubmitHelper(searchComp);
        console.log("----- END OF doSubmit() in searchBarComp client-side Controller -----");
	},
    
    doWaiting : function(searchComp, searchEvent, searchHelper) {
        	searchComp.set("v.isSpinner", true);
	},
    
    doneWaiting : function(searchComp, searchEvent, searchHelper) {
        	searchComp.set("v.isSpinner", false);
	},
    
    
})