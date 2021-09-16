@RestResource(urlMapping='/apiAccount')
global with sharing class createAcc {
    @AuraEnabled
    global static Account createAccount(Account acc) {
        system.debug('acc'+acc);
        insert acc;
        return acc;
    }
    @AuraEnabled
    public static Contact createContact(Contact con) {
        system.debug('con-----'+con);
        insert con;
        return con;
    }
    @HttpGet
    global static Account doGet() {
        Account a = new Account();
        a.Name = 'apiAccount';
        insert a;
        return a;
    }
}