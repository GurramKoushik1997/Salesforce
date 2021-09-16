@isTest
public class AutomadeCodeTest {
    
    @testSetup static void testDataMethod(){
        PermissionSet PermissionSetToAssign = new PermissionSet(Name='RightRev_Admin1');
        insert PermissionSetToAssign;
    }
    
    @isTest
    public static void userCreationTest(){
        Test.startTest();
        AutomateCode.newUserAndPermissionSet('Test123@gmail.com', 'Standard User', 'Test1User@dev.com');
        Test.stopTest();
        System.debug('-->'+[SELECT Id,Name FROM User WHERE Name=:'Test1User@dev.com']);
    }

}