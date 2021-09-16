public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static Integer getContacts(String accId){
        Integer count;
        List<Account> acc=[select Name , (Select LastName from contacts) from Account where Id = :accId];
        for(Account acct:acc){
            count = acct.contacts.size();
        }
        System.debug('count=='+count);
        return count;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactslist(String accId) {
         return [SELECT Id, Name ,Email, Phone, Account.Name from Contact where AccountId = :accId]; 
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsForTable(String accId) {
        List<Contact> clist = [SELECT AccountId, Id, FirstName, LastName, Title, Phone, Email FROM Contact WHERE AccountId = :accId];
        System.debug('clist==='+clist);
         return [SELECT AccountId, Id, FirstName, LastName, Title, Phone, Email FROM Contact WHERE AccountId = :accId];
    }
    @AuraEnabled
    public static String deleteContacts(list<Id> lstConIds){
        list<Contact> lstConsToDelete = new list<Contact>();
        System.debug('lstConIds ====> '+lstConIds);
        for(Id idCon : lstConIds) {
            lstConsToDelete.add(new Contact(Id = idCon));
        }
        delete lstConsToDelete;
        return 'Success';
    }
    @AuraEnabled
    public static String createContact(String FName,String LName,String Fax,String Email,String aId){
        System.debug('FName=='+FName);
        System.debug('LName=='+LName);
        System.debug('Fax=='+Fax);
        System.debug('Email=='+Email);
        System.debug('aId=='+aId);
        Contact c = new Contact();
        c.FirstName = FName;
        c.LastName = LName;
        c.Fax = Fax;
        c.Email = Email;
        c.AccountId = aId;
        insert c;
        return 'Success';
    }
}