/*****************************************************************************************************************************
Name of the Class : WSGetSocialDetailsScore
Created By : Gautam Kasukhela
Created Date : 03rd June, 2016
Description of the class : Webservice that captures the Social details score (Lenddo Score) that is passed on from the front
						   end. A few validations are done to check the status of the application and then the score is updated
						   in the LMS system or the backend.
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/GetSocialDetailsScore')
global class WSGetSocialDetailsScore {
    
	@HttpPost
	global static Response getScore(){
		
		RestRequest restReq 	 = 	RestContext.request;
        RestResponse restRes 	 = 	RestContext.response;
        Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        JSONParser 			finalResponseParser  = JSON.createParser(restReq.requestBody.toString());
        
        List<Account>					accountDetailsList 	= 	new List<Account>();
        List<genesis__Applications__c>	appDetailsList		=	new List<genesis__Applications__c>();
        Id 		accountId;
        Id		loanAppId;
        String	loanAppStatus;
        
        /*Verification Details*/
        String  facebookVerified;
        String  nameVerified;
        String  universityVerified;
        String	employerVerified;
        String  birthDayVerified;
        String	topEmployerVerified;
        
        /*Probe Details*/
        String  name;
        String  university;
        String	employer;
        String  birthDay;
        String	topEmployer;
        
        Long 		userID;
        String		prospectID;
        String		socialDetailsScore;
        
        userID 						=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        prospectID					=	(String)requestBodyParamsMap.get('ProspectID') != null ? (String)requestBodyParamsMap.get('ProspectID') : null;
        socialDetailsScore			=	(String)requestBodyParamsMap.get('SocialDetailsScore') != null ? (String)requestBodyParamsMap.get('SocialDetailsScore') : null;
        
        
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
        if(String.isEmpty(socialDetailsScore)){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.SOCIAL_DETAILS_SCORE_BLANK);
            return res;
        }
		try{
		 	 accountDetailsList =	[SELECT 	Id
        							 FROM		Account
        							 WHERE		User_ID__c =: userID];
        	if(accountDetailsList != null && accountDetailsList.size() != 0){
        		accountId	=	accountDetailsList[0].Id;
        	}else{
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ACCOUNT_DETAILS_NOT_FOUND);
	            return res;
        	 }
/************************************Parse the JSON for Verification Details : START*****************************************************/
        	 
       while(finalResponseParser.nextToken() != null){
            if(finalResponseParser.getText().equals('verified_by_facebook') ){
                finalResponseParser.nextToken();
                facebookVerified = finalResponseParser.getText();
            	}
    		if(finalResponseParser.getText().equals('verifications')){
        			while(finalResponseParser.nextToken() != null &&
                      		finalResponseParser.getCurrentToken() != JSONToken.END_OBJECT){
                      			
			            if(finalResponseParser.getText().equals('name') ){
			                finalResponseParser.nextToken();
			                nameVerified = finalResponseParser.getText();
			            }
			            else if(finalResponseParser.getText().equals('university') ){
			                finalResponseParser.nextToken();
			                universityVerified = finalResponseParser.getText();
			            }
			            else if(finalResponseParser.getText().equals('employer') ){
			                finalResponseParser.nextToken();
			                employerVerified = finalResponseParser.getText();
			            }
			            else if(finalResponseParser.getText().equals('birthday') ){
			                finalResponseParser.nextToken();
			                birthDayVerified = finalResponseParser.getText();
			            }
	          			else if(finalResponseParser.getText().equals('top_employer') ){
			                finalResponseParser.nextToken();
			                topEmployerVerified = finalResponseParser.getText();
			            }
        		}
        	}
        	if(finalResponseParser.getText().equals('probes')){
        			while(finalResponseParser.nextToken() != null &&
                      		finalResponseParser.getCurrentToken() != JSONToken.END_OBJECT){
			            if(finalResponseParser.getText().equals('name') ){
			                finalResponseParser.nextToken();
			                finalResponseParser.nextToken();
			                name = finalResponseParser.getText();
			                      
			            }
			            else if(finalResponseParser.getText().equals('university') ){
			                while(finalResponseParser.nextToken() != null &&
			                      finalResponseParser.getCurrentToken() != JSONToken.END_OBJECT){
			                          if(finalResponseParser.getText().equals('university')){
			                finalResponseParser.nextToken();
			                university = finalResponseParser.getText();
			                          }
			                      }
			            }
			            else if(finalResponseParser.getText().equals('employer') ){
			                while(finalResponseParser.nextToken() != null &&
			                      finalResponseParser.getCurrentToken() != JSONToken.END_OBJECT){
			                          if(finalResponseParser.getText().equals('employer')){
			                finalResponseParser.nextToken();
			                employer = finalResponseParser.getText();
			                          }
			                      }
			            }
			            else if(finalResponseParser.getText().equals('birthday') ){
			                finalResponseParser.nextToken();
			                birthDay = finalResponseParser.getText();
			            }
          				else if(finalResponseParser.getText().equals('top_employer') ){
			                finalResponseParser.nextToken();
			                topEmployer = finalResponseParser.getText();
			            }
        
        	}
        }
    }
