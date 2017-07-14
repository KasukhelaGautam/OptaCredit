/*****************************************************************************************************************************
Name of the Class : WSUpdateEmailAndMobileNumber
Created By : Gautam Kasukhela
Created Date : 13th May, 2016
Description of the class : Webservice that updates the email id and phone number of a user.
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/UpdateEmailAndMobileNumber')
global class WSUpdateEmailAndMobileNumber {
    
	@HttpPost
	global static Response updateData(){
		
		RestRequest restReq 	 = 	RestContext.request;
        RestResponse restRes 	 = 	RestContext.response;
        Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        
        Long 	userID;
        String	cifID;
        String	emailID;
        String	mobileNumber;
        
        userID 					=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        cifID					=	(String)requestBodyParamsMap.get('CIFId') != null ? (String)requestBodyParamsMap.get('CIFId') : null;
        emailID					=	(String)requestBodyParamsMap.get('EmailID') != null ? (String)requestBodyParamsMap.get('EmailID') : null;
        mobileNumber			=	(String)requestBodyParamsMap.get('MobileNumber') != null ? (String)requestBodyParamsMap.get('MobileNumber') : null;
        
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
        if(String.isEmpty(emailID) && String.isEmpty(mobileNumber)){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BOTH_EMAIL_AND_MOBILE_NUMBER_MISSING);
            return res;
        }
        
        Account	account		= 	new 	Account();
        genesis__Applications__c  application = new genesis__Applications__c();
        Id      accountId;
        Id		applicationId;
        String  loanAppStatus;
        try{	
        List<Account> accountList 				= 	[SELECT	    Id
        						     				 FROM		Account
        						     				 WHERE		User_ID__c =: userID 
        						     				 AND 		Unique_CIF_ID__c	=: cifID
        						     				 LIMIT 1];
         /*Fetch the latest Loan application that is linked with the User ID and Prospect ID*/						     				 
        List<genesis__Applications__c> appList 	=   [SELECT 	Id,genesis__Status__c
        											 FROM		genesis__Applications__c
        											 WHERE		genesis__Account__r.User_ID__c =: userID 
        											 AND		genesis__Account__r.Unique_CIF_ID__c	=: cifID
        											 ORDER BY   CreatedDate 
        											 DESC
        											 LIMIT 1];	
        if(appList != null && appList.size() != 0){
        	applicationId	= 	appList[0].Id;
        	loanAppStatus	=	appList[0].genesis__Status__c;
        }											  						     
        if(accountList != null && accountList.size() == 0 ){
          	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.NO_CIF_RECORDS_FOR_USER_ID);
            return res;
          }else{
        	accountId		=	accountList[0].Id;
          }
        }catch(QueryException qe){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_LOAN_TYPE);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
        }
        
        /*Update Email and Mobile number*/
        try{
        	if(!String.isEmpty(emailID)){
        		account.Email_ID__c			=	emailID;
        		account.cnotify__Email__c	=	emailID;
        	}
	        if(!String.isEmpty(mobileNumber)){
	        	account.Phone				=	mobileNumber;
	        }
	        account.Id					=	accountId;
	        upsert account;
	        /*Update the latest active loan application's email Id field to ensure that the email alerts are routed to the updated  email address */
	        if(applicationId != null && !loanAppStatus.equals(WebServiceConstants.LOAN_APPLICATION_CLOSED_STATUS)){
	        	application.Id 				=	applicationId;
	        	application.Email_ID__c		=	emailID;
	        	upsert application;
	        }
           }catch(DmlException dmle){
              res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
              res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
              res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_WHILE_UPDATING_DETAILS);
              res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
              return res;
           }
           if(account != null){
           		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
           	    res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.DETAILS_UPDATED_SUCCESSFULLY +userID);
           }
           return res;					  
	}
	
}