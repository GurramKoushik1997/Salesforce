public class Rollup_Methods {
    
    public static void rollupStatementsToRentalAgreement(List<Statement__c> newList)
    {
        Set<id> rentalAgreementSet=new Set<id>();
        for(Statement__c s:newList)
        {
            rentalAgreementSet.add(s.Rental_Agreement_del__c);
            
        }
        //this list will store the rental Agreement records which needs to be updates
        List<Rental_Agreement__c> rentalUpdates=new List<Rental_Agreement__c>();
        //aggregate query to sum total amount from statement
        System.debug('rentalAgreementSet====='+rentalAgreementSet);
        for(AggregateResult ar:[select sum(Total_amount__c)totalInvoice,Rental_Agreement_del__c from Statement__c where Rental_Agreement_del__c IN :rentalAgreementSet group by Rental_Agreement_del__c])
        {
            Rental_Agreement__c r=new Rental_Agreement__c(id=String.valueOf(ar.get('Rental_Agreement__c')));
            r.Total_Invoiced__c=double.valueOf(ar.get('totalInvoice'));
            rentalUpdates.add(r);
        }
        if(!rentalUpdates.isEmpty())
        {
            update rentalUpdates;
        }
    }

     public static void rollupPaymentsToRentalAgreement(Map<id,Payment__c> newMap)
     {
         Set<Id> rentalAgreementSet =new Set<id>();
         for(Payment__c p : [SELECT id,Statement__r.Rental_Agreement_del__c FROM Payment__c where Id IN :newMap.keySet()])
         {
             rentalAgreementSet.add(p.Statement__r.Rental_Agreement_del__c);
         }
         List<Rental_Agreement__c> rentalUpdates=new List<Rental_Agreement__c>();
         
         for(AggregateResult ar:[SELECT sum(Amount__c)totalPaid,Statement__r.Rental_Agreement_del__c FROM Payment__c where Statement__r.Rental_Agreement_del__c IN :rentalAgreementSet group by Statement__r.Rental_Agreement_del__c  ])
         {
             Rental_Agreement__c r = new Rental_Agreement__c(id=string.valueOf(ar.get('ra')));
             r.Total_Payments__c=double.valueOf(ar.get('totalPaid'));
             rentalUpdates.add(r);
         }
         
         if(!rentalUpdates.isEmpty())
         {
             update rentalUpdates;
         }
    }
}