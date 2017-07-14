/*****************************************************************************************************************************
Name of the Class : WSUserResponseToSanctionDetails
Created By : Gautam Kasukhela
Created Date : 16th May, 2016
Description of the class : Webservice that updates the loan application status to REJECTED.
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/UserResponseToSanctionDetails')
global class WSUserResponseToSanctionDetails {
    
	@HttpPost
	global static Response updateLoanAppStatus(){
		RestRequest restReq 	 = 	RestContext.request;
        RestResponse restRes 	 = 	RestContext.response;
        Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        
        Long 		userID;
        String		prospectID;
        String		reasonForRejection;
        String		sanctionDetailsResponse;
        Id			appId;
        String		applicationStatus;
        String 		phoneNumber;
        String		accountName;
        String		message;
        
        userID 					=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        prospectID				=	(String)requestBodyParamsMap.get('ProspectID') != null ? (String)requestBodyParamsMap.get('ProspectID') : null;
        sanctionDetailsResponse	=	(String)requestBodyParamsMap.get('SanctionDetailsResponse') != null ? (String)requestBodyParamsMap.get('SanctionDetailsResponse') : null;
		reasonForRejection		=	(String)requestBodyParamsMap.get('ReasonForRejection') != null ? (String)requestBodyParamsMap.get('ReasonForRejection') : null;
		
		if(userID == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.USER_ID_BLANK_PUSH_TO_LMS);
            return res;
        }
		if(String.isEmpty(prospectID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PROSPECT_ID_BLANK);
            return res;
        }
        if(String.isEmpty(sanctionDetailsResponse)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.SANCTION_DETAILS_RESPONSE_NOT_FOUND);
            return res;
        }
        if(!(sanctionDetailsResponse.equals(WebServiceConstants.OFFER_ACCEPTED_BY_CUSTOMER) ||
        		sanctionDetailsResponse.equals(WebServiceConstants.APPLICATION_REJECT_STATUS))){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.SANCTION_DETAILS_NOT_AS_PER_STANDARDS);
            return res;
        }
        if(sanctionDetailsResponse.equals(WebServiceConstants.APPLICATION_REJECT_STATUS)
        					&& String.isEmpty(reasonForRejection)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.REASON_FOR_REJECTION_NOT_FOUND);
            return res;
        }
        
        List<genesis__Applications__c> 	appList 	=		new 	List<genesis__Applications__c>();
        try{
        appList		=		[SELECT 	Id,genesis__Status__c,genesis__Account__r.Name,genesis__Account__r.Phone
        					 FROM		genesis__Applications__c
        					 WHERE		Prospect_Number__c =: prospectID AND genesis__Account__r.User_ID__c =: userID
        					 LIMIT 1];
        }catch(QueryException qe){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_APPLICATION_DETAILS);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
        } 
        if(appList != null && appList.size() == 0){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.NO_LOAN_RECORD_FOR_USER_PROSPECT_ID);
            return res;
        }else{
        	appId				=	appList[0].Id;
        	applicationStatus	=	appList[0].genesis__Status__c;
        	phoneNumber			=	appList[0].genesis__Account__r.Phone;
        	accountName			=	appList[0].genesis__Account__r.Name;
        	
        }
        if(!applicationStatus.equals(WebServiceConstants.AWAITING_CUSTOMER_TO_ACCEPT)){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.USER_ACTION_NOT_POSSIBLE_ON_LOAN_APP +applicationStatus);
            return res;
        }
        genesis__Applications__c app = 	new 	genesis__Applications__c();
        try{
	        app.Id						 			 =	appId;
	        if(sanctionDetailsResponse.equals(WebServiceConstants.OFFER_ACCEPTED_BY_CUSTOMER)){
	        	app.genesis__Status__c		 		 =	WebServiceConstants.APPLICATION_APPROVED_STATUS;
	        	message 							 =	'Dear '+accountName+', Thank you for accepting our Loan proposal.'+
	        											' For more details, Kindly check your registered Email.';
	        											
	        }else if(sanctionDetailsResponse.equals(WebServiceConstants.APPLICATION_REJECT_STATUS)){
	        	app.genesis__Status__c		 		 =	WebServiceConstants.APPLICATION_REJ_BY_CUSTOMER_STATUS;
	        	message 							 =  'Dear '+accountName+', You choose to reject our Loan proposal.'+
	        											' For more details, Kindly check your registered Email.';
	        }
	        if(reasonForRejection != null && sanctionDetailsResponse.equals(WebServiceConstants.APPLICATION_REJECT_STATUS)){
	        	app.Reason_for_rejection__c	 		 =  reasonForRejection;
	        }
	        app.Application_Rejection_Timestamp__c	 =	Date.today();
			upsert app;
        }catch(DmlException dmle){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_WHILE_UPDATING_APP_DETAILS);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
				return res;
        }
		   if(app != null && sanctionDetailsResponse.equals(WebServiceConstants.OFFER_ACCEPTED_BY_CUSTOMER)){
		   		if(!Test.isRunningTest()){
		   			
		   			HttpCalloutToRouteSMS.sendSMS(phoneNumber,message);
		   		}
		   		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
		   		res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.LOAN_SANCTION_DETAILS_ACCEPTED_BY_CUSTOMER);
		   		return res;
		   }else if(app != null && sanctionDetailsResponse.equals(WebServiceConstants.APPLICATION_REJECT_STATUS)){
		   		if(!Test.isRunningTest()){
		   			HttpCalloutToRouteSMS.sendSMS(phoneNumber,message);
		   		}
		   		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
		   		res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.LOAN_SANCTION_DETAILS_REJECTED_BY_CUSTOMER);
		   }
     return res;   
	}
}