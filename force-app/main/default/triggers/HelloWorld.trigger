trigger HelloWorld on Account (after delete) {
	system.debug('Hello World!');
    for(Account a : Trigger.New) {
        a.Description = 'New description';
    }   
}