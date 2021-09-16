({
	doInit : function(semComp, semEvent, semHelper) {
        console.log("doInit()");
		semHelper.doInitHelper(semComp);
	},
    
    searchSeminars : function(semComp, semEvent, semHelper)
    {
        semHelper.searchSeminarsHelper(semComp);
    },
    
})