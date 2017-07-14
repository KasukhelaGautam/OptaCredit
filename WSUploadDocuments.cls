/*****************************************************************************************************************************
Name of the Class : WSUploadDocuments
Created By : Gautam Kasukhela
Created Date : 17th May, 2016
Description of the class : Webservice that is used to upload user documents from the frontend and stored in the Attachment object
						   in the backend.
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/UploadDocuments')
global class WSUploadDocuments {
	        
   @HttpPost
    global static Response upload(){
    	
    	RestRequest restReq 	 = 	RestContext.request;
   		RestResponse restRes 	 = 	RestContext.response;
   		Response res 		 	 = 	new Response();
		String 		userID;
        String		prospectID;
        Id			appId;
        String		fileName;
        String		fileCategory;
        String		attachmentBody;
        Long		userIDLong;
        String		description;
        
        userID 					=	restReq.headers.get('UserID') ;
        prospectID				=	restReq.headers.get('ProspectID') ;
        fileCategory 			=   restReq.headers.get('FileCategory') ;
      	fileName 				=   restReq.headers.get('FileName') ;
      	attachmentBody			=	restReq.requestBody.toString();
        
        if(String.isEmpty(userID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.USER_ID_BLANK);
            return res;
        }
		if(String.isEmpty(prospectID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PROSPECT_ID_BLANK);
            return res;
        }
        if(String.isEmpty(fileCategory)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.FILE_CATEGORY_IS_BLANK);
            return res;
        }
        if(String.isEmpty(fileName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.FILE_NAME_IS_BLANK);
            return res;
        }
         if(String.isEmpty(attachmentBody)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.REQUEST_BODY_FOR_DOC_UPLOAD_IS_BLANK);
            return res;
        }
        userIDLong	=	Long.valueOf(userID);
         List<genesis__Applications__c> 	appList 	=		new 	List<genesis__Applications__c>();
         try{
        appList		=		[SELECT 	Id
        					 FROM		genesis__Applications__c
        					 WHERE		Prospect_Number__c =: prospectID AND genesis__Account__r.User_ID__c =: userIDLong
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
        }
        /*Check if the document category is a valid one. Document categories are pre defined, only the pre defined ones are valid.*/
        if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_PAN)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_PAN;	
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_AADHAAR)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_AADHAAR;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_VOTER_ID)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_VOTER_ID;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_SALARY_SLIP)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_SALARY_SLIP;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_LAST_ITR)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_LAST_ITR;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_OTHER)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_OTHER;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_CORPORATE_PAN)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_CORPORATE_PAN;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_CORPORATE_INCOME_STATEMENT)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_CORPORATE_INCOME_STATEMENT;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_CORPORATE_BALANCE_SHEET)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_CORPORATE_BALANCE_SHEET;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_CORPORATE_INVOICES)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_CORPORATE_INVOICES;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_MARKETPLACE_DOCUMENT)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_MARKETPLACE_DOCUMENT;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_DL)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_DL;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_BANK_STATEMENT)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_BANK_STATEMENT;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_VAT)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_VAT;
        }else if(fileCategory.equals(WebServiceConstants.FILE_CATEGORY_PASSPORT)){
        	description		=	WebServiceConstants.FILE_DESCRIPTION_PASSPORT;
        }else{
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.INVALID_DOCUMENT_CATEGORY);
            return res;
        }
        
        Attachment 	attach	=	new 	Attachment();
        try{
        	attach.Name			=	fileName;
        	attach.ParentId		=	appId;
        	attach.Body			=	EncodingUtil.base64Decode(restReq.requestBody.toString());
        	attach.Description	=	description;
        	insert attach;
        }catch(DmlException dmle){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_WHILE_UPLOADING_DOCUMENT);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
				return res;
        }
        if(attach != null){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
		   		res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.DOCUMENT_UPLOAD_SUCCESS);
        }
        return res;
    }
}