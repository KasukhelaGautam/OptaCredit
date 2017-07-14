/*****************************************************************************************************************************
Name of the Class : WSFetchOfflineLoanDetails
Created By : Gautam Kasukhela
Created Date : 06th May, 2016
Description of the class : Webservice that fetches the loan details of the applications created offline. This webservice 
						   returns the details for both Personal and Business loans.
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/FetchOfflineLoanDetails')
global class WSFetchOfflineLoanDetails {
    
	@HttpPost
	global static Response fetchData(){
		RestRequest restReq 	 = 	RestContext.request;
        RestResponse restRes 	 = 	RestContext.response;
        Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        
        Long 	userID;
        String	prospectID;
        
        userID 					=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        prospectID				=	(String)requestBodyParamsMap.get('ProspectNumber') != null ? (String)requestBodyParamsMap.get('ProspectNumber') : null;
        
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
        
        List<Account>					accountDetailsList 				= 	new List<Account>();
        List<Contact>					contactDetailsPAndBList			=	new	List<Contact>();
        List<Contact>					contactDetailsList				=	new	List<Contact>();
        List<genesis__Applications__c>	appDetailsList					=	new List<genesis__Applications__c>();
        List<loan__Bank_Account__c>	    bankDetailsList					=	new List<loan__Bank_Account__c>();
        String							loanType;
        Id								accountId;		
        Id								bankAccountId;
        String							legalEntityType;
        try{
        	accountDetailsList		=	[SELECT 	Type_of_Loan__c 
        								 FROM		Account
        								 WHERE		User_ID__c =: userID
        								 LIMIT 1];	
        	if(accountDetailsList != null && accountDetailsList.size() == 0){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.NO_CIF_RECORDS_FOR_USER_ID);
	            return res;
        	}else{
        		loanType = accountDetailsList[0].Type_of_Loan__c;
        	}							 
        }catch(QueryException qe){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_LOAN_TYPE);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
        }
        
        if(loanType.equals(WebServiceConstants.PERSONAL_LOAN)){
        	/*Fetch account details for the User ID*/
        	try{
        	accountDetailsList =[SELECT 	Name,Email_ID__c,Phone,Unique_CIF_ID__c,Id
        						 FROM		Account
        						 WHERE		User_ID__c =: userID];
        	if(accountDetailsList != null && accountDetailsList.size() == 0){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ACCOUNT_DETAILS_NOT_FOUND);
	            return res;
        	}else{
        			accountId	=	accountDetailsList[0].Id;
        	 }				 
        	}catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_ACCOUNT_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}
        	
        	/*Fetch Contact details for the Account*/
        	try{ 
        		contactDetailsPAndBList =	[SELECT 	FirstName,Middle_Name__c,LastName,Gender__c,Email,Phone,Permanent_Account_Number_PAN__c,BirthDate,
		        										AADHAAR_Number__c,Voter_ID__c,Voter_ID_State__c,Voter_ID_District__c,Passport_Number__c,
		        										Driving_License_Number__c,Driving_License_State__c,Permanent_Address__c,Permanent_Address_City__c,
		        										Permanent_Address_State__c,Permanent_Address_Pin_code__c,Present_Address__c,Present_Address_City__c,
		        										Present_Address_State__c,Present_Address_Pin_code__c,Registered_in_market_place_or_employer__c,
		        										Alternate_contact_number__c,Employer_Name__c,Official_Email_ID__c,Total_Experience__c,Employment_ID__c,
		        										Primary_Marketplace__c,Primary_Marketplace_Merchant_ID__c,Second_Marketplace__c,
		        										Second_Marketplace_Merchant_ID__c,Third_Marketplace__c,Third_Marketplace_Merchant_ID__c,
		        										Marketplace_Experience__c,Do_you_have_any_existing_Debt__c,Any_cash_credit_or_overdraft_account__c,
		        										Gmail_ID__c,Facebook_Profile_URL__c,Twitter_Profile_URL__c,LinkedIn_Profile_URL__c,Do_you_live_in__c,
		        										Full_name_of_reference_1__c,Address_of_reference_1__c,Email_ID_of_reference_1__c,Mobile_number_of_reference_1__c,
		        										Full_name_of_reference_2__c,Address_of_reference_2__c,Email_ID_of_reference_2__c,Mobile_number_of_reference_2__c,
		        										Source__c,Source_sub_category__c,If_others_Please_mention__c,Authorized_Signatory__c
        									FROM		Contact
        									WHERE		AccountId =: accountId
        									LIMIT 1];
        		if(contactDetailsPAndBList != null && contactDetailsPAndBList.size() == 0){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.CONTACT_DETAILS_NOT_FOUND);
		            return res;
        		}				
        	}catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_CONTACT_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}
        	try{
        		appDetailsList=	[SELECT 	Id,genesis__Account__c,genesis__Loan_Amount__c,genesis__Interest_Rate__c,genesis__Term__c,BankAccount__c
        						 FROM		genesis__Applications__c
        						 WHERE		Prospect_Number__c	=: prospectID
        						 AND		genesis__Account__c =: accountId
        						 LIMIT 1];
        		if(appDetailsList != null && appDetailsList.size() == 0){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.APPLICATION_DETAILS_NOT_FOUND);
		            return res;
        		}else{
        			bankAccountId	=	appDetailsList[0].BankAccount__c;
        		}				
        	}catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_APPLICATION_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}	
        	
        	/*Fetch Bank Account Details*/
        	try{
        		bankDetailsList		=		[SELECT  	loan__Bank_Name__c,loan__Bank_Account_Number__c,Bank_IFSC_Code__c
        								 	 FROM	 	loan__Bank_Account__c
        								 	 WHERE	 	Id =: 	bankAccountId];
        		if(bankDetailsList != null && bankDetailsList.size() == 0){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_DETAILS_NOT_FOUND);
		            return res;
        		}						 
        	}catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_BANK_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}
        	
        	/*Form the JSON response string that is to be sent to the front end*/
        	
        	String  personalLoanDetails		=		formJSONStringForPersonalLoanDetails(accountDetailsList[0], contactDetailsPAndBList[0], appDetailsList[0], bankDetailsList[0]);
        	res.responseDetails.put('PersonalLoanDetails',personalLoanDetails);
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);		 
        }
        /*BUSINESS LOAN DETAILS PROCESSING*/
        else if(loanType.equals(WebServiceConstants.BUSINESS_LOAN)){
        	try{
        		accountDetailsList= [SELECT	    Id,Name,Email_ID__c,Phone,Legal_Entity_Type__c,Date_of_Inception__c,Company_Permanent_Account_Number_PAN__c,
        										VAT_Number__c,CST_Number__c,Have_CC_Overdraft_account__c,Company_Address__c,Company_City__c,Pin_code__c,
        										Alternate_contact_number__c,Warehouse_Premise_s__c,Business_Premise_s__c,Primary_Marketplace__c,
        										Merchant_ID_1__c,Second_Marketplace__c,Merchant_ID_2__c,Third_Marketplace__c,Merchant_ID_3__c,Other_Marketplace__c,
        										Merchant_ID_4__c,Facebook_Profile_URL__c,Twitter_Profile_URL__c,LinkedIn_Profile_URL__c,cnotify__Email__c,
        										Number_of_Directors_Partners_Members__c
        							 FROM		Account
        							 WHERE		User_ID__c =: userID
        							 LIMIT 1];	
        		if(accountDetailsList != null && accountDetailsList.size() == 0){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
	            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ACCOUNT_DETAILS_NOT_FOUND);
	            	return res;
        		}else{
        			accountId		=	accountDetailsList[0].Id;
        			legalEntityType	=	accountDetailsList[0].Legal_Entity_Type__c;
        		}					 
        	}catch(QueryException qe){
	        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_LOAN_TYPE);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
           }
        try{
        	if(legalEntityType.equals(WebServiceConstants.ENTITY_TYPE_SOLE)){
        		contactDetailsPAndBList	=	  [SELECT		FirstName,Middle_Name__c,LastName,Permanent_Account_Number_PAN__c,AADHAAR_Number__c,Voter_ID__c,
			        										Passport_Number__c,Driving_License_Number__c,BirthDate,Alternate_contact_number__c,
			        										Present_Address__c,Present_Address_City__c,Present_Address_Pin_code__c,MobilePhone,
			        										Voter_ID_State__c,Driving_License_State__c
        							 			FROM		Contact
        							 			WHERE		AccountId =: accountId
        							 			LIMIT 1];
        	 if(contactDetailsPAndBList != null && contactDetailsPAndBList.size() == 0){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.CONTACT_DETAILS_NOT_FOUND);
		            return res;
        		}						 			
        	}	
        					
        	}catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_CONTACT_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}
         try{
         	if(legalEntityType.equals(WebServiceConstants.ENTITY_TYPE_PUBLIC) || legalEntityType.equals(WebServiceConstants.ENTITY_TYPE_PRIVATE) ||
         			legalEntityType.equals(WebServiceConstants.ENTITY_TYPE_LLP)){
         		contactDetailsList	=	[SELECT 	FirstName,Middle_Name__c,LastName,Permanent_Account_Number_PAN__c,AADHAAR_Number__c,Voter_ID__c,
        											Passport_Number__c,Driving_License_Number__c,BirthDate,Alternate_contact_number__c,
        											Present_Address__c,Present_Address_City__c,Present_Address_Pin_code__c,MobilePhone,
        											DIN_Number__c,DPIN_Number__c,Director_or_Promoter__c,
        											Voter_ID_State__c,Driving_License_State__c
        							     FROM		Contact
        							     WHERE		AccountId =: accountId];
        		if(contactDetailsList != null && contactDetailsList.size() == 0){
         			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.CONTACT_DETAILS_NOT_FOUND);
		            return res;
         		}					     
         	}
         }catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_CONTACT_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}
          try{
        		appDetailsList=	[SELECT 	Id,genesis__Account__c,genesis__Loan_Amount__c,genesis__Interest_Rate__c,genesis__Term__c,BankAccount__c
        						 FROM		genesis__Applications__c
        						 WHERE		Prospect_Number__c	=: prospectID
        						 AND		genesis__Account__c =: accountId
        						 LIMIT 1];
        		if(appDetailsList != null && appDetailsList.size() == 0){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.APPLICATION_DETAILS_NOT_FOUND);
		            return res;
        		}else{
        			bankAccountId	=	appDetailsList[0].BankAccount__c;
        		}				
        	}catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_APPLICATION_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}
        	
        	/*Fetch Bank Account Details*/
        	try{
        		bankDetailsList	=		[SELECT  loan__Bank_Name__c,loan__Bank_Account_Number__c,Bank_IFSC_Code__c
        								 FROM	 loan__Bank_Account__c
        								 WHERE	 Id =: 	bankAccountId];
        		if(bankDetailsList != null && bankDetailsList.size() == 0){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_DETAILS_NOT_FOUND);
		            return res;
        		}						 
        	}catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_BANK_DETAILS);
	            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
	            return res;
        	}        	
        	String  businessLoanDetails = formJSONStringForBusinessLoanDetails(accountDetailsList[0],contactDetailsPAndBList,contactDetailsList,appDetailsList[0],bankDetailsList[0]);
        	res.responseDetails.put('BusinessLoanDetails',businessLoanDetails);
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
        }
        return res;
	}
	/*Method Name: formJSONStringForPersonalLoanDetails
	  Method Description: This method forms the reponse JSON String for a Personal loan and returns the String formed.
	  Created By: Gautam Kasukhela*/
	private static String formJSONStringForPersonalLoanDetails(Account accountDetails,Contact contactDetails, 
															genesis__Applications__c appDetails, loan__Bank_Account__c bankDetails){
		String response;
		JSONGenerator	jsonGen	=	JSON.createGenerator(true);
		jsonGen.writeStartObject();
		if(contactDetails.FirstName != null){
			jsonGen.writeStringField('FirstName',contactDetails.FirstName);
		}
		if(contactDetails.Middle_Name__c != null){
			jsonGen.writeStringField('MiddleName',contactDetails.Middle_Name__c);
		}
		if(contactDetails.LastName != null){
			jsonGen.writeStringField('LastName',contactDetails.LastName);
		}
		if(contactDetails.Gender__c != null){
			jsonGen.writeStringField('Gender',contactDetails.Gender__c);
		}
		if(contactDetails.BirthDate != null){
			jsonGen.writeStringField('DateOfBirth',String.valueOf(contactDetails.BirthDate));
		}
		if(contactDetails.Email != null){
			jsonGen.writeStringField('EmailID',contactDetails.Email);
		}
		if(accountDetails.Phone != null){
			jsonGen.writeStringField('MobileNumber',accountDetails.Phone);
		}
		if(appDetails.genesis__Loan_Amount__c != null){
			jsonGen.writeNumberField('LoanAmount',appDetails.genesis__Loan_Amount__c);
		}
		if(appDetails.genesis__Term__c != null){
			jsonGen.writeNumberField('LoanTenure',appDetails.genesis__Term__c);
		}
		if(contactDetails.Permanent_Account_Number_PAN__c != null){
			jsonGen.writeStringField('PANNumber',contactDetails.Permanent_Account_Number_PAN__c);
		}
		if(contactDetails.AADHAAR_Number__c != null){
			jsonGen.writeNumberField('AADHAARNumber',contactDetails.AADHAAR_Number__c);
		}
		if(contactDetails.Voter_ID__c != null){
			jsonGen.writeStringField('VoterID',contactDetails.Voter_ID__c);
		}
		if(contactDetails.Voter_ID_State__c != null){
			jsonGen.writeStringField('VoterIDState',contactDetails.Voter_ID_State__c);
		}
		if(contactDetails.Voter_ID_District__c != null){
			jsonGen.writeStringField('VoterIDDistrict',contactDetails.Voter_ID_District__c);
		}
		if(contactDetails.Passport_Number__c != null){
			jsonGen.writeStringField('PassportNumber',contactDetails.Passport_Number__c);
		}
		if(contactDetails.Driving_License_Number__c != null){
			jsonGen.writeStringField('DrivingLicenseNumber',contactDetails.Driving_License_Number__c);
		}
		if(contactDetails.Driving_License_State__c != null){
			jsonGen.writeStringField('DrivingLicenseState',contactDetails.Driving_License_State__c);
		}
		if(contactDetails.Permanent_Address__c != null){
			jsonGen.writeStringField('PermanentAddress',contactDetails.Permanent_Address__c);
		}
		if(contactDetails.Permanent_Address_City__c != null){
			jsonGen.writeStringField('PermanentAddressCity',contactDetails.Permanent_Address_City__c);
		}
		if(contactDetails.Permanent_Address_State__c != null){
			jsonGen.writeStringField('PermanentAddressState',contactDetails.Permanent_Address_State__c);
		}
		if(contactDetails.Permanent_Address_Pin_code__c != null){
			jsonGen.writeStringField('PermanentAddressPinCode',contactDetails.Permanent_Address_Pin_code__c);
		}
		if(contactDetails.Present_Address__c != null){
			jsonGen.writeStringField('PresentAddress',contactDetails.Present_Address__c);
		}
		if(contactDetails.Present_Address_City__c != null){
			jsonGen.writeStringField('PresentAddressCity',contactDetails.Present_Address_City__c);
		}
		if(contactDetails.Present_Address_State__c != null){
			jsonGen.writeStringField('PresentAddressState',contactDetails.Present_Address_State__c);
		}
		if(contactDetails.Present_Address_Pin_code__c != null){
			jsonGen.writeStringField('PresentAddressPinCode',contactDetails.Present_Address_Pin_code__c);
		}
		if(contactDetails.Registered_in_market_place_or_employer__c != null){
			jsonGen.writeStringField('SubLoanType',contactDetails.Registered_in_market_place_or_employer__c);
		}
		if(contactDetails.Alternate_contact_number__c != null){
			jsonGen.writeStringField('AlternateContactNumber',contactDetails.Alternate_contact_number__c);
		}
		if(contactDetails.Employment_ID__c != null){
			jsonGen.writeStringField('EmploymentID',contactDetails.Employment_ID__c);
		}
		if(contactDetails.Employer_Name__c != null){
			jsonGen.writeStringField('EmployerName',contactDetails.Employer_Name__c);
		}
		if(contactDetails.Official_Email_ID__c != null){
			jsonGen.writeStringField('OfficialEmailID',contactDetails.Official_Email_ID__c);
		}
		if(contactDetails.Total_Experience__c != null){
			jsonGen.writeStringField('TotalExperience',contactDetails.Total_Experience__c);
		}
		if(contactDetails.Primary_Marketplace__c != null){
			jsonGen.writeStringField('PrimaryMarketplace',contactDetails.Primary_Marketplace__c);
		}
		if(contactDetails.Primary_Marketplace_Merchant_ID__c != null){
			jsonGen.writeStringField('PrimaryMarketplaceMerchantID',contactDetails.Primary_Marketplace_Merchant_ID__c);
		}
		if(contactDetails.Second_Marketplace__c != null){
			jsonGen.writeStringField('SecondMarketplace',contactDetails.Second_Marketplace__c);
		}
		if(contactDetails.Second_Marketplace_Merchant_ID__c != null){
			jsonGen.writeStringField('SecondMarketplaceMerchantID',contactDetails.Second_Marketplace_Merchant_ID__c);
		}
		if(contactDetails.Third_Marketplace__c != null){
			jsonGen.writeStringField('ThirdMarketplace',contactDetails.Third_Marketplace__c);
		}
		if(contactDetails.Third_Marketplace_Merchant_ID__c != null){
			jsonGen.writeStringField('ThirdMarketplaceMerchantID',contactDetails.Third_Marketplace_Merchant_ID__c);
		}
		if(contactDetails.Marketplace_Experience__c != null){
			jsonGen.writeStringField('MarketplaceExperience',contactDetails.Marketplace_Experience__c);
		}
		if(contactDetails.Do_you_have_any_existing_Debt__c != null){
			jsonGen.writeBooleanField('ExistingDebt',contactDetails.Do_you_have_any_existing_Debt__c);
		}
		if(contactDetails.Any_cash_credit_or_overdraft_account__c != null){
			jsonGen.writeBooleanField('CashCreditOrOverdraft',contactDetails.Any_cash_credit_or_overdraft_account__c);
		}
		if(contactDetails.Gmail_ID__c != null){
			jsonGen.writeStringField('GmailID',contactDetails.Gmail_ID__c);
		}
		if(contactDetails.Facebook_Profile_URL__c != null){
			jsonGen.writeStringField('FacebookProfileURL',contactDetails.Facebook_Profile_URL__c);
		}
		if(contactDetails.Twitter_Profile_URL__c != null){
			jsonGen.writeStringField('TwitterProfileURL',contactDetails.Twitter_Profile_URL__c);
		}
		if(contactDetails.LinkedIn_Profile_URL__c != null){
			jsonGen.writeStringField('LinkedInProfileURL',contactDetails.LinkedIn_Profile_URL__c);
		}
		if(contactDetails.Do_you_live_in__c != null){
			jsonGen.writeStringField('DoYouLiveIn',contactDetails.Do_you_live_in__c);
		}
		if(bankDetails.loan__Bank_Account_Number__c != null){
			jsonGen.writeStringField('BankAccountNumber',bankDetails.loan__Bank_Account_Number__c);
		}
		if(bankDetails.loan__Bank_Name__c != null){
			jsonGen.writeStringField('BankName',bankDetails.loan__Bank_Name__c);
		}
		if(bankDetails.Bank_IFSC_Code__c != null){
			jsonGen.writeStringField('BankIFSCCode',bankDetails.Bank_IFSC_Code__c);
		}
		if(contactDetails.Full_name_of_reference_1__c != null){
			jsonGen.writeStringField('Reference1FullName',contactDetails.Full_name_of_reference_1__c);
		}
		if(contactDetails.Email_ID_of_reference_1__c != null){
			jsonGen.writeStringField('Reference1EmailID',contactDetails.Email_ID_of_reference_1__c);
		}
		if(contactDetails.Address_of_reference_1__c != null){
			jsonGen.writeStringField('Reference1Address',contactDetails.Address_of_reference_1__c);
		}
		if(contactDetails.Mobile_number_of_reference_1__c != null){
			jsonGen.writeStringField('Reference1MobileNumber',contactDetails.Mobile_number_of_reference_1__c);
		}
		if(contactDetails.Full_name_of_reference_2__c != null){
			jsonGen.writeStringField('Reference2FullName',contactDetails.Full_name_of_reference_2__c);
		}
		if(contactDetails.Email_ID_of_reference_2__c != null){
			jsonGen.writeStringField('Reference2EmailID',contactDetails.Email_ID_of_reference_2__c);
		}
		if(contactDetails.Address_of_reference_2__c != null){
			jsonGen.writeStringField('Reference2Address',contactDetails.Address_of_reference_2__c);
		}
		if(contactDetails.Mobile_number_of_reference_2__c != null){
			jsonGen.writeStringField('Reference2MobileNumber',contactDetails.Mobile_number_of_reference_2__c);
		}
		if(contactDetails.Source__c != null){
			jsonGen.writeStringField('Source',contactDetails.Source__c);
		}
		if(contactDetails.Source_sub_category__c != null){
			jsonGen.writeStringField('SourceSubCategory',contactDetails.Source_sub_category__c);
		}
		if(contactDetails.If_others_Please_mention__c != null){
			jsonGen.writeStringField('Others',contactDetails.If_others_Please_mention__c);
		}
		jsonGen.writeEndObject();	
		jsonGen.close();
		
		response =  jsonGen.getAsString();
		return response;
		
	}
	
	/*Method Name: formJSONStringForBusinessLoanDetails
	  Method Description: This method forms the reponse JSON String for a Business loan and returns the String formed.
	  Created By: Gautam Kasukhela*/
	private static String formJSONStringForBusinessLoanDetails(Account accountDetails,List<Contact> contactDetailsPAndBList, List<Contact>  contactDetailsList,
															genesis__Applications__c appDetails, loan__Bank_Account__c bankDetails){
		String response;
		JSONGenerator	jsonGen	=	JSON.createGenerator(true);
		jsonGen.writeStartObject();
		if(accountDetails.Name != null){
			jsonGen.writeStringField('CompanyName',accountDetails.Name);
		}
		if(accountDetails.Legal_Entity_Type__c != null){
			jsonGen.writeStringField('EntityType',accountDetails.Legal_Entity_Type__c);
		}
		if(accountDetails.Email_ID__c != null){
			jsonGen.writeStringField('EmailID',accountDetails.Email_ID__c);
		}
		if(accountDetails.Phone != null){
			jsonGen.writeStringField('MobileNumber',accountDetails.Phone);
		}
		if(accountDetails.Date_of_Inception__c != null){
			jsonGen.writeStringField('DateOfIncorporation',String.valueOf(accountDetails.Date_of_Inception__c));
		}
		if(accountDetails.Company_Permanent_Account_Number_PAN__c != null){
			jsonGen.writeStringField('PANOfBusiness',accountDetails.Company_Permanent_Account_Number_PAN__c);
		}
		if(accountDetails.VAT_Number__c != null){
			jsonGen.writeStringField('VATNumber',accountDetails.VAT_Number__c);
		}
		if(accountDetails.CST_Number__c != null){
			jsonGen.writeStringField('CSTNumber',accountDetails.CST_Number__c);
		}
		if(appDetails.genesis__Loan_Amount__c != null){
			jsonGen.writeNumberField('LoanAmount',appDetails.genesis__Loan_Amount__c);
		}
		if(appDetails.genesis__Term__c != null){
			jsonGen.writeNumberField('LoanTenure',appDetails.genesis__Term__c);
		}
		if(accountDetails.Have_CC_Overdraft_account__c != null){
			jsonGen.writeBooleanField('CashCreditOrOverdraftAccount',accountDetails.Have_CC_Overdraft_account__c);
		}
		if(accountDetails.Company_Address__c != null){
			jsonGen.writeStringField('RegisteredOfficeAddress',accountDetails.Company_Address__c);
		}
		if(accountDetails.Company_City__c != null){
			jsonGen.writeStringField('RegisteredOfficeAddressCity',accountDetails.Company_City__c);
		}
		if(accountDetails.Pin_code__c != null){
			jsonGen.writeNumberField('RegisteredOfficeAddressPinCode',accountDetails.Pin_code__c);
		}
		if(accountDetails.Warehouse_Premise_s__c != null){
			jsonGen.writeStringField('WarehousePremises',accountDetails.Warehouse_Premise_s__c);
		}
		if(accountDetails.Business_Premise_s__c != null){
			jsonGen.writeStringField('BusinessPremises',accountDetails.Business_Premise_s__c);
		}
		if(accountDetails.Legal_Entity_Type__c.equals(WebServiceConstants.ENTITY_TYPE_SOLE)){
			if(contactDetailsPAndBList[0].FirstName != null){
				jsonGen.writeStringField('FirstName',contactDetailsPAndBList[0].FirstName);
	    	}
	    	if(contactDetailsPAndBList[0].Middle_Name__c != null){
				jsonGen.writeStringField('MiddleName',contactDetailsPAndBList[0].Middle_Name__c);
	    	}
	    	if(contactDetailsPAndBList[0].LastName != null){
				jsonGen.writeStringField('LastName',contactDetailsPAndBList[0].LastName);
	    	}
	    	if(contactDetailsPAndBList[0].Permanent_Account_Number_PAN__c != null){
				jsonGen.writeStringField('PANNumber',contactDetailsPAndBList[0].Permanent_Account_Number_PAN__c);
	    	}
	    	if(contactDetailsPAndBList[0].AADHAAR_Number__c != null){
				jsonGen.writeNumberField('AADHAARNumber',contactDetailsPAndBList[0].AADHAAR_Number__c);
	    	}
	    	if(contactDetailsPAndBList[0].Voter_ID__c != null){
				jsonGen.writeStringField('VoterID',contactDetailsPAndBList[0].Voter_ID__c);
	    	}
	    	if(contactDetailsPAndBList[0].Voter_ID_State__c != null){
				jsonGen.writeStringField('VoterIDState',contactDetailsPAndBList[0].Voter_ID_State__c);
	    	}
	    	if(contactDetailsPAndBList[0].Passport_Number__c != null){
				jsonGen.writeStringField('PassportNumber',contactDetailsPAndBList[0].Passport_Number__c);
	    	}
	    	if(contactDetailsPAndBList[0].Driving_License_Number__c != null){
				jsonGen.writeStringField('DrivingLicenseNumber',contactDetailsPAndBList[0].Driving_License_Number__c);
	    	}
	    	if(contactDetailsPAndBList[0].Driving_License_State__c != null){
				jsonGen.writeStringField('DrivingLicenseState',contactDetailsPAndBList[0].Driving_License_State__c);
	    	}
	    	if(contactDetailsPAndBList[0].BirthDate != null){
				jsonGen.writeStringField('DateOfBirth',String.valueOf(contactDetailsPAndBList[0].BirthDate));
	    	}
	    	if(contactDetailsPAndBList[0].Present_Address__c != null){
				jsonGen.writeStringField('ResidentialAddress',contactDetailsPAndBList[0].Present_Address__c);
	    	}
	    	if(contactDetailsPAndBList[0].Present_Address_City__c != null){
				jsonGen.writeStringField('ResidentialAddressCity',contactDetailsPAndBList[0].Present_Address_City__c);
	    	}
	    	if(contactDetailsPAndBList[0].Present_Address_Pin_code__c != null){
				jsonGen.writeStringField('ResidentialAddressPinCode',contactDetailsPAndBList[0].Present_Address_Pin_code__c);
	    	}
	    	if(contactDetailsPAndBList[0].MobilePhone != null){
				jsonGen.writeStringField('ContactNumber',contactDetailsPAndBList[0].MobilePhone);
	    	}
	    	if(contactDetailsPAndBList[0].Alternate_contact_number__c != null){
				jsonGen.writeStringField('AlternateContactNumber',contactDetailsPAndBList[0].Alternate_contact_number__c);
	    	}
		}else if(accountDetails.Legal_Entity_Type__c.equals(WebServiceConstants.ENTITY_TYPE_PUBLIC) || 
				 accountDetails.Legal_Entity_Type__c.equals(WebServiceConstants.ENTITY_TYPE_PRIVATE) ||
         		 accountDetails.Legal_Entity_Type__c.equals(WebServiceConstants.ENTITY_TYPE_LLP)){
         		 jsonGen.writeFieldName('DirectorsOrPartners');
         		 jsonGen.writeStartArray();
			for(Contact tempContactDetails : contactDetailsList){
				jsonGen.writeStartObject();
				if(tempContactDetails.FirstName != null){
					jsonGen.writeStringField('FirstName_PD',tempContactDetails.FirstName);
				}
				if(tempContactDetails.Middle_Name__c != null){
					jsonGen.writeStringField('MiddleName_PD',tempContactDetails.Middle_Name__c);
				}
				if(tempContactDetails.LastName != null){
					jsonGen.writeStringField('LastName_PD',tempContactDetails.LastName);
				}
				if(tempContactDetails.Director_or_Promoter__c != null){
					jsonGen.writeStringField('DirectorOrPromoter_PD',tempContactDetails.Director_or_Promoter__c);
				}
				if(tempContactDetails.BirthDate != null){
					jsonGen.writeStringField('DateOfBirth_PD',String.valueOf(tempContactDetails.BirthDate));
				}
				if(tempContactDetails.Permanent_Account_Number_PAN__c != null){
					jsonGen.writeStringField('PANNumber_PD',tempContactDetails.Permanent_Account_Number_PAN__c);
				}
				if(tempContactDetails.AADHAAR_Number__c != null){
					jsonGen.writeNumberField('AADHAARNumber_PD',tempContactDetails.AADHAAR_Number__c);
				}
				if(tempContactDetails.Voter_ID__c != null){
					jsonGen.writeStringField('VoterID_PD',tempContactDetails.Voter_ID__c);
				}
				if(tempContactDetails.Voter_ID_State__c != null){
					jsonGen.writeStringField('VoterIDState_PD',tempContactDetails.Voter_ID_State__c);
				}
				if(tempContactDetails.Passport_Number__c != null){
					jsonGen.writeStringField('PassportNumber_PD',tempContactDetails.Passport_Number__c);
				}
				if(tempContactDetails.Driving_License_Number__c != null){
					jsonGen.writeStringField('DrivingLicenseNumber_PD',tempContactDetails.Driving_License_Number__c);
				}
				if(tempContactDetails.Driving_License_State__c != null){
					jsonGen.writeStringField('DrivingLicenseState_PD',tempContactDetails.Driving_License_State__c);
				}
				if(tempContactDetails.DIN_Number__c != null){
					jsonGen.writeStringField('DINNumber_PD',tempContactDetails.DIN_Number__c);
				}
				if(tempContactDetails.DPIN_Number__c != null){
					jsonGen.writeStringField('DPINNumber_PD',tempContactDetails.DPIN_Number__c);
				}
				if(tempContactDetails.Present_Address__c != null){
					jsonGen.writeStringField('ResidentialAddress_PD',tempContactDetails.Present_Address__c);
				}
				if(tempContactDetails.Present_Address_City__c != null){
					jsonGen.writeStringField('ResidentialAddressCity_PD',tempContactDetails.Present_Address_City__c);
				}
				if(tempContactDetails.Present_Address_Pin_code__c != null){
					jsonGen.writeStringField('ResidentialAddressPinCode_PD',tempContactDetails.Present_Address_Pin_code__c);
				}
				if(tempContactDetails.MobilePhone != null){
					jsonGen.writeStringField('ContactNumber_PD',tempContactDetails.MobilePhone);
				}
				if(tempContactDetails.Alternate_contact_number__c != null){
					jsonGen.writeStringField('AlternateContactNumber_PD',tempContactDetails.Alternate_contact_number__c);
				}
				jsonGen.writeEndObject();
			}   jsonGen.writeEndArray();
			
		}
	    	if(accountDetails.Primary_Marketplace__c != null){
				jsonGen.writeStringField('PrimaryMarketplace',accountDetails.Primary_Marketplace__c);
	    	}
	    	if(accountDetails.Merchant_ID_1__c != null){
				jsonGen.writeStringField('PrimaryMarketplaceMerchantID',accountDetails.Merchant_ID_1__c);
	    	}
	    	if(accountDetails.Second_Marketplace__c != null){
				jsonGen.writeStringField('SecondMarketplace',accountDetails.Second_Marketplace__c);
	    	}
			if(accountDetails.Merchant_ID_2__c != null){
				jsonGen.writeStringField('SecondMarketplaceMerchantID',accountDetails.Merchant_ID_2__c);
			}
			if(accountDetails.Third_Marketplace__c != null){
				jsonGen.writeStringField('ThirdMarketplace',accountDetails.Third_Marketplace__c);
			}
			if(accountDetails.Merchant_ID_3__c != null){
				jsonGen.writeStringField('ThirdMarketplaceMerchantID',accountDetails.Merchant_ID_3__c);
			}
			if(accountDetails.Other_Marketplace__c != null){
				jsonGen.writeStringField('OtherMarketPlace',accountDetails.Other_Marketplace__c);
			}
			if(accountDetails.Merchant_ID_4__c != null){
				jsonGen.writeStringField('OtherMarketPlaceMerchantID',accountDetails.Merchant_ID_4__c);
			}
			if(bankDetails.loan__Bank_Account_Number__c != null){
				jsonGen.writeStringField('BankAccountNumber',bankDetails.loan__Bank_Account_Number__c);
			}
			if(bankDetails.loan__Bank_Name__c != null){
				jsonGen.writeStringField('BankName',bankDetails.loan__Bank_Name__c);
			}
			if(bankDetails.Bank_IFSC_Code__c != null){
				jsonGen.writeStringField('BankIFSCCode',bankDetails.Bank_IFSC_Code__c);
			}
			if(accountDetails.Facebook_Profile_URL__c != null){
				jsonGen.writeStringField('FacebookProfileURL',accountDetails.Facebook_Profile_URL__c);
			}
			if(accountDetails.Twitter_Profile_URL__c != null){
				jsonGen.writeStringField('TwitterProfileURL',accountDetails.Twitter_Profile_URL__c);
			}
			if(accountDetails.LinkedIn_Profile_URL__c != null){
				jsonGen.writeStringField('LinkedInProfileURL',accountDetails.LinkedIn_Profile_URL__c);
			}
		jsonGen.writeEndObject();	
		jsonGen.close();
		response =  jsonGen.getAsString();
		return response;
		
	}
	
}