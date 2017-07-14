/*****************************************************************************************************************************
Name of the Class : CreateTestData
Created By : Gautam Kasukhela
Created Date : 15th April, 2016
Description of the class : This class is primarily used to create test data for test classes of Web services.
*******************************************************************************************************************************/
@isTest
global class CreateTestData {
    
    global static Id createAccountForPersonalLoan(){
        Account dummyAccount = new Account(Name = 'Test Account',Email_ID__c = 'test@test.com', Phone = '00998877665',
                                Type_of_Loan__c = WebServiceConstants.PERSONAL_LOAN,User_ID__c = 1234567891,Prospect_Number__c = 'ASW34AA');
        upsert dummyAccount;                        
        return dummyAccount.Id;
    }
    
    global static Account createAccountForAPersonalLoan(){
        Account dummyAccount = new Account(Name = 'Test Account',Email_ID__c = 'test@test.com', Phone = '00998877665',
                                Type_of_Loan__c = WebServiceConstants.PERSONAL_LOAN,User_ID__c = 1234567891,Prospect_Number__c = 'ASW34AA');
        upsert dummyAccount;                        
        return dummyAccount;
    }
    
    global static Account createAccountForBusinessLoan()
    {
        Account accTest = new Account();
        accTest.Name                                            = 'test';
        accTest.Legal_Entity_Type__c                            = 'Partnership'; 
        accTest.Number_of_Directors_Partners_Members__c         = '2';
        accTest.Date_of_Inception__c                            = date.ValueOf('2016-04-21');
        accTest.Company_Permanent_Account_Number_PAN__c         = 'CEZPS1232C';
        accTest.CST_Number__c                                   = '121212';                 
        accTest.Have_CC_Overdraft_account__c                    = true;
        accTest.Company_Address__c                              = 'Test Address';
        accTest.Company_City__c                                 = 'TestCity';
        accTest.Pin_code__c                                     = 110011;
        accTest.Phone                                           = '12121212';
        accTest.Alternate_contact_number__c                     = '21212121';  
        accTest.Email_ID__c                                     = 'testmail@mail.com';
        accTest.Business_Premise_s__c                           = 'Rented';
        accTest.Warehouse_Premise_s__c                          = 'Rented';
        accTest.Primary_Marketplace__c                          = 'Uber';
        accTest.Merchant_ID_1__c                                = 'as2112sa';
        accTest.Type_of_Loan__c                                 = 'Business';
        accTest.User_ID__c                                      = 1234567891;
        accTest.Prospect_Number__c                              = 'ASW34AA';
        accTest.Social_Details_Score__c                         = 750;
        accTest.Account_Status__c                               = 'Active';  
        upsert accTest;  
        return accTest;
     }
     
    /*For a Sole propreitor Business Loan*/
    global static Account createAccountForSPBusinessLoan()
    {
        Account accTest = new Account();
        accTest.Name                                            = 'test';
        accTest.Legal_Entity_Type__c                            = 'Sole Proprietorship'; 
        accTest.Number_of_Directors_Partners_Members__c         = '2';
        accTest.Date_of_Inception__c                            = date.ValueOf('2016-04-21');
        accTest.Company_Permanent_Account_Number_PAN__c         = 'CEZPS1232C';
        accTest.CST_Number__c                                   = '121212';                 
        accTest.VAT_Number__c                                   = '121212';
        accTest.Have_CC_Overdraft_account__c                    = true;
        accTest.Company_Address__c                              = 'Test Address';
        accTest.Company_City__c                                 = 'TestCity';
        accTest.Pin_code__c                                     = 110011;
        accTest.Phone                                           = '12121212';
        accTest.Alternate_contact_number__c                     = '21212121';  
        accTest.Email_ID__c                                     = 'testmail@mail.com';
        accTest.Business_Premise_s__c                           = 'Rented';
        accTest.Warehouse_Premise_s__c                          = 'Rented';
        accTest.Primary_Marketplace__c                          = 'Uber';
        accTest.Merchant_ID_1__c                                = 'as2112sa';
        accTest.Second_Marketplace__c                           = 'Uber';
        accTest.Merchant_ID_2__c                                = 'as2112sa';
        accTest.Third_Marketplace__c                            = 'Uber';
        accTest.Merchant_ID_3__c                                = 'as2112sa';   
        accTest.Other_Marketplace__c                            = 'Uber';
        accTest.Merchant_ID_4__c                                = 'as2112sa';
        accTest.Facebook_Profile_URL__c                         = 'fb'; 
        accTest.Twitter_Profile_URL__c                          = 'tweet';  
        accTest.LinkedIn_Profile_URL__c                         = 'link';
        accTest.Type_of_Loan__c                                 = 'Business';
        accTest.User_ID__c                                      = 1234567891;
        accTest.Prospect_Number__c                              = 'ASW34AA';
        accTest.Social_Details_Score__c                         = 750;
        upsert accTest;  
        return accTest;
    }
         
    /*For a LLP Business Loan*/
    global static Account createAccountForOtherBusinessLoan()
    {
        Account accTest = new Account();
        accTest.Name                                            = 'test';
        accTest.Legal_Entity_Type__c                            = 'LLP'; 
        accTest.Number_of_Directors_Partners_Members__c         = '2';
        accTest.Date_of_Inception__c                            = date.ValueOf('2016-04-21');
        accTest.Company_Permanent_Account_Number_PAN__c         = 'CEZPS1232C';
        accTest.CST_Number__c                                   = '121212';                 
        accTest.VAT_Number__c                                   = '121212';
        accTest.Have_CC_Overdraft_account__c                    = true;
        accTest.Company_Address__c                              = 'Test Address';
        accTest.Company_City__c                                 = 'TestCity';
        accTest.Pin_code__c                                     = 110011;
        accTest.Phone                                           = '8899898989';
        accTest.Alternate_contact_number__c                     = '21212121';  
        accTest.Email_ID__c                                     = 'testmail@mail.com';
        accTest.Business_Premise_s__c                           = 'Rented';
        accTest.Warehouse_Premise_s__c                          = 'Rented';
        accTest.Primary_Marketplace__c                          = 'Uber';
        accTest.Merchant_ID_1__c                                = 'as2112sa';
        accTest.Second_Marketplace__c                           = 'Uber';
        accTest.Merchant_ID_2__c                                = 'as2112sa';
        accTest.Third_Marketplace__c                            = 'Uber';
        accTest.Merchant_ID_3__c                                = 'as2112sa';   
        accTest.Other_Marketplace__c                            = 'Uber';
        accTest.Merchant_ID_4__c                                = 'as2112sa';
        accTest.Facebook_Profile_URL__c                         = 'fb'; 
        accTest.Twitter_Profile_URL__c                          = 'tweet';  
        accTest.LinkedIn_Profile_URL__c                         = 'link';
        accTest.Type_of_Loan__c                                 = 'Business';
        accTest.User_ID__c                                      = 1234567892;
        accTest.Prospect_Number__c                              = 'ASW34AA';
        accTest.Social_Details_Score__c                         = 750;
        upsert accTest;  
        return accTest;
     }
    
    global static Contact createContact()
    {
        Contact conTest = new Contact();
        conTest.FirstName = 'FNameTest';
        conTest.Middle_Name__c = 'MNameTest';
        conTest.LastName = 'LNameTest';
        conTest.Gender__c = 'MALE';
        conTest.Birthdate = date.ValueOf('1988-12-18');
        conTest.Email = 'testmail@mail.com';
        conTest.MobilePhone = '1234567890';
        conTest.Permanent_Account_Number_PAN__c = 'CEZPE1234W';
        conTest.AADHAAR_Number__c = 1221122112;
        conTest.Voter_ID__c = 'ASD123ERSA';
        conTest.Voter_ID_State__c = 'Assam';
        conTest.Voter_ID_District__c = 'Test';
        conTest.Passport_Number__c = 'J2133DD4';
        conTest.Driving_License_State__c = 'Assam';
        conTest.Driving_License_Number__c = 'J121212';
        conTest.Permanent_Address__c = 'Test';
        conTest.Permanent_Address_City__c = 'TestCity';
        conTest.Permanent_Address_State__c = 'Assam';
        conTest.Permanent_Address_Pin_code__c = '121212';
        conTest.Present_Address__c = 'Test';                   
        conTest.Present_Address_City__c = 'TestCt';
        conTest.Present_Address_State__c = 'Assam';
        conTest.Present_Address_Pin_code__c = '112211';
        conTest.Registered_in_market_place_or_employer__c = 'Employer Linked';
        conTest.Alternate_contact_number__c = '12121212';
        conTest.Employment_ID__c = 'ASD2345';
        conTest.Employer_Name__c = 'Uber'; 
        conTest.Official_Email_ID__c = 'testOfficial@mail.com';
        conTest.Total_Experience__c = '5';
        conTest.Primary_Marketplace__c = 'Flipkart';
        conTest.Primary_Marketplace_Merchant_ID__c = '121212';
        conTest.Second_Marketplace__c = 'Flipkart';
        conTest.Second_Marketplace_Merchant_ID__c = '121212';
        conTest.Third_Marketplace__c = 'Flipkart';
        conTest.Third_Marketplace_Merchant_ID__c = '121212';
        conTest.Marketplace_Experience__c   =   '1';
        conTest.Facebook_Profile_URL__c =   'fb';
        conTest.Twitter_Profile_URL__c  =   'tweet';
        conTest.LinkedIn_Profile_URL__c =   'link';
        conTest.Full_name_of_reference_1__c =   'A';
        conTest.Email_ID_of_reference_1__c  =   'E@a.com';
        conTest.Address_of_reference_1__c   =   'A1';
        conTest.Mobile_number_of_reference_1__c =   '234555';
        conTest.Full_name_of_reference_2__c =   'R2';
        conTest.Email_ID_of_reference_2__c  =   'r2@er.com';
        conTest.Address_of_reference_2__c   =   'A2';
        conTest.Mobile_number_of_reference_2__c =   '433323';
        conTest.If_others_Please_mention__c =   'No';
        conTest.Gmail_ID__c = 'test@gmail.com';
        conTest.Do_you_live_in__c = 'Rented';
        conTest.Source__c = 'Event';
        conTest.Source_sub_category__c = 'Google';
        conTest.Director_or_Promoter__c =   'Director';
        conTest.DIN_Number__c   =   'ASDF34';
        conTest.DPIN_Number__c  =   '876GHT';
        
        upsert conTest;
        return conTest;
    } 


    global static Id createContact(Id accountIDFromTestClass){
        Id accountId = accountIDFromTestClass;
        Contact dummyContact = new Contact();
        dummyContact.LastName = 'Peter';
        dummyContact.AccountId=accountId;
        dummyContact.Permanent_Account_Number_PAN__c='ASWER7865L';
        dummyContact.Do_you_live_in__c='Rented';
        dummyContact.Authorized_Signatory__c='Yes';
        dummyContact.Permanent_Address__c='My address';
        dummyContact.Permanent_Address_City__c='Paris';
        dummyContact.Permanent_Address_State__c='Paris';
        dummyContact.Permanent_Address_Pin_code__c='345656';
        dummyContact.Registered_in_market_place_or_employer__c='Employer Linked';
        dummyContact.Employer_Name__c='Ola Cabs';
        dummyContact.Employment_ID__c= '123456';
        dummyContact.Total_Experience__c = '4.5';
        upsert dummyContact;
        return dummyContact.Id;
    } 
    
    /*Create Bank Account Test Data*/
    global static loan__Bank_Account__c createBankAccount(Id accountId)
    {
        loan__Bank_Account__c  bankAccount          = new loan__Bank_Account__c();
        bankAccount.loan__Bank_Name__c              = 'HDFC';
        bankAccount.Bank_IFSC_Code__c               = 'HDF009';
        bankAccount.loan__Bank_Account_Number__c    = '0152342132';
        bankAccount.loan__Active__c                 = true;
        bankAccount.loan__Account__c                = accountId;
        upsert bankAccount;
        return bankAccount;
    } 
  
    /*Create genesis loan application*/
    global static genesis__Applications__c createLoanApplication(Id accountId, Id contactId, Id bankAccountId,String prospectNumber)
    {
        genesis__Applications__c    app     =   new     genesis__Applications__c();
        app.genesis__Loan_Amount__c         =   200000;
        app.genesis__Term__c                =   2;
        app.genesis__Account__c             =   accountId;
        app.genesis__Contact__c             =   contactId;
        app.Prospect_Number__c              =   prospectNumber;
        app.genesis__Status__c              =   WebServiceConstants.NEWLY_ENTERED_APPLICATION;
        app.BankAccount__c                  =   bankAccountId;
        upsert app; 
        return app;
    }
     
    /*Create genesis loan application*/
    global static genesis__Applications__c createLoanApplicationWithDiffStatus(Id accountId, Id contactId, Id bankAccountId,String prospectNumber)
    {
        genesis__Applications__c    app     =   new     genesis__Applications__c();
        app.genesis__Loan_Amount__c         =   200000;
        app.genesis__Term__c                =   2;
        app.genesis__Account__c             =   accountId;
        app.genesis__Contact__c             =   contactId;
        app.Prospect_Number__c              =   prospectNumber;
        app.genesis__Status__c              =   WebServiceConstants.AWAITING_CUSTOMER_TO_ACCEPT;
        app.BankAccount__c                  =   bankAccountId;
        upsert app; 
        return app;
    }
    
     /*Create genesis loan application*/
    global static genesis__Applications__c createLoanApplicationWithClosedStatus(Id accountId, Id contactId, Id bankAccountId,String prospectNumber)
    {
        genesis__Applications__c    app     =   new     genesis__Applications__c();
        app.genesis__Loan_Amount__c         =   200000;
        app.genesis__Term__c                =   2;
        app.genesis__Account__c             =   accountId;
        app.genesis__Contact__c             =   contactId;
        app.Prospect_Number__c              =   prospectNumber;
        app.Email_ID__c                     =   'a@b.com';
        app.genesis__Status__c              =   WebServiceConstants.LOAN_APPLICATION_CLOSED_STATUS;
        app.BankAccount__c                  =   bankAccountId;
        upsert app; 
        return app;
    }
     
    /*Create a Scorecard record for a Business Loan*/
    global static genesis__Scorecard__c  createSocrecardForBusinessLoan(){
        
        genesis__Scorecard__c       score   =   new genesis__Scorecard__c();
        score.Name                          =   'Business';
        score.genesis__Object_Type__c       =   'genesis__Applications__c';
        score.genesis__Total_Weight__c      =   4.0;
        upsert score;
        return score;
    }
     
    /*Create a Scorecard record for a Employer Linked Personal Loan*/
    global static genesis__Scorecard__c  createSocrecardForELPersonalLoan(){
        
        genesis__Scorecard__c       score   =   new genesis__Scorecard__c();
        score.Name                          =   'Personal Employer Linked';
        score.genesis__Object_Type__c       =   'genesis__Applications__c';
        score.genesis__Total_Weight__c      =   4.0;
        upsert score;
        return score;
     }
     
     /*Create a Scorecard record for a Market place Linked Personal Loan*/
     global static genesis__Scorecard__c  createSocrecardForMPPersonalLoan(){
        
        genesis__Scorecard__c       score   =   new genesis__Scorecard__c();
        score.Name                          =   'Personal Marketplace Linked';
        score.genesis__Object_Type__c       =   'genesis__Applications__c';
        score.genesis__Total_Weight__c      =   4.0;
        upsert score;
        return score;
     }
     
    /* Create Loan Contract */
    global static loan__Loan_Account__c CreateloanAccount(){
        //Setup seed data
        TestHelper testhelp = new TestHelper();        
        TestHelper.setupORGParameters();
        
        loan.TestHelper.systemDate = Date.newInstance(2016, 6, 20); // June 20 - Monday
        List<loan__Payment_Mode__c> pModes = new List<loan__Payment_Mode__c>();
        loan__Payment_Mode__c dummyPM = new loan__Payment_Mode__c(name='dummyPM');
        pModes.add(dummyPM);
        loan__Payment_Mode__c dummyPM2 = new loan__Payment_Mode__c(name='Check');
        pModes.add(dummyPM2);
        loan__Payment_Mode__c dummyPM3 = new loan__Payment_Mode__c(name='Cash');
        pModes.add(dummyPM3);
        loan__Payment_Mode__c dummyPM4 = new loan__Payment_Mode__c(name='ACH');
        pModes.add(dummyPM4);
        loan__Payment_Mode__c dummyPM5 = new loan__Payment_Mode__c(name='Wire');
        pModes.add(dummyPM5);
        loan__Payment_Mode__c dummyPM6 = new loan__Payment_Mode__c(name='Excess');
        pModes.add(dummyPM6);
        loan__Payment_Mode__c dummyPM7 = new loan__Payment_Mode__c(name='Mobile');
        pModes.add(dummyPM7);
        insert pModes;

        //Create a Currency
        loan__Currency__c curr = loan.TestHelper.createCurrency();

        //Create a dummy MF_Account
        loan__MF_Account__c dummyAccount    = loan.TestHelper.createMFAccount('XXXAccountForTest', '10000 - ASSETS');
        loan__MF_Account__c dummyIncAccount = loan.TestHelper.createMFAccount('XXXIncAccountForTest', '30000 - INCOME');
        
        //Create a Fee Set
        loan__Fee__c dummyFee           = loan.TestHelper.createFee(curr, dummyIncAccount, dummyAccount);
        loan__Fee_Set__c dummyFeeSet    = loan.TestHelper.createFeeSet();
        dummyFeeSet.Name                = 'MO';
        upsert dummyFeeSet;
        
        //Create a Fee Junction
        loan__Fee_Junction__c dummyFeeJunction = loan.TestHelper.createFeeJunction(dummyFee, dummyFeeSet);
        
        //Create a Bank
        loan__Bank__c bank = loan.TestHelper.createBank();
        
        //Create a Office
        loan__Office_Name__c dummyOffice    = loan.TestHelper.createOffice();
        dummyOffice.loan__Branch_s_Bank__c  = bank.id;
        
        //Create a dummy Loan Product
        loan__Loan_Product__c dummyLP;
        RecordType loanRecordType;
        String productType;
        String productName  = 'TestLP';
        loanRecordType      = [Select Id from RecordType where DeveloperName =: loan.LoanConstants.LOAN_PRODUCT_RT and SObjectType =: 'loan__Loan_Product__c'];     
        productType         = loan.LoanConstants.LOAN;
        dummyLP = new loan__Loan_Product__c(Name                                            = productName,
                                            RecordTypeId                                    = loanRecordType.Id,
                                            loan__Loan_Product_Type__c                      = productType,
                                            loan__Loan_Cycle_Setup__c                       = loan.LoanConstants.LOAN_ATTRIBUTES_SAME_FOR_ALL_LOANS,
                                            loan__Currency__c                               = curr.ID,
                                            loan__Fee_Set__c                                = dummyFeeSet.ID,
                                            loan__Accrual_Based_Accounting__c               = true,
                                            loan__Accrue_Income_On_Suspended_Account__c     = true,
                                            loan__Approval_Date__c                          = getCurrentSystemDate()-50,
                                            loan__Cash_Based_Accounting__c                  = false,
                                            loan__Default_Interest_Rate__c                  = 20,
                                            loan__Default_Number_of_Installments__c         = 20,
                                            loan__Interest_Rate_Type__c                     = 'Declining Balance',
                                            loan__Maximum_Gap_Between_Installments__c       = 1,
                                            loan__Minimum_Gap_Between_Installments__c       = 1,
                                            loan__Max_Interest_Rate__c                      = 25,
                                            loan__Max_Loan_Amount__c                        = 30000000,
                                            loan__Max_Number_of_Installments__c             = 26,
                                            loan__Max_Overdue_Interest_Rate__c              = 24,
                                            loan__Minimum_Installment_Amount__c             = 100,
                                            loan__Minimum_Draw_Amount__c                    = 0,
                                            loan__Maximum_Draw_Amount__c                    = 30000000,
                                            loan__Draw_Billing_Method__c                    = 'Interest Only',
                                            loan__Draw_Term_Payment_Percent__c              = 1,
                                            loan__Repayment_Billing_Method__c               ='Principal Plus Interest',
                                            loan__Repayment_Term_Payment_Percent__c         = 9.25,
                                            loan__Min_Interest_Rate__c                      = 1,
                                            loan__Min_Loan_Amount__c                        = 1,
                                            loan__Min_Number_of_Installments__c             = 0,
                                            loan__Min_Overdue_Interest_Rate__c              = 10,
                                            loan__Product_Interest_Income_Account__c        = dummyAccount.ID,
                                            loan__Product_Int_On_Overdue_Income_Acc__c      = dummyAccount.ID,
                                            loan__Product_Loan_Control_Account__c           = dummyAccount.ID,
                                            loan__Product_Loan_Loss_Provision_Account__c    = dummyAccount.ID,
                                            loan__Product_Loan_Loss_Reserve_Account__c      = dummyAccount.ID,
                                            loan__Product_Overdue_Interest_Account__c       = dummyAccount.ID,
                                            loan__Product_Suspended_Interest_Account__c     = dummyAccount.ID,
                                            loan__Product_Suspended_Int_On_Overdue_Acc__c   = dummyAccount.ID,
                                            loan__Product_Write_Off_Recovery_Account__c     =   dummyAccount.ID,
                                            loan__Product_Interest_Amortization_Account__c  = dummyAccount.ID,
                                            loan__Product_Excess_Account__c                 = dummyAccount.ID,
                                            loan__Status__c                                 = 'Active',
                                            loan__Late_Charge_Grace_Days__c                 = 1,
                                            loan__Delinquency_Grace_Days__c                 = 5
                                            );
        insert dummyLP;
        
        //Create a Loan Purpose
        loan__Loan_Purpose__c dummyLoanPurpose = loan.TestHelper.createLoanPurpose();
        
        //Create a Account
        Account accnt               = createAccountForBusinessLoan();
        
        //Create a Bank Account
        loan__Bank_Account__c dummyBank = createBankAccount(accnt.Id);
        
        //Create a Contact
        Contact c       = CreateTestData.createContact();
        Id contactId    = c.Id;
        c.AccountId     = accnt.Id;
        c.Id            = contactId;    
        upsert c;
        
        //Create a dummy genesis Application
        genesis__Applications__c genesisApp = createLoanApplication(accnt.Id,contactId,dummyBank.Id,accnt.Prospect_Number__c);
        
        //Create a dummy Loan Account
        loan__Loan_Account__c loanAccount       = TestHelper.createLoanAccountForContact(dummyLP,
                                                                                         c,
                                                                                         dummyFeeSet,
                                                                                         dummyLoanPurpose,
                                                                                         dummyOffice);
        loanAccount.Prospect_Number__c          = 'ASW34AA';
        loanAccount.loan__Account__c            = accnt.Id;
        loanAccount.Loan_Application__c         = genesisApp.Id;
        loanAccount.loan__Application_Date__c   = getCurrentSystemDate();
        upsert loanAccount;                                                                                                                     
        
        return loanAccount;    
    }
    /*Create a Loan Contract with status as CLOSED*/
     /* Create Loan Contract */
    global static loan__Loan_Account__c CreateClosedloanAccount(){
        //Setup seed data
        TestHelper testhelp = new TestHelper();        
        TestHelper.setupORGParameters();
        
        loan.TestHelper.systemDate = Date.newInstance(2016, 6, 20); // June 20 - Monday
        List<loan__Payment_Mode__c> pModes = new List<loan__Payment_Mode__c>();
        loan__Payment_Mode__c dummyPM = new loan__Payment_Mode__c(name='dummyPM');
        pModes.add(dummyPM);
        loan__Payment_Mode__c dummyPM2 = new loan__Payment_Mode__c(name='Check');
        pModes.add(dummyPM2);
        loan__Payment_Mode__c dummyPM3 = new loan__Payment_Mode__c(name='Cash');
        pModes.add(dummyPM3);
        loan__Payment_Mode__c dummyPM4 = new loan__Payment_Mode__c(name='ACH');
        pModes.add(dummyPM4);
        loan__Payment_Mode__c dummyPM5 = new loan__Payment_Mode__c(name='Wire');
        pModes.add(dummyPM5);
        loan__Payment_Mode__c dummyPM6 = new loan__Payment_Mode__c(name='Excess');
        pModes.add(dummyPM6);
        loan__Payment_Mode__c dummyPM7 = new loan__Payment_Mode__c(name='Mobile');
        pModes.add(dummyPM7);
        insert pModes;

        //Create a Currency
        loan__Currency__c curr = loan.TestHelper.createCurrency();

        //Create a dummy MF_Account
        loan__MF_Account__c dummyAccount    = loan.TestHelper.createMFAccount('XXXAccountForTest', '10000 - ASSETS');
        loan__MF_Account__c dummyIncAccount = loan.TestHelper.createMFAccount('XXXIncAccountForTest', '30000 - INCOME');
        
        //Create a Fee Set
        loan__Fee__c dummyFee           = loan.TestHelper.createFee(curr, dummyIncAccount, dummyAccount);
        loan__Fee_Set__c dummyFeeSet    = loan.TestHelper.createFeeSet();
        dummyFeeSet.Name                = 'MO';
        upsert dummyFeeSet;
        
        //Create a Fee Junction
        loan__Fee_Junction__c dummyFeeJunction = loan.TestHelper.createFeeJunction(dummyFee, dummyFeeSet);
        
        //Create a Bank
        loan__Bank__c bank = loan.TestHelper.createBank();
        
        //Create a Office
        loan__Office_Name__c dummyOffice    = loan.TestHelper.createOffice();
        dummyOffice.loan__Branch_s_Bank__c  = bank.id;
        
        //Create a dummy Loan Product
        loan__Loan_Product__c dummyLP;
        RecordType loanRecordType;
        String productType;
        String productName  = 'TestLP';
        loanRecordType      = [Select Id from RecordType where DeveloperName =: loan.LoanConstants.LOAN_PRODUCT_RT and SObjectType =: 'loan__Loan_Product__c'];     
        productType         = loan.LoanConstants.LOAN;
        dummyLP = new loan__Loan_Product__c(Name                                            = productName,
                                            RecordTypeId                                    = loanRecordType.Id,
                                            loan__Loan_Product_Type__c                      = productType,
                                            loan__Loan_Cycle_Setup__c                       = loan.LoanConstants.LOAN_ATTRIBUTES_SAME_FOR_ALL_LOANS,
                                            loan__Currency__c                               = curr.ID,
                                            loan__Fee_Set__c                                = dummyFeeSet.ID,
                                            loan__Accrual_Based_Accounting__c               = true,
                                            loan__Accrue_Income_On_Suspended_Account__c     = true,
                                            loan__Approval_Date__c                          = getCurrentSystemDate()-50,
                                            loan__Cash_Based_Accounting__c                  = false,
                                            loan__Default_Interest_Rate__c                  = 20,
                                            loan__Default_Number_of_Installments__c         = 20,
                                            loan__Interest_Rate_Type__c                     = 'Declining Balance',
                                            loan__Maximum_Gap_Between_Installments__c       = 1,
                                            loan__Minimum_Gap_Between_Installments__c       = 1,
                                            loan__Max_Interest_Rate__c                      = 25,
                                            loan__Max_Loan_Amount__c                        = 30000000,
                                            loan__Max_Number_of_Installments__c             = 26,
                                            loan__Max_Overdue_Interest_Rate__c              = 24,
                                            loan__Minimum_Installment_Amount__c             = 100,
                                            loan__Minimum_Draw_Amount__c                    = 0,
                                            loan__Maximum_Draw_Amount__c                    = 30000000,
                                            loan__Draw_Billing_Method__c                    = 'Interest Only',
                                            loan__Draw_Term_Payment_Percent__c              = 1,
                                            loan__Repayment_Billing_Method__c               ='Principal Plus Interest',
                                            loan__Repayment_Term_Payment_Percent__c         = 9.25,
                                            loan__Min_Interest_Rate__c                      = 1,
                                            loan__Min_Loan_Amount__c                        = 1,
                                            loan__Min_Number_of_Installments__c             = 0,
                                            loan__Min_Overdue_Interest_Rate__c              = 10,
                                            loan__Product_Interest_Income_Account__c        = dummyAccount.ID,
                                            loan__Product_Int_On_Overdue_Income_Acc__c      = dummyAccount.ID,
                                            loan__Product_Loan_Control_Account__c           = dummyAccount.ID,
                                            loan__Product_Loan_Loss_Provision_Account__c    = dummyAccount.ID,
                                            loan__Product_Loan_Loss_Reserve_Account__c      = dummyAccount.ID,
                                            loan__Product_Overdue_Interest_Account__c       = dummyAccount.ID,
                                            loan__Product_Suspended_Interest_Account__c     = dummyAccount.ID,
                                            loan__Product_Suspended_Int_On_Overdue_Acc__c   = dummyAccount.ID,
                                            loan__Product_Write_Off_Recovery_Account__c     =   dummyAccount.ID,
                                            loan__Product_Interest_Amortization_Account__c  = dummyAccount.ID,
                                            loan__Product_Excess_Account__c                 = dummyAccount.ID,
                                            loan__Status__c                                 = 'Active'
                                            );
        insert dummyLP;
        
        //Create a Loan Purpose
        loan__Loan_Purpose__c dummyLoanPurpose = loan.TestHelper.createLoanPurpose();
        
        //Create a Account
        Account accnt               = createAccountForBusinessLoan();
        
        //Create a Bank Account
        loan__Bank_Account__c dummyBank = createBankAccount(accnt.Id);
        
        //Create a Contact
        Contact c       = CreateTestData.createContact();
        Id contactId    = c.Id;
        c.AccountId     = accnt.Id;
        c.Id            = contactId;    
        upsert c;
        
        //Create a dummy genesis Application
        genesis__Applications__c genesisApp = createLoanApplication(accnt.Id,contactId,dummyBank.Id,accnt.Prospect_Number__c);
        
        //Create a dummy Loan Account
        loan__Loan_Account__c loanAccount       = TestHelper.createLoanAccountForContact(dummyLP,
                                                                                         c,
                                                                                         dummyFeeSet,
                                                                                         dummyLoanPurpose,
                                                                                         dummyOffice);
        loanAccount.Prospect_Number__c          = 'ASW34AA';
        loanAccount.loan__Account__c            = accnt.Id;
        loanAccount.Loan_Application__c         = genesisApp.Id;
        loanAccount.loan__Application_Date__c   = getCurrentSystemDate();
        loanAccount.loan__Loan_Status__c        = WebServiceConstants.CL_CONTRACT_CLOSED_STATUS;
        upsert loanAccount;                                    
        
        return loanAccount;    
    }
     public static loan__Loan_Account__c createLoanContractAndDisbursement()
    {
        //Create a Loan Contract for a BusinessLoan 
        loan__Loan_Account__c clcontract = new loan__Loan_Account__c ();
        try{
        TestHelper testhelp = new TestHelper();        
        TestHelper.setupORGParameters();      
         
        List<loan__Payment_Mode__c> pModes = new List<loan__Payment_Mode__c>();
        loan__Payment_Mode__c dummyPM = new loan__Payment_Mode__c(name='dummyPM');
        pModes.add(dummyPM);
        loan__Payment_Mode__c dummyPM2 = new loan__Payment_Mode__c(name='Check');
        pModes.add(dummyPM2);
        loan__Payment_Mode__c dummyPM3 = new loan__Payment_Mode__c(name='Cash');
        pModes.add(dummyPM3);
        loan__Payment_Mode__c dummyPM4 = new loan__Payment_Mode__c(name='ACH');
        pModes.add(dummyPM4);
        loan__Payment_Mode__c dummyPM5 = new loan__Payment_Mode__c(name='Wire');
        pModes.add(dummyPM5);
        loan__Payment_Mode__c dummyPM6 = new loan__Payment_Mode__c(name='Excess');
        pModes.add(dummyPM6);
        loan__Payment_Mode__c dummyPM7 = new loan__Payment_Mode__c(name='Mobile');
        pModes.add(dummyPM7);
        insert pModes;

        //Create a Currency
        loan__Currency__c curr = loan.TestHelper.createCurrency();

        //Create a dummy MF_Account
        loan__MF_Account__c dummyAccount    = loan.TestHelper.createMFAccount('XXXAccountForTest', '10000 - ASSETS');
        loan__MF_Account__c dummyIncAccount = loan.TestHelper.createMFAccount('XXXIncAccountForTest', '30000 - INCOME');
        
        //Create a Fee Set
        loan__Fee__c dummyFee           = loan.TestHelper.createFee(curr, dummyIncAccount, dummyAccount);
        loan__Fee_Set__c dummyFeeSet    = loan.TestHelper.createFeeSet();
        dummyFeeSet.Name                = 'MO';
        upsert dummyFeeSet;
        
        //Create a Fee Junction
        loan__Fee_Junction__c dummyFeeJunction = loan.TestHelper.createFeeJunction(dummyFee, dummyFeeSet);
        
        //Create a Bank
        loan__Bank__c cbank = loan.TestHelper.createBank();
        
        //Create a Office
        loan__Office_Name__c dummyOffice    = loan.TestHelper.createOffice();
        dummyOffice.loan__Branch_s_Bank__c  = cbank.id;
        dummyOffice.Name                    = 'OptaCredit';
        upsert dummyOffice;
        //Create Loan Purpose
        loan__Loan_Purpose__c purpose = new loan__Loan_Purpose__c();
        purpose.name                  = 'Business';
        purpose.loan__Loan_Purpose_Code__c    = 'Business';
        purpose.loan__Description__c     ='Business';
        insert purpose;
        //Create a dummy Loan Product
        loan__Loan_Product__c dummyLP;
        RecordType loanRecordType;
        String productType;
        String productName  = 'Business Loans/E-Commerce';
        loanRecordType      = [Select Id from RecordType where DeveloperName =: loan.LoanConstants.LOAN_PRODUCT_RT and SObjectType =: 'loan__Loan_Product__c'];     
        productType         = loan.LoanConstants.LOAN;
        dummyLP = new loan__Loan_Product__c(Name                                            = productName,
                                            RecordTypeId                                    = loanRecordType.Id,
                                            loan__Loan_Product_Type__c                      = productType,
                                            loan__Loan_Cycle_Setup__c                       = loan.LoanConstants.LOAN_ATTRIBUTES_SAME_FOR_ALL_LOANS,
                                            loan__Currency__c                               = curr.ID,
                                            loan__Fee_Set__c                                = dummyFeeSet.ID,
                                            loan__Accrual_Based_Accounting__c               = true,
                                            loan__Accrue_Income_On_Suspended_Account__c     = true,
                                            loan__Approval_Date__c                          = CreateTestData.getCurrentSystemDate()-50,
                                            loan__Cash_Based_Accounting__c                  = false,
                                            loan__Default_Interest_Rate__c                  = 20,
                                            loan__Default_Number_of_Installments__c         = 20,
                                            loan__Interest_Rate_Type__c                     = 'Declining Balance',
                                            loan__Maximum_Gap_Between_Installments__c       = 1,
                                            loan__Minimum_Gap_Between_Installments__c       = 1,
                                            loan__Max_Interest_Rate__c                      = 25,
                                            loan__Max_Loan_Amount__c                        = 30000000,
                                            loan__Max_Number_of_Installments__c             = 26,
                                            loan__Max_Overdue_Interest_Rate__c              = 24,
                                            loan__Minimum_Installment_Amount__c             = 100,
                                            loan__Minimum_Draw_Amount__c                    = 0,
                                            loan__Maximum_Draw_Amount__c                    = 30000000,
                                            loan__Draw_Billing_Method__c                    = 'Interest Only',
                                            loan__Draw_Term_Payment_Percent__c              = 1,
                                            loan__Repayment_Billing_Method__c               ='Principal Plus Interest',
                                            loan__Repayment_Term_Payment_Percent__c         = 9.25,
                                            loan__Min_Interest_Rate__c                      = 1,
                                            loan__Min_Loan_Amount__c                        = 1,
                                            loan__Min_Number_of_Installments__c             = 0,
                                            loan__Min_Overdue_Interest_Rate__c              = 10,
                                            loan__Product_Interest_Income_Account__c        = dummyAccount.ID,
                                            loan__Product_Int_On_Overdue_Income_Acc__c      = dummyAccount.ID,
                                            loan__Product_Loan_Control_Account__c           = dummyAccount.ID,
                                            loan__Product_Loan_Loss_Provision_Account__c    = dummyAccount.ID,
                                            loan__Product_Loan_Loss_Reserve_Account__c      = dummyAccount.ID,
                                            loan__Product_Overdue_Interest_Account__c       = dummyAccount.ID,
                                            loan__Product_Suspended_Interest_Account__c     = dummyAccount.ID,
                                            loan__Product_Suspended_Int_On_Overdue_Acc__c   = dummyAccount.ID,
                                            loan__Product_Write_Off_Recovery_Account__c     =   dummyAccount.ID,
                                            loan__Product_Interest_Amortization_Account__c  = dummyAccount.ID,
                                            loan__Product_Excess_Account__c                 = dummyAccount.ID,
                                            loan__Status__c                                 = 'Active'
                                            );
        insert dummyLP;
        
        //Create a Account
        Account accnt               = CreateTestData.createAccountForBusinessLoan();
        
        //Create a Bank Account
        loan__Bank_Account__c dummyBank = CreateTestData.createBankAccount(accnt.Id);
        
        //Create a Contact
        Contact c       = CreateTestData.createContact();
        Id contactId    = c.Id;
        c.AccountId     = accnt.Id;
        c.Id            = contactId;    
        upsert c;
        
        //Create a dummy genesis Application
        genesis__Applications__c genesisApp = CreateTestData.createLoanApplication(accnt.Id,contactId,dummyBank.Id,accnt.Prospect_Number__c);
        
        
        Date todayDate = getCurrentSystemDate();
        clcontract.loan__Account__c                         =       accnt.Id;
        clcontract.Prospect_Number__c                       =       'Test123';
        //Application Information
        clcontract.loan__Contract_Type__c                   =       'New';
        clcontract.loan__Branch__c                          =       dummyOffice.Id;
        clcontract.loan__Loan_Purpose__c                    =       purpose.Id;
        clcontract.loan__Loan_Status__c                     =       WebServiceConstants.CONTRACT_PARTIAL_APPLICATION;
        clcontract.loan__Loan_Product_Name__c               =       dummyLP.Id;
        clcontract.loan__Interest_Type__c                   =       'Fixed';
        clcontract.loan__Application_Date__c                =       todayDate;
        //Loan Details
        clcontract.loan__Loan_Amount__c                     =       1000000;
        clcontract.loan__Contractual_Interest_Rate__c       =       13.0;
        //Funding Information
        clcontract.loan__Expected_Disbursal_Date__c         =       todayDate;
        //Payment Information
        clcontract.loan__Number_of_Installments__c          =       3;
        clcontract.loan__Frequency_of_Loan_Payment__c       =       'Monthly';
        clcontract.loan__Expected_Repayment_Start_Date__c   =       todayDate+10;
        //Grace Days and Pre Bill Days
        clcontract.loan__Write_off_Tolerance_Amount__c      =       0.00;
        //Other fields
        clcontract.loan__Interest_Only_Period__c            =       0;
        clcontract.loan__Balloon_Payment__c                 =       0;
        /* Changed By Poulomi : Start */
        clcontract.loan__Fee_Set__c                         =       dummyLP.loan__Fee_Set__c;
        clcontract.loan__Pre_Bill_Days__c                   =       dummyLP.loan__Pre_Bill_Days__c;
        clcontract.loan__Term_Cur__c                        =       3;
        clcontract.Loan_Application__c                      =       genesisApp.Id;
        clcontract.loan__Disbursal_Amount__c                =       1000000;
        clcontract.loan__Disbursal_Status__c                =      'Pending Disbursal';
        insert clcontract;
                             
        clcontract.loan__Expected_Disbursal_Date__c         =       todayDate;
        clcontract.loan__Loan_Status__c                     =       loan.LoanConstants.LOAN_STATUS_APPROVED;
        clcontract.loan__Amortization_Schedule_Generated__c =       false;
        clcontract.loan__Expected_Repayment_Start_Date__c   =       todayDate+10;
        clcontract.loan__Contractual_Due_Day__c             =       todayDate.day();   
        clcontract.loan__First_Installment_Date__c          =       todayDate+10;
        clcontract.loan__Last_Installment_Date__c           =       todayDate.addMonths(Integer.valueOf(clcontract.loan__Term_Cur__c));
        clcontract.loan__Draw_Period_End_Date__c            =       todayDate;
        clcontract.loan__Disbursal_Status__c                =       'Fully Disbursed';
        upsert clcontract; 
          
        }catch(Exception e)
        {
        }
           return clcontract;
            
   } 
    
    global static date getCurrentSystemDate(){
        
        loan.GlobalLoanUtilFacade facade = new loan.GlobalLoanUtilFacade();
        return facade.getCurrentSystemDate();
        
    }
    global static date getToday()
    {
        DateTime dT = DateTime.now();
        return date.newinstance(dT.year(), dT.month(), dT.day());
    }
    
    global static OptaCreditSetup__c customSettingsForRouteSMS(){
    	OptaCreditSetup__c ocs                  = new OptaCreditSetup__c();
        ocs.Route_SMS_Server__c    				= 'sms6.routesms.com';
        ocs.Route_SMS_Server_Port__c            = 8080;
        ocs.Route_SMS_User_Name__c              = 'Manimarket';
        ocs.Route_SMS_Password__c               = 'rn9Lied4';
        ocs.Route_SMS_DLR__c					= 1;
        ocs.Route_SMS_Type__c					= 0;	
        ocs.Route_SMS_Source__c					= 'OPTACR';
        insert ocs;
        return ocs;
    }
    
}