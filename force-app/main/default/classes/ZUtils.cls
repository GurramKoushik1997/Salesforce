public class ZUtils {
    
     public static final boolean PREFIX = true;
     public static final boolean SUFFIX = false;
     
    /* public static void createBatchErrors(Boolean isDeltaRun, String query, String errorBatchName, String errors){
         System.debug('calling createBatchErrors method');
        Staging__c stagingError = new Staging__c();
          stagingError.Name                = errorBatchName +' Error';
          stagingError.RecordTypeId        = ZConstants.BATCH_ERROR_RECORD_TYPE_ID;
          stagingError.Is_Delta_Run__c     = isDeltaRun;
          stagingError.Query__c            = query ;
          stagingError.Error_Batch_Name__c = errorBatchName;
          stagingError.Error__c            = errors;
         
        insert stagingError;
    }*/
    
    public static String getErrors(Map<String, String> unsuccessfulMap, boolean isDeltaRunConfigMissing){
          System.debug('calling getErrors method');
          String errors = '';
          if(isDeltaRunConfigMissing){
            errors +=  ZConstants.DELTA_BATCH_CONFIG_INVALID + '\n\n';
          } else if (unsuccessfulMap.size()>0 ) {
            errors += 'The following records has errors: \n\n';
            errors += JSON.serializePretty(unsuccessfulMap);
          }
        System.debug('errors==='+errors+'==');
          return errors;
    }

     //String of field number and length of field
     public static String getZeroPrefixedString(String fieldValue, Integer definedFieldLength){
        return getFormattedString(fieldValue, definedFieldLength, ZConstants.ZERO_CHARACTER, PREFIX);
    }
    

    public static String getFormattedString(String fieldValue, Integer definedFieldLength){
        return getFormattedString(fieldValue, definedFieldLength, ZConstants.ZW_NO_VALUE, SUFFIX);
    }
    

    public static String getFormattedString(String fieldValue, Integer definedFieldLength, String amendCharacter, Boolean isPrefix){
        if(String.isBlank(fieldValue)){
            fieldValue = '';
            for(Integer i=0; i<definedFieldLength; i++){
                fieldValue = fieldValue + amendCharacter;                 
            }
        } 
        else{
            if(fieldValue.length() == definedFieldLength){
                return fieldValue;
            }
            else if(fieldValue.length() > definedFieldLength){
                fieldValue = fieldValue.right(definedFieldLength);
            }
            else if(fieldValue.length() < definedFieldLength){
                Integer fieldLength = definedFieldLength - fieldValue.length();
                for(Integer i=0; i< fieldLength; i++){
                    if(isPrefix){
                        fieldValue =  amendCharacter + fieldValue;
                    } else {
                        fieldValue =  fieldValue + amendCharacter;
                    }
                }
            }
        }
        return fieldValue;
    }
    
    public static String getDate(Datetime dt){
        Date dateObj = date.newinstance(dt.year(), dt.month(), dt.day());
        return dateObj.format();
    }

    public static String getFormattedDate(Datetime datetimeVal){
        String output = null;
        if(datetimeVal != null){
            output = getDate(datetimeVal);
        }
        output = getFormattedString(output, ZConstants.DATE_LENGTH,ZConstants.NO_SPACE, PREFIX);
        return output;
    }
    
    //If field value is null , the of field making as '-'
    public static String getBlankSpace(Integer definedFieldLength){
        String noValue = '';
        for(Integer i=0; i<definedFieldLength; i++){
            noValue = noValue + ZConstants.ZW_NO_VALUE;
        }
        return noValue;
    }

    public static String getSubString(String input, Integer startIndex, Integer endIndex){
        String output = '';
        if(!String.isBlank(input) && (endIndex > startIndex) ){
            Integer locationLength = input.length();
            if((locationLength >= (endIndex))) {
                output = input.substring(startIndex-1, endIndex);
            } else if(locationLength >= startIndex){
                output = input.substring(startIndex-1, locationLength);
            }
        }
        return output;
    }
}