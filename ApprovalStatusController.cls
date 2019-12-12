/*Class Name: ApprovalStatusController
  Class Description: This class is used to approve a loan application and create a CL Contract in a PARTIAL APPLICATION status.
  Created By: Gautam Kasukhela
  Created On: 24/05/2016                   
*/
global class ApprovalStatusController {
    
/*    Method Name:approveLoanApplication()
    Method Description: This method approves the genesis loan application.
    Created Date:24/05/2016
    Created By: Gautam Kasukhela*/
  webservice static String approveLoanApplication(Id applicationID,Double interestRate,Double preEmiInterestRate) {
    genesis__Applications__c  application        =    new genesis__Applications__c();
    List<genesis__Applications__c>  applicationList    =    new List<genesis__Applications__c>();
    String     prospectNumber;
    DateTime   startDateTime;
    String 		phoneNumber;
    String		accountName;
    String		message;
    //Adding comments to this file in the branch
    applicationList    =  [SELECT    Prospect_Number__c,Stage_Processing_Start_Date_App_Status__c,genesis__Account__r.Name,genesis__Account__r.Phone
                 		   FROM    	 genesis__Applications__c
                 		   WHERE     Id =: applicationID
                 		   LIMIT 1];  
    if(applicationList != null && applicationList.size() == 0){
      return 'Error';
    }else{
        prospectNumber  =   applicationList[0].Prospect_Number__c;
        startDateTime  	=  	applicationList[0].Stage_Processing_Start_Date_App_Status__c;
        phoneNumber		=	applicationList[0].genesis__Account__r.Phone;
        accountName		=	applicationList[0].genesis__Account__r.Name;
    }             
    
    try{
    application.Id                      					=    applicationID;
    application.genesis__Status__c              			=    WebServiceConstants.AWAITING_CUSTOMER_TO_ACCEPT;
    application.Last_Action_Taken_By_Appr_Status__c      	=    UserInfo.getFirstName()+' '+UserInfo.getLastName();
    application.Approval_Stage_Status__c          			=    WebServiceConstants.APPROVED_STATUS;
    if(startDateTime == null){    
      application.Stage_Processing_Start_Date_App_Status__c =    DateTime.now();
    }
    application.genesis__Interest_Rate__c          			=    interestRate;
    application.Pre_EMI_Interest_Rate__c           			=    preEmiInterestRate;
    upsert application;
    
    message													=	'Dear '+accountName+', Loan Proposal Details have been mailed to you.'+
    															' For more details, Kindly check your registered Email.';
    }catch(DmlException dmle){
      return  WebServiceConstants.DML_EXCEPTION_WHILE_SAVING_APP_DATA;
    }
    if(!Test.isRunningTest()){
		HttpCalloutToRouteSMS.sendSMS(phoneNumber,message);
	 }
    return 'SUCCESS';
  }  
  
  /*    Method Name:markStageAsComplete()
    Method Description: This method marks the stage as complete.
    Created Date:24/05/2016
    Created By: Gautam Kasukhela*/
  webservice static String markStageAsComplete(Id applicationID) {
    genesis__Applications__c  application          =    new   genesis__Applications__c();
    String status;
    try{
    application.Id                      =    applicationID;
    application.Approval_Status_Stage_Completed__c      =    true;
    application.Last_Action_Taken_By_Appr_Status__c      =    UserInfo.getFirstName()+' '+UserInfo.getLastName();
    application.Stage_Processing_End_Date_App_Status__c    =    Datetime.now();
    upsert application;
    }catch(DmlException dmle){
      status  =  WebServiceConstants.DML_EXCEPTION_WHILE_SAVING_APP_DATA;
    }
    if(application != null){
      status = WebServiceConstants.SUCCESS;
    }  
    return status;
  }
    
}
