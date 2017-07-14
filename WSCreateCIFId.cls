/*****************************************************************************************************************************
Name of the Class : WSCreateCIFId
Created By : Gautam Kasukhela
Created Date : 22nd February, 2016
Description of the class : Webservice that creates a CIF ID in the backend by taking a few inputs from the frontend system.

*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/CreateCIFId')
global class WSCreateCIFId {
	        
   @HttpPost
    global static Response CreateCIF(){
        
        RestRequest restReq 	 = 	RestContext.request;
   		RestResponse restRes 	 = 	RestContext.response;
   		Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        
        /*Variables that will hold the values coming from the frontend for Personal Loan : START*/
        String 	firstName;
        String  middleName;
        String 	lastName;
        String  panNumber;
        Double  aadhaarNumber;
        String  voterID;
        String  voterIDState;
        //String  voterIDDistrict;
        String  passportNumber;
        String  drivingLicenseNumber;
        String  drivingLicenseState;
        /*Variables that will hold the values coming from the frontend for Personal Loan : END*/
        
        /*Variables that will hold the values coming from the frontend for Business Loan : START*/
        String 	companyName;
        String  panOfBusiness;
        String  vatNumber;
        String  cstNumber;
        /*Variables that will hold the values coming from the frontend for Business Loan : END*/
        
        /*Variables that will hold the values coming from the frontend common to both Personal & Business Loans : START*/
        String 	typeOfLoan;
        String 	emailID;
        String 	mobileNumber;
        Long	userID;
        String  prospectID;
        /*Variables that will hold the values coming from the frontend common to both Personal & Business Loans : END*/
        
        String 		permanentAddress;
        String		permanentAddressCity;
        String 		permanentAddressState;
        String		permanentAddressPincode;
        String 		subLoanType;
        String		employmentID;
        String		employerName;
        String		totalExperience;
        String		primaryMarketPlace;
        String		primaryMarketPlaceMerchantID;
        String 		doYouLiveIn;      
        
                
        /*Parsing the values from the request*/
        typeOfLoan 						=  	(String)requestBodyParamsMap.get('TypeOfLoan') != null ? (String)requestBodyParamsMap.get('TypeOfLoan') : null;
        firstName 						=  	(String)requestBodyParamsMap.get('FirstName') != null ? (String)requestBodyParamsMap.get('FirstName') : null;
        middleName 						=  	(String)requestBodyParamsMap.get('MiddleName') != null ? (String)requestBodyParamsMap.get('MiddleName') : null;
        lastName 						= 	(String)requestBodyParamsMap.get('LastName') != null ? (String)requestBodyParamsMap.get('LastName') : null;
        emailID							= 	(String)requestBodyParamsMap.get('EmailID') != null ? (String)requestBodyParamsMap.get('EmailID') : null;
        mobileNumber 					=	(String)requestBodyParamsMap.get('MobileNumber') != null ? (String)requestBodyParamsMap.get('MobileNumber') : null;
        userID							=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID'):null;
        prospectID						=	(String)requestBodyParamsMap.get('ProspectID') != null ? (String)requestBodyParamsMap.get('ProspectID') : null;
        panNumber						=	(String)requestBodyParamsMap.get('PANNumber') != null ? (String)requestBodyParamsMap.get('PANNumber') : null;
        aadhaarNumber   				=	(Double)requestBodyParamsMap.get('AADHAARNumber') != null ? (Double)requestBodyParamsMap.get('AADHAARNumber') : null;
        voterID							=	(String)requestBodyParamsMap.get('VoterID') != null ? (String)requestBodyParamsMap.get('VoterID') : null;
        voterIDState					=	(String)requestBodyParamsMap.get('VoterIDState') != null ? (String)requestBodyParamsMap.get('VoterIDState') : null;
        //voterIDDistrict					=	(String)requestBodyParamsMap.get('VoterIDDistrict') != null ? (String)requestBodyParamsMap.get('VoterIDDistrict') : null;
        passportNumber					=	(String)requestBodyParamsMap.get('PassportNumber') != null ? (String)requestBodyParamsMap.get('PassportNumber') : null;
        drivingLicenseNumber			=	(String)requestBodyParamsMap.get('DrivingLicenseNumber') != null ? (String)requestBodyParamsMap.get('DrivingLicenseNumber') : null;
        drivingLicenseState				=	(String)requestBodyParamsMap.get('DrivingLicenseState') != null ? (String)requestBodyParamsMap.get('DrivingLicenseState') : null;
        companyName 					=	(String)requestBodyParamsMap.get('CompanyName') != null ? (String)requestBodyParamsMap.get('CompanyName') : null;
        panOfBusiness 					=	(String)requestBodyParamsMap.get('PANOfBusiness') != null ? (String)requestBodyParamsMap.get('PANOfBusiness') : null;
        vatNumber	 					=	(String)requestBodyParamsMap.get('VATNumber') != null ? (String)requestBodyParamsMap.get('VATNumber') : null;
        cstNumber	 					=	(String)requestBodyParamsMap.get('CSTNumber') != null ? (String)requestBodyParamsMap.get('CSTNumber') : null;
        
        subLoanType						=	(String)requestBodyParamsMap.get('SubLoanType') != null ? (String)requestBodyParamsMap.get('SubLoanType') : null; 
        employmentID					=	(String)requestBodyParamsMap.get('EmploymentID') != null ? (String)requestBodyParamsMap.get('EmploymentID') : null; 
        employerName					=	(String)requestBodyParamsMap.get('EmployerName') != null ? (String)requestBodyParamsMap.get('EmployerName') : null; 
        totalExperience					=	(String)requestBodyParamsMap.get('TotalExperience') != null ? (String)requestBodyParamsMap.get('TotalExperience') : null; 
        primaryMarketPlace				=	(String)requestBodyParamsMap.get('PrimaryMarketplace') != null ? (String)requestBodyParamsMap.get('PrimaryMarketplace') : null; 
        primaryMarketPlaceMerchantID	=	(String)requestBodyParamsMap.get('PrimaryMarketplaceMerchantID') != null ? (String)requestBodyParamsMap.get('PrimaryMarketplaceMerchantID') : null;
        permanentAddress				=	(String)requestBodyParamsMap.get('PermanentAddress') != null ? (String)requestBodyParamsMap.get('PermanentAddress') : null; 
		permanentAddressCity			=	(String)requestBodyParamsMap.get('PermanentAddressCity') != null ? (String)requestBodyParamsMap.get('PermanentAddressCity') : null; 
        permanentAddressState			=	(String)requestBodyParamsMap.get('PermanentAddressState') != null ? (String)requestBodyParamsMap.get('PermanentAddressState') : null; 
        permanentAddressPincode			=	(String)requestBodyParamsMap.get('PermanentAddressPinCode') != null ? (String)requestBodyParamsMap.get('PermanentAddressPinCode') : null;
        doYouLiveIn						=	(String)requestBodyParamsMap.get('DoYouLiveIn') != null ? (String)requestBodyParamsMap.get('DoYouLiveIn') : null;
        
        //Mandatory and business validations.
        if(String.isEmpty(typeOfLoan)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.TYPE_OF_LOAN_BLANK);
            return res;
        }
        if(String.isEmpty(emailID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.EMAIL_ID_BLANK);
            return res;
        }
        if(String.isEmpty(mobileNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.MOBILE_NUMBER_BLANK);
            return res;
        }
        if(userID == null){
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
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(firstName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.FIRST_NAME_BLANK);
            return res;
        }
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(lastName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.LAST_NAME_BLANK);
            return res;
        }
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(panNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PAN_NUMBER_BLANK);
            return res;
        }
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && 
           			(!String.isEmpty(voterID) && String.isEmpty(voterIDState))){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.VOTER_ID_STATE_BLANK);
            return res;
        }
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && 
           			(!String.isEmpty(drivingLicenseNumber) && String.isEmpty(drivingLicenseState))){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DRIVING_LICENSE_STATE_BLANK);
            return res;
        }
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.BUSINESS_LOAN) && String.isEmpty(companyName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.COMPANY_NAME_BLANK);
            return res;
        }
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.BUSINESS_LOAN) && String.isEmpty(panOfBusiness)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PAN_OF_BUSINESS_BLANK);
            return res;
        }
         if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.BUSINESS_LOAN) && String.isEmpty(vatNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.VAT_NUMBER_BLANK);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(subLoanType)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.SUB_LOAN_TYPE_MANDATORY);
            return res;
        }
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(permanentAddress)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PERMANENT_ADDRESS_IS_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(permanentAddressCity)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PERMANENT_ADDRESS_CITY_IS_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(permanentAddressState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PERMANENT_ADDRESS_STATE_IS_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(permanentAddressPincode)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PERMANENT_ADDRESS_PINCODE_IS_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && 
        				subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED) && String.isEmpty(employmentID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.EMPLOYMENT_ID_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && 
        				subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED) && String.isEmpty(employerName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.EMPLOYER_NAME_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && 
        				subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED) && String.isEmpty(totalExperience)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.TOTAL_WORK_EXPERIENCE_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && 
        				subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_MARKETPLACE_LINKED) && String.isEmpty(primaryMarketPlace)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PRIMARY_MARKETPLACE_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && 
        				subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_MARKETPLACE_LINKED) && String.isEmpty(primaryMarketPlaceMerchantID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PRIMARY_MERCHANT_ID_MANDATORY);
            return res;
        }if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN) && String.isEmpty(doYouLiveIn)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DO_YOU_LIVE_IN_MANDATORY);
            return res;
        }
        /*The save point denatoes the state of the data base currently in the flow. No Account or contact records are created. If
          the acccount record is inserted successfully and an issue arises with the insertion of the contact object then we use the
          rollback command in the catch block to rollback to this save point and thus rolling back whatever account related data
          that was inserted.*/
        Savepoint sp = Database.setSavepoint();
        
        Integer propectNumberCount	 =  Database.countQuery('SELECT Count() FROM Account WHERE Prospect_Number__c =: prospectID');
       		if(propectNumberCount > 0){
       			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PROSPECT_ID_ALREADY_PRESENT);
            	return res;
       		}
        
        Integer userIDCount		  = Database.countQuery('SELECT Count() FROM Account WHERE User_ID__c =: userID AND Prospect_Number__c =: prospectID');
        if(userIDCount > 0 ){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.CANNOT_CREATE_CIF_FOR_USER_ID);
            return res;
        }
        
         //Fetch the current instance from the URL
         String host 		= 	System.URL.getSalesforceBaseURL().getHost();
         String instance;
         if(host != null){
         		instance    =   host.substringbefore('.');
         }	
        try{
        /*Inserting data into Account object*/
        if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.BUSINESS_LOAN)){
            Account accountDetailsForACompany = new Account(Name = companyName, Email_ID__c = EmailID, Phone = mobileNumber,
                                                           Type_of_Loan__c = typeOfLoan,Created_Online__c = WebServiceConstants.TRUE_VALUE,
                                                           Company_Permanent_Account_Number_PAN__c = panOfBusiness,
                                                           VAT_Number__c = vatNumber, CST_Number__c = cstNumber,
                                                           User_ID__c = userID, Prospect_Number__c = prospectID,
                                                           Business_Premise_s__c=WebServiceConstants.BUSINESS_PREMISES_DEFAULT_VALUE,
                                                           Warehouse_Premise_s__c=WebServiceConstants.WAREHOUSE_PREMISES_DEFAULT_VALUE,
                                                           Legal_Entity_Type__c=WebServiceConstants.ENTITY_TYPE_DEFAULT_VALUE,
                                                           Account_Status__c = WebServiceConstants.ACCOUNT_STATUS_ACTIVE);
            accountDetailsForACompany.Status_of_the_Account__c 		= 	WebServiceConstants.CIF_ID_CREATED;
            accountDetailsForACompany.Current_Instance_from_URL__c	=	instance;
            insert accountDetailsForACompany;
	                                    
            /*Once the record is created, we retrieve the Unique CIF ID that is linked to the account */
            List<Account> accountList = [SELECT 			Unique_CIF_ID__c 
                                         FROM   			Account 
                                         WHERE 				Id =: accountDetailsForACompany.Id 
                                         LIMIT 1];
            if(accountList != null && accountList.size() != 0){
             res.responseDetails.put(WebServiceConstants.CIFID,accountList[0].Unique_CIF_ID__c); 
             res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
             res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.CIF_ID_CREATED);
            }else{
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.CIF_ID_NOT_CREATED);
            }
             
        } else if(typeOfLoan.equalsIgnoreCase(WebServiceConstants.PERSONAL_LOAN)){
            Account accountDetailsForAnIndividual = new Account(Name = firstName+ ' ' +middleName+ ' '+lastName , 
                                                                Email_ID__c = EmailID, Phone = mobileNumber,
                                                                Type_of_Loan__c = typeOfLoan,Created_Online__c = WebServiceConstants.TRUE_VALUE,
                                                                User_ID__c = userID, Prospect_Number__c = prospectID,
                                                                Account_Status__c = WebServiceConstants.ACCOUNT_STATUS_ACTIVE);
            accountDetailsForAnIndividual.Status_of_the_Account__c 		= 	WebServiceConstants.CIF_ID_CREATED;
            accountDetailsForAnIndividual.Current_Instance_from_URL__c	=	instance;
            insert accountDetailsForAnIndividual;
            
            /*Once the record is created, we retrieve the Unique CIF ID that is linked to the account */
            List<Account> accountList = [SELECT 		Unique_CIF_ID__c 
                                         FROM   		Account 
                                         WHERE 			Id =: accountDetailsForAnIndividual.Id 
                                         LIMIT 1];
            
            Contact contactDetailsForAnIndividual = new Contact(FirstName = firstName, Middle_Name__c = middleName, 
                                                                LastName = lastName, Email = emailID,
                                                                MobilePhone = mobileNumber,
                                                                AccountId = accountDetailsForAnIndividual.Id,
                                                                Authorized_Signatory__c = WebServiceConstants.YES,
                                                                Permanent_Account_Number_PAN__c = panNumber,
                                                                AADHAAR_Number__c = aadhaarNumber,
                                                                Voter_ID__c = voterID, Voter_ID_State__c = voterIDState,
                                                                Passport_Number__c = passportNumber,
                                                                Driving_License_Number__c = drivingLicenseNumber,
                                                                Driving_License_State__c = drivingLicenseState,Permanent_Address__c = permanentAddress,
                                                                Permanent_Address_City__c = permanentAddressCity,Permanent_Address_State__c = permanentAddressState,
                                                                Permanent_Address_Pin_code__c = permanentAddressPincode,
                                                                Registered_in_market_place_or_employer__c = subLoanType,
                                                                Employer_Name__c=employerName,Total_Experience__c=totalExperience,Employment_ID__c=employmentID,
                                                                Primary_Marketplace__c=primaryMarketPlace,Primary_Marketplace_Merchant_ID__c=primaryMarketPlaceMerchantID,
                                                                Do_you_live_in__c=doYouLiveIn);
            insert contactDetailsForAnIndividual;
                       
            if(contactDetailsForAnIndividual != null && accountList != null && accountList.size() != 0){
             	res.responseDetails.put(WebServiceConstants.CIFID,accountList[0].Unique_CIF_ID__c); 
             	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
             	res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.CIF_ID_CREATED);
            }else{
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.CIF_ID_NOT_CREATED);
            }
        }
        }catch(DmlException dmle){
        	Database.rollback(sp);
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_CIF_CREATION);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
        }
        return res;
    }
}