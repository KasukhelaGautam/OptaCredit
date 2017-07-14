/*****************************************************************************************************************************
Name of the Class : WSRejectUserDetails
Created By : Gautam Kasukhela
Created Date : 16th May, 2016
Description of the class : Webservice that updates the Account status to REJECTED once the front end user rejects the details entered
                           by the user. This happens before pushing the details to the LMS system.
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/RejectUserDetails')
global class WSRejectUserDetails {
    
	@HttpPost
	global static Response updateAccountStatus(){
		
		RestRequest restReq 	 = 	RestContext.request;
        RestResponse restRes 	 = 	RestContext.response;
        Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        
        Long 		userID;
        String		prospectID;
        String		cifID;
        String		reasonForRejection;
        Id			accountId;
        
        userID 					=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        cifID					=	(String)requestBodyParamsMap.get('CIFId') != null ? (String)requestBodyParamsMap.get('CIFId') : null;
		reasonForRejection		=	(String)requestBodyParamsMap.get('ReasonForRejection') != null ? (String)requestBodyParamsMap.get('ReasonForRejection') : null;
		
		
		if(userID == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.USER_ID_BLANK_PUSH_TO_LMS);
            return res;
        }
        if(String.isEmpty(cifID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.CIF_ID_BLANK);
            return res;
        }
        if(String.isEmpty(reasonForRejection)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.REASON_FOR_REJECTION_NOT_FOUND);
            return res;
        }
        List<Account> 	accountList 	=		new 	List<Account>();
        accountList	=		[SELECT 	Id
        					 FROM		Account
        					 WHERE		User_ID__c =: userID AND Unique_CIF_ID__c	=: cifID
        					 LIMIT 1]; 
        if(accountList != null && accountList.size() == 0){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.NO_LOAN_RECORD_FOR_PROSPECT_ID);
            return res;
        }else{
        	accountId				=	accountList[0].Id;
        }
        	Account account	 = 	new 	Account();
        try{
	        account.Id									=	accountId;
	        account.Account_Status__c		 			=	WebServiceConstants.ACCOUNT_STATUS_REJECTED;
	        account.Date_of_Rejection__c	 			=	Date.today();
	        account.Reason_for_rejection__c			 	=   reasonForRejection;
			upsert account;
        }catch(DmlException dmle){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_WHILE_UPDATING_ACC_DETAILS);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
				return res;
        }
		   if(account != null){
		   		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
		   		res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.ACCOUNT_DETAILS_REJECTED_SUCCESSFULLY);
		   }     
		return res;
	}
}