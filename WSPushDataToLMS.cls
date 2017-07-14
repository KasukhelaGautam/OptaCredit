/*****************************************************************************************************************************
Name of the Class : WSPushDataToLMS
Created By : Gautam Kasukhela
Created Date : 23rd February, 2016
Description of the class : Webservice that stores the details sent from the frontend in respective objects (Account, Contact,
Application). This web service is invoked on click of 'Push to LMS'  button on the frontend.

*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/PushDataToLMS')
global class WSPushDataToLMS {
    
	@HttpPost
	global static Response saveData(){
        RestRequest restReq 	 = 	RestContext.request;
        RestResponse restRes 	 = 	RestContext.response;
        Response res 		 	 = 	new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        Long	    userID;
        String 		accountId;
        String 		contactId;
        String		typeOfLoan;
        String		prospectNumber;
        String		cifID;
        /*Personal Details */
		String 		firstName;
        String 		middleName;
        String		lastName;
        String 		gender;
        String		dob;
        Date 		dateOfBirth;
        String 		emailID;
        String 		mobileNumber;
               
        Double		loanAmount;
        Integer		loanTenure;
        String		panNumber;
        Long		aadhaarNumber;
        String		voterID;
        String		voterIDState;
        //String 		voterIDDistrict;
        String		passportNumber;
        String		drivingLicenseNumber;
        String		drivingLicenseState;
        String		presentAddress;
        String		presentAddressCity;
        String 		presentAddressState;
        String		presentAddressPincode;
        String 		permanentAddress;
        String		permanentAddressCity;
        String 		permanentAddressState;
        String		permanentAddressPincode;
        
        /*Additional Details*/
        String 		subLoanType;
        String		alternateContactNumber;
        String		employmentID;
        String		employerName;
        String		officialEmailID;
        String		totalExperience;
        String		primaryMarketPlace;
        String		primaryMarketPlaceMerchantID;
        String		secondMarketplace;
        String		secondMarketplaceMerchantID;
        String		thirdMarketplace;
        String		thirdMarketplaceMerchantID;
        String 		marketplaceExperience;
        String 		secondMarketplaceExperience;
        String 		thirdMarketplaceExperience;
        Boolean		existingDebt;
        Boolean		cashCreditOrOverdraft;
        String		gmailID;
        String		facebookProfileURL;
        String 		twitterProfileURL;
        String		linkedInProfileURL;
        String		doYouLiveIn;
        String		bankAccountNumber;
        String		bankName;
        String		bankIFSCCode;
        String		bankAccountType;
        
        /*Reference details*/
        String 		reference1FullName;
        String		reference1EmailID;
        String		reference1Address;
        String		reference1City;
        String		reference1State;
        String		reference1Pincode;
        String		reference1MobileNumber;
        String 		reference2FullName;
        String		reference2EmailID;
        String		reference2Address;
        String		reference2City;
        String		reference2State;
        String		reference2Pincode;
        String		reference2MobileNumber;
        String		source;
        String 		sourceSubCategory;
        String		others;
        
        String 		companyName;
        String		entityType;
        String		doi;
        Date		dateOfIncorporation;
        String		panOfBusiness;
        String		vatNumber;
        String		cstNumber;
        String		registeredOfficeAddress;
        String		registeredOfficeAddressCity;
        String		registeredOfficeAddressState;
        Integer		registeredOfficeAddressPinCode;
        String		warehousePremises;
        String 		businessPremises;
        String		directorOrPromoter;
        String		dinNumber;
        String		dpinNumber;
        String		residentialAddress;
        String		residentialAddressCity;
        String		residentialAddressState;
        String		residentialAddressPinCode;
        String		contactNumber;
        Boolean		termsAndConditions;
        String		otherMarketplace;
        String		otherMarketplaceMerchantID;
        String 		otherMarketplaceExperience;
        
        Id			scorecardForPersonalMPLoan;
        Id		    scorecardForPersonalEMPLoan;
        Id			scorecardForBusinessLoan; 
        
        Double		socialDetailsScore;
        String		emailOfAccount;
        Date		rejectedDate;
        String      accountStatus;
        String		ownershipPercent;
        
        //List and Map for Business loan
        List<Object> listOfDirectorsOrPartners = new List<Object>();
        Map<String, Object> directorOrPartnerDetails =  new Map<String, Object>();
        
   		Id	contactIdAuthorizedSignatory;
   		Boolean loanApplicationStatusNotClosed = false;
   		Boolean contractStatusNotClosed = false;
   		Integer numberOfPartnerOrDirectors;
        /*User ID is the primary field with which we will uniquely identify a record in the backend, If the User ID field is blank,
         return an error message.*/              
        userID 					=	(Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        prospectNumber			=	(String)requestBodyParamsMap.get('ProspectNumber') != null ? (String)requestBodyParamsMap.get('ProspectNumber') : null;
        cifID					=	(String)requestBodyParamsMap.get('CIFId') != null ? (String)requestBodyParamsMap.get('CIFId') : null;
        if(userID == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.USER_ID_BLANK_PUSH_TO_LMS);
            return res;
        }
        if(String.isEmpty(prospectNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PROSPECT_ID_BLANK);
            return res;
        }
        if(String.isEmpty(cifID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.CIF_ID_BLANK);
            return res;
        }
        List<Account> accountList = [SELECT 			Id, Type_of_Loan__c,Social_Details_Score__c,Email_ID__c,Account_Status__c 
                                     FROM 				Account
                                     WHERE 				User_ID__c =: userID 
                                     AND				Unique_CIF_ID__c	=: cifID
                                     LIMIT 1];
        if(accountList != null && accountList.size() != 0){
            accountId 			=	accountList[0].Id;
            typeOfLoan			=	accountList[0].Type_of_Loan__c;
            socialDetailsScore	=	accountList[0].Social_Details_Score__c;
            emailOfAccount		=	accountList[0].Email_ID__c;
            accountStatus		=	accountList[0].Account_Status__c;
            
           if(accountStatus.equals(WebServiceConstants.ACCOUNT_STATUS_REJECTED)){
           		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.DATA_PUSH_ACCOUNT_REJECTED);
                return res;
           } 
           if(String.isEmpty(typeOfLoan)){
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.TYPE_OF_LOAN_BLANK);
                return res;
          }
        }else{
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.NO_RECORDS_FOUND);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.NO_CIF_RECORDS_FOR_USER_ID);
            return res;
        }
        try{
       		Integer propectNumberCount	 =  Database.countQuery('SELECT Count() FROM genesis__Applications__c WHERE Prospect_Number__c =: prospectNumber');
       		if(propectNumberCount > 0){
       			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PROSPECT_ID_ALREADY_PRESENT);
            	return res;
       		}
        /*Check if the User ID has any loans which are not closed, if so, do not allow loan creation.*/
        List<genesis__Applications__c> genesisAppList = new List<genesis__Applications__c>();
        
        genesisAppList = [SELECT 	genesis__Status__c,Application_Rejection_Timestamp__c
                          FROM 		genesis__Applications__c
                          WHERE 	genesis__Account__r.User_ID__c =: userID AND genesis__Account__r.Unique_CIF_ID__c =: cifID
                          ORDER BY 	CreatedDate
                          DESC
                          LIMIT 1];
            if(genesisAppList != null && genesisAppList.size()!=0){
            		rejectedDate	= genesisAppList[0].Application_Rejection_Timestamp__c;
            	if(!genesisAppList[0].genesis__Status__c.equals(WebServiceConstants.LOAN_APPLICATION_CLOSED_STATUS)){
            		if(genesisAppList[0].genesis__Status__c.equals(WebServiceConstants.APPLICATION_REJECT_STATUS)){
            			if(rejectedDate != null && rejectedDate.daysBetween(Date.today()) < 30){
            					loanApplicationStatusNotClosed = true;	
            			}
            		}else{
            					loanApplicationStatusNotClosed = true;
            		}
            	}
            }             
          }catch(QueryException qe){
          	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_LOAN_STATUS);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
          }
         List<loan__Loan_Account__c> clContractList = new List<loan__Loan_Account__c>();
         try{
         	clContractList   =   [SELECT 		loan__Loan_Status__c
         	                      FROM	 		loan__Loan_Account__c
         	                      WHERE  		loan__Account__r.User_ID__c =: userID AND loan__Account__r.Unique_CIF_ID__c =: cifID
         	                      ORDER BY 		CreatedDate
         	                      DESC
         	                      LIMIT 1];
         	 if(clContractList != null && clContractList.size() != 0){
            	if(!clContractList[0].loan__Loan_Status__c.equals(WebServiceConstants.CL_CONTRACT_CLOSED_STATUS)){
            		contractStatusNotClosed = true;	
            	}
            }                           
         }catch(QueryException qe){
         	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_CONTRACT_STATUS);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
         }
        /*If the user has either an active loan application or a CL contract then another loan creation is not allowed*/
        if(loanApplicationStatusNotClosed || contractStatusNotClosed){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.NEW_LOAN_APP_CANNOT_BE_CREATED);
            return res;
        }
        
        /*Scorecard for a loan application will be associated which inturn will get associated with a Socrecard*/
        List<genesis__Scorecard__c>  scorecardList	=	new 	List<genesis__Scorecard__c>();
        try{
        		scorecardList	=	[SELECT			Id,Name
        							 FROM			genesis__Scorecard__c
        							 WHERE			Name IN ('Personal Employer Linked','Personal Marketplace Linked','Business')];
        		for(genesis__Scorecard__c  temp  :  scorecardList){
        			if(temp.Name == WebServiceConstants.SCORECARD_PERSONAL_MP_LOAN){
        				scorecardForPersonalMPLoan	=	temp.Id;
        			}else if(temp.Name == WebServiceConstants.SCORECARD_PERSONAL_EMP_LOAN){
        				scorecardForPersonalEMPLoan	=	temp.Id;	
        			}else if(temp.Name == WebServiceConstants.SCORECARD_BUSINESS_LOAN){
        				scorecardForBusinessLoan	=	temp.Id;
        			}
        		}					 
        }catch(QueryException qe){
        		res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
           		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.QUERY_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_SCORECARD);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
                return res;
        }
         /*If any one of the Scorecard setup is not present then an exception is raised.*/	
            if(scorecardForPersonalMPLoan == null || scorecardForPersonalEMPLoan == null || scorecardForBusinessLoan == null){
            	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.SCORECARD_SETUP_MISSING);
            	return res;
            }
        
          
        /*BEGIN PROCESSING OF DATA BEING SENT FROM FRONTEND, MANDATORY VALIDATIONS, BUSINESS VALIDATIONS*/
         List<Contact> contactList = new List<Contact>();        
        if(typeOfLoan.equals(WebServiceConstants.PERSONAL_LOAN)){
            contactList = [SELECT 			Id 
                           FROM 			Contact
                           WHERE 			AccountId =: accountId AND Authorized_Signatory__c =: WebServiceConstants.YES
                           LIMIT 1];
            if(contactList != null && contactList.size() != 0){
                contactId 	=	contactList[0].Id;
                if(String.isEmpty(contactId)){
                    res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                    res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
                    res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.CONTACT_ID_BLANK);
                    return res;
               }
            }else{
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.NO_RECORDS_FOUND);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.NO_CONTACT_RECORDS_FOR_USER_ID);
                return res;
             }
        /*Parse the input values and validate the madatory fields and business validations : START*/
        firstName 						=  	(String)requestBodyParamsMap.get('FirstName') != null ? (String)requestBodyParamsMap.get('FirstName') : null;
        middleName 						=  	(String)requestBodyParamsMap.get('MiddleName') != null ? (String)requestBodyParamsMap.get('MiddleName') : null;
        lastName 						= 	(String)requestBodyParamsMap.get('LastName') != null ? (String)requestBodyParamsMap.get('LastName') : null;
        gender		 					=	(String)requestBodyParamsMap.get('Gender') != null ? (String)requestBodyParamsMap.get('Gender') : null;    
        dob		 						=	(String)requestBodyParamsMap.get('DateOfBirth') != null ? (String)requestBodyParamsMap.get('DateOfBirth') : null;
        emailID							= 	(String)requestBodyParamsMap.get('EmailID') != null ? (String)requestBodyParamsMap.get('EmailID') : null;
        mobileNumber 					=	(String)requestBodyParamsMap.get('MobileNumber') != null ? (String)requestBodyParamsMap.get('MobileNumber') : null;
        loanAmount 						=	(Integer)requestBodyParamsMap.get('LoanAmount') != null	 ? (Integer)requestBodyParamsMap.get('LoanAmount') : null;
        loanTenure						=	(Integer)requestBodyParamsMap.get('LoanTenure') != null	 ? (Integer)requestBodyParamsMap.get('LoanTenure') : null;    
        panNumber						=	(String)requestBodyParamsMap.get('PANNumber') != null ? (String)requestBodyParamsMap.get('PANNumber') : null;
        aadhaarNumber					=	(Long)requestBodyParamsMap.get('AADHAARNumber') != null ? (Long)requestBodyParamsMap.get('AADHAARNumber') : null;
        voterID							=	(String)requestBodyParamsMap.get('VoterID') != null ? (String)requestBodyParamsMap.get('VoterID') : null; 
        voterIDState					=	(String)requestBodyParamsMap.get('VoterIDState') != null ? (String)requestBodyParamsMap.get('VoterIDState') : null; 
        //voterIDDistrict					=	(String)requestBodyParamsMap.get('VoterIDDistrict') != null ? (String)requestBodyParamsMap.get('VoterIDDistrict') : null; 
        passportNumber					=	(String)requestBodyParamsMap.get('PassportNumber') != null ? (String)requestBodyParamsMap.get('PassportNumber') : null; 
        drivingLicenseNumber			=	(String)requestBodyParamsMap.get('DrivingLicenseNumber') != null ? (String)requestBodyParamsMap.get('DrivingLicenseNumber') : null; 
        drivingLicenseState				=	(String)requestBodyParamsMap.get('DrivingLicenseState') != null ? (String)requestBodyParamsMap.get('DrivingLicenseState') : null; 
        permanentAddress				=	(String)requestBodyParamsMap.get('PermanentAddress') != null ? (String)requestBodyParamsMap.get('PermanentAddress') : null; 
		permanentAddressCity			=	(String)requestBodyParamsMap.get('PermanentAddressCity') != null ? (String)requestBodyParamsMap.get('PermanentAddressCity') : null; 
        permanentAddressState			=	(String)requestBodyParamsMap.get('PermanentAddressState') != null ? (String)requestBodyParamsMap.get('PermanentAddressState') : null; 
        permanentAddressPincode			=	(String)requestBodyParamsMap.get('PermanentAddressPinCode') != null ? (String)requestBodyParamsMap.get('PermanentAddressPinCode') : null; 
        presentAddress					=	(String)requestBodyParamsMap.get('PresentAddress') != null ? (String)requestBodyParamsMap.get('PresentAddress') : null; 
        presentAddressCity				=	(String)requestBodyParamsMap.get('PresentAddressCity') != null ? (String)requestBodyParamsMap.get('PresentAddressCity') : null;  
        presentAddressState				=	(String)requestBodyParamsMap.get('PresentAddressState') != null ? (String)requestBodyParamsMap.get('PresentAddressState') : null; 
        presentAddressPincode			=	(String)requestBodyParamsMap.get('PresentAddressPinCode') != null ? (String)requestBodyParamsMap.get('PresentAddressPinCode') : null; 
        subLoanType						=	(String)requestBodyParamsMap.get('SubLoanType') != null ? (String)requestBodyParamsMap.get('SubLoanType') : null; 
        alternateContactNumber			=	(String)requestBodyParamsMap.get('AlternateContactNumber') != null ? (String)requestBodyParamsMap.get('AlternateContactNumber') : null; 
        employmentID					=	(String)requestBodyParamsMap.get('EmploymentID') != null ? (String)requestBodyParamsMap.get('EmploymentID') : null; 
        employerName					=	(String)requestBodyParamsMap.get('EmployerName') != null ? (String)requestBodyParamsMap.get('EmployerName') : null; 
        officialEmailID					=	(String)requestBodyParamsMap.get('OfficialEmailID') != null ? (String)requestBodyParamsMap.get('OfficialEmailID') : null; 
        totalExperience					=	(String)requestBodyParamsMap.get('TotalExperience') != null ? (String)requestBodyParamsMap.get('TotalExperience') : null; 
        primaryMarketPlace				=	(String)requestBodyParamsMap.get('PrimaryMarketplace') != null ? (String)requestBodyParamsMap.get('PrimaryMarketplace') : null; 
        primaryMarketPlaceMerchantID	=	(String)requestBodyParamsMap.get('PrimaryMarketplaceMerchantID') != null ? (String)requestBodyParamsMap.get('PrimaryMarketplaceMerchantID') : null;
        marketplaceExperience			=	(String)requestBodyParamsMap.get('MarketplaceExperience') != null ? (String)requestBodyParamsMap.get('MarketplaceExperience') : null; 
        secondMarketplace				=	(String)requestBodyParamsMap.get('SecondMarketplace') != null ? (String)requestBodyParamsMap.get('SecondMarketplace') : null; 
        secondMarketplaceMerchantID		=	(String)requestBodyParamsMap.get('SecondMarketplaceMerchantID') != null ? (String)requestBodyParamsMap.get('SecondMarketplaceMerchantID') : null;
        secondMarketplaceExperience		=	(String)requestBodyParamsMap.get('SecondMarketplaceExperience') != null ? (String)requestBodyParamsMap.get('SecondMarketplaceExperience') : null; 
        thirdMarketplace				=	(String)requestBodyParamsMap.get('ThirdMarketplace') != null ? (String)requestBodyParamsMap.get('ThirdMarketplace') : null; 
        thirdMarketplaceMerchantID		=	(String)requestBodyParamsMap.get('ThirdMarketplaceMerchantID') != null ? (String)requestBodyParamsMap.get('ThirdMarketplaceMerchantID') : null; 
        thirdMarketplaceExperience		=	(String)requestBodyParamsMap.get('ThirdMarketplaceExperience') != null ? (String)requestBodyParamsMap.get('ThirdMarketplaceExperience') : null;
        existingDebt					=	(Boolean)requestBodyParamsMap.get('ExistingDebt') != null ? (Boolean)requestBodyParamsMap.get('ExistingDebt') : null; 
        cashCreditOrOverdraft			=	(Boolean)requestBodyParamsMap.get('CashCreditOrOverdraft') != null ? (Boolean)requestBodyParamsMap.get('CashCreditOrOverdraft') : null;     
        gmailID							=	(String)requestBodyParamsMap.get('GmailID') != null ? (String)requestBodyParamsMap.get('GmailID') : null; 
        facebookProfileURL				=	(String)requestBodyParamsMap.get('FacebookProfileURL') != null ? (String)requestBodyParamsMap.get('FacebookProfileURL') : null; 
        twitterProfileURL				=	(String)requestBodyParamsMap.get('TwitterProfileURL') != null ? (String)requestBodyParamsMap.get('TwitterProfileURL') : null; 
        linkedInProfileURL				=	(String)requestBodyParamsMap.get('LinkedInProfileURL') != null ? (String)requestBodyParamsMap.get('LinkedInProfileURL') : null; 
        doYouLiveIn						=	(String)requestBodyParamsMap.get('DoYouLiveIn') != null ? (String)requestBodyParamsMap.get('DoYouLiveIn') : null; 
        bankAccountNumber				=	(String)requestBodyParamsMap.get('BankAccountNumber') != null ? (String)requestBodyParamsMap.get('BankAccountNumber') : null; 
        bankName						=	(String)requestBodyParamsMap.get('BankName') != null ? (String)requestBodyParamsMap.get('BankName') : null;     
        bankIFSCCode					=	(String)requestBodyParamsMap.get('BankIFSCCode') != null ? (String)requestBodyParamsMap.get('BankIFSCCode') : null; 
        bankAccountType					=	(String)requestBodyParamsMap.get('BankAccountType') != null ? (String)requestBodyParamsMap.get('BankAccountType') : null;
        reference1FullName				=	(String)requestBodyParamsMap.get('Reference1FullName') != null ? (String)requestBodyParamsMap.get('Reference1FullName') : null; 
        reference1EmailID				=	(String)requestBodyParamsMap.get('Reference1EmailID') != null ? (String)requestBodyParamsMap.get('Reference1EmailID') : null; 
        reference1Address				=	(String)requestBodyParamsMap.get('Reference1Address') != null ? (String)requestBodyParamsMap.get('Reference1Address') : null; 
        reference1City					=	(String)requestBodyParamsMap.get('Reference1City') != null ? (String)requestBodyParamsMap.get('Reference1City') : null;
        System.debug('reference1City '+reference1City);
        reference1State					=	(String)requestBodyParamsMap.get('Reference1State') != null ? (String)requestBodyParamsMap.get('Reference1State') : null;
        System.debug('reference1State '+reference1State);
        reference1Pincode				=	(String)requestBodyParamsMap.get('Reference1Pincode') != null ? (String)requestBodyParamsMap.get('Reference1Pincode') : null;
        System.debug('reference1Pincode '+reference1Pincode);
        reference1MobileNumber			=	(String)requestBodyParamsMap.get('Reference1MobileNumber') != null ? (String)requestBodyParamsMap.get('Reference1MobileNumber') : null; 
        reference2FullName				=	(String)requestBodyParamsMap.get('Reference2FullName') != null ? (String)requestBodyParamsMap.get('Reference2FullName') : null; 
        reference2EmailID				=	(String)requestBodyParamsMap.get('Reference2EmailID') != null ? (String)requestBodyParamsMap.get('Reference2EmailID') : null; 
        reference2Address				=	(String)requestBodyParamsMap.get('Reference2Address') != null ? (String)requestBodyParamsMap.get('Reference2Address') : null;
        reference2City					=	(String)requestBodyParamsMap.get('Reference2City') != null ? (String)requestBodyParamsMap.get('Reference2City') : null;
        reference2State					=	(String)requestBodyParamsMap.get('Reference2State') != null ? (String)requestBodyParamsMap.get('Reference2State') : null;
        reference2Pincode				=	(String)requestBodyParamsMap.get('Reference2Pincode') != null ? (String)requestBodyParamsMap.get('Reference2Pincode') : null; 
        reference2MobileNumber			=	(String)requestBodyParamsMap.get('Reference2MobileNumber') != null ? (String)requestBodyParamsMap.get('Reference2MobileNumber') : null; 
        source							=	(String)requestBodyParamsMap.get('Source') != null ? (String)requestBodyParamsMap.get('Source') : null; 
        sourceSubCategory				=	(String)requestBodyParamsMap.get('SourceSubCategory') != null ? (String)requestBodyParamsMap.get('SourceSubCategory') : null; 
        others							=	(String)requestBodyParamsMap.get('Others') != null ? (String)requestBodyParamsMap.get('Others') : null; 
            
          if(String.isEmpty(firstName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.FIRST_NAME_BLANK);
            return res;
        }if(String.isEmpty(lastName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LAST_NAME_BLANK);
            return res;
        }if(String.isEmpty(gender)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.GENDER_IS_MANDATORY);
            return res;
        }if(String.isEmpty(dob)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.DATE_OF_BIRTH_IS_MANDATORY);
            return res;
        }if(String.isEmpty(emailID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.EMAIL_ID_BLANK);
            return res;
        }if(String.isEmpty(mobileNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.MOBILE_NUMBER_BLANK);
            return res;
        }if(loanAmount == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_AMOUNT_IS_MANDATORY);
            return res;
        }if(loanAmount < 50000 || loanAmount > 500000){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_AMOUNT_RANGE_PL);
            return res;
        }if(loanTenure == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_TENURE_IS_MANDATORY);
            return res;
        }if(loanTenure < 1 || loanTenure > 12){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_TENURE_RANGE_PL);
            return res;
        }if(String.isEmpty(panNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PAN_IS_MANDATORY);
            return res;
        }if(String.isEmpty(presentAddress)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PRESENT_ADDRESS_IS_MANDATORY);
            return res;
        }if(String.isEmpty(presentAddressCity)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PRESENT_ADDRESS_CITY_IS_MANDATORY);
            return res;
        }if(String.isEmpty(presentAddressState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PRESENT_ADDRESS_STATE_IS_MANDATORY);
            return res;
        }if(String.isEmpty(presentAddressPincode)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PRESENT_ADDRESS_PINCODE_IS_MANDATORY);
            return res;
        }if(String.isEmpty(subLoanType)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.SUB_LOAN_TYPE_MANDATORY);
            return res;
        }if(!String.isEmpty(voterID) && String.isEmpty(voterIDState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.VOTER_ID_STATE_BLANK);
            return res;
        }if(!String.isEmpty(drivingLicenseNumber) && String.isEmpty(drivingLicenseState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DRIVING_LICENSE_STATE_BLANK);
            return res;
        }if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED) && String.isEmpty(employmentID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.EMPLOYMENT_ID_MANDATORY);
            return res;
        }if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED) && String.isEmpty(employerName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.EMPLOYER_NAME_MANDATORY);
            return res;
        }if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED) && String.isEmpty(totalExperience)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.TOTAL_WORK_EXPERIENCE_MANDATORY);
            return res;
        }if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_MARKETPLACE_LINKED) && String.isEmpty(primaryMarketPlace)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PRIMARY_MARKETPLACE_MANDATORY);
            return res;
        }if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_MARKETPLACE_LINKED) && String.isEmpty(primaryMarketPlaceMerchantID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PRIMARY_MERCHANT_ID_MANDATORY);
            return res;
        }if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_MARKETPLACE_LINKED) && String.isEmpty(marketplaceExperience)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.MARKETPLACE_EXPERIENCE_MANDATORY);
            return res;
        }if(!String.isEmpty(secondMarketplace) || !String.isEmpty(secondMarketplaceMerchantID) || !String.isEmpty(secondMarketplaceExperience)){
        		if(String.isEmpty(secondMarketplace) || String.isEmpty(secondMarketplaceMerchantID) || String.isEmpty(secondMarketplaceExperience)){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
		            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ALL_SECOND_MARKETPLACE_DETAILS_NOT_ENTERED);
		            return res;		
        		}
        }if(!String.isEmpty(thirdMarketplace) || !String.isEmpty(thirdMarketplaceMerchantID) || !String.isEmpty(thirdMarketplaceExperience)){
        		if(String.isEmpty(thirdMarketplace) || String.isEmpty(thirdMarketplaceMerchantID) || String.isEmpty(thirdMarketplaceExperience)){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
		            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ALL_THIRD_MARKETPLACE_DETAILS_NOT_ENTERED);
		            return res;		
        		}
        }if(existingDebt == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.LIABILITY_DETAILS_DEBT_MANDATORY);
            return res;
        }if(String.isEmpty(doYouLiveIn)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DO_YOU_LIVE_IN_MANDATORY);
            return res;
        }if(String.isEmpty(bankAccountNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_ACCOUNT_NUMBER_MANDATORY);
            return res;
        }if(String.isEmpty(bankName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_NAME_MANDATORY);
            return res;
        }if(String.isEmpty(bankIFSCCode)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_IFSC_CODE_MANDATORY);
            return res;
        }if(String.isEmpty(bankAccountType)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_ACCOUNT_TYPE_MANDATORY);
            return res;
        }if((source != null) && !(source.equals('Search Engine') || source.equals('Social Network')) && String.isEmpty(others)){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.OTHERS_MANDATORY);
            return res;
        }		
        
        
        /*In case there are any exceptions raised while upserting data into multiple objects, then all the previous upserts will be
          rolled back to this savepoint.*/
        Savepoint spForPersonalLoanFlow = Database.setSavepoint();
            //Upserting data into the Account object
            Account accountDetailsPersonalLoan = new Account();
           try{
                 accountDetailsPersonalLoan = new Account(Name = firstName+ ' ' +middleName+ ' '+lastName,
                                                          Email_ID__c = emailID, Phone = mobileNumber,
                                                          cnotify__Email__c = emailID);
                 accountDetailsPersonalLoan.Id		=	 accountId;
                 upsert  accountDetailsPersonalLoan;
           }catch(DmlException dmle){
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_ACC_DATA_TO_LMS_PL);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
				return res;
           }
            dateOfBirth = Date.parse(dob);
            Contact  contactDetailsPersonalLoan = new contact();
            //Upserting data into the contact object
            try{
            		
                        contactDetailsPersonalLoan = new Contact(FirstName = firstName,Middle_Name__c = middleName,
                                                                 LastName = lastName,Gender__c = gender,Email = emailID,
                                                                 Phone = mobileNumber,Permanent_Account_Number_PAN__c = panNumber,
                                                                 AADHAAR_Number__c = aadhaarNumber,Voter_ID__c = voterID,
                                                                 Voter_ID_State__c = voterIDState,MobilePhone = mobileNumber,
                                                                 Passport_Number__c = passportNumber, Driving_License_Number__c= drivingLicenseNumber,
                                                                 Driving_License_State__c = drivingLicenseState,Permanent_Address__c = permanentAddress,
                                                                 Permanent_Address_City__c = permanentAddressCity,Permanent_Address_State__c = permanentAddressState,
                                                                 Permanent_Address_Pin_code__c = permanentAddressPincode,Present_Address__c = presentAddress,
                                                                 Present_Address_City__c = presentAddressCity,Present_Address_State__c = presentAddressState,
                                                                 Present_Address_Pin_code__c = presentAddressPincode,Registered_in_market_place_or_employer__c = subLoanType,
                                                                 Alternate_contact_number__c=alternateContactNumber,Employment_ID__c=employmentID,
                                                                 Employer_Name__c=employerName,Official_Email_ID__c=officialEmailID,Total_Experience__c=totalExperience,
                                                                 Primary_Marketplace__c=primaryMarketPlace,Primary_Marketplace_Merchant_ID__c=primaryMarketPlaceMerchantID,
                                                                 Second_Marketplace__c=secondMarketplace,Second_Marketplace_Merchant_ID__c=secondMarketplaceMerchantID,
                                                                 Third_Marketplace__c=thirdMarketplace,Third_Marketplace_Merchant_ID__c=thirdMarketplaceMerchantID,
                                                                 Marketplace_Experience__c=marketplaceExperience,Second_Marketplace_Experience__c=secondMarketplaceExperience,
                                                                 Third_Marketplace_Experience__c=thirdMarketplaceExperience,Do_you_have_any_existing_Debt__c=existingDebt,
                                                                 Any_cash_credit_or_overdraft_account__c=cashCreditOrOverdraft,Gmail_ID__c=gmailID,
                                                                 Facebook_Profile_URL__c=facebookProfileURL,Twitter_Profile_URL__c=twitterProfileURL,
                                                                 LinkedIn_Profile_URL__c=linkedInProfileURL,Do_you_live_in__c=doYouLiveIn,
                                                                 Full_name_of_reference_1__c = reference1FullName,Address_of_reference_1__c=reference1Address,
                                                                 City_of_Reference_1__c=reference1City,State_of_reference_1__c=reference1State,
                                                                 Pincode_of_reference_1__c=reference1Pincode,
                                                                 Email_ID_of_reference_1__c=reference1EmailID,Mobile_number_of_reference_1__c=reference1MobileNumber,
                                                                 Full_name_of_reference_2__c = reference2FullName,Address_of_reference_2__c=reference2Address,
                                                                 City_of_Reference_2__c=reference2City,State_of_reference_2__c=reference2State,
                                                                 Pincode_of_reference_2__c=reference2Pincode,
                                                                 Email_ID_of_reference_2__c=reference2EmailID,Mobile_number_of_reference_2__c=reference2MobileNumber,
                                                                 Source__c = source,Source_sub_category__c=sourceSubCategory,If_others_Please_mention__c=others,
                                                                 BirthDate=dateOfBirth);
                                    contactDetailsPersonalLoan.Id	=   contactId;  
                					contactDetailsPersonalLoan.AccountId = accountId;
                				    contactDetailsPersonalLoan.Authorized_Signatory__c= WebServiceConstants.YES;
                					upsert contactDetailsPersonalLoan;
                					System.debug('MY VALUES '+contactDetailsPersonalLoan);
            }catch(DmlException dmle){
            	Database.rollback(spForPersonalLoanFlow);
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_CON_DATA_TO_LMS_PL);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
                return res;
            }
            loan__Bank_Account__c bankAccountDetailsPersonalLoan 			= 	new loan__Bank_Account__c();
            try{
                /*Bank details saved in the Loan Bank Account object*/    
            bankAccountDetailsPersonalLoan.loan__Account__c					=	accountId;
            bankAccountDetailsPersonalLoan.loan__Bank_Name__c				=	bankName;
            bankAccountDetailsPersonalLoan.loan__Bank_Account_Number__c 	= 	bankAccountNumber;
            bankAccountDetailsPersonalLoan.Bank_IFSC_Code__c				=	bankIFSCCode;
            bankAccountDetailsPersonalLoan.loan__Account_Type__c			=	bankAccountType;
            bankAccountDetailsPersonalLoan.loan__Active__c					=	true;
            upsert bankAccountDetailsPersonalLoan;
                
            }catch(DmlException dmle){
            	Database.rollback(spForPersonalLoanFlow);
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_BANK_DATA_TO_LMS_PL);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
                return res;
            }
            //Application details
            genesis__Applications__c applicationDetailsForPersonalLoan = new genesis__Applications__c();
            List<genesis__Applications__c> app = new List<genesis__Applications__c>();
            String applicationID;
            try{
            applicationDetailsForPersonalLoan.genesis__Account__c				=		accountId;
            applicationDetailsForPersonalLoan.genesis__Contact__c				=		contactId;
            applicationDetailsForPersonalLoan.genesis__Loan_Amount__c			=		loanAmount;
            applicationDetailsForPersonalLoan.genesis__Interest_Rate__c			=		WebServiceConstants.DEFAULT_INTEREST_RATE_PERSONAL_LOAN;
            applicationDetailsForPersonalLoan.genesis__Term__c					=		loanTenure;
            applicationDetailsForPersonalLoan.genesis__Status__c				=		WebServiceConstants.NEWLY_ENTERED_APPLICATION;
            applicationDetailsForPersonalLoan.BankAccount__c 					= 		bankAccountDetailsPersonalLoan.Id;
			applicationDetailsForPersonalLoan.Prospect_Number__c				=		prospectNumber;
			applicationDetailsForPersonalLoan.Email_ID__c						=		emailOfAccount;
			if(socialDetailsScore != null){
				applicationDetailsForPersonalLoan.Social_Details_Score__c		=		socialDetailsScore;
			}
            upsert applicationDetailsForPersonalLoan;
            
            /*Retrieve the loan application name to be sent to the frontend.*/
            app = [SELECT 		Name 
                   FROM 		genesis__Applications__c
                   WHERE 		Id =: applicationDetailsForPersonalLoan.Id
                   LIMIT 1];
              if(app != null && app.size() != 0){     
             		applicationID = app[0].Name;   
              }
            }catch(DmlException dmle){
            	Database.rollback(spForPersonalLoanFlow);
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_APP_DATA_TO_LMS_PL);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
                return res;
            }
            
            genesis__Application_Scorecard__c		scorecardJunction	=	new 	genesis__Application_Scorecard__c();
            try{
            scorecardJunction.genesis__Application__c					=	applicationDetailsForPersonalLoan.Id;
            if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED)){
				scorecardJunction.genesis__Scorecard__c		=		scorecardForPersonalEMPLoan;
			}else if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_MARKETPLACE_LINKED)){
				scorecardJunction.genesis__Scorecard__c		=		scorecardForPersonalMPLoan;
			}
            upsert scorecardJunction;
            }catch(DmlException dmle){
				Database.rollback(spForPersonalLoanFlow);
                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_SCORECARD_JUNCTION);
                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
                return res;	            	
            }
           if(accountDetailsPersonalLoan != null && contactDetailsPersonalLoan != null &&
              bankAccountDetailsPersonalLoan != null && applicationDetailsForPersonalLoan != null){
             	  res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
                  res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.DATA_PUSHED_TO_LMS);
                  res.responseDetails.put(WebServiceConstants.APPLICATION_ID,applicationID);
                  return res;  
              }
        }else if(typeOfLoan.equals(WebServiceConstants.BUSINESS_LOAN)){
            companyName						=  	(String)requestBodyParamsMap.get('CompanyName') != null ? (String)requestBodyParamsMap.get('CompanyName') : null;
            entityType 						=  	(String)requestBodyParamsMap.get('EntityType') != null ? (String)requestBodyParamsMap.get('EntityType') : null;
            emailID 						=  	(String)requestBodyParamsMap.get('EmailID') != null ? (String)requestBodyParamsMap.get('EmailID') : null;
            mobileNumber					=  	(String)requestBodyParamsMap.get('MobileNumber') != null ? (String)requestBodyParamsMap.get('MobileNumber') : null;
            doi								=  	(String)requestBodyParamsMap.get('DateOfIncorporation') != null ? (String)requestBodyParamsMap.get('DateOfIncorporation') : null;
            panOfBusiness 					=  	(String)requestBodyParamsMap.get('PANOfBusiness') != null ? (String)requestBodyParamsMap.get('PANOfBusiness') : null;
            vatNumber 						=  	(String)requestBodyParamsMap.get('VATNumber') != null ? (String)requestBodyParamsMap.get('VATNumber') : null;
            cstNumber 						=  	(String)requestBodyParamsMap.get('CSTNumber') != null ? (String)requestBodyParamsMap.get('CSTNumber') : null;
            loanAmount 						=  	(Double)requestBodyParamsMap.get('LoanAmount') != null ? (Double)requestBodyParamsMap.get('LoanAmount') : null;
            loanTenure 						=  	(Integer)requestBodyParamsMap.get('LoanTenure') != null ? (Integer)requestBodyParamsMap.get('LoanTenure') : null;
            cashCreditOrOverdraft			=  	(Boolean)requestBodyParamsMap.get('CashCreditOrOverdraftAccount') != null ? (Boolean)requestBodyParamsMap.get('CashCreditOrOverdraftAccount') : null;
            registeredOfficeAddress			=  	(String)requestBodyParamsMap.get('RegisteredOfficeAddress') != null ? (String)requestBodyParamsMap.get('RegisteredOfficeAddress') : null;
            registeredOfficeAddressCity		=  	(String)requestBodyParamsMap.get('RegisteredOfficeAddressCity') != null ? (String)requestBodyParamsMap.get('RegisteredOfficeAddressCity') : null;
            registeredOfficeAddressState	=  	(String)requestBodyParamsMap.get('RegisteredOfficeAddressState') != null ? (String)requestBodyParamsMap.get('RegisteredOfficeAddressState') : null;
            registeredOfficeAddressPinCode	=  	(Integer)requestBodyParamsMap.get('RegisteredOfficeAddressPinCode') != null ? (Integer)requestBodyParamsMap.get('RegisteredOfficeAddressPinCode') : null;
            alternateContactNumber			=  	(String)requestBodyParamsMap.get('AlternateContactNumber') != null ? (String)requestBodyParamsMap.get('AlternateContactNumber') : null;
            warehousePremises				=  	(String)requestBodyParamsMap.get('WarehousePremises') != null ? (String)requestBodyParamsMap.get('WarehousePremises') : null;
            businessPremises				=  	(String)requestBodyParamsMap.get('BusinessPremises') != null ? (String)requestBodyParamsMap.get('BusinessPremises') : null;
         if(String.isEmpty(emailID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.EMAIL_ID_BLANK);
            return res;
        }if(String.isEmpty(mobileNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.MOBILE_NUMBER_BLANK);
            return res;
        }if(String.isEmpty(companyName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.COMPANY_NAME_MANDATORY);
            return res;
        }if(String.isEmpty(entityType)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.ENTITY_TYPE_MANDATORY);
            return res;
        }if(String.isEmpty(doi)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.DATE_OF_INCORPORATION_MANDATORY);
            return res;
        }if(String.isEmpty(panOfBusiness)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PAN_OF_BUSINESS_BLANK);
            return res;
        }if(String.isEmpty(vatNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.VAT_NUMBER_BLANK);
            return res;
        }if(String.isEmpty(registeredOfficeAddress)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.REGISTERED_OFFICE_ADDRESS_MANDATORY);
            return res;
        }if(String.isEmpty(registeredOfficeAddressCity)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.REGISTERED_OFFICE_ADDRESS_STATE_MANDATORY);
            return res;
        }if(String.isEmpty(registeredOfficeAddressState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.REGISTERED_OFFICE_ADDRESS_CITY_MANDATORY);
            return res;
        }if(registeredOfficeAddressPinCode == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.REGISTERED_OFFICE_ADDRESS_PINCODE_MANDATORY);
            return res;
        }if(cashCreditOrOverdraft == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.CASH_CREDIT_OVERDRAFT_MANDATORY);
            return res;
        }if(loanAmount == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_AMOUNT_IS_MANDATORY);
            return res;
        }if(loanAmount < 200000 || loanAmount > 5000000){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_AMOUNT_RANGE_BL);
            return res;
        }if(loanTenure == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_TENURE_IS_MANDATORY);
            return res;
        }if(loanTenure < 1 || loanTenure > 12){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LOAN_TENURE_RANGE_BL);
            return res;
        }if(String.isEmpty(warehousePremises)){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.WAREHOUSE_PREMISES_IS_MANDATORY);
            return res;
        }if(String.isEmpty(businessPremises)){
        	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.BUSINESS_PREMISES_IS_MANDATORY);
            return res;
        }
            //Fields for Sole propreitor
           if(entityType.equals(WebServiceConstants.ENTITY_TYPE_SOLE)){
            firstName						=	(String)requestBodyParamsMap.get('FirstName') != null ? (String)requestBodyParamsMap.get('FirstName') : null;
            middleName						=	(String)requestBodyParamsMap.get('MiddleName') != null ? (String)requestBodyParamsMap.get('MiddleName') : null;
            lastName						=	(String)requestBodyParamsMap.get('LastName') != null ? (String)requestBodyParamsMap.get('LastName') : null;
            gender		 					=	(String)requestBodyParamsMap.get('Gender') != null ? (String)requestBodyParamsMap.get('Gender') : null;
            panNumber						=	(String)requestBodyParamsMap.get('PANNumber') != null ? (String)requestBodyParamsMap.get('PANNumber') : null;
            aadhaarNumber					=	(Long)requestBodyParamsMap.get('AADHAARNumber') != null ? (Long)requestBodyParamsMap.get('AADHAARNumber') : null;
            voterID							=	(String)requestBodyParamsMap.get('VoterID') != null ? (String)requestBodyParamsMap.get('VoterID') : null;
            voterIDState					=	(String)requestBodyParamsMap.get('VoterIDState') != null ? (String)requestBodyParamsMap.get('VoterIDState') : null;
            passportNumber					=	(String)requestBodyParamsMap.get('PassportNumber') != null ? (String)requestBodyParamsMap.get('PassportNumber') : null;
            drivingLicenseNumber			=	(String)requestBodyParamsMap.get('DrivingLicenseNumber') != null ? (String)requestBodyParamsMap.get('DrivingLicenseNumber') : null;
            drivingLicenseState				=	(String)requestBodyParamsMap.get('DrivingLicenseState') != null ? (String)requestBodyParamsMap.get('DrivingLicenseState') : null;
            dob		 						=	(String)requestBodyParamsMap.get('DateOfBirth') != null ? (String)requestBodyParamsMap.get('DateOfBirth') : null;
            residentialAddress				=	(String)requestBodyParamsMap.get('ResidentialAddress') != null ? (String)requestBodyParamsMap.get('ResidentialAddress') : null;
            residentialAddressCity			=	(String)requestBodyParamsMap.get('ResidentialAddressCity') != null ? (String)requestBodyParamsMap.get('ResidentialAddressCity') : null;
            residentialAddressState			=	(String)requestBodyParamsMap.get('ResidentialAddressState') != null ? (String)requestBodyParamsMap.get('ResidentialAddressState') : null;
            residentialAddressPinCode		=	(String)requestBodyParamsMap.get('ResidentialAddressPinCode') != null ? (String)requestBodyParamsMap.get('ResidentialAddressPinCode') : null;
            contactNumber					=	(String)requestBodyParamsMap.get('ContactNumber') != null ? (String)requestBodyParamsMap.get('ContactNumber') : null;
            alternateContactNumber			=	(String)requestBodyParamsMap.get('AlternateContactNumber') != null ? (String)requestBodyParamsMap.get('AlternateContactNumber') : null;
            
         if(String.isEmpty(firstName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.FIRST_NAME_BLANK);
            return res;
        }if(String.isEmpty(lastName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LAST_NAME_BLANK);
            return res;
        }if(String.isEmpty(gender)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.GENDER_IS_MANDATORY);
            return res;
        }if(String.isEmpty(dob)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.DATE_OF_BIRTH_BLANK);
            return res;
        }if(String.isEmpty(panNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PAN_IS_MANDATORY);
            return res;
        }if(!String.isEmpty(voterID) && String.isEmpty(voterIDState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.VOTER_ID_STATE_BLANK);
            return res;
        }if(!String.isEmpty(drivingLicenseNumber) && String.isEmpty(drivingLicenseState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DRIVING_LICENSE_STATE_BLANK);
            return res;
        } 
           }           
            //Fields for Partner or Director 
            else{
            	listOfDirectorsOrPartners  = (List<Object>)requestBodyParamsMap.get('DirectorsOrPartners');
            	numberOfPartnerOrDirectors = listOfDirectorsOrPartners.size();
            if(listOfDirectorsOrPartners.size() == 0){
            	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PARTNER_DETAILS_REQUIRED);
                return res;
            }else if(listOfDirectorsOrPartners.size() > 2){
            	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.BUSINESS_VALIDATION_FAILURE);
                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PARTNER_DETAILS_EXCEED_LIMIT);
                return res;
            }
            for(Object temp:listOfDirectorsOrPartners){
            	directorOrPartnerDetails 		= 	(Map<String, Object>)temp;
            	firstName						=	(String)directorOrPartnerDetails.get('FirstName_PD') != null ? (String)directorOrPartnerDetails.get('FirstName_PD') : null;
	            middleName						=	(String)directorOrPartnerDetails.get('MiddleName_PD') != null ? (String)directorOrPartnerDetails.get('MiddleName_PD') : null;
	            lastName						=	(String)directorOrPartnerDetails.get('LastName_PD') != null ? (String)directorOrPartnerDetails.get('LastName_PD') : null;
	            gender							=	(String)directorOrPartnerDetails.get('Gender_PD') != null ? (String)directorOrPartnerDetails.get('Gender_PD') : null;
	            directorOrPromoter				=	(String)directorOrPartnerDetails.get('DirectorOrPromoter_PD') != null ? (String)directorOrPartnerDetails.get('DirectorOrPromoter_PD') : null;
	            dob								=	(String)directorOrPartnerDetails.get('DateOfBirth_PD') != null ? (String)directorOrPartnerDetails.get('DateOfBirth_PD') : null;
	            panNumber						=	(String)directorOrPartnerDetails.get('PANNumber_PD') != null ? (String)directorOrPartnerDetails.get('PANNumber_PD') : null;
	            aadhaarNumber					=	(Long)directorOrPartnerDetails.get('AADHAARNumber_PD') != null ? (Long)directorOrPartnerDetails.get('AADHAARNumber_PD') : null;
	            voterID							=	(String)directorOrPartnerDetails.get('VoterID_PD') != null ? (String)directorOrPartnerDetails.get('VoterID_PD') : null;
	            voterIDState					=	(String)directorOrPartnerDetails.get('VoterIDState_PD') != null ? (String)directorOrPartnerDetails.get('VoterIDState_PD') : null;
	            passportNumber					=	(String)directorOrPartnerDetails.get('PassportNumber_PD') != null ? (String)directorOrPartnerDetails.get('PassportNumber_PD') : null;
	            drivingLicenseNumber			=	(String)directorOrPartnerDetails.get('DrivingLicenseNumber_PD') != null ? (String)directorOrPartnerDetails.get('DrivingLicenseNumber_PD') : null;
                drivingLicenseState				=	(String)directorOrPartnerDetails.get('DrivingLicenseState_PD') != null ? (String)directorOrPartnerDetails.get('DrivingLicenseState_PD') : null;
	            dinNumber						=	(String)directorOrPartnerDetails.get('DINNumber_PD') != null ? (String)directorOrPartnerDetails.get('DINNumber_PD') : null;
	            dpinNumber						=	(String)directorOrPartnerDetails.get('DPINNumber_PD') != null ? (String)directorOrPartnerDetails.get('DPINNumber_PD') : null;
	            residentialAddress				=	(String)directorOrPartnerDetails.get('ResidentialAddress_PD') != null ? (String)directorOrPartnerDetails.get('ResidentialAddress_PD') : null;
	            residentialAddressCity			=	(String)directorOrPartnerDetails.get('ResidentialAddressCity_PD') != null ? (String)directorOrPartnerDetails.get('ResidentialAddressCity_PD') : null;
	            residentialAddressState			=	(String)directorOrPartnerDetails.get('ResidentialAddressState_PD') != null ? (String)directorOrPartnerDetails.get('ResidentialAddressState_PD') : null;
	            residentialAddressPinCode		=	(String)directorOrPartnerDetails.get('ResidentialAddressPinCode_PD') != null ? (String)directorOrPartnerDetails.get('ResidentialAddressPinCode_PD') : null;
	            contactNumber					=	(String)directorOrPartnerDetails.get('ContactNumber_PD') != null ? (String)directorOrPartnerDetails.get('ContactNumber_PD') : null;
	            alternateContactNumber			=	(String)directorOrPartnerDetails.get('AlternateContactNumber_PD') != null ? (String)directorOrPartnerDetails.get('AlternateContactNumber_PD') : null;
	            termsAndConditions				=	(Boolean)directorOrPartnerDetails.get('TermsAndConditions_PD') != null ? (Boolean)directorOrPartnerDetails.get('TermsAndConditions_PD') : null;
	            ownershipPercent				=	(String)directorOrPartnerDetails.get('OwnershipPercent_PD') != null ? (String)directorOrPartnerDetails.get('OwnershipPercent_PD') : null;
	            
	     if(String.isEmpty(firstName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.FIRST_NAME_BLANK);
            return res;
        }if(String.isEmpty(lastName)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.LAST_NAME_BLANK);
            return res;
        }if(String.isEmpty(gender)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.GENDER_IS_MANDATORY);
            return res;
        }if(String.isEmpty(dob)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.DATE_OF_BIRTH_BLANK);
            return res;
        }if(String.isEmpty(panNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.PAN_IS_MANDATORY);
            return res;
        }if(!String.isEmpty(voterID) && String.isEmpty(voterIDState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.VOTER_ID_STATE_BLANK);
            return res;
        }if(!String.isEmpty(drivingLicenseNumber) && String.isEmpty(drivingLicenseState)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DRIVING_LICENSE_STATE_BLANK);
            return res;
        }if((entityType == WebServiceConstants.ENTITY_TYPE_PUBLIC || entityType == WebServiceConstants.ENTITY_TYPE_PRIVATE)
           			&& String.isEmpty(dinNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.DIN_NUMBER_MANDATORY);
            return res;
        }if((entityType == WebServiceConstants.ENTITY_TYPE_LLP)
           			&& String.isEmpty(dpinNumber)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE,WebServiceConstants.DPIN_NUMBER_MANDATORY);
            return res;
        }
          }
            }
            bankAccountNumber				=	(String)requestBodyParamsMap.get('BankAccountNumber') != null ? (String)requestBodyParamsMap.get('BankAccountNumber') : null; 
	        bankName						=	(String)requestBodyParamsMap.get('BankName') != null ? (String)requestBodyParamsMap.get('BankName') : null;     
    	    bankIFSCCode					=	(String)requestBodyParamsMap.get('BankIFSCCode') != null ? (String)requestBodyParamsMap.get('BankIFSCCode') : null;
    	    bankAccountType					=	(String)requestBodyParamsMap.get('BankAccountType') != null ? (String)requestBodyParamsMap.get('BankAccountType') : null;
    	     
            if(String.isEmpty(bankAccountNumber)){
	            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_ACCOUNT_NUMBER_MANDATORY);
	            return res;
        	}if(String.isEmpty(bankName)){
	            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_NAME_MANDATORY);
	            return res;
        	}if(String.isEmpty(bankIFSCCode)){
	            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
	            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_IFSC_CODE_MANDATORY);
	            return res;
        	}if(String.isEmpty(bankAccountType)){
            	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            	res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.BANK_ACCOUNT_TYPE_MANDATORY);
            	return res;
        }
            primaryMarketPlace				=	(String)requestBodyParamsMap.get('PrimaryMarketplace') != null ? (String)requestBodyParamsMap.get('PrimaryMarketplace') : null; 
	        primaryMarketPlaceMerchantID	=	(String)requestBodyParamsMap.get('PrimaryMarketplaceMerchantID') != null ? (String)requestBodyParamsMap.get('PrimaryMarketplaceMerchantID') : null;
	        marketplaceExperience			=	(String)requestBodyParamsMap.get('PrimaryMarketplaceExperience') != null ? (String)requestBodyParamsMap.get('PrimaryMarketplaceExperience') : null; 
    	    secondMarketplace				=	(String)requestBodyParamsMap.get('SecondMarketplace') != null ? (String)requestBodyParamsMap.get('SecondMarketplace') : null;
        	secondMarketplaceMerchantID		=	(String)requestBodyParamsMap.get('SecondMarketplaceMerchantID') != null ? (String)requestBodyParamsMap.get('SecondMarketplaceMerchantID') : null;
        	secondMarketplaceExperience		=	(String)requestBodyParamsMap.get('SecondMarketplaceExperience') != null ? (String)requestBodyParamsMap.get('SecondMarketplaceExperience') : null;
        	thirdMarketplace				=	(String)requestBodyParamsMap.get('ThirdMarketplace') != null ? (String)requestBodyParamsMap.get('ThirdMarketplace') : null; 
        	thirdMarketplaceMerchantID		=	(String)requestBodyParamsMap.get('ThirdMarketplaceMerchantID') != null ? (String)requestBodyParamsMap.get('ThirdMarketplaceMerchantID') : null;
        	thirdMarketplaceExperience		=	(String)requestBodyParamsMap.get('ThirdMarketplaceExperience') != null ? (String)requestBodyParamsMap.get('ThirdMarketplaceExperience') : null; 	
            otherMarketplace				=	(String)requestBodyParamsMap.get('OtherMarketPlace') != null ? (String)requestBodyParamsMap.get('OtherMarketPlace') : null;
            otherMarketplaceMerchantID		=	(String)requestBodyParamsMap.get('OtherMarketPlaceMerchantID') != null ? (String)requestBodyParamsMap.get('OtherMarketPlaceMerchantID') : null;
            otherMarketplaceExperience		=	(String)requestBodyParamsMap.get('OtherMarketplaceExperience') != null ? (String)requestBodyParamsMap.get('OtherMarketplaceExperience') : null;
            
            reference1FullName				=	(String)requestBodyParamsMap.get('Reference1FullName') != null ? (String)requestBodyParamsMap.get('Reference1FullName') : null; 
        	reference1EmailID				=	(String)requestBodyParamsMap.get('Reference1EmailID') != null ? (String)requestBodyParamsMap.get('Reference1EmailID') : null; 
        	reference1Address				=	(String)requestBodyParamsMap.get('Reference1Address') != null ? (String)requestBodyParamsMap.get('Reference1Address') : null;
        	reference1City					=	(String)requestBodyParamsMap.get('Reference1City') != null ? (String)requestBodyParamsMap.get('Reference1City') : null;
        	reference1State					=	(String)requestBodyParamsMap.get('Reference1State') != null ? (String)requestBodyParamsMap.get('Reference1State') : null;
        	reference1Pincode				=	(String)requestBodyParamsMap.get('Reference1Pincode') != null ? (String)requestBodyParamsMap.get('Reference1Pincode') : null;
        	reference1MobileNumber			=	(String)requestBodyParamsMap.get('Reference1MobileNumber') != null ? (String)requestBodyParamsMap.get('Reference1MobileNumber') : null; 
        	reference2FullName				=	(String)requestBodyParamsMap.get('Reference2FullName') != null ? (String)requestBodyParamsMap.get('Reference2FullName') : null; 
        	reference2EmailID				=	(String)requestBodyParamsMap.get('Reference2EmailID') != null ? (String)requestBodyParamsMap.get('Reference2EmailID') : null; 
        	reference2Address				=	(String)requestBodyParamsMap.get('Reference2Address') != null ? (String)requestBodyParamsMap.get('Reference2Address') : null;
        	reference2City					=	(String)requestBodyParamsMap.get('Reference2City') != null ? (String)requestBodyParamsMap.get('Reference2City') : null;
        	reference2State					=	(String)requestBodyParamsMap.get('Reference2State') != null ? (String)requestBodyParamsMap.get('Reference2State') : null;
			reference2Pincode				=	(String)requestBodyParamsMap.get('Reference2Pincode') != null ? (String)requestBodyParamsMap.get('Reference2Pincode') : null; 
        	reference2MobileNumber			=	(String)requestBodyParamsMap.get('Reference2MobileNumber') != null ? (String)requestBodyParamsMap.get('Reference2MobileNumber') : null; 
       	 	source							=	(String)requestBodyParamsMap.get('Source') != null ? (String)requestBodyParamsMap.get('Source') : null; 
        	sourceSubCategory				=	(String)requestBodyParamsMap.get('SourceSubCategory') != null ? (String)requestBodyParamsMap.get('SourceSubCategory') : null; 
        	others							=	(String)requestBodyParamsMap.get('Others') != null ? (String)requestBodyParamsMap.get('Others') : null;
            
            facebookProfileURL				=	(String)requestBodyParamsMap.get('FacebookProfileURL') != null ? (String)requestBodyParamsMap.get('FacebookProfileURL') : null; 
	        twitterProfileURL				=	(String)requestBodyParamsMap.get('TwitterProfileURL') != null ? (String)requestBodyParamsMap.get('TwitterProfileURL') : null; 
    	    linkedInProfileURL				=	(String)requestBodyParamsMap.get('LinkedInProfileURL') != null ? (String)requestBodyParamsMap.get('LinkedInProfileURL') : null; 
			
        if(String.isEmpty(primaryMarketPlace)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PRIMARY_MARKETPLACE_MANDATORY_BL);
            return res;
        }if(String.isEmpty(primaryMarketPlaceMerchantID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.MERCHANT_ID_1_MANDATORY);
            return res;
        }if(String.isEmpty(marketplaceExperience)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.MARKETPLACE_EXPERIENCE_MANDATORY);
            return res;
        }if(!String.isEmpty(secondMarketplace) || !String.isEmpty(secondMarketplaceMerchantID) || !String.isEmpty(secondMarketplaceExperience)){
        		if(String.isEmpty(secondMarketplace) || String.isEmpty(secondMarketplaceMerchantID) || String.isEmpty(secondMarketplaceExperience)){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
		            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ALL_SECOND_MARKETPLACE_DETAILS_NOT_ENTERED);
		            return res;		
        		}
        }if(!String.isEmpty(thirdMarketplace) || !String.isEmpty(thirdMarketplaceMerchantID) || !String.isEmpty(thirdMarketplaceExperience)){
        		if(String.isEmpty(thirdMarketplace) || String.isEmpty(thirdMarketplaceMerchantID) || String.isEmpty(thirdMarketplaceExperience)){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
		            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ALL_THIRD_MARKETPLACE_DETAILS_NOT_ENTERED);
		            return res;		
        		}
        }if(!String.isEmpty(otherMarketplace) || !String.isEmpty(otherMarketplaceMerchantID) || !String.isEmpty(otherMarketplaceExperience)){
        		if(String.isEmpty(otherMarketplace) || String.isEmpty(otherMarketplaceMerchantID) || String.isEmpty(otherMarketplaceExperience)){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
		            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
		            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ALL_OTHER_MARKETPLACE_DETAILS_NOT_ENTERED);
		            return res;		
        		}
        }
        if((source != null) && !(source.equals('Search Engine') || source.equals('Social Network')) && String.isEmpty(others)){
        			res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            		res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            		res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.OTHERS_MANDATORY);
            		return res;
        }		
        		/*In case there are any exceptions raised while upserting data into multiple objects, then all the previous upserts will be
          		 rolled back to this savepoint. This save point is for a business flow*/
        		Savepoint spForBusinessLoanFlow									=	 Database.setSavepoint();
        		
        	    Account accountDetailsForBusinessLoan 							=	 new Account();
                Contact contactDetailsForSoleProp 								= 	 new Contact();
                Contact contactDetailsForOtherEntityType 						=    new Contact();
                loan__Bank_Account__c bankAccountDetailsBusinessLoan 			= 	 new loan__Bank_Account__c();
                genesis__Applications__c applicationDetailsForBusinessLoan 		= 	 new genesis__Applications__c();
                List<genesis__Applications__c> app 								=    new List<genesis__Applications__c>();
                String applicationID;
                dateOfIncorporation = Date.parse(doi);
                try{
         			accountDetailsForBusinessLoan = new Account(Name = companyName, Email_ID__c = emailID, Phone = mobileNumber,
                                                               Legal_Entity_Type__c=entityType,Date_of_Inception__c=dateOfIncorporation,
                                                               Company_Permanent_Account_Number_PAN__c=panOfBusiness,
                                                               VAT_Number__c=vatNumber,CST_Number__c=cstNumber,
                                                               Have_CC_Overdraft_account__c=cashCreditOrOverdraft,
                                                               Company_Address__c=registeredOfficeAddress,
                                                               Company_City__c=registeredOfficeAddressCity,
                                                               Company_State__c=registeredOfficeAddressState,
                                                               Pin_code__c = registeredOfficeAddressPinCode,
                                                               Alternate_contact_number__c=alternateContactNumber,
                                                               Warehouse_Premise_s__c=warehousePremises,Business_Premise_s__c=businessPremises,
                                                               Primary_Marketplace__c=primaryMarketPlace,Merchant_ID_1__c=primaryMarketPlaceMerchantID,
                                                               Second_Marketplace__c=secondMarketplace,Merchant_ID_2__c=secondMarketplaceMerchantID,
                                                               Third_Marketplace__c=thirdMarketplace,Merchant_ID_3__c=thirdMarketplaceMerchantID,
                                                               Other_Marketplace__c=otherMarketplace,Merchant_ID_4__c=otherMarketplaceMerchantID,
                                                               Primary_Marketplace_Experience__c=marketplaceExperience,
                                                               Second_Marketplace_Experience__c=secondMarketplaceExperience,
                                                               Third_Marketplace_Experience__c=thirdMarketplaceExperience,
                                                               Other_Marketplace_Experience__c=otherMarketplaceExperience,
                                                               Facebook_Profile_URL__c=facebookProfileURL,Twitter_Profile_URL__c=twitterProfileURL,
                                                               LinkedIn_Profile_URL__c=linkedInProfileURL,cnotify__Email__c = emailID,
                                                               Full_name_of_reference_1__c = reference1FullName,Address_of_reference_1__c=reference1Address,
                                                               City_of_Reference_1__c=reference1City,State_of_reference_1__c=reference1State,
                                                               Pincode_of_reference_1__c=reference1Pincode,
                                                               Email_ID_of_reference_1__c=reference1EmailID,Mobile_number_of_reference_1__c=reference1MobileNumber,
                                                               Full_name_of_reference_2__c = reference2FullName,Address_of_reference_2__c=reference2Address,
                                                               City_of_Reference_2__c=reference2City,State_of_reference_2__c=reference2State,
                                                               Pincode_of_reference_2__c=reference2Pincode,
                                                               Email_ID_of_reference_2__c=reference2EmailID,Mobile_number_of_reference_2__c=reference2MobileNumber,
                                                               Source__c = source,Source_sub_category__c=sourceSubCategory,If_others_Please_mention__c=others,
                                                               Number_of_Directors_Partners_Members__c=String.valueOf(numberOfPartnerOrDirectors));       
                accountDetailsForBusinessLoan.Id =accountId;
                upsert accountDetailsForBusinessLoan;
                }catch(DmlException dmle){
                    res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
                    res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
                    res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_ACC_DATA_TO_LMS_BL);
                    res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
                    return res;
               }
                	if(entityType.equals(WebServiceConstants.ENTITY_TYPE_SOLE)){
                	 try{	
                	dateOfBirth = Date.parse(dob); 	
                    contactDetailsForSoleProp	= new Contact(FirstName=firstName,Middle_Name__c=middleName,LastName=lastName,
                    										  Gender__c = gender,
                                                              Authorized_Signatory__c = WebServiceConstants.YES,
                                                              Permanent_Account_Number_PAN__c=panNumber,
                                                              AADHAAR_Number__c=aadhaarNumber,Voter_ID__c= voterID,Voter_ID_State__c = voterIDState,
                                                              Passport_Number__c=passportNumber,
                                                              Driving_License_Number__c=drivingLicenseNumber,Driving_License_State__c = drivingLicenseState,
                                                              BirthDate=dateOfBirth,Alternate_contact_number__c=alternateContactNumber,
                                                              Present_Address__c=residentialAddress,Present_Address_City__c=residentialAddressCity,
                                                              Present_Address_State__c=residentialAddressState,
                                                              Present_Address_Pin_code__c=residentialAddressPinCode,MobilePhone=contactNumber,
                                                              Terms_Conditions__c=WebServiceConstants.TRUE_VALUE);
                    contactDetailsForSoleProp.AccountId = accountDetailsForBusinessLoan.Id;
                    upsert contactDetailsForSoleProp;
                    }catch(DmlException dmle){
	                    res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	                    res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
	                    res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_CON_DATA_TO_LMS_BL);
	                    res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
	                    return res;
                	  }
                	}else{
                		for(Object temp:listOfDirectorsOrPartners){
            				directorOrPartnerDetails = (Map<String, Object>)temp;
            				Boolean isAuthorizedSignatory = false;	
            				try{
            				dob = (String)directorOrPartnerDetails.get('DateOfBirth_PD');
            				contactDetailsForOtherEntityType = new Contact(FirstName=(String)directorOrPartnerDetails.get('FirstName_PD'),
            															   Middle_Name__c=(String)directorOrPartnerDetails.get('MiddleName_PD'),  
            															   LastName=(String)directorOrPartnerDetails.get('LastName_PD'),
            															   Gender__c=(String)directorOrPartnerDetails.get('Gender_PD'),
            															   Director_or_Promoter__c=(String)directorOrPartnerDetails.get('DirectorOrPromoter_PD'),
            															   Permanent_Account_Number_PAN__c=(String)directorOrPartnerDetails.get('PANNumber_PD'),
            															   AADHAAR_Number__c=(Long)directorOrPartnerDetails.get('AADHAARNumber_PD'),
            															   Voter_ID__c=(String)directorOrPartnerDetails.get('VoterID_PD'),
            															   Voter_ID_State__c = (String)directorOrPartnerDetails.get('VoterIDState_PD'),
            															   Passport_Number__c=(String)directorOrPartnerDetails.get('PassportNumber_PD'),
            															   Driving_License_Number__c=(String)directorOrPartnerDetails.get('DrivingLicenseNumber_PD'),
            															   Driving_License_State__c = (String)directorOrPartnerDetails.get('DrivingLicenseState_PD'),
            															   Present_Address__c=(String)directorOrPartnerDetails.get('ResidentialAddress_PD'),
            															   Present_Address_City__c=(String)directorOrPartnerDetails.get('ResidentialAddressCity_PD'),
            															   Present_Address_State__c=(String)directorOrPartnerDetails.get('ResidentialAddressState_PD'),
            															   Present_Address_Pin_code__c=(String)directorOrPartnerDetails.get('ResidentialAddressPinCode_PD'),
            															   MobilePhone=(String)directorOrPartnerDetails.get('ContactNumber_PD'),
            															   Phone=(String)directorOrPartnerDetails.get('ContactNumber_PD'),
            															   Alternate_contact_number__c=(String)directorOrPartnerDetails.get('AlternateContactNumber_PD'),
            															   Terms_Conditions__c=(Boolean)directorOrPartnerDetails.get('TermsAndConditions_PD'),
            															   Ownership__c = (String)directorOrPartnerDetails.get('OwnershipPercent_PD'));
            															   
							contactDetailsForOtherEntityType.BirthDate = Date.parse(dob);
            			    if(entityType.equals(WebServiceConstants.ENTITY_TYPE_PUBLIC) || 
            			    			entityType.equals(WebServiceConstants.ENTITY_TYPE_PRIVATE)){
            			    				contactDetailsForOtherEntityType.DIN_Number__c = (String)directorOrPartnerDetails.get('DINNumber_PD');
            			    	}else if(entityType.equals(WebServiceConstants.ENTITY_TYPE_LLP)){
            			    		contactDetailsForOtherEntityType.DPIN_Number__c = (String)directorOrPartnerDetails.get('DPINNumber_PD');
            			    	}
            			     if((Boolean)directorOrPartnerDetails.get('TermsAndConditions_PD') == WebServiceConstants.TRUE_VALUE){
            			     		contactDetailsForOtherEntityType.Authorized_Signatory__c = WebServiceConstants.YES;
            			     		isAuthorizedSignatory = WebServiceConstants.TRUE_VALUE;
            			     }	
            			    contactDetailsForOtherEntityType.AccountId = accountId;
            			    upsert contactDetailsForOtherEntityType;
            			    //Check if the contact upserted is that of an authorized signatory, if yes then save the Id of the contact
            			    //to be used in the application object.
            			    if(isAuthorizedSignatory){
            			    	contactIdAuthorizedSignatory = contactDetailsForOtherEntityType.Id;
            			    }	
            				  }catch(DmlException dmle){
            				  	Database.rollback(spForBusinessLoanFlow);
            				  	res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
			                	res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
			               		res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_CON_DATA_TO_LMS_BL_OE);
			                	res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
			                	return res;
            				  }										   
                		}
                		
                	}
            //Bank Details and Application data inserted for both personal and business loans.
                	 try{
                			/*Bank details saved in the Loan Bank Account object*/    
				            bankAccountDetailsBusinessLoan.loan__Account__c					=	accountId;
				            bankAccountDetailsBusinessLoan.loan__Bank_Name__c				=	bankName;
				            bankAccountDetailsBusinessLoan.loan__Bank_Account_Number__c 	= 	bankAccountNumber;
				            bankAccountDetailsBusinessLoan.Bank_IFSC_Code__c				=	bankIFSCCode;
				            bankAccountDetailsBusinessLoan.loan__Account_Type__c			=	bankAccountType;
				            bankAccountDetailsBusinessLoan.loan__Active__c					=	true;
				            upsert bankAccountDetailsBusinessLoan;
                
            			}catch(DmlException dmle){
            				Database.rollback(spForBusinessLoanFlow);
			                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
			                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
			                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_BANK_DATA_TO_LMS_BL);
			                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
			                return res;
            			}
                	 // Genesis Application details for a Sole propreitor in case of a Business Loan. 
                	 	Id contactIdOfBusinessLoan;
                	 	if(entityType.equals(WebServiceConstants.ENTITY_TYPE_SOLE)){
                	 		contactIdOfBusinessLoan  = contactDetailsForSoleProp.Id;
                	 	}else{
                	 		contactIdOfBusinessLoan  = contactIdAuthorizedSignatory;
                	 	}
                	 	try{
                	 		applicationDetailsForBusinessLoan.genesis__Account__c				=		accountId;
            				applicationDetailsForBusinessLoan.genesis__Contact__c				=		contactIdOfBusinessLoan;
				            applicationDetailsForBusinessLoan.genesis__Loan_Amount__c			=		loanAmount;
				            applicationDetailsForBusinessLoan.genesis__Interest_Rate__c			=		WebServiceConstants.DEFAULT_INTEREST_RATE_BUSINESS_LOAN;
				            applicationDetailsForBusinessLoan.genesis__Term__c					=		loanTenure;
				            applicationDetailsForBusinessLoan.genesis__Status__c				=		WebServiceConstants.NEWLY_ENTERED_APPLICATION;
				            applicationDetailsForBusinessLoan.BankAccount__c 					= 		bankAccountDetailsBusinessLoan.Id;
				            applicationDetailsForBusinessLoan.Prospect_Number__c				=		prospectNumber;
				            applicationDetailsForBusinessLoan.Email_ID__c						=		emailOfAccount;
				            if(socialDetailsScore != null){
				            	applicationDetailsForBusinessLoan.Social_Details_Score__c		=		socialDetailsScore;
				            }
				            upsert applicationDetailsForBusinessLoan;
				            
            				/*Application Name is retrieved and will be set in the response.*/
				            app = [SELECT 		Name 
				                   FROM 		genesis__Applications__c
				                   WHERE 		Id =: applicationDetailsForBusinessLoan.Id
				                   LIMIT 1];
				            if(app != null && app.size() != 0){
				            	 applicationID = app[0].Name;   
				               }
			            }catch(DmlException dmle){
			            	Database.rollback(spForBusinessLoanFlow);
			                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
			                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
			                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_PUSH_APP_DATA_TO_LMS_BL);
			                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
			                return res;
			            }
			            genesis__Application_Scorecard__c		scorecardJunction	=	new 	genesis__Application_Scorecard__c();
            	try{
            		scorecardJunction.genesis__Application__c	=	applicationDetailsForBusinessLoan.Id;
					scorecardJunction.genesis__Scorecard__c		=	scorecardForBusinessLoan;
					upsert scorecardJunction;
            	  }catch(DmlException dmle){
					Database.rollback(spForBusinessLoanFlow);
	                res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
	                res.responseDetails.put(WebServiceConstants.ERRORCONSTANT,WebServiceConstants.DATABASE_OPERATION_FAILED);
	                res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.DATABASE_EXCEPTION_SCORECARD_JUNCTION);
	                res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, dmle.getMessage());
	                return res;	            	
              }
			          //Return the success response
			          if(accountDetailsForBusinessLoan != null  &&
              				bankAccountDetailsBusinessLoan != null && applicationDetailsForBusinessLoan != null){
			             	  res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);
			                  res.responseDetails.put(WebServiceConstants.SUCCESSMESSAGE,WebServiceConstants.DATA_PUSHED_TO_LMS);
			                  res.responseDetails.put(WebServiceConstants.APPLICATION_ID,applicationID);
                		}
     }
        return res;
  }
}