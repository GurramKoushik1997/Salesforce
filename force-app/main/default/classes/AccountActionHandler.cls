public class AccountActionHandler {
    
    public static void createContact(List<Account> accountsList){
        List <Contact> contactList = new List<Contact>();
    for(Account aObj : accountsList){
    Contact cObj = new Contact();
    cObj.AccountId = aObj .id;
    cObj.LastName = aObj.Name;
    contactList .add(cObj);
    }
    
    if(!contactList.isEmpty()){
    insert contactList;
    }
    }

}