/************************************Parse the JSON for Verification Details : END*****************************************************/        	 
        	 
        	 
        	  appDetailsList    =  [SELECT 		Id,genesis__Status__c
        						 	FROM		genesis__Applications__c
        						 	WHERE		Prospect_Number__c	=: prospectID
        						 	AND			genesis__Account__c =: accountId
        						 	LIMIT 1];
        						 	
        		if(appDetailsList != null && appDetailsList.size() == 0){
        			/*If no loan application is present then it implies that the loan application has not yet been created in the system and hence
        			  only the Account object is updated. If the Loan Application is present then check the status, if it is anything other than 
        			  NEW - ENTERED then an error is thrown else application record is updated.*/
        			  Account 	account					=	new 	Account();
					  account.Id						=	accountId;
					  account.Social_Details_Score__c	=	Integer.valueOf(socialDetailsScore);
					  upsert account;
					  
					  if(account != null){
					  		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
                  			res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.SOCIAL_DETAILS_SCORE_UPDATED);
                  			return res;
					  }
        		}else{
        				loanAppId 		=	appDetailsList[0].Id;
        				loanAppStatus	=	appDetailsList[0].genesis__Status__c;
        			/*If the status of the loan application is not NEW - ENTERED then an error is returned informing that the 
        			  Social details score cannot be updated now in the LMS system.*/
        			if(loanAppId != null && !loanAppStatus.equals(WebServiceConstants.NEWLY_ENTERED_APPLICATION)){
					    res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
		           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
		            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.SOCIAL_DETAILS_SCORE_APP_STATUS_MISMATCH +loanAppStatus);
		            	return res;
		            }	
        	 		genesis__Applications__c	app		= 	new 	genesis__Applications__c();
        	 		app.Id								=	loanAppId;
        	 		app.Social_Details_Score__c			=	Integer.valueOf(socialDetailsScore);
        	 		if(!String.isEmpty(nameVerified)){
        	 			app.Name_Verified__c				=	Boolean.valueOf(nameVerified);
        	 		}
        	 		if(!String.isEmpty(universityVerified)){
        	 			app.University_Verified__c			=	Boolean.valueOf(universityVerified);
        	 		}
        	 		if(!String.isEmpty(employerVerified)){
        	 			app.Employer_Verified__c			=	Boolean.valueOf(employerVerified);
        	 		}
        	 		if(!String.isEmpty(birthDayVerified)){
        	 			app.Birthday_Verified__c			=	Boolean.valueOf(birthDayVerified);
        	 		}
        	 		if(!String.isEmpty(topEmployerVerified)){
        	 			app.Top_Employer_Verified__c		=	Boolean.valueOf(topEmployerVerified);
        	 		}
        	 		app.Birthday_as_per_Lenddo__c			=	birthDay;
        	 		app.Employer_Name_as_per_Lenddo__c		=	employer;
        	 		app.Name_as_per_Lenddo__c				=	name;
        	 		app.Top_Employer_as_per_Lenddo__c		=	topEmployer;
        	 		app.University_as_per_Lenddo__c			=	university;
        	 		upsert app;
        	 		if(app != null){
        	 			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
                  		res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.SOCIAL_DETAILS_SCORE_UPDATED);
        	 		}	
		         }				 
			}catch(Exception e){
				res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.DATABASE_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.EXCEPTION_WHILE_UPDATING_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, e.getMessage());
		}
		return res;
	}
}