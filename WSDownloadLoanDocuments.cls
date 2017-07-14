/*****************************************************************************************************************************
Name of the Class : WSDownloadLoanDocuments
Created By : Gautam Kasukhela
Created Date : 14th June, 2016
Description of the class : Webservice that fetches the Loan documents from the LMS system and sends it to the front end.
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/DownloadLoanDocuments')
global class WSDownloadLoanDocuments {
    
	@HttpPost
	global static Response getDocument(){
	
		RestRequest restReq 	 = 	RestContext.request;
        RestResponse restRes 	 = 	RestContext.response;
        Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        
        Long 		userID;
        String		prospectID;
        String		fileType;
        Id			applicationId;
        
        userID 					=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        prospectID				=	(String)requestBodyParamsMap.get('ProspectID') != null ? (String)requestBodyParamsMap.get('ProspectID') : null;
        fileType				=	(String)requestBodyParamsMap.get('FileType') != null ? (String)requestBodyParamsMap.get('FileType') : null;
		
		/*Valid file types are : Loan Agreement, Sanction Letter, Repayment Schedule, Security PDC Letter, Promissory Note, Continuity Letter,
		  End Use Letter, Sole Proprietorship, Vernacular Declaration, Common Mandate Form, Personal Guarantee Form, Authorization Letter  */
		
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
        if(String.isEmpty(fileType)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.FILE_TYPE_BLANK);
            return res;
        }
        if(!(fileType.equals('Loan Agreement') || fileType.equals('Sanction Letter') || fileType.equals('Repayment Schedule') || 
           fileType.equals('Security PDC Letter') || fileType.equals('Promissory Note') || fileType.equals('Continuity Letter') ||
           fileType.equals('End User Letter') || fileType.equals('Sole Proprietorship Declaration') || fileType.equals('Vernacular Declaration') ||
           fileType.equals('Common Mandate Form') || fileType.equals('Personal Guarantee Form') || fileType.equals('Authorization Letter'))){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.INVALID_FILE_TYPE);
            	return res;
        }
        
        List<Attachment> 				attachmentList	=	new List<Attachment>();
        List<loan__Loan_Account__c>		contractList	=	new List<loan__Loan_Account__c>();
        List<genesis__Applications__c>	appList			=	new List<genesis__Applications__c>();
        
        try{
        	appList				=		[SELECT 		Id
        								 FROM			genesis__Applications__c
        								 WHERE			genesis__Account__r.User_ID__c =: userID
        								 AND			Prospect_Number__c	=: prospectID
        								 LIMIT 1];
        	if(appList != null && appList.size() == 0){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.NO_LOAN_RECORD_FOR_PROSPECT_ID);
            	return res;
        	}							 
        	
        	contractList		=		[SELECT 		Id
        								 FROM			loan__Loan_Account__c	
        								 WHERE			loan__Account__r.User_ID__c	=: userID 
        								 AND			Prospect_Number__c	=: prospectID
        								 LIMIT 1];
        	if(contractList != null && contractList.size() == 0){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_CONTRACT_DETAILS_NOT_FOUND);
            	return res;
        	}
        	applicationId		=		appList[0].Id;
        	attachmentList		=		[SELECT 		Body
        								 FROM			Attachment
        								 WHERE			ParentId =: applicationId
        								 AND			Description =: fileType
        								 ORDER BY		CreatedDate  DESC];
        	if(attachmentList != null && attachmentList.size() == 0){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_DOCS_NOT_GENERATED);
            	return res;
        	}								 
        }catch(QueryException e){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.QUERY_EXCEPTION_FETCHING_ATTACHMENT);
            	return res;
        }
        
        Blob 	attachmentBody	=	attachmentList[0].Body;
        String  blobString64 	= 	EncodingUtil.base64Encode(attachmentBody);
        
        if(!String.isEmpty(blobString64)){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
                res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.LOAN_DOCUMENT_FETCHED_SUCCESSFULLY);
	            res.responseDetails.put(WebServiceConstants.ENCODED_DATA,blobString64);
        }
	return res;
	}
}