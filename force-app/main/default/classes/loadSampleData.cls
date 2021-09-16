Public with sharing class loadSampleData
{
    STATIC List<Seminar__c> Seminars = new List<Seminar__c>();
    STATIC List<HealthTip__c> HealthTips = new List<HealthTip__c>();
    Public STATIC void loadSampleData()
    {
        Seminars.add(new Seminar__c(
            Name		=	'Orientation on Over-Weight',
            Category__c = 	'OVER-WEIGHT',
            Speaker__c 	= 	'Dr Amy Wright',
            Venue__c 	= 	'Auditorium-1',
            Day__c 		= 	'Monday',
            Time__c 	= 	'6pm'
        ));
        
        Seminars.add(new Seminar__c(
            Name		=	'Bye Bye to Over-Weight',
            Category__c =	'OVER-WEIGHT',
            Speaker__c 	= 	'Dr David Solomon',
            Venue__c 	= 	'Auditorium-4',
            Day__c 		= 	'Wednesday',
            Time__c 	= 	'8pm'
        ));
        
        Seminars.add(new Seminar__c(
            Name		=	'Under-Weight to Normal-Weight in one month',
            Category__c =	'UNDER-WEIGHT',
            Speaker__c 	= 	'Dr Ben Nadal',
            Venue__c 	= 	'Auditorium-3',
            Day__c 		= 	'Tuesday',
            Time__c 	= 	'5pm'
        ));
        
        Seminars.add(new Seminar__c(
            Name		=	'Why Under-Weight is problematic than Over-Weight?',
            Category__c =	'UNDER-WEIGHT',
            Speaker__c 	= 	'Dr Chris Rafa',
            Venue__c 	= 	'Auditorium-4',
            Day__c 		= 	'Thursday',
            Time__c 	= 	'7pm'
        ));
        
        Seminars.add(new Seminar__c(
            Name		=	'Prevention is better than cure',
            Category__c =	'NORMAL-WEIGHT',
            Speaker__c 	= 	'Dr Evan Richard',
            Venue__c 	= 	'Auditorium-2',
            Day__c 		= 	'Friday',
            Time__c 	= 	'9pm'
        ));
        
        Seminars.add(new Seminar__c(
            Name		=	'Who wants to be unhealthy?',
            Category__c =	'NORMAL-WEIGHT',
            Speaker__c 	= 	'Dr Evan Richard',
            Venue__c 	= 	'Auditorium-4',
            Day__c 		= 	'Wednesday',
            Time__c 	= 	'7pm'
        ));
        INSERT Seminars;
        // ENDING of inserting Seminars
        
        
        // BEGIN of inserting HealthTips
        HealthTips.add(new HealthTip__c(
        	Name = 'Tip to overcome Over-Weight',
            Category__c = 'OVER-WEIGHT',
            Description__c = 'On waking up, with empty stomach, add 10 spoons of honey to luke-warm water and drink it. \nDo the brisk walk till you get free-bowel movement.'
        ));
        
         HealthTips.add(new HealthTip__c(
        	Name = 'Yoga Tip for Over-Weight',
            Category__c = 'OVER-WEIGHT',
            Description__c = 'Practice Sun-Prostrations regularly.\nDo not drink while eating. Drink after 45 mins of eating.\nThis will help for digestion.'
        ));
        
        HealthTips.add(new HealthTip__c(
        	Name = 'Tip to gain Weight',
            Category__c = 'UNDER-WEIGHT',
            Description__c = 'add 5 spoons of honey to normal water and drink it before every meal.\nIf possible, have a little nap after every meal.\n\nNOTE: Do not forget to stop after gaining the weight to prevent over-weight.'
        ));
        
        HealthTips.add(new HealthTip__c(
        	Name = 'Diet for gaining Weight',
            Category__c = 'UNDER-WEIGHT',
            Description__c = 'Soak the dry fruits in water over-night.\nHave them as the first thing in the morning.'
        ));
        
        HealthTips.add(new HealthTip__c(
        	Name = 'Tip to maintain Normal-Weight',
            Category__c = 'NORMAL-WEIGHT',
            Description__c = 'Follow Early to Bed - Early to Rise policy.\nEat only when hungry. Drink only when thirsty.\nUn-compromised regular exercises will help you maintain fitness'
        ));
        
        INSERT HealthTips;
    }
}