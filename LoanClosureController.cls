/*Class Name: LoanClosureController
  Class Description: This class is used to Close the Loan Application and send out a no dues certificate to the customer.
  Created By: Gautam Kasukhela
  Created On: 29/06/2016                   
*/
global class LoanClosureController {
    
/*    Method Name:closeLoan()
    Method Description: This method checks the status of the CL Contract that is associated with this loan application and if the status
                        of the contract is 'closed-All Oblogations met' then it closes the loan application.
    Created Date:29/06/2016
    Created By: Gautam Kasukhela*/
webservice static String closeLoan(Id applicationID,String remarks) {
    List<loan__Loan_Account__c> clContractList = new List<loan__Loan_Account__c>();
    String   statusOfContract;
    String 		phoneNumber;
    String		accountName;
    String		message;
    
    
    try{
    
        clContractList    =    [SELECT      loan__Loan_Status__c,loan__Account__r.Name,loan__Account__r.Phone 
                                FROM        loan__Loan_Account__c
                                WHERE       Loan_Application__c =: applicationID
                                LIMIT 1];
        
        if(clContractList != null && clContractList.size() != 0){
            statusOfContract    =   clContractList[0].loan__Loan_Status__c ; 
            phoneNumber			=	clContractList[0].loan__Account__r.Phone;
        	accountName			=	clContractList[0].loan__Account__r.Name;
        }else{
           return  WebServiceConstants.NO_CL_CONTRACT_FOUND;
        }
        
        if(statusOfContract.equals(WebServiceConstants.CL_CONTRACT_CLOSED_STATUS)){
            genesis__Applications__c    application   =  new genesis__Applications__c();
            application.Id                            =   applicationID;
            application.genesis__Status__c            =   WebServiceConstants.LOAN_APPLICATION_CLOSED_STATUS;
            application.Loan_Application_Closed_On__c =   DateTime.now();
            application.Loan_Closure_Remarks__c       =   remarks;
            upsert application;
            
            message									 = 'Dear '+accountName+' Your Loan Application has been closed in our system.'+
            											' The \'No Dues Certificate\' will be mailed to your registered Email shortly.';
            
        }else{
            return  WebServiceConstants.LOAN_APPLICATION_CANNOT_BE_CLOSED;
        }
    }catch(Exception e){
            return WebServiceConstants.EXCEPTION_WHILE_CLOSING_LOAN_APPLICATION;
    }
    if(!Test.isRunningTest()){
		HttpCalloutToRouteSMS.sendSMS(phoneNumber,message);
    }
    return WebServiceConstants.SUCCESS;
  }
  
  /*Method Name:sendNoDuesCertificate()
    Method Description: This method sends a no due certificate to the customer. This method is instrumental in updating a flag value on 
                        the Application object. Based on this flag value a Process builder is invoked and a no dues certificate is sent
                        to the customer.
    Created Date:29/06/2016
    Created By: Gautam Kasukhela*/
webservice static String sendNoDuesCertificate(Id applicationID,String remarks) {
    List<genesis__Applications__c> appList = new List<genesis__Applications__c>();
    String   statusOfLoan;
    
    try{
        appList			  =    [SELECT      genesis__Status__c 
                                FROM        genesis__Applications__c
                                WHERE       Id =: applicationID
                                LIMIT 1];
        
        if(appList != null && appList.size() != 0){
            statusOfLoan    =   appList[0].genesis__Status__c ; 
        }else{
           return  WebServiceConstants.LOAN_APP_DETAILS_NOT_FOUND;
        }
        
        if(statusOfLoan.equals(WebServiceConstants.LOAN_APPLICATION_CLOSED_STATUS)){
            genesis__Applications__c    application   =  new genesis__Applications__c();
            application.Id                            =   applicationID;
            application.No_Dues_Certificate_sent__c	  =   true;
            upsert application;
        }else{
            return  WebServiceConstants.NO_DUES_CERTIFICATE_CANNOT_BE_SENT;
        }
    }catch(Exception e){
            return WebServiceConstants.EXCEPTION_WHILE_SENDING_NO_DUES_CERTIFICATE;
    }
    return WebServiceConstants.SUCCESS;
  }    
    }