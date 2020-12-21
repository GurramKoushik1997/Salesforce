@isTest
public class ZUtils_test {
    
    public static Boolean isDeltaRunConfigMissing      = true;
    public static Datetime dt                          = System.now();
    public static Integer definedLength                = 20;
    public static Integer length                       = 10;
    public static Boolean PREFIX                       = true;
    public static Boolean NOT_PREFIX                   = false;
    public static String amendCharecter                = '-';
    public static String fieldValue                    = 'fieldValue';
    public static String emptyFieldValue               = null;
    public static String ERROR_LIST_STRING             = 'The following records has errors:';

    

    @isTest static void getErrorsMethod(){
        
        Map<String, String> unsuccessfulMap  = new Map<String , String>();
        Map<String, String> unsuccessfulMap1 = new Map<String , String>();
        Map<String, String> unsuccessfulMap2 = new Map<String , String>();
        Map<String, String> unsuccessfulMap3 = new Map<String , String>();

        String s1 = null;
        String s2 = '';
        String s3 = 's3';
        String s4 = 's4';
        
        String v1 = 'errorValue1';
        String v2 = 'errorValue2';
        String v3 = 'errorValue3';
        String v4 = 'errorValue4';
        
        unsuccessfulMap.put(s1, v1);
        String errors = ZUtils.getErrors(unsuccessfulMap , isDeltaRunConfigMissing);
        System.debug('errors====='+errors);
        System.assertEquals((ZConstants.DELTA_BATCH_CONFIG_INVALID+ '\n\n') , errors, 'Both errors Should equal');
        
        unsuccessfulMap1.put(s2,v2);
        String errors1 = ZUtils.getErrors(unsuccessfulMap1 , !isDeltaRunConfigMissing);
        System.debug('errors1====='+errors1);
        System.assertEquals(('The following records has errors: \n\n'+ JSON.serializePretty(unsuccessfulMap1)) , errors1, 'Both errors Should equal');
        
        unsuccessfulMap2.put(s3,v3);
        String errors2 = ZUtils.getErrors(unsuccessfulMap2 , !isDeltaRunConfigMissing);
        System.debug('errors2====='+errors2);
        System.assertEquals(('The following records has errors: \n\n'+ JSON.serializePretty(unsuccessfulMap2)) , errors2, 'Both errors Should equal');
        
        unsuccessfulMap3.put(s4,v4);
        String errors3 = ZUtils.getErrors(unsuccessfulMap3 , true);
        System.debug('errors3====='+errors3);
        System.assertEquals((ZConstants.DELTA_BATCH_CONFIG_INVALID+ '\n\n'),errors3, 'Both errors Should equal');


    }
    
	@isTest static void testUtilsMethods(){  
        
        String zeroPrefixString = ZUtils.getZeroPrefixedString('ZeroPrefixedString', length);
        String expectedString = 'ixedString';
        System.debug('zeroPrefixString===='+zeroPrefixString);
        System.assertEquals(expectedString, zeroPrefixString , 'Both Strings Should equal');
        
        String formattedString  = ZUtils.getFormattedString('formattedString', ZConstants.DEFAULT_TEST_LENGTH);
        expectedString = 'ttedString';
        System.debug('formattedString===='+formattedString);
        System.assertEquals(expectedString, formattedString , 'Both Strings Should equal');
    }
        
     @isTest static void formattedStringMethods(){ 
         
         String expectedString = '';
         
        String formattedString1 = ZUtils.getFormattedString( fieldValue ,definedLength,amendCharecter, PREFIX);
        expectedString = '----------fieldValue';
        System.debug('formattedString1===='+formattedString1);
        System.assertEquals(expectedString, formattedString1 , 'Both Strings Should equal');
        
        String formattedString2 = ZUtils.getFormattedString(fieldValue , definedLength,amendCharecter, NOT_PREFIX);
        expectedString = 'fieldValue----------';
        System.debug('formattedString2===='+formattedString2);
        System.assertEquals(expectedString, formattedString2 , 'Both Strings Should equal');
        
        String formattedString3 = ZUtils.getFormattedString(emptyFieldValue , definedLength,amendCharecter, PREFIX);
        expectedString = '--------------------';
        System.debug('formattedString3===='+formattedString3);
        System.assertEquals(expectedString, formattedString3 , 'Both Strings Should equal');
     	
         String formattedString4 = ZUtils.getFormattedString(fieldValue , length,amendCharecter, PREFIX);
        expectedString = 'fieldValue';
        System.debug('formattedString4===='+formattedString4);
        System.assertEquals(expectedString, formattedString4 , 'Both Strings Should equal');

        
        String dateFormat = ZUtils.getDate(dt);
        expectedString = (String.valueOf(Date.today().format()));
        System.debug('dateFormat===='+dateFormat);
        System.assertEquals(expectedString , dateFormat , 'Both Strings Should equal');
        
       
        String blankSpace = ZUtils.getBlankSpace(length);
        expectedString = '----------';
        System.debug('blankSpace===='+blankSpace);
        System.assertEquals(expectedString , blankSpace , 'Both Strings Should equal');
    }
    
    @isTest static void formattedDateUtilsMethod(){
        
     String formattedDate = ZUtils.getFormattedDate(dt);
        String expectedString = (String.valueOf(Date.today().format()));
        System.debug('expectedString===='+expectedString);
        System.debug('formattedDate===='+formattedDate);
        System.assertEquals(expectedString , formattedDate , 'Both Strings Should equal');
    }   
    
    @isTest static void subStringUtilsMethod(){
        String input                  = 'input';
        Integer startIndex            = 2;
        Integer endIndex              = 4;
        Integer greaterthanStartIndex = 8;
        
        String subString = ZUtils.getSubString(input, startIndex, endIndex);
        System.debug('subString===='+subString);
        String expectedString = 'npu';
        System.assertEquals(expectedString , subString , 'Both Strings Should equal');
        
        String subString1 = ZUtils.getSubString(input, greaterthanStartIndex , endIndex);
        System.debug('subString===='+subString);
        expectedString = '';
        System.assertEquals(expectedString , subString1 , 'Both Strings Should equal');
        
        input = null;
        String subString2 = ZUtils.getSubString(input, startIndex, endIndex);
        System.debug('subString1===='+subString1);
        expectedString = '';
        System.assertEquals(expectedString , subString2 , 'Both Strings Should equal');        
    }
}