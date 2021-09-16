public with sharing class ZConstants {
    
    
    public static final String SEPARATOR                             = '-'; 
    public static final boolean FULL_DATASET_RUN                     = false;
    public static final boolean DELTA_RUN  						     = true;
    public static final String BLANK_SPACE                           = ' ';
    public static final String NO_SPACE                              = '';
    public static final String ZW_NO_VALUE                           = '-';
    public static final String Z_TEST_STRING                         = 'Test String';

    public static final Integer DEFAULT_TEST_LENGTH					 = 10;
    public static final Integer ZW_LOCATION_STREET_LENGTH            = 30;
    public static final Integer ZW_LOCATION_CITY_LENGTH              = 30;
    public static final Integer ZW_LOCATION_STATE_LENGTH             = 30;
    public static final Integer ZW_LOCATION_POSTAL_CODE_LENGTH       = 30;
    public static final Integer ZW_BILLING_STATE_LENGTH              = 30;
    public static final Integer ZW_BILLING_CITY_LENGTH               = 30;
    public static final Integer ZW_ACCOUNT_SIC_LENGTH                = 5;
    public static final Integer ZW_BILLING_COUNTRY_LENGTH            = 30;
    public static final Integer ZW_BILLING_POSTAL_CODE_LENGTH        = 30;
    public static final Integer ZW_BILLING_STREET_LENGTH             = 30;
    public static final Integer ZW_BILLING_CONTRACT_ACCOUNT_NAME_LENGTH = 30;
    public static final Integer ZW_BILLING_CONTRACT_NAME_LENGTH      = 30;
    public static final Integer ZW_BILLING_FREQUENCY_LENGTH          = 2;
    public static final Integer ZW_BILLING_CONTRACT_CUST_NAME_LENGTH = 78;
    public static final Integer ZW_SUPPLY_POINT_NAME_LENGTH          = 8;
    public static final Integer ZW_BLANK_SPACE_LENGTH                = 8;
    public static final Integer ZW_BILLINGCONTRACT_NAME_LENGTH       = 8;
    public static final Integer ZW_BILL_DATE_LENGTH                  = 10;
    public static final Integer DATE_LENGTH                          = 10;
    public static final Integer ZW_BILL_NAME_LENGTH                  = 8;
    public static final Integer RECORD_TYPE_LENGTH                   = 2;
    public static final Integer ZW_LOCATION_NAME_LENGTH              = 26;
    public static final Integer ZW_RECORD_TYPE_LENGTH                = 6;
    public static final Integer ZW_DEVICE_NAME_LENGTH                = 3;
    public static final Integer ZW_DEVICE_READING_LENGTH             = 9;
    public static final Integer ZW_DEVICE_LOCATION_LENGTH            = 40;
    public static final Integer ZW_DEVICE_INSTALLAION_DATE_LENGTH    = 10;
    public static final Integer ZW_DEVICE_UNIT_MEASURE_LENGTH        = 1;
    public static final Integer ZW_DEVICE_DIGIT_LENGTH               = 1;
    public static final Integer ZW_SUPPLY_POINT_TARRIF_LENGTH        = 4;
    public static final Integer ZW_SUPPLY_POINT_PADDING_LENGTH       = 9;
    public static final Integer ZW_CHARGE_BASIS_AMOUNT_LENGTH        = 7;


    
    public static final String ZW_Location_RECORD_TYPE_INFO          = '04';
    public static final String ZW_SUPPLY_POINT_RECORD_TYPE_INFO      = '02';


    public static final String RECORD_COUNT                          = '000001';
    public static final String ZERO_CHARACTER                        = '0';
    public static final String ZW_SUPPLY_POINT_CHARECTER             = 'S'; 
    public static final String ZW_SERVICE_UNIT_OCCUPANCY_TYPE        = 'D';
    public static final String ZW_PROPERTY_DESC                      = '00';
    public static final String ZW_BILL_FREQUENCY                     = '04';
    public static final String ZW_DEVICE_UNIT_OF_MEASURE             = 'M';

    


    public static final String ZW_NO                                 = 'N';
    public static final String ZW_YES                                = 'Y';
    public static final String ZW_MAIN_SUPPLY                        = 'Y';
    public static final String ZW_SUB_SUPPLY                         = 'N';

    
    public static final String TEST_NAME  	                         = 'Test Name';
    public static final String TEST_DESCRIPTION					     = 'Test Description';
    
    public static final Date START_DATE                              = Date.today();
    public static final DateTime ADHOC_START_DATE                    = DateTime.now().addDays(-2);
    public static final DateTime ADHOC_END_DATE					     = DateTime.now().addDays(0);
    public static final DateTime RECORD_TEST_DATE                    = DateTime.now().addDays(-2);
    
    public static final String ACCOUNT_INFO_KEY 				     = 'ACCOUNT INFO';
    public static final String LOCATION_INFO_KEY     	    	     = 'LOCATION INFO';
    public static final String ZW_INFO_KEY                           = 'ZW INFO KEY';
    public static final String ZW_SERVICE_TYPE_NAME                  = 'Southern Water';
    public static final String ZW_NO_METER                           = 'No Meter';
    public static final String ZW_DISCON_STATUS                      = 'shared supply';


    public static final String ACCOUNT_RECORDS   	 	 	  	     = 'accountRecords';
    public static final String LOCATION_RECORDS                      = 'locationRecords';
    
    public static final String LIMIT_RECORDS_DURING_ERROR            = ' LIMIT 0';
    
    public static final String SOQL_DATETIME_FOTMAT                  = 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\'';
    public static final String DELTA_BATCH_CONFIG_INVALID 		     = 'The Configuration';
    public static final String DATA_OBJECT 						     = 'Staging__c';
    public static final String STAGING_ACCOUNT_RECORD_TYPE           = 'Account_Type';
    public static final String STAGING_LOCATION_RECORD_TYPE          = 'Location_Type';
    public static final String BATCH_ERROR_RECORD_TYPE               = 'Batch_Execution_Error';
    public static final String WASTE_LOATION_RECORD                  = 'Waste_Type';

    //public static final Id ACCOUNT_RECORD_TYPE 					     = Schema.getGlobalDescribe().get(DATA_OBJECT).getDescribe().getRecordTypeInfosByDeveloperName().get(STAGING_ACCOUNT_RECORD_TYPE).getRecordTypeId();
    //public static final Id LOCATION_RECORD_TYPE 				     = Schema.getGlobalDescribe().get(DATA_OBJECT).getDescribe().getRecordTypeInfosByDeveloperName().get(STAGING_LOCATION_RECORD_TYPE).getRecordTypeId();
    //public static final Id BATCH_ERROR_RECORD_TYPE_ID 			     = Schema.getGlobalDescribe().get(DATA_OBJECT).getDescribe().getRecordTypeInfosByDeveloperName().get(BATCH_ERROR_RECORD_TYPE).getRecordTypeId();
	//public static final Id WASTE_RECORD_TYPE                         = Schema.getGlobalDescribe().get(DATA_OBJECT).getDescribe().getRecordTypeInfosByDeveloperName().get(WASTE_LOATION_RECORD).getRecordTypeId();
    
}