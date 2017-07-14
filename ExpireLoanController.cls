/*Class Name: ExpireLoanController
  Class Description: This class is instrumental in marking the Loan Application as EXPIRED if the loan documents were not received from 
                     the customer even after 21 days.
  Created By: Gautam Kasukhela
  Created On: 21/07/2016                   
*/

global  class ExpireLoanController {
    
    
    /*Method Name:markLoanAsExpired()
    Method Description: This method marks the Loan as Expired.
    Created Date:21/07/2016
    Created By: Gautam Kasukhela*/
  webservice static String markLoanAsExpired(Id applicationID) {
    
        /*Fetch the Date when the documents were sent to the customer*/
        List<genesis__Applications__c>  appList     =   new List<genesis__Applications__c>();
        List<loan__Loan_Account__c> contractList    =   new List<loan__Loan_Account__c>();
        
        genesis__Applications__c app        =   new genesis__Applications__c();
        loan__Loan_Account__c    contract   =   new loan__Loan_Account__c();
        Date    documentSentOn;
        String  appStatus;
        String  response;
        
        try{
            appList         =   [SELECT     Documents_Sent_On__c,genesis__Status__c
                                 FROM       genesis__Applications__c
                                 WHERE      Id =: applicationID
                                 LIMIT 1];  
                                 
            contractList    =   [SELECT     Id
                                 FROM       loan__Loan_Account__c
                                 WHERE      Loan_Application__c =: applicationID
                                 LIMIT 1];           
            if(appList != null && appList.size() !=0){
                documentSentOn  =   appList[0].Documents_Sent_On__c;
                appStatus       =   appList[0].genesis__Status__c;  
            }
            if(!appStatus.equals(WebServiceConstants.APPLICATION_APPROVED_CONVERT_CONTRACT_STATUS)){
                return WebServiceConstants.LOAN_APP_CANNOT_BE_MARKED_AS_EXPIRED;
            }
            if(documentSentOn == null){
                return WebServiceConstants.DOCUMENT_SENT_DATE_ON_BLANK;
            }
            if(documentSentOn != null && (Date.today().daysBetween(documentSentOn)) < 21){
                return WebServiceConstants.LOAN_APP_CANNOT_BE_EXPIRED_BEFORE_21_DAYS;
            }
            /*If the above checks pass then the Loan Application can be marked as Expired*/
                    app.Id                  =   applicationID;  
                    app.genesis__Status__c  =   WebServiceConstants.APPLICATION_EXPIRED_NO_DOCS_RECEIVED_STATUS;
                    upsert app;
                    
            /*A contract that would have been created has to be marked as Cancelled*/   
            if(contractList != null && contractList.size() != 0){
                contract.Id                     =       contractList[0].Id;
                contract.loan__Loan_Status__c   =       'Cancelled';
                upsert contract;
            }
                if(app != null || contract != null){
                    response = WebServiceConstants.SUCCESS;
                }
        }catch(Exception e){
            return WebServiceConstants.EXCEPTION_WHILE_EXPIRING_LOAN_APP;
        }
    return response;
  }

}