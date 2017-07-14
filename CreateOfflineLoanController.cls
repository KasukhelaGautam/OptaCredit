/***************************************************************************
Name : CreateOfflineLoanController
Created By : Akash Singh
Created Date : March 1, 2016
Description : Class used to create offline application i.e. the application which gets created 
              in the CL Originate without Portal/Front End Actions
***************************************************************************/

public class CreateOfflineLoanController
{
        public genesis__Applications__c loanApplication {get;set;}
        public loan__Bank_Account__c    bankAccount {set;get;} 
        public Account    loanAppAccount {set;get;}
        public Contact    loanAppContact {set;get;}
        public Contact    partnerOneContactDetails {set;get;}
        public Contact    partnerTwoContactDetails {set;get;}
        public Boolean    enablePartnerTab {set;get;}
        public String     partnerOneSectionHeading {set;get;}
        public String     partnerTwoSectionHeading {set;get;}        
        public Boolean    controlEmployerVisibility {set;get;}   
        public Boolean    controlMarketplaceVisibility {set;get;}
        public Attachment attachPANCard {set;get;}
        public Attachment attachAdhar {set;get;}
        public Attachment attachAdharPage {set;get;}
        public Attachment attachVoterIDTest {set;get;}
        public Attachment attachVoterIDTestPage {set;get;}
        public Attachment attachSalarySlip {set;get;}
        public Attachment attachSalarySlipPage {set;get;}
        public Attachment attachLastITR {set;get;}
        public Attachment attachLastITRPage {set;get;}
        public Attachment attachOthers {set;get;}
        public Attachment attachOthersPage {set;get;}
        public Attachment attachPANCorporate {set;get;}
        public Attachment attachPANCorporatePage {set;get;}
        public Attachment attachIncomeStatementCorporate {set;get;}
        public Attachment attachIncomeStatementCorporatePage {set;get;}
        public Attachment attachBalanceSheetCorporate {set;get;}     
        public Attachment attachBalanceSheetCorporatePage {set;get;}
        public Attachment attachInvoicesCorporate {set;get;}
        public Attachment attachInvoicesCorporatePage {set;get;}
        public Attachment attachPANIndividualCorporate {set;get;}
        public Attachment attachPANIndividualCorporatePage {set;get;}
        public Attachment attachAdhaarIndividualCorporate {set;get;}
        public Attachment attachAdhaarIndividualCorporatePage {set;get;}
        public Attachment attachOtherBusiness {set;get;}
        public Attachment attachOtherBusinessPage {set;get;}
        public Attachment attachPANCardPage {set;get;}
        public Attachment attachDrivingLicensePage {set;get;}
        public Attachment attachDrivingLicense {set;get;}
        public Attachment attachBankStmtPage {set;get;}
        public Attachment attachBankStmt {set;get;}
        public Attachment attachVATPage {set;get;}
        public Attachment attachVAT {set;get;}
        public Attachment attachPassportPage {set;get;}
        public Attachment attachPassport {set;get;}
        
    public CreateOfflineLoanController(ApexPages.StandardController controller) 
     {
            loanApplication = (genesis__Applications__c)controller.getRecord();
            genesis__Applications__c appTemp = new genesis__Applications__c();
            String accountId ;
            List<Contact> contactList;
            if(loanApplication == appTemp)
               {
                    loanAppContact                      =   new Contact();
                    loanAppAccount                      =   new Account ();
                    bankAccount                         =   new loan__Bank_Account__c();
                    attachPANCard                       =   new Attachment();
                    attachAdhar                         =   new Attachment();
                    attachVoterIDTest                   =   new Attachment();
                    attachSalarySlip                    =   new Attachment();
                    attachLastITR                       =   new Attachment();
                    attachOthers                        =   new Attachment();
                    attachPANCorporate                  =   new Attachment();
                    attachIncomeStatementCorporate      =   new Attachment();
                    attachBalanceSheetCorporate         =   new Attachment();
                    attachInvoicesCorporate             =   new Attachment();
                    attachPANIndividualCorporate        =   new Attachment();
                    attachAdhaarIndividualCorporate     =   new Attachment();
                    attachOtherBusiness                 =   new Attachment();
                    attachPANCardPage                   =   new Attachment();
                    attachAdharPage                     =   new Attachment();
                    attachVoterIDTestPage               =   new Attachment();
                    attachSalarySlipPage                =   new Attachment();
                    attachLastITRPage                   =   new Attachment();
                    attachOthersPage                    =   new Attachment();
                    attachPANCorporatePage              =   new Attachment();
                    attachIncomeStatementCorporatePage  =   new Attachment();
                    attachBalanceSheetCorporatePage     =   new Attachment();
                    attachInvoicesCorporatePage         =   new Attachment();
                    attachPANIndividualCorporatePage    =   new Attachment();
                    attachAdhaarIndividualCorporatePage =   new Attachment();
                    attachOtherBusinessPage             =   new Attachment();
                    partnerOneContactDetails            =   new Contact(); 
                    partnerTwoContactDetails            =   new Contact();
                    
                   if(String.isEmpty(loanAppAccount.Legal_Entity_Type__c) && (loanAppAccount.Type_of_Loan__c != 'Personal'))
                   {
                          loanAppAccount.Legal_Entity_Type__c = 'Sole Proprietorship';
                   }
               }     
               else
               {
                 try
                  {
                      loanApplication = [SELECT genesis__Term__c,genesis__Loan_Amount__c ,genesis__Contact__c,genesis__Account__c, genesis__Account__r.Name,
                                                genesis__Account__r.cnotify__Email__c
                                         FROM   genesis__Applications__c 
                                         WHERE  id=:loanApplication.Id
                                         LIMIT 1];
                                         
                    accountId         = loanApplication.genesis__Account__c;
                    
                    loanAppAccount    = [SELECT Id,Name,Legal_Entity_Type__c,Number_of_Directors_Partners_Members__c,
                                                Date_of_Inception__c,Company_Permanent_Account_Number_PAN__c,
                                                VAT_Number__c,CST_Number__c,Have_CC_Overdraft_account__c,
                                                Company_Address__c,Company_City__c,Pin_code__c,Phone,
                                                Alternate_contact_number__c,Email_ID__c,Business_Premise_s__c,
                                                Warehouse_Premise_s__c,Type_of_Loan__c,Primary_Marketplace__c,
                                                Merchant_ID_1__c,Second_Marketplace__c,Merchant_ID_2__c,Third_Marketplace__c,
                                                Merchant_ID_3__c,Other_Marketplace__c,Merchant_ID_4__c,Facebook_Profile_URL__c,
                                                Twitter_Profile_URL__c,LinkedIn_Profile_URL__c 
                                        FROM    Account 
                                        WHERE   id =:accountId 
                                        LIMIT 1];  
                
                  }
                catch(Exception e)
                {
                    Apexpages.addMessages(e);
                }
                if(loanAppAccount != NULL)
                {
                    if(loanAppAccount.Type_of_Loan__c == 'Personal')
                    {
                        String contactId  = loanApplication.genesis__Contact__c;
                        try
                        {              
                            
                        loanAppContact = [SELECT Id,FirstName,Middle_Name__c,LastName,Gender__c,Birthdate,
                                                 Email,MobilePhone,Permanent_Account_Number_PAN__c,
                                                 AADHAAR_Number__c,Voter_ID__c,Voter_ID_State__c,Voter_ID_District__c,
                                                 Passport_Number__c,Driving_License_State__c,Driving_License_Number__c,
                                                 Permanent_Address__c,Permanent_Address_City__c,Permanent_Address_State__c,
                                                 Permanent_Address_Pin_code__c,Present_Address__c,Present_Address_City__c,
                                                 Present_Address_State__c,Present_Address_Pin_code__c,
                                                 Registered_in_market_place_or_employer__c,Alternate_contact_number__c,
                                                 Employer_Name__c,Official_Email_ID__c,Total_Experience__c,Employment_ID__c,
                                                 Primary_Marketplace__c,Primary_Marketplace_Merchant_ID__c,
                                                 Second_Marketplace__c,Second_Marketplace_Merchant_ID__c,Third_Marketplace__c,
                                                 Third_Marketplace_Merchant_ID__c,Marketplace_Experience__c,
                                                 Do_you_have_any_existing_Debt__c,Any_cash_credit_or_overdraft_account__c,
                                                 Gmail_ID__c,Facebook_Profile_URL__c,Twitter_Profile_URL__c,LinkedIn_Profile_URL__c,
                                                 Do_you_live_in__c,Owned__c,Full_name_of_reference_1__c,Email_ID_of_reference_1__c,
                                                 Address_of_reference_1__c,Mobile_number_of_reference_1__c,Full_name_of_reference_2__c,
                                                 Email_ID_of_reference_2__c,Address_of_reference_2__c,Mobile_number_of_reference_2__c,
                                                 Source__c,Source_sub_category__c,If_others_Please_mention__c 
                                          FROM   Contact
                                          WHERE  id =:contactId
                                          LIMIT  1];
                                          }
                        catch(Exception e)
                        {
                            Apexpages.addMessages(e);
                        }
                                          
                                          
                        
                    }
                    else if(loanAppAccount.Type_of_Loan__c == 'Business')
                    {
                        try
                        {
                            contactList = [SELECT  Id,FirstName, Middle_Name__c, LastName,City__c,Director_or_Promoter__c,
                                                   Permanent_Account_Number_PAN__c, AADHAAR_Number__c, Voter_ID__c,
                                                   Passport_Number__c, Driving_License_Number__c, DIN_Number__c,
                                                   DPIN_Number__c, Birthdate, Present_Address__c, Present_Address_City__c,
                                                   Present_Address_Pin_code__c, Pin_code__c , MobilePhone,
                                                   Alternate_contact_number__c,Voter_ID_State__c,
                                                   Terms_Conditions__c,Driving_License_State__c 
                                            FROM   Contact 
                                            WHERE  AccountId =: accountId];
                        }
                        catch(Exception e)
                        {
                            Apexpages.addMessages(e);
                        }
                        
                        if(contactList != NULL && contactList.size()>0)
                        {
                            if(contactList.size() == 2)
                            {
                                partnerOneContactDetails = contactList.get(0);
                                partnerTwoContactDetails = contactList.get(1);              
                            }
                            else
                                partnerOneContactDetails = contactList.get(0);
                        }
                        
                    }
                        ApexPages.Message msg = new ApexPages.message(ApexPages.severity.Confirm,'Application Created Successfully');
                        Apexpages.addMessage(msg);
                   }
               }
     }
     
 
     /**
     *This method is used to create Offline Loan Application for Loan Type as Personal
     **/
    
