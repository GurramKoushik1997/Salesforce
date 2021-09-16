public class KCloudTriger {

    public static void contactList(){
        List<Contact> conlist = [SELECT Id,AccountId From Contact];
    System.debug('conlist---'+conlist.size());
    
    List<Account> acclist = [SELECT Id,Name FROM Account];
    
    List<Contact> conlist2 = new List<Contact>();
    for(Contact c : conlist){
        if(String.isNotBlank(c.AccountId)){
            conlist2.add(c);
        }
    }
    System.debug('conlist2 size--'+conlist2.size());
    }
}