    public PageReference createLoanApplicationPersonal()
    {
        Id          scorecardForPersonalMPLoan;
        Id          scorecardForPersonalEMPLoan;
        Id          scorecardForBusinessLoan; 
        String      subLoanType;
        String      prospectId;
        Integer     userID;
        String returnValue = checkProspectAvailability(loanAppAccount,loanAppContact,loanApplication,bankAccount);
        Savepoint spForPersonalApplicationFlow = Database.setSavepoint();
      
        try
        {
            upsert bankAccount;
            loanAppAccount.Email_ID__c       =  loanAppContact.Email;
            loanAppAccount.cnotify__Email__c =  loanAppContact.Email;
            loanAppAccount.Account_Status__c = WebServiceConstants.ACCOUNT_STATUS_ACTIVE;
            if(loanAppAccount.Phone != NULL){
            	loanAppContact.MobilePhone		 = loanAppAccount.Phone;
            }
            if(loanAppContact.FirstName != NULL)
                loanAppAccount.Name = loanAppContact.FirstName + ' ' + loanAppContact.LastName;
            else
                loanAppAccount.Name = loanAppContact.LastName;
            
            upsert loanAppAccount;
            loanAppContact.AccountId = loanAppAccount.Id;
            upsert loanAppContact;
            
            loanApplication.genesis__Product_Type__c =  'LOAN';
            loanApplication.genesis__Status__c       =  WebServiceConstants.NEWLY_ENTERED_APPLICATION; 
            loanApplication.genesis__Account__c      =  loanAppAccount.Id;
            loanApplication.genesis__Contact__c      =  loanAppContact.Id;
            loanApplication.BankAccount__c           =  bankAccount.Id;
            
            if(returnValue == 'ERROR')
            {
                Database.rollback(spForPersonalApplicationFlow);
                bankAccount.Id    = NULL ;
                loanAppAccount.Id = NULL; 
                loanAppContact.Id = NULL;
                loanApplication.Id= NULL; 
            }else{
                /*Read the Propsect Id and User Id from the returned value and save*/
                if(returnValue != NULL || returnValue != ''){
                    prospectId  =   returnValue.subStringBefore('|');
                    userID      =   Integer.valueOf(returnValue.subStringAfter('|'));
                    loanApplication.Prospect_Number__c = prospectId;
                }
            }
            upsert loanApplication;
             
            /*Upsert the User ID that was returned into the Account Object*/
            Account a      =   new Account();
            a.Id           =   loanAppAccount.Id;
            a.User_ID__c   =   userID;
            upsert a;
            /*Documents Upload*/
            uploadAttachementsForPersonal();
        }
        catch(Exception e) 
        { 
            Database.rollback(spForPersonalApplicationFlow);
            bankAccount.Id    = NULL ;
            loanAppAccount.Id = NULL; 
            loanAppContact.Id = NULL;
            loanApplication.Id= NULL; 
            return NULL; 
        }  
        
      /*Scorecard for a loan application will be associated which inturn will get associated with a Socrecard*/
        List<genesis__Scorecard__c>  scorecardList  =   new     List<genesis__Scorecard__c>();
        try{
                scorecardList   =   [SELECT         Id,Name
                                     FROM           genesis__Scorecard__c
                                     WHERE          Name IN ('Personal Employer Linked','Personal Marketplace Linked','Business')];
                for(genesis__Scorecard__c  temp  :  scorecardList){
                    if(temp.Name == WebServiceConstants.SCORECARD_PERSONAL_MP_LOAN){
                        scorecardForPersonalMPLoan  =   temp.Id;
                    }else if(temp.Name == WebServiceConstants.SCORECARD_PERSONAL_EMP_LOAN){
                        scorecardForPersonalEMPLoan =   temp.Id;    
                    }else if(temp.Name == WebServiceConstants.SCORECARD_BUSINESS_LOAN){
                        scorecardForBusinessLoan    =   temp.Id;
                    }
                }                    
        }catch(QueryException qe){
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_SCORECARD);
                Apexpages.addMessage(msg);
                return NULL;
        }
           /*If any one of the Scorecard setup is not present then an exception is raised.*/    
            if(scorecardForPersonalMPLoan == NULL || scorecardForPersonalEMPLoan == NULL || scorecardForBusinessLoan == NULL){
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,WebServiceConstants.SCORECARD_SETUP_MISSING);
                Apexpages.addMessage(msg);
                return NULL;    
            }
       
           genesis__Application_Scorecard__c        scorecardJunction   =   new     genesis__Application_Scorecard__c();
            try{
            subLoanType = loanAppContact.Registered_in_market_place_or_employer__c; 
            scorecardJunction.genesis__Application__c   =   loanApplication.Id;
            if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_EMPLOYER_LINKED)){
                scorecardJunction.genesis__Scorecard__c =       scorecardForPersonalEMPLoan;
            }else if(subLoanType.equals(WebServiceConstants.SUB_LOAN_TYPE_MARKETPLACE_LINKED)){
                scorecardJunction.genesis__Scorecard__c =       scorecardForPersonalMPLoan;
            }
            upsert scorecardJunction;
            }catch(DmlException dmle){
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,WebServiceConstants.DATABASE_EXCEPTION_SCORECARD_JUNCTION);
                Apexpages.addMessage(msg);
                return NULL;
            }
        
        
        
        PageReference returnPage= new PageReference('/apex/CreateOfflineLoanConfirmation?id=' + loanApplication.id); 
        returnPage.setRedirect(true);
        
        
        return returnPage;
    }
    
    /**
     *This method is used to create Offline Loan Application for Loan Type as Business
     **/
    
    public PageReference createLoanApplicationBusiness()
    {
        Id      scorecardForPersonalMPLoan;
        Id      scorecardForPersonalEMPLoan;
        Id      scorecardForBusinessLoan; 
        String  subLoanType;
        String  prospectId;
        Integer userID;
        /*Invoke the web service exposed by the front end team to get the User ID for this loan application and loan application's
          prospect Number*/
          
          String returnValue = checkProspectAvailabilityBusiness(loanAppAccount,partnerOneContactDetails,partnerTwoContactDetails,
                                                               loanApplication,bankAccount);
                                                        //String returnValue = 'ABC|TYUI';       
        Savepoint spForBusinessApplicationFlow = Database.setSavepoint();
        try
        {
            loanAppAccount.cnotify__Email__c = loanAppAccount.Email_ID__c;
            loanAppAccount.Account_Status__c = WebServiceConstants.ACCOUNT_STATUS_ACTIVE;
            upsert loanAppAccount;
            upsert bankAccount;
            
            if(partnerOneContactDetails.LastName != NULL)
            {
                partnerOneContactDetails.AccountId = loanAppAccount.Id;
                if(partnerOneContactDetails.Terms_Conditions__c == true)
                {   
                    partnerOneContactDetails.Authorized_Signatory__c = 'Yes';
                }
                upsert partnerOneContactDetails;
            }
            if(partnerTwoContactDetails.LastName != NULL)
            {
                partnerTwoContactDetails.AccountId = loanAppAccount.Id;
                if(partnerTwoContactDetails.Terms_Conditions__c == true)
                {   
                    partnerTwoContactDetails.Authorized_Signatory__c = 'Yes';
                }
                upsert partnerTwoContactDetails;
            }
            
            loanApplication.genesis__Product_Type__c = 'LOAN';
            loanApplication.genesis__Status__c       = WebServiceConstants.NEWLY_ENTERED_APPLICATION;
            loanApplication.BankAccount__c           = bankAccount.Id;
            loanApplication.genesis__Account__c      = loanAppAccount.Id;
            
            if(partnerOneContactDetails.Terms_Conditions__c == true)
            {
                loanApplication.genesis__Contact__c      = partnerOneContactDetails.Id;
            }
        
            else if(partnerTwoContactDetails.Terms_Conditions__c == true)
            {
                loanApplication.genesis__Contact__c      = partnerTwoContactDetails.Id;
            }
            
            if(returnValue == 'ERROR')
            {
                Database.rollback(spForBusinessApplicationFlow);
                bankAccount.Id    = NULL ;
                loanAppAccount.Id = NULL; 
                partnerOneContactDetails.Id = NULL;
                partnerTwoContactDetails.Id = NULL;
                loanApplication.Id= NULL; 
            }else{
                /*Read the Propsect Id and User Id from the returned value and save*/
                if(returnValue != NULL || returnValue != ''){
                    prospectId  =   returnValue.subStringBefore('|');
                    userID      =   Integer.valueOf(returnValue.subStringAfter('|'));
                    loanApplication.Prospect_Number__c = prospectId;
                }
            }
            
            upsert loanApplication;
             /*Upsert the User ID that was returned into the Account Object*/
             Account a      =   new Account();
             a.Id           =   loanAppAccount.Id;
             a.User_ID__c   =   userID;
             upsert a;
            /*Documents Upload*/
            uploadAttachementsForBusiness();
        }
        catch(Exception e) 
        { 
            Database.rollback(spForBusinessApplicationFlow);
            loanApplication.Id          = NULL;
            partnerTwoContactDetails.Id = NULL;
            partnerOneContactDetails.Id = NULL; 
            loanAppAccount.Id           = NULL;
            bankAccount.Id              = NULL; 
            return NULL; 
        }
    

        
        
        if(loanApplication.genesis__Contact__c == NULL)
        {
            Database.rollback(spForBusinessApplicationFlow);
            ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,'Authorised Signatory has not been chosen among the Negotiator(s)');
            Apexpages.addMessage(msg);
            return NULL; 
        }
        
        
      /*Scorecard for a loan application will be associated which inturn will get associated with a Socrecard*/
        List<genesis__Scorecard__c>  scorecardList  =   new     List<genesis__Scorecard__c>();
        try{
                scorecardList   =   [SELECT         Id,Name
                                     FROM           genesis__Scorecard__c
                                     WHERE          Name IN ('Personal Employer Linked','Personal Marketplace Linked','Business')];
                
                for(genesis__Scorecard__c  temp  :  scorecardList){
                    if(temp.Name == WebServiceConstants.SCORECARD_PERSONAL_MP_LOAN){
                        scorecardForPersonalMPLoan  =   temp.Id;
                    }else if(temp.Name == WebServiceConstants.SCORECARD_PERSONAL_EMP_LOAN){
                        scorecardForPersonalEMPLoan =   temp.Id;    
                    }else if(temp.Name == WebServiceConstants.SCORECARD_BUSINESS_LOAN){
                        scorecardForBusinessLoan    =   temp.Id;
                    }
                }                    
        }catch(QueryException qe){
             ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_SCORECARD);
             Apexpages.addMessage(msg);
             return NULL;
        }
           /*If any one of the Scorecard setup is not present then an exception is raised.*/    
            if(scorecardForPersonalMPLoan == NULL || scorecardForPersonalEMPLoan == NULL || scorecardForBusinessLoan == NULL){
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,WebServiceConstants.SCORECARD_SETUP_MISSING);
                Apexpages.addMessage(msg);
                return NULL;
            }
       
           genesis__Application_Scorecard__c        scorecardJunction   =   new     genesis__Application_Scorecard__c();
            try{
                scorecardJunction.genesis__Application__c   =   loanApplication.Id;
                scorecardJunction.genesis__Scorecard__c     =   scorecardForBusinessLoan;
                upsert scorecardJunction;
               }
               catch(DmlException dmle){
                    ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,WebServiceConstants.DATABASE_EXCEPTION_SCORECARD_JUNCTION);
                    Apexpages.addMessage(msg);
                    return NULL;                    
              }
        
        
        PageReference returnPage= new PageReference('/apex/CreateOfflineLoanConfirmation?id=' + loanApplication.id); 
        returnPage.setRedirect(true);
        return returnPage;
     }
    
    
    /*
    * This method is used when the user wishes to upload PAN Card,Aadhar Card,VoterID, and other applicable documents
    * from the documents upload tab present in offline loan application creation page when the chosen loan type is Personal
    */
    
    public void uploadAttachementsForPersonal()
    {
        List<Attachment> personalAttachementList = new List<Attachment>(); 
        
        if(attachPANCardPage.name != NULL && attachPANCardPage.body != NULL)
        {
            attachPANCard.name        = attachPANCardPage.name;
            attachPANCard.body        = attachPANCardPage.body;
            attachPANCard.ParentId    = loanApplication.Id;
            attachPANCard.Description = WebServiceConstants.FILE_DESCRIPTION_PAN; 
            personalAttachementList.add(attachPANCard);
            attachPANCardPage.body    = NULL;
        }
       
        if(attachAdharPage.name != NULL && attachAdharPage.body != NULL)
        {
            attachAdhar.name        = attachAdharPage.name;
            attachAdhar.body        = attachAdharPage.body;
            attachAdhar.ParentId    = loanApplication.Id;
            attachAdhar.Description = WebServiceConstants.FILE_DESCRIPTION_AADHAAR; 
            personalAttachementList.add(attachAdhar);
            attachAdharPage.body    = NULL;
        }
        
        if(attachVoterIDTestPage.name != NULL && attachVoterIDTestPage.body != NULL)
        {
            attachVoterIDTest.name        = attachVoterIDTestPage.name;
            attachVoterIDTest.body        = attachVoterIDTestPage.body;
            attachVoterIDTest.ParentId    = loanApplication.Id;
            attachVoterIDTest.Description = WebServiceConstants.FILE_DESCRIPTION_VOTER_ID; 
            personalAttachementList.add(attachVoterIDTest);
            attachVoterIDTestPage.body    = NULL;
        }
        
        if(attachSalarySlipPage.name != NULL && attachSalarySlipPage.body != NULL)
        {
            attachSalarySlip.name        = attachSalarySlipPage.name;
            attachSalarySlip.body        = attachSalarySlipPage.body;
            attachSalarySlip.ParentId    = loanApplication.Id;
            attachSalarySlip.Description = WebServiceConstants.FILE_DESCRIPTION_SALARY_SLIP; 
            personalAttachementList.add(attachSalarySlip);
            attachSalarySlipPage.body    = NULL;
        }
        
        if(attachLastITRPage.name != NULL && attachLastITRPage.body != NULL)
        {
            attachLastITR.name        = attachLastITRPage.name;
            attachLastITR.body        = attachLastITRPage.body;
            attachLastITR.ParentId    =  loanApplication.Id;
            attachLastITR.Description = WebServiceConstants.FILE_DESCRIPTION_LAST_ITR; 
            personalAttachementList.add(attachLastITR);
            attachLastITRPage.body    = NULL;
        }
        
        if(attachOthersPage.name != NULL && attachOthersPage.body != NULL)
        {
            attachOthers.name        = attachOthersPage.name;
            attachOthers.body        = attachOthersPage.body;
            attachOthers.ParentId    = loanApplication.Id;
            attachOthers.Description = WebServiceConstants.FILE_DESCRIPTION_OTHER; 
            personalAttachementList.add(attachOthers);
            attachOthersPage.body    = NULL;
        }
        if(personalAttachementList != NULL)
        upsert personalAttachementList;
    }
    
    
    /*
    * This method is used when the user wishes to upload PAN Card,Income Statement, and other applicable documents
    * from the documents upload tab present in offline loan application creation page when the chosen loan type is Business
    */
    
    public void uploadAttachementsForBusiness()
    {
        List<Attachment> businessAttachementList = new List<Attachment>();
        
        if(attachPANCorporatePage.name != NULL && attachPANCorporatePage.body != NULL)
         {
            attachPANCorporate.name                     =       attachPANCorporatePage.name;
            attachPANCorporate.body                     =       attachPANCorporatePage.body;
            attachPANCorporate.ParentId                 =       loanApplication.Id;
            attachPANCorporate.Description              =       WebServiceConstants.FILE_DESCRIPTION_CORPORATE_PAN;
             
            businessAttachementList.add(attachPANCorporate);
            attachPANCorporatePage.body                 =       NULL;
         }
       
       if(attachIncomeStatementCorporatePage.name != NULL && attachIncomeStatementCorporatePage.body != NULL)
        {
            attachIncomeStatementCorporate.name         =   attachIncomeStatementCorporatePage.name;
            attachIncomeStatementCorporate.body         =   attachIncomeStatementCorporatePage.body;
            attachIncomeStatementCorporate.ParentId     =   loanApplication.Id;
            attachIncomeStatementCorporate.Description  =   WebServiceConstants.FILE_DESCRIPTION_CORPORATE_INCOME_STATEMENT;
            
            businessAttachementList.add(attachIncomeStatementCorporate);
            attachIncomeStatementCorporatePage.body     =   NULL;
        }
         
       if(attachBalanceSheetCorporatePage.name != NULL && attachBalanceSheetCorporatePage.body != NULL)
        {
            attachBalanceSheetCorporate.name            =   attachBalanceSheetCorporatePage.name;
            attachBalanceSheetCorporate.body            =   attachBalanceSheetCorporatePage.body;
            attachBalanceSheetCorporate.ParentId        =   loanApplication.Id;
            attachBalanceSheetCorporate.Description     =   WebServiceConstants.FILE_DESCRIPTION_CORPORATE_BALANCE_SHEET;
            
            businessAttachementList.add(attachBalanceSheetCorporate);
            attachBalanceSheetCorporatePage.body        =   NULL;                  
        }
        
        if(attachInvoicesCorporatePage.name != NULL && attachInvoicesCorporatePage.body != NULL)
         {
            attachInvoicesCorporate.name                =   attachInvoicesCorporatePage.name;
            attachInvoicesCorporate.body                =   attachInvoicesCorporatePage.body;
            attachInvoicesCorporate.ParentId            =   loanApplication.Id;
            attachInvoicesCorporate.Description         =   WebServiceConstants.FILE_DESCRIPTION_CORPORATE_INVOICES;
            
            businessAttachementList.add(attachInvoicesCorporate);
            attachInvoicesCorporatePage.body            =   NULL;
         }
        
        if(attachPANIndividualCorporatePage.name != NULL && attachPANIndividualCorporatePage.body != NULL)
         {
            attachPANIndividualCorporate.name           =   attachPANIndividualCorporatePage.name;
            attachPANIndividualCorporate.body           =   attachPANIndividualCorporatePage.body;
            attachPANIndividualCorporate.ParentId       =   loanApplication.Id;
            attachPANIndividualCorporate.Description    =   WebServiceConstants.FILE_DESCRIPTION_PAN;   
            
            businessAttachementList.add(attachPANIndividualCorporate);
            attachPANIndividualCorporatePage.body       =   NULL;
        }
         
         if(attachAdhaarIndividualCorporatePage.name != NULL && attachAdhaarIndividualCorporatePage.body != NULL)
          {
            attachAdhaarIndividualCorporate.name        =   attachAdhaarIndividualCorporatePage.name;
            attachAdhaarIndividualCorporate.body        =   attachAdhaarIndividualCorporatePage.body;
            attachAdhaarIndividualCorporate.ParentId    =   loanApplication.Id;
            attachAdhaarIndividualCorporate.Description =   WebServiceConstants.FILE_DESCRIPTION_AADHAAR;
            
            businessAttachementList.add(attachAdhaarIndividualCorporate);
            attachAdhaarIndividualCorporatePage.body    =   NULL;
          }
          
          if(attachOtherBusinessPage.name != NULL && attachOtherBusinessPage.body != NULL)
           {
            attachOtherBusiness.name                    =   attachOtherBusinessPage.name;
            attachOtherBusiness.body                    =   attachOtherBusinessPage.body;
            attachOtherBusiness.ParentId                =   loanApplication.Id;
            attachOtherBusiness.Description             =   WebServiceConstants.FILE_DESCRIPTION_OTHER;
            
            businessAttachementList.add(attachOtherBusiness);
            attachOtherBusinessPage.body                =   NULL; 
           }  
             
           if(businessAttachementList != NULL)
                upsert businessAttachementList;
    }
    
        
    /**
     * This method is used when the user has chosen Legal Entity type from the picklist and accordingly the heading of 
     * partner details section needs to be populated.Also partner details tab needs to be enabled/disbaled depending on
     * legal entity type value
     **/
     
    public void partnerTabCheck()
    {
        if(((loanAppAccount.Legal_Entity_Type__c != NULL)))
                enablePartnerTab = true;
        else
                enablePartnerTab = false;  
                
        if((loanAppAccount.Legal_Entity_Type__c == 'Partnership')||(loanAppAccount.Legal_Entity_Type__c == 'LLP'))        
        {
            partnerOneSectionHeading = WebServiceConstants.SECTION_HEADING_PARTNER_1;
            partnerTwoSectionHeading = WebServiceConstants.SECTION_HEADING_PARTNER_2;      
        }     
        else if((loanAppAccount.Legal_Entity_Type__c == 'Private Limited')||(loanAppAccount.Legal_Entity_Type__c == 'Public Limited'))
        {
            partnerOneSectionHeading = WebServiceConstants.SECTION_HEADING_DIRECTOR_1;
            partnerTwoSectionHeading = WebServiceConstants.SECTION_HEADING_DIRECTOR_2; 
        }
        else if(loanAppAccount.Legal_Entity_Type__c == 'HUF')
        {
            partnerOneSectionHeading = WebServiceConstants.SECTION_HEADING_KARTA;
            partnerTwoSectionHeading = WebServiceConstants.SECTION_HEADING_MEMBER_2;
        }
        else
            partnerOneSectionHeading = NULL;
    }
 
    /**
     * In the Additional Details Tab , depending upon what value has been given for Registered in Marktplace or employer,
     * accordingly Employer/Marktplace sections would be displayed 
     **/
 
    public void controlEmpMktplaceVisibility()
    {
        if(String.valueOf(loanAppContact.Registered_in_market_place_or_employer__c) == 'Employer Linked')
        {
            controlEmployerVisibility    = true;
            controlMarketplaceVisibility = false;
        }
        else if(String.valueOf(loanAppContact.Registered_in_market_place_or_employer__c) == 'Marketplace Linked')
        {
            controlMarketplaceVisibility = true;
            controlEmployerVisibility    = false;
        }
        else 
        {
            controlMarketplaceVisibility = false;
            controlEmployerVisibility    = false;
        }
    }
    
    /*
    This method checks the availability of Prospect Number & User id in the front end system to check duplicate
    active loan applications
    */
    
    public String checkProspectAvailability(Account loanAppAccount,Contact loanAppContact,genesis__applications__c loanApplication,
                                             loan__Bank_Account__c bankAccount)
    {
        OptaCreditSetup__c    customSettingsData        =       OptaCreditSetup__c.getOrgDefaults();
        String endPoint       =     customSettingsData.Tejora_EndPoint__c;
        String authToken      =     customSettingsData.Tejora_Bearer_Token__c;
        Http http             =     new Http();
        HttpRequest req       =     new HttpRequest();
        HTTPResponse httpRes  =     new HttpResponse();
        Response res          =     new Response();
        String   returnValue  =     'ERROR';
        String   typeOfLoan   =    loanAppAccount.Type_of_Loan__c;
        req.setMethod('POST');
        if(Test.isRunningTest())
        {
            endPoint    = 'http://182.74.22.133:8888/v1/pwcs/adduserloan';
            authToken   = 'Bearer SZ1B9CfPknYVSX7rmqEiPgN9xmBytJ07';
        }
        req.setEndpoint(endPoint);
        req.setHeader('Authorization', authToken);
        req.setHeader('Content-Type','application/json');   
        req.setHeader('KEYWORD_IDENTIFIER','adduserloan');
        /*Form the JSON request : START*/
        req.setBody(formJSONStringForPersonalLoanProspect(loanAppAccount,loanAppContact,loanApplication,bankAccount));
        /*Form the JSON request : END*/
        httpRes            =       http.send(req);
        String response    =       httpRes.getBody();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(response);
                            
        Integer responseCode        = (Integer)requestBodyParamsMap.get('code')!= NULL ? (Integer)requestBodyParamsMap.get('code') : NULL;
        String  message             = (String)requestBodyParamsMap.get('message')!= NULL ? (String)requestBodyParamsMap.get('message') : NULL;
        List<Object> listOfErrors   = (List<Object>)requestBodyParamsMap.get('error');
        String errorsEncountered;
        Integer userID;
        String  prospectId;
        /*Parse the response and get the errors that were encountered from the front end web service*/
        if(listOfErrors != NULL)
        {
            for(Object errorObj : listOfErrors){
                if(errorsEncountered != NULL){
                    errorsEncountered = errorsEncountered + ' '+errorObj;
                }else{
                    errorsEncountered = errorObj + ' ';
                }
            }
        }      
        if(responseCode != NULL)
        {
            if(responseCode == 0)
            {
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue; 
            }
            else if(responseCode == 6002)
            {
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue;
            }
            else if(responseCode == 6003)
            {
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue;
            }
            else if((responseCode == 1001) || (responseCode == 1002) || (responseCode == 1003) || (responseCode == 1004) || (responseCode == 1005) ||
                      (responseCode == 1006) || (responseCode == 1007) || (responseCode == 1008) || (responseCode == 1009) ||
                      (responseCode == 1010) || (responseCode == 1011) || (responseCode == 1012) || (responseCode == 1013) ||
                      (responseCode == 1014) || (responseCode == 1015) || (responseCode == 1016) || (responseCode == 1017) || (responseCode == 1018) ||
                      (responseCode == 1019) || (responseCode == 1020) || (responseCode == 1021) || (responseCode == 2001) || (responseCode == 2002) ||
                      (responseCode == 2003) || (responseCode == 2004) || (responseCode == 2005) || (responseCode == 2006) || (responseCode == 3001) ||
                      (responseCode == 3002) || (responseCode == 3003) || (responseCode == 3004) || (responseCode == 3005) || (responseCode == 3006) ||
                      (responseCode == 3007) || (responseCode == 3008) || (responseCode == 3009)){
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue; 
            }else{
                    /*Parse the response to get User ID and Prospect Id*/
                    JSONParser finalResponseParser = JSON.createParser(response);  
                    while(finalResponseParser.nextToken() != NULL){
                        if(finalResponseParser.getCurrentToken() == JSONToken.FIELD_NAME &&
                                finalResponseParser.getText().equals('loan_id')){
                                     finalResponseParser.nextToken();       
                                     prospectId = finalResponseParser.getText();
                        }else if(finalResponseParser.getCurrentToken() == JSONToken.FIELD_NAME &&
                            finalResponseParser.getText().equals('user_id')){
                                    finalResponseParser.nextToken();        
                                    userID  = finalResponseParser.getIntegerValue();    
               }  
            
        }
            returnValue = prospectId + '|' + String.valueOf(userID);
            }
        }     
      return returnValue;
    }
    
     /*
    This method fetches the User Id and Prospect Id from the front end by sending the details to the front end.
    This method is for Business Loans only.
    */
    public String checkProspectAvailabilityBusiness(Account loanAppAccount,Contact partnerOneContactDetails,
                                                    Contact partnerTwoContactDetails,genesis__applications__c loanApplication,
                                                    loan__Bank_Account__c bankAccount)
    {
    	  
        OptaCreditSetup__c    customSettingsData        =       OptaCreditSetup__c.getOrgDefaults();
        String endPoint       =     customSettingsData.Tejora_EndPoint__c;
        String authToken      =     customSettingsData.Tejora_Bearer_Token__c;
        Http http             =     new Http();
        HttpRequest req       =     new HttpRequest();
        HTTPResponse httpRes  =     new HttpResponse();
        Response res          =     new Response();
        String   returnValue  =     'ERROR';
        req.setMethod('POST');
        if(Test.isRunningTest())
        {
            endPoint    = 'http://182.74.22.133:8888/v1/pwcs/adduserloan';
            authToken   = 'Bearer SZ1B9CfPknYVSX7rmqEiPgN9xmBytJ07';
        }
        req.setEndpoint(endPoint);
        req.setHeader('Authorization', authToken);
        req.setHeader('Content-Type','application/json');   
        req.setHeader('KEYWORD_IDENTIFIER','adduserloan');
        /*Form the JSON request : START*/
          
        req.setBody(formJSONStringForBusinessLoanProspect(loanAppAccount,partnerOneContactDetails,partnerTwoContactDetails,
                                                          loanApplication,bankAccount));
                                                          
                                                          
        /*Form the JSON request : END*/
        httpRes            =       http.send(req);
        String response    =       httpRes.getBody();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(response);
                            
        Integer responseCode = (Integer)requestBodyParamsMap.get('code')!= NULL ? (Integer)requestBodyParamsMap.get('code') : NULL;
        String  message      = (String)requestBodyParamsMap.get('message')!= NULL ? (String)requestBodyParamsMap.get('message') : NULL;
        List<Object> listOfErrors   = (List<Object>)requestBodyParamsMap.get('error');
        String errorsEncountered;
        Integer userID;
        String  prospectId;
        /*Parse the response and get the errors that were encountered from the front end web service*/
        if(listOfErrors != NULL)
        {
            for(Object errorObj : listOfErrors){
                if(errorsEncountered != NULL){
                    errorsEncountered = errorsEncountered + ' '+errorObj;
                }else{
                    errorsEncountered = errorObj + ' ';
                }
            }
        }      
        if(responseCode != NULL)
        {
            if(responseCode == 0)
            {
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue; 
            }
            else if(responseCode == 6002)
            {
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue;
            }
            else if(responseCode == 6003)
            {	
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue;
            }
            else if((responseCode == 1001) || (responseCode == 1002) || (responseCode == 1003) || (responseCode == 1004) || (responseCode == 1005) ||
                      (responseCode == 1006) || (responseCode == 1007) || (responseCode == 1008) || (responseCode == 1009) ||
                      (responseCode == 1010) || (responseCode == 1011) || (responseCode == 1012) || (responseCode == 1013) ||
                      (responseCode == 1014) || (responseCode == 1015) || (responseCode == 1016) || (responseCode == 1017) || (responseCode == 1018) ||
                      (responseCode == 1019) || (responseCode == 1020) || (responseCode == 1021) || (responseCode == 2001) || (responseCode == 2002) ||
                      (responseCode == 2003) || (responseCode == 2004) || (responseCode == 2005) || (responseCode == 2006) || (responseCode == 3001) ||
                      (responseCode == 3002) || (responseCode == 3003) || (responseCode == 3004) || (responseCode == 3005) || (responseCode == 3006) ||
                      (responseCode == 3007) || (responseCode == 3008) || (responseCode == 3009)){
                ApexPages.Message msg = new ApexPages.message(ApexPages.severity.ERROR,errorsEncountered);
                Apexpages.addMessage(msg);
                return returnValue; 
            }else{
                    /*Parse the response to get User ID and Prospect Id*/
                    JSONParser finalResponseParser = JSON.createParser(response);  
                    while(finalResponseParser.nextToken() != NULL){
                        if(finalResponseParser.getCurrentToken() == JSONToken.FIELD_NAME &&
                                finalResponseParser.getText().equals('loan_id')){
                                     finalResponseParser.nextToken();       
                                     prospectId = finalResponseParser.getText();
                        }else if(finalResponseParser.getCurrentToken() == JSONToken.FIELD_NAME &&
                            finalResponseParser.getText().equals('user_id')){
                                    finalResponseParser.nextToken();        
                                    userID  = finalResponseParser.getIntegerValue();    
               }  
            
        }
            returnValue = prospectId + '|' + String.valueOf(userID);
            }
        }     
      return returnValue;
    }
    
    /*
    This method is used to generate the JSON request body which needs to be sent to Tejora/Front End system to check
    for any duplicate active loan application. 
    */
    
    private static String formJSONStringForPersonalLoanProspect(Account accountDetails,Contact contactDetails,genesis__Applications__c appDetails,
                                                                loan__Bank_Account__c bankDetails)
    {
        String response;
        JSONGenerator   jsonGen =   JSON.createGenerator(true);
        jsonGen.writeStartObject();
        
        jsonGen.writeStringField('user_type','RETAIL');
        
        if(contactDetails.Email != NULL){
        jsonGen.writeStringField('email_id',contactDetails.Email);
        }
        
        if(accountDetails.Phone != NULL){
        jsonGen.writeStringField('mobile_number',accountDetails.Phone);
        }
        
        if(contactDetails.FirstName != NULL){
        jsonGen.writeStringField('first_name',contactDetails.FirstName);
        }
        
        if(contactDetails.Middle_Name__c != NULL){
        jsonGen.writeStringField('middle_name',contactDetails.Middle_Name__c);
        }
        
        if(contactDetails.LastName != NULL){
        jsonGen.writeStringField('last_name',contactDetails.LastName);
        }
        
        if(contactDetails.Gender__c != NULL){
        jsonGen.writeStringField('gender',(contactDetails.Gender__c).substring(0,1));
        }
        
        if(contactDetails.BirthDate != NULL){
        jsonGen.writeStringField('dob',String.valueOf(contactDetails.BirthDate));
        }
        
        if(contactDetails.Permanent_Account_Number_PAN__c != NULL){
        jsonGen.writeStringField('pan',contactDetails.Permanent_Account_Number_PAN__c);
        }
        
        if(contactDetails.Voter_ID__c != NULL){
        jsonGen.writeStringField('voter_id',contactDetails.Voter_ID__c);
        }
        
        if(contactDetails.Voter_ID_State__c != NULL){
        jsonGen.writeStringField('voter_state',contactDetails.Voter_ID_State__c);
        }
        
        if(contactDetails.Driving_License_State__c != NULL){
        jsonGen.writeStringField('dl_licence_state',contactDetails.Driving_License_State__c);
        }
        
        if(contactDetails.Driving_License_Number__c != NULL){
        jsonGen.writeStringField('driving_licence',contactDetails.Driving_License_Number__c);
        }
        
        if(contactDetails.AADHAAR_Number__c != NULL){
        jsonGen.writeStringField('aadhar',String.valueOf(contactDetails.AADHAAR_Number__c));
        }
        
        if(contactDetails.Passport_Number__c != NULL){
        jsonGen.writeStringField('passport',contactDetails.Passport_Number__c);
        }
        
        if(appDetails.genesis__Loan_Amount__c != NULL){
        String loanAmount =    String.valueOf(appDetails.genesis__Loan_Amount__c); 
        loanAmount  = loanAmount.substringBefore('.');
        jsonGen.writeStringField('loan_amount',loanAmount);
        }
        
        if(appDetails.genesis__Term__c != NULL){
        jsonGen.writeStringField('loan_tenure',String.valueOf(appDetails.genesis__Term__c));
        }
        
        //jsonGen.writeStringField('profile','1');
        
        jsonGen.writeFieldName('present_address');
        jsonGen.writeStartObject();
        if(contactDetails.Present_Address_State__c != NULL)
            jsonGen.writeStringField('state',contactDetails.Present_Address_State__c);
            
        if(contactDetails.Present_Address_City__c != NULL)  
            jsonGen.writeStringField('city',contactDetails.Present_Address_City__c);
            
        if(contactDetails.Present_Address_Pin_code__c != NULL)
            jsonGen.writeStringField('pin_code',contactDetails.Present_Address_Pin_code__c);
            
        if(contactDetails.Present_Address__c != NULL)   
            jsonGen.writeStringField('address',contactDetails.Present_Address__c);
        
        jsonGen.writeEndObject();
        
        jsonGen.writeFieldName('permanent_address');
        jsonGen.writeStartObject();
        
        if(contactDetails.Permanent_Address_State__c != NULL)
            jsonGen.writeStringField('state',contactDetails.Permanent_Address_State__c);
            
        if(contactDetails.Permanent_Address_City__c != NULL)
            jsonGen.writeStringField('city',contactDetails.Permanent_Address_City__c);
            
        if(contactDetails.Permanent_Address_Pin_code__c != NULL)
            jsonGen.writeStringField('pin_code',contactDetails.Permanent_Address_Pin_code__c);
            
        if(contactDetails.Permanent_Address__c != NULL)
            jsonGen.writeStringField('address',contactDetails.Permanent_Address__c);
        jsonGen.writeEndObject();
        
        if(contactDetails.Registered_in_market_place_or_employer__c != NULL){
        jsonGen.writeStringField('sub_loan_type',(contactDetails.Registered_in_market_place_or_employer__c).substring(0,1));
        }
        
        if(contactDetails.Alternate_contact_number__c != NULL){
        jsonGen.writeStringField('alternate_contact',contactDetails.Alternate_contact_number__c);
        }
        /*Primary Marketplace Details : START*/
        if(contactDetails.Primary_Marketplace__c != NULL){
        jsonGen.writeStringField('primary_market',contactDetails.Primary_Marketplace__c);
        }
        
        if(contactDetails.Primary_Marketplace_Merchant_ID__c != NULL){
        jsonGen.writeStringField('primary_merchant',contactDetails.Primary_Marketplace_Merchant_ID__c);
        }
        if(contactDetails.Marketplace_Experience__c != NULL){
            if((contactDetails.Marketplace_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('primary_exp_yr',contactDetails.Marketplace_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('primary_exp_mnth',contactDetails.Marketplace_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('primary_exp_yr',contactDetails.Marketplace_Experience__c);    
                jsonGen.writeStringField('primary_exp_mnth','0');
            }
        }
        /*Primary Marketplace Details : END*/
        
        /*Secondary Marketplace Details : START*/
        if(contactDetails.Second_Marketplace__c != NULL){
        jsonGen.writeStringField('second_market',contactDetails.Second_Marketplace__c);
        }
        
        if(contactDetails.Second_Marketplace_Merchant_ID__c != NULL){
        jsonGen.writeStringField('second_merchant',contactDetails.Second_Marketplace_Merchant_ID__c);
        }
        if(contactDetails.Second_Marketplace_Experience__c != NULL){
            if((contactDetails.Second_Marketplace_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('second_exp_yr',contactDetails.Second_Marketplace_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('second_exp_mnth',contactDetails.Second_Marketplace_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('second_exp_yr',contactDetails.Second_Marketplace_Experience__c);  
                jsonGen.writeStringField('second_exp_mnth','0');
            }
        }
        /*Secondary Marketplace Details : END*/
        
        /*Third Marketplace Details : START*/
        if(contactDetails.Third_Marketplace__c != NULL){
        jsonGen.writeStringField('third_market',contactDetails.Third_Marketplace__c);
        }
        
        if(contactDetails.Third_Marketplace_Merchant_ID__c != NULL){
        jsonGen.writeStringField('third_merchant',contactDetails.Third_Marketplace_Merchant_ID__c);
        }
        if(contactDetails.Third_Marketplace_Experience__c != NULL){
            if((contactDetails.Third_Marketplace_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('third_exp_yr',contactDetails.Third_Marketplace_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('third_exp_mnth',contactDetails.Third_Marketplace_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('third_exp_yr',contactDetails.Third_Marketplace_Experience__c);    
                jsonGen.writeStringField('third_exp_mnth','0');
            }
        }
        /*Third Marketplace Details : END*/
        jsonGen.writeStringField('other_market','');
        jsonGen.writeStringField('other_merchant','');
        
        if(contactDetails.Email != NULL){
        jsonGen.writeStringField('personal_email',contactDetails.Email);
        }
        
        if(contactDetails.Official_Email_ID__c != NULL){
        jsonGen.writeStringField('official_email',contactDetails.Official_Email_ID__c);
        }
        if(contactDetails.Total_Experience__c != NULL){
            if((contactDetails.Total_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('experience_year',contactDetails.Total_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('experience_month',contactDetails.Total_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('experience_year',contactDetails.Total_Experience__c); 
                jsonGen.writeStringField('experience_month','0');
            }
        }
        if(contactDetails.Do_you_have_any_existing_Debt__c != NULL){
            if(contactDetails.Do_you_have_any_existing_Debt__c == true)
                jsonGen.writeStringField('existing_debt','Y');
            else
                jsonGen.writeStringField('existing_debt','N');
         }
        if(contactDetails.Do_you_live_in__c != NULL){
        jsonGen.writeStringField('accomodation',(contactDetails.Do_you_live_in__c).substring(0,1));
        }
        if(bankDetails.loan__Bank_Account_Number__c != NULL){
        jsonGen.writeStringField('bank_account_number',bankDetails.loan__Bank_Account_Number__c);
        }
        
        if(bankDetails.Bank_IFSC_Code__c != NULL){
        jsonGen.writeStringField('ifsc_code',bankDetails.Bank_IFSC_Code__c);
        }
        
        if(bankDetails.loan__Bank_Name__c != NULL){
        jsonGen.writeStringField('bankname',bankDetails.loan__Bank_Name__c);
        }
        
        if(bankDetails.loan__Account_Type__c != NULL){
        jsonGen.writeStringField('account_type',bankDetails.loan__Account_Type__c);
        }
        if(contactDetails.Employment_ID__c != NULL){
        jsonGen.writeStringField('employee_id',contactDetails.Employment_ID__c);
        }
        
        if(contactDetails.Employer_Name__c != NULL){
        jsonGen.writeStringField('employer_name',contactDetails.Employer_Name__c);
        }
        
        if(contactDetails.Source__c != NULL){
        jsonGen.writeStringField('source',contactDetails.Source__c);
        }
        
        if(contactDetails.Source_sub_category__c != NULL){
        jsonGen.writeStringField('sub_source',contactDetails.Source_sub_category__c);
        }
        
        if(contactDetails.If_others_Please_mention__c != NULL){
        jsonGen.writeStringField('others',contactDetails.If_others_Please_mention__c);
        }
        jsonGen.writeFieldName('references');
        jsonGen.writeStartArray();
        jsonGen.writeStartObject();
            if(contactDetails.Full_name_of_reference_1__c != NULL)
                jsonGen.writeStringField('full_name',contactDetails.Full_name_of_reference_1__c);
            if(contactDetails.Email_ID_of_reference_1__c != NULL)   
                jsonGen.writeStringField('email_id',contactDetails.Email_ID_of_reference_1__c);
            if(contactDetails.Mobile_number_of_reference_1__c != NULL)  
                jsonGen.writeStringField('mobile',contactDetails.Mobile_number_of_reference_1__c);
            if(contactDetails.Address_of_reference_1__c != NULL)    
                jsonGen.writeStringField('address',contactDetails.Address_of_reference_1__c);
            if(contactDetails.State_of_reference_1__c != NULL)  
                jsonGen.writeStringField('state',contactDetails.State_of_reference_1__c);
            if(contactDetails.City_of_Reference_1__c != NULL)   
                jsonGen.writeStringField('city',contactDetails.City_of_Reference_1__c);
            if(contactDetails.Pincode_of_reference_1__c != NULL)    
                jsonGen.writeStringField('pincode',contactDetails.Pincode_of_reference_1__c);           
        jsonGen.writeEndObject();
        jsonGen.writeStartObject();
            if(contactDetails.Full_name_of_reference_2__c != NULL)
                jsonGen.writeStringField('full_name',contactDetails.Full_name_of_reference_2__c);
            if(contactDetails.Email_ID_of_reference_2__c != NULL)   
                jsonGen.writeStringField('email_id',contactDetails.Email_ID_of_reference_2__c);
            if(contactDetails.Mobile_number_of_reference_2__c != NULL)  
                jsonGen.writeStringField('mobile',contactDetails.Mobile_number_of_reference_2__c);
            if(contactDetails.Address_of_reference_2__c != NULL)    
                jsonGen.writeStringField('address',contactDetails.Address_of_reference_2__c);
            if(contactDetails.State_of_reference_2__c != NULL)  
                jsonGen.writeStringField('state',contactDetails.State_of_reference_2__c);
            if(contactDetails.City_of_Reference_2__c != NULL)   
                jsonGen.writeStringField('city',contactDetails.City_of_Reference_2__c);
            if(contactDetails.Pincode_of_reference_2__c != NULL)    
                jsonGen.writeStringField('pincode',contactDetails.Pincode_of_reference_2__c);   
        jsonGen.writeEndObject();
        jsonGen.writeEndArray();
        
        if(contactDetails.Facebook_Profile_URL__c != NULL){
        jsonGen.writeStringField('facebook_url',contactDetails.Facebook_Profile_URL__c);
        }
        if(contactDetails.LinkedIn_Profile_URL__c != NULL){
        jsonGen.writeStringField('linkedin_url',contactDetails.LinkedIn_Profile_URL__c);
        }
        if(contactDetails.Twitter_Profile_URL__c != NULL){
        jsonGen.writeStringField('twitter_url',contactDetails.Twitter_Profile_URL__c);
        }
        if(contactDetails.Gmail_ID__c != NULL){
        jsonGen.writeStringField('gmail_id',contactDetails.Gmail_ID__c);
        }
        jsonGen.writeEndObject();
        jsonGen.close();
        response =  jsonGen.getAsString();
        return response;
    }
    
        /*
    This method is used to generate the JSON request body which needs to be sent to Tejora/Front End system to generate
    User Id and Prospect Id for a Business Loan. 
    */
    
    private static String formJSONStringForBusinessLoanProspect(Account accountDetails,Contact partnerOneContactDetails,
                                                                Contact partnerTwoContactDetails,genesis__Applications__c appDetails,
                                                                loan__Bank_Account__c bankDetails)
    {
        String response;
        JSONGenerator   jsonGen =   JSON.createGenerator(true);
        jsonGen.writeStartObject();
        
        jsonGen.writeStringField('user_type','BUSINESS');
        
        if(accountDetails.Email_ID__c != NULL){
        jsonGen.writeStringField('email_id',accountDetails.Email_ID__c);
        }
        
        if(accountDetails.Phone != NULL){
        jsonGen.writeStringField('mobile_number',accountDetails.Phone);
        }
        
        if(accountDetails.Name != NULL){
        jsonGen.writeStringField('company_name',accountDetails.Name);
        }
        
        if(accountDetails.Legal_Entity_Type__c != NULL){
        	if(accountDetails.Legal_Entity_Type__c.equals('Sole Proprietorship')){
        		jsonGen.writeStringField('legal_type','SOLEPRO');		
        	}else if(accountDetails.Legal_Entity_Type__c.equals('Partnership')){
        		jsonGen.writeStringField('legal_type','PARTNER');		
        	}else if(accountDetails.Legal_Entity_Type__c.equals('LLP')){
        		jsonGen.writeStringField('legal_type','LLP');		
        	}else if(accountDetails.Legal_Entity_Type__c.equals('Private Limited')){
        		jsonGen.writeStringField('legal_type','PRILTD');		
        	}else if(accountDetails.Legal_Entity_Type__c.equals('Public Limited')){
        		jsonGen.writeStringField('legal_type','PUBLTD');		
        	}else if(accountDetails.Legal_Entity_Type__c.equals('HUF')){
        		jsonGen.writeStringField('legal_type','HUF');		
        	}
        
        }
        
        if(accountDetails.Date_of_Inception__c != NULL){
        jsonGen.writeStringField('inception_date',String.valueOf(accountDetails.Date_of_Inception__c));
        }
        
        if(accountDetails.Company_Permanent_Account_Number_PAN__c != NULL){
        jsonGen.writeStringField('pan',accountDetails.Company_Permanent_Account_Number_PAN__c);
        }
        
        
        if(accountDetails.VAT_Number__c != NULL){
        jsonGen.writeStringField('vat',accountDetails.VAT_Number__c);
        }
        
        if(accountDetails.CST_Number__c != NULL){
        jsonGen.writeStringField('cstno',accountDetails.CST_Number__c);
        }
        
        if(accountDetails.Warehouse_Premise_s__c != NULL){
            if(accountDetails.Warehouse_Premise_s__c == 'Rented'){
                jsonGen.writeStringField('warehouse_p_rented','R');
            }else if(accountDetails.Warehouse_Premise_s__c == 'Owned'){
                jsonGen.writeStringField('warehouse_p_rented','O');
            }else if(accountDetails.Warehouse_Premise_s__c == 'Managed by Others'){
                jsonGen.writeStringField('warehouse_p_rented','M');
            }
        }
        
        if(accountDetails.Business_Premise_s__c != NULL){
            if(accountDetails.Business_Premise_s__c == 'Rented'){
                jsonGen.writeStringField('business_p_rented','R');
            }else if(accountDetails.Business_Premise_s__c == 'Owned'){
                jsonGen.writeStringField('business_p_rented','O');
            }
        }
        
        if(accountDetails.Have_CC_Overdraft_account__c != NULL){
            if(accountDetails.Have_CC_Overdraft_account__c == true){
                jsonGen.writeStringField('ccod','Y');
            }else{
                jsonGen.writeStringField('ccod','N');
            }
        }
        
        if(appDetails.genesis__Loan_Amount__c != NULL){
        String loanAmount =    String.valueOf(appDetails.genesis__Loan_Amount__c); 
        loanAmount  = loanAmount.substringBefore('.');
        jsonGen.writeNumberField('loan_amount',Integer.valueOf(loanAmount));    
        }
        
        if(appDetails.genesis__Term__c != NULL){
        String loanTenure =    String.valueOf(appDetails.genesis__Term__c); 
        loanTenure  = loanTenure.substringBefore('.');  
        jsonGen.writeNumberField('loan_tenure',Integer.valueOf(loanTenure));
        }
        
        if(accountDetails.Company_State__c != NULL){
        jsonGen.writeStringField('company_state',accountDetails.Company_State__c);
        }
        if(accountDetails.Company_City__c != NULL){
        jsonGen.writeStringField('company_city',accountDetails.Company_City__c);
        }
        if(accountDetails.Pin_code__c != NULL){
        jsonGen.writeStringField('pin_code',String.valueOf(accountDetails.Pin_code__c));
        }
        if(accountDetails.Alternate_contact_number__c != NULL){
        jsonGen.writeStringField('alternate_number',accountDetails.Alternate_contact_number__c);
        }
        //jsonGen.writeStringField('profile','1');
        
        jsonGen.writeFieldName('address');
        jsonGen.writeStartObject();
        if(accountDetails.Company_Address__c != NULL){
        jsonGen.writeStringField('office_addr',(accountDetails.Company_Address__c));
        }
        jsonGen.writeEndObject();
        /*Primary Marketplace Details : START*/
        /*if(accountDetails.Primary_Marketplace__c != NULL){
        jsonGen.writeStringField('primary_market',(accountDetails.Primary_Marketplace__c));
        }*/
        
        if(accountDetails.Merchant_ID_1__c != NULL){
        jsonGen.writeStringField('primary_merchant',accountDetails.Merchant_ID_1__c);
        }
        if(accountDetails.Primary_Marketplace_Experience__c != NULL){
            if((accountDetails.Primary_Marketplace_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('primary_exp_yr',accountDetails.Primary_Marketplace_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('primary_exp_mnth',accountDetails.Primary_Marketplace_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('primary_exp_yr',accountDetails.Primary_Marketplace_Experience__c);    
                jsonGen.writeStringField('primary_exp_mnth','0');
            }
        }
        /*Primary Marketplace Details : END*/
        
        /*Second Marketplace Details : START*/
        /*if(accountDetails.Second_Marketplace__c != NULL){
        jsonGen.writeStringField('second_market',accountDetails.Second_Marketplace__c);
        }*/
        
        if(accountDetails.Merchant_ID_2__c != NULL){
        jsonGen.writeStringField('second_merchant',accountDetails.Merchant_ID_2__c);
        }
        
        if(accountDetails.Second_Marketplace_Experience__c != NULL){
            if((accountDetails.Second_Marketplace_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('second_exp_yr',accountDetails.Second_Marketplace_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('second_exp_mnth',accountDetails.Second_Marketplace_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('second_exp_yr',accountDetails.Second_Marketplace_Experience__c);  
                jsonGen.writeStringField('second_exp_mnth','0');
            }
        }
        
        /*Second Marketplace Details : END*/
        
        /*Third Marketplace Details : START*/
        /*if(accountDetails.Third_Marketplace__c != NULL){
        jsonGen.writeStringField('third_market',accountDetails.Third_Marketplace__c);
        }*/
        
        if(accountDetails.Merchant_ID_3__c != NULL){
        jsonGen.writeStringField('third_merchant',accountDetails.Merchant_ID_3__c);
        }
        if(accountDetails.Third_Marketplace_Experience__c != NULL){
            if((accountDetails.Third_Marketplace_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('third_exp_yr',accountDetails.Third_Marketplace_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('third_exp_mnth',accountDetails.Third_Marketplace_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('third_exp_yr',accountDetails.Third_Marketplace_Experience__c);    
                jsonGen.writeStringField('third_exp_mnth','0');
            }
        }
        /*Third Marketplace Details : END*/
        
        /*Other Marketplace Details : START*/
        /*if(accountDetails.Other_Marketplace__c != NULL){
        jsonGen.writeStringField('other_market',accountDetails.Other_Marketplace__c);
        }*/
        
        if(accountDetails.Merchant_ID_4__c != NULL){
        jsonGen.writeStringField('other_merchant',accountDetails.Merchant_ID_4__c);
        }
        
        if(accountDetails.Other_Marketplace_Experience__c != NULL){
            if((accountDetails.Other_Marketplace_Experience__c).contains('.'))
            {
                jsonGen.writeStringField('other_exp_yr',accountDetails.Other_Marketplace_Experience__c.subStringBefore('.'));
                jsonGen.writeStringField('other_exp_mnth',accountDetails.Other_Marketplace_Experience__c.subStringAfter('.'));
            }
            else
            {
                jsonGen.writeStringField('other_exp_yr',accountDetails.Other_Marketplace_Experience__c);    
                jsonGen.writeStringField('other_exp_mnth','0');
            }
        }
        /*Other Marketplace Details : END*/
        if(bankDetails.loan__Bank_Account_Number__c != NULL){
        jsonGen.writeStringField('bank_account_number',bankDetails.loan__Bank_Account_Number__c);
        }
        
        if(bankDetails.Bank_IFSC_Code__c != NULL){
        jsonGen.writeStringField('ifsc_code',bankDetails.Bank_IFSC_Code__c);
        }
        
        if(bankDetails.loan__Bank_Name__c != NULL){
        jsonGen.writeStringField('bankname',bankDetails.loan__Bank_Name__c);
        }
        if(bankDetails.loan__Account_Type__c != NULL){
        jsonGen.writeStringField('account_type',bankDetails.loan__Account_Type__c);
        }
        if(accountDetails.Source__c != NULL){
        jsonGen.writeStringField('source',accountDetails.Source__c);
        }
        
        if(accountDetails.Source_sub_category__c != NULL){
        jsonGen.writeStringField('sub_source',accountDetails.Source_sub_category__c);
        }
        
        if(accountDetails.If_others_Please_mention__c != NULL){
        jsonGen.writeStringField('others',accountDetails.If_others_Please_mention__c);
        }
        
        if(accountDetails.Facebook_Profile_URL__c != NULL){
        jsonGen.writeStringField('facebook_url',accountDetails.Facebook_Profile_URL__c);
        }
        
        if(accountDetails.LinkedIn_Profile_URL__c != NULL){
        jsonGen.writeStringField('linkedin_url',accountDetails.LinkedIn_Profile_URL__c);
        }
        
        if(accountDetails.Twitter_Profile_URL__c != NULL){
        jsonGen.writeStringField('twitter_url',accountDetails.Twitter_Profile_URL__c);
        }
        
        jsonGen.writeFieldName('references');
        jsonGen.writeStartArray();
        jsonGen.writeStartObject();
            if(accountDetails.Full_name_of_reference_1__c != NULL)
                jsonGen.writeStringField('full_name',accountDetails.Full_name_of_reference_1__c);
            if(accountDetails.Email_ID_of_reference_1__c != NULL)   
                jsonGen.writeStringField('email_id',accountDetails.Email_ID_of_reference_1__c);
            if(accountDetails.Mobile_number_of_reference_1__c != NULL)  
                jsonGen.writeStringField('mobile',accountDetails.Mobile_number_of_reference_1__c);
            if(accountDetails.Address_of_reference_1__c != NULL)    
                jsonGen.writeStringField('address',accountDetails.Address_of_reference_1__c);
            if(accountDetails.State_of_reference_1__c != NULL)  
                jsonGen.writeStringField('state',accountDetails.State_of_reference_1__c);
            if(accountDetails.City_of_Reference_1__c != NULL)   
                jsonGen.writeStringField('city',accountDetails.City_of_Reference_1__c);
            if(accountDetails.Pincode_of_reference_1__c != NULL)    
                jsonGen.writeStringField('pincode',accountDetails.Pincode_of_reference_1__c);   
        jsonGen.writeEndObject();
        jsonGen.writeStartObject();
            if(accountDetails.Full_name_of_reference_2__c != NULL)
                jsonGen.writeStringField('full_name',accountDetails.Full_name_of_reference_2__c);
            if(accountDetails.Email_ID_of_reference_2__c != NULL)   
                jsonGen.writeStringField('email_id',accountDetails.Email_ID_of_reference_2__c);
            if(accountDetails.Mobile_number_of_reference_2__c != NULL)  
                jsonGen.writeStringField('mobile',accountDetails.Mobile_number_of_reference_2__c);
            if(accountDetails.Address_of_reference_2__c != NULL)    
                jsonGen.writeStringField('address',accountDetails.Address_of_reference_2__c);
            if(accountDetails.State_of_reference_2__c != NULL)  
                jsonGen.writeStringField('state',accountDetails.State_of_reference_2__c);
            if(accountDetails.City_of_Reference_2__c != NULL)   
                jsonGen.writeStringField('city',accountDetails.City_of_Reference_2__c);
            if(accountDetails.Pincode_of_reference_2__c != NULL)    
                jsonGen.writeStringField('pincode',accountDetails.Pincode_of_reference_2__c);   
        jsonGen.writeEndObject();
        jsonGen.writeEndArray();
        
        
        jsonGen.writeFieldName('negotiators');
        jsonGen.writeStartArray();
        jsonGen.writeStartObject();
            if(partnerOneContactDetails.FirstName != NULL)
                jsonGen.writeStringField('first_name',partnerOneContactDetails.FirstName);
            if(partnerOneContactDetails.Middle_Name__c != NULL)
                jsonGen.writeStringField('middle_name',partnerOneContactDetails.Middle_Name__c);
            if(partnerOneContactDetails.LastName != NULL)
                jsonGen.writeStringField('last_name',partnerOneContactDetails.LastName);
            if(partnerOneContactDetails.Gender__c != NULL)
                jsonGen.writeStringField('gender',(partnerOneContactDetails.Gender__c).substring(0,1));
            if(partnerOneContactDetails.BirthDate != NULL)
                jsonGen.writeStringField('dob',String.valueOf(partnerOneContactDetails.BirthDate));
            if(partnerOneContactDetails.Permanent_Account_Number_PAN__c != NULL)
                jsonGen.writeStringField('pan',partnerOneContactDetails.Permanent_Account_Number_PAN__c);
            if(partnerOneContactDetails.Voter_ID__c != NULL)
                jsonGen.writeStringField('voter_id',partnerOneContactDetails.Voter_ID__c);
            if(partnerOneContactDetails.Voter_ID_State__c != NULL)
                jsonGen.writeStringField('voter_state',partnerOneContactDetails.Voter_ID_State__c);
            if(partnerOneContactDetails.Driving_License_State__c != NULL)
                jsonGen.writeStringField('dl_licence_state',partnerOneContactDetails.Driving_License_State__c);
            if(partnerOneContactDetails.Driving_License_Number__c != NULL)
                jsonGen.writeStringField('driving_licence',partnerOneContactDetails.Driving_License_Number__c);
            if(partnerOneContactDetails.Passport_Number__c != NULL)
                jsonGen.writeStringField('passport',partnerOneContactDetails.Passport_Number__c);
            if(partnerOneContactDetails.AADHAAR_Number__c != NULL)
                jsonGen.writeStringField('aadhar',String.valueOf(partnerOneContactDetails.AADHAAR_Number__c));
            if(partnerOneContactDetails.MobilePhone != NULL)
                jsonGen.writeStringField('mobile_number',partnerOneContactDetails.MobilePhone);
            if(partnerOneContactDetails.Present_Address__c != NULL)
                jsonGen.writeStringField('address',partnerOneContactDetails.Present_Address__c);
            if(partnerOneContactDetails.Present_Address_State__c != NULL)
                jsonGen.writeStringField('state',partnerOneContactDetails.Present_Address_State__c);
            if(partnerOneContactDetails.Present_Address_City__c != NULL)
                jsonGen.writeStringField('city',partnerOneContactDetails.Present_Address_City__c);
            if(partnerOneContactDetails.Present_Address_Pin_code__c != NULL)
                jsonGen.writeStringField('pincode',partnerOneContactDetails.Present_Address_Pin_code__c);
            if(partnerOneContactDetails.Alternate_contact_number__c != NULL)
                jsonGen.writeStringField('alternate_contact',partnerOneContactDetails.Alternate_contact_number__c);
            if(partnerOneContactDetails.Director_or_Promoter__c != NULL){
                if(partnerOneContactDetails.Director_or_Promoter__c.equals('Director')){
                    jsonGen.writeStringField('director_promotor','D');
                }else if(partnerOneContactDetails.Director_or_Promoter__c.equals('Promoter')){
                    jsonGen.writeStringField('director_promotor','P');
                }
            }
            if(partnerOneContactDetails.DIN_Number__c != NULL)
                jsonGen.writeStringField('din',partnerOneContactDetails.DIN_Number__c);
            if(partnerOneContactDetails.DPIN_Number__c != NULL)
                jsonGen.writeStringField('dpin',partnerOneContactDetails.DPIN_Number__c);
            if(partnerOneContactDetails.Ownership__c != NULL)
                jsonGen.writeStringField('percentage',partnerOneContactDetails.Ownership__c);                                                                                   
        jsonGen.writeEndObject();
        if(partnerTwoContactDetails.FirstName != null){
        jsonGen.writeStartObject();
            if(partnerTwoContactDetails.FirstName != NULL)
                jsonGen.writeStringField('first_name',partnerTwoContactDetails.FirstName);
            if(partnerTwoContactDetails.Middle_Name__c != NULL)
                jsonGen.writeStringField('middle_name',partnerTwoContactDetails.Middle_Name__c);
            if(partnerTwoContactDetails.LastName != NULL)
                jsonGen.writeStringField('last_name',partnerTwoContactDetails.LastName);
            if(partnerTwoContactDetails.Gender__c != NULL)
                jsonGen.writeStringField('gender',(partnerTwoContactDetails.Gender__c).substring(0,1));
            if(partnerTwoContactDetails.BirthDate != NULL)
                jsonGen.writeStringField('dob',String.valueOf(partnerTwoContactDetails.BirthDate));
            if(partnerTwoContactDetails.Permanent_Account_Number_PAN__c != NULL)
                jsonGen.writeStringField('pan',partnerTwoContactDetails.Permanent_Account_Number_PAN__c);
            if(partnerTwoContactDetails.Voter_ID__c != NULL)
                jsonGen.writeStringField('voter_id',partnerTwoContactDetails.Voter_ID__c);
            if(partnerTwoContactDetails.Voter_ID_State__c != NULL)
                jsonGen.writeStringField('voter_state',partnerTwoContactDetails.Voter_ID_State__c);
            if(partnerTwoContactDetails.Driving_License_State__c != NULL)
                jsonGen.writeStringField('dl_licence_state',partnerTwoContactDetails.Driving_License_State__c);
            if(partnerTwoContactDetails.Driving_License_Number__c != NULL)
                jsonGen.writeStringField('driving_licence',partnerTwoContactDetails.Driving_License_Number__c);
            if(partnerTwoContactDetails.Passport_Number__c != NULL)
                jsonGen.writeStringField('passport',partnerTwoContactDetails.Passport_Number__c);
            if(partnerTwoContactDetails.AADHAAR_Number__c != NULL)
                jsonGen.writeStringField('aadhar',String.valueOf(partnerTwoContactDetails.AADHAAR_Number__c));
            if(partnerTwoContactDetails.MobilePhone != NULL)
                jsonGen.writeStringField('mobile_number',partnerTwoContactDetails.MobilePhone);
            if(partnerTwoContactDetails.Present_Address__c != NULL)
                jsonGen.writeStringField('address',partnerTwoContactDetails.Present_Address__c);
            if(partnerTwoContactDetails.Present_Address_State__c != NULL)
                jsonGen.writeStringField('state',partnerTwoContactDetails.Present_Address_State__c);
            if(partnerTwoContactDetails.Present_Address_City__c != NULL)
                jsonGen.writeStringField('city',partnerTwoContactDetails.Present_Address_City__c);
            if(partnerTwoContactDetails.Present_Address_Pin_code__c != NULL)
                jsonGen.writeStringField('pincode',partnerTwoContactDetails.Present_Address_Pin_code__c);
            if(partnerTwoContactDetails.Alternate_contact_number__c != NULL)
                jsonGen.writeStringField('alternate_contact',partnerTwoContactDetails.Alternate_contact_number__c);
            if(partnerTwoContactDetails.Director_or_Promoter__c != NULL){
                if(partnerTwoContactDetails.Director_or_Promoter__c.equals('Director')){
                    jsonGen.writeStringField('director_promotor','D');
                }else if(partnerTwoContactDetails.Director_or_Promoter__c.equals('Promoter')){
                    jsonGen.writeStringField('director_promotor','P');
                }
            }
            if(partnerTwoContactDetails.DIN_Number__c != NULL)
                jsonGen.writeStringField('din',partnerTwoContactDetails.DIN_Number__c);
            if(partnerTwoContactDetails.DPIN_Number__c != NULL)
                jsonGen.writeStringField('dpin',partnerTwoContactDetails.DPIN_Number__c);
            if(partnerTwoContactDetails.Ownership__c != NULL)
                jsonGen.writeStringField('percentage',partnerTwoContactDetails.Ownership__c);    
        jsonGen.writeEndObject();
        }
        jsonGen.writeEndArray();   
         
        jsonGen.writeEndObject();
        jsonGen.close();
        response =  jsonGen.getAsString();
        return response;
    }
    
    public boolean checkIfAnyActiveLoans(Integer userID)
    {
        Boolean loanApplicationStatusNotClosed = false;
        Boolean contractStatusNotClosed        = false;
        
        //Check if the User ID has any loans which are not closed, if so, do not allow loan creation.
        List<genesis__Applications__c> genesisAppList = new List<genesis__Applications__c>();
        try{
        genesisAppList = [SELECT    genesis__Status__c
                          FROM      genesis__Applications__c
                          WHERE     genesis__Account__r.User_ID__c =: userID
                          ORDER BY  CreatedDate
                          DESC];
            if(genesisAppList != NULL && genesisAppList.size()!=0){
                if(!genesisAppList[0].genesis__Status__c.equals(WebServiceConstants.LOAN_APPLICATION_CLOSED_STATUS)){
                    loanApplicationStatusNotClosed = true;  
                }
            }             
          }
          catch(Exception e){} 
         
         List<loan__Loan_Account__c> clContractList = new List<loan__Loan_Account__c>();
         try{
            clContractList   =   [SELECT        loan__Loan_Status__c
                                  FROM          loan__Loan_Account__c
                                  WHERE         loan__Account__r.User_ID__c =: userID
                                  ORDER BY      CreatedDate
                                  DESC];
                                  
             if(clContractList != NULL && clContractList.size() != 0){
                if(!clContractList[0].loan__Loan_Status__c.equals(WebServiceConstants.CL_CONTRACT_CLOSED_STATUS)){
                    contractStatusNotClosed = true; 
                }
            }                           
         }catch(Exception e){}
        
        if(loanApplicationStatusNotClosed || contractStatusNotClosed){
             return true;
        }       
        else
             return false;
    }
  
       
}