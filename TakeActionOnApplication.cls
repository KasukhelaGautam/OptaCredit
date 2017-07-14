/*****************************************************************************************************************************
Name of the Class : TakeActionOnApplication
Created By : Gautam Kasukhela
Created Date : 1st March, 2016
Description of the class : This clas handles other actions that an underwriter can take on an application. These actions
include Approve, reject and mark the stage as completed. These 3 actions are for all the different stages of an origination
process.
*******************************************************************************************************************************/
public class TakeActionOnApplication {


    /*
    This method would be called from approveCIBILDetails method present in ApplicationMasterController class.
    It approves the Jocata stage post by setting CIBIL_Stage_Approved__c value in genesis__Applications__c object to Approved
    */
    
    public static String approveCibil(Id applicationId, String remarks){
        
        String response;
        genesis__Applications__c applicationForStartDate; 
        
        try{
        String underwriterRemarks =remarks;
        genesis__Applications__c  app               =       new genesis__Applications__c();
        app.Id                                      =       applicationId;
        app.CIBIL_Stage_Approved__c                 =       WebServiceConstants.APPROVED_STATUS;
        app.Underwriter_remarks_for_CIBIL__c        =       underwriterRemarks;
        
        List<genesis__Applications__c>  genesisDetails = [SELECT Id,Stage_Processing_Start_Date_CIBIL__c 
                                                                FROM genesis__Applications__c 
                                                                WHERE Id=:applicationId LIMIT 1];
        
        if(genesisDetails != null && genesisDetails.size() != 0)
            {    
                applicationForStartDate = genesisDetails.get(0);
                if(applicationForStartDate.Stage_Processing_Start_Date_CIBIL__c == NULL)
                {
                    app.Stage_Processing_Start_Date_CIBIL__c = Datetime.now();
                }
                app.Last_Action_Taken_By_CIBIL__c = UserInfo.getFirstName()+' '+UserInfo.getLastName();
            }
        
        upsert app;
        }catch(DmlException dmle){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
            return response;
        }
        response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        return response;
    }
    
    /*
    This method would be called from approveJocataDetails method present in ApplicationMasterController class.
    It approves the Jocata stage post by setting Jocata_Approval_Status__c value in Borrower_Details__c object to Approved
    */
    
    public static String approveJocata(Id applicationId, String remarks){
        String response;
        try{
        String underwriterRemarks = remarks;
        genesis__Applications__c  app                       =       new genesis__Applications__c();
        Borrower_Details__c borrowerDetails                 =       new Borrower_Details__c();
        app.Id                                              =       applicationId;
        upsert app;
        
        List<Borrower_Details__c> borrowerDetailsList       =     [SELECT Id FROM Borrower_Details__c 
                                                                    WHERE Application_ID__c =:applicationId 
                                                                   LIMIT 1];
        
        if(borrowerDetailsList != null && borrowerDetailsList.size() != 0)
          {    
                borrowerDetails = borrowerDetailsList.get(0);
          } 
          
        borrowerDetails.Jocata_Approval_Status__c           =     WebServiceConstants.APPROVED_STATUS;
        borrowerDetails.Underwriter_remarks_for_Jocata__c   =     underwriterRemarks;
        borrowerDetails.Application_ID__c                   =     applicationId;
        upsert borrowerDetails;
        ApplicationMasterController.getStartTime(borrowerDetails);
        }catch(DmlException dmle){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
            return response;
        }
        response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        return response;
    }
    
    /*
    This method would be called from rejectJocataDetails method present in ApplicationMasterController class.
    It rejects the Jocata stage which would then also changes the application overall status to rejected as well. 
    */
    
    public static String rejectJocata(Id applicationId, String remarks)
    {
        String response;
        Borrower_Details__c borrowerDtls = new Borrower_Details__c();
        String 		phoneNumber;
    	String		message;
        try
        {
            String underwriterRemarks =remarks;
            genesis__Applications__c  app                           =       new genesis__Applications__c();
            app.Id                                                  =       applicationId;
            app.genesis__Status__c                                  =       WebServiceConstants.APPLICATION_REJECT_STATUS;
            app.Application_Rejection_Timestamp__c                  =       Date.today();
            upsert app;
            
            List<Borrower_Details__c> borrowerDetailsList           =     [SELECT Id,Stage_Processing_Start_Date_Jocata__c,Last_Action_Taken_By_Jocata__c,Stage_Processing_End_Date_Jocata__c
                                                                           FROM Borrower_Details__c 
                                                                           WHERE Application_ID__c =:applicationId 
                                                                           LIMIT 1];
            List<genesis__Applications__c>  applicationList    		=    new List<genesis__Applications__c>();
            applicationList											=	  [SELECT  genesis__Account__r.Phone
            															   FROM	   genesis__Applications__c
            															   WHERE   Id =: applicationId
            															   LIMIT 1];
            if(applicationList != null && applicationList.size() !=0){
            	phoneNumber		=	 applicationList[0].genesis__Account__r.Phone;
            }															   
            if(borrowerDetailsList != null && borrowerDetailsList.size() != 0)  
            {
                borrowerDtls = borrowerDetailsList.get(0);
            }
            
            if(borrowerDtls != NULL && borrowerDtls.Stage_Processing_Start_Date_Jocata__c == NULL)
            {
                borrowerDtls.Stage_Processing_Start_Date_Jocata__c = Datetime.now();
            }
              
                borrowerDtls.Application_ID__c                      =  applicationId;
                borrowerDtls.Last_Action_Taken_By_Jocata__c         =  UserInfo.getFirstName()+' '+UserInfo.getLastName();
                borrowerDtls.Stage_Processing_End_Date_Jocata__c    =  Datetime.now();
                borrowerDtls.Underwriter_remarks_for_Jocata__c      =  underwriterRemarks;
                borrowerDtls.Jocata_Approval_Status__c              =  WebServiceConstants.REJECTED_STATUS;
            upsert borrowerDtls;
                
        }catch(DmlException dmle){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
            return response;
        }
        response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        message  = 'Dear Customer, Your Loan Application has been rejected by our Underwriter. For more details, Kindly check your registered Email.';
        
         if(!Test.isRunningTest()){
				HttpCalloutToRouteSMS.sendSMS(phoneNumber,message);
	 	}
        return response;
    }
    
     /*
    This method would be called from markJocataStageComplete method present in ApplicationMasterController class.
    It marks the Jocata stage as complete which is the final status for a particular stage 
    */
    
    public static String markJocataStageAsComplete(Id applicationId)
    {
            String response;
            Borrower_Details__c borrowerDtls;
        try{
            
            List<Borrower_Details__c> borrowerDetailsList           =     [SELECT Id,Stage_Processing_Start_Date_Jocata__c,Last_Action_Taken_By_Jocata__c,Stage_Processing_End_Date_Jocata__c
                                                                           FROM Borrower_Details__c 
                                                                           WHERE Application_ID__c =:applicationId 
                                                                           LIMIT 1];
            
            if(borrowerDetailsList != null && borrowerDetailsList.size() != 0)  
            {
                borrowerDtls = borrowerDetailsList.get(0);
            }
            
            borrowerDtls.Last_Action_Taken_By_Jocata__c         =  UserInfo.getFirstName()+' '+UserInfo.getLastName();
            borrowerDtls.Stage_Processing_End_Date_Jocata__c    =  Datetime.now();
            borrowerDtls.Jocata_Stage_Completed__c   =  true;
            borrowerDtls.Application_ID__c                      =  applicationId;
            upsert borrowerDtls;
            
        }catch(DmlException dmle){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
            return response;
        }
        response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        return response;
    }
    
    
    /*
    This method would be called from rejectCIBILDetails method present in ApplicationMasterController class.
    It rejects the CIBIL stage which would then also changes the application overall status to rejected as well. 
    */
    
    public static String rejectCibil(Id applicationId, String remarks){
        String response;
        genesis__Applications__c applicationForStartDate;
        String 		phoneNumber;
    	String		message;
        
        try{
        String underwriterRemarks =remarks;
        genesis__Applications__c  app               =       new genesis__Applications__c();
        app.Id                                      =       applicationId;
        app.CIBIL_Stage_Approved__c                 =       WebServiceConstants.REJECTED_STATUS;
        app.genesis__Status__c                      =       WebServiceConstants.APPLICATION_REJECT_STATUS;
        app.Underwriter_remarks_for_CIBIL__c        =       underwriterRemarks;
        app.Application_Rejection_Timestamp__c      =       Date.today();
        
        List<genesis__Applications__c>  genesisDetails = 	   [SELECT 		Id,Stage_Processing_Start_Date_CIBIL__c,genesis__Account__r.Phone 
                                                                FROM 		genesis__Applications__c 
                                                                WHERE 		Id=:applicationId 
                                                                LIMIT 1];
        
        if(genesisDetails != null && genesisDetails.size() != 0)
            {    
                applicationForStartDate = genesisDetails.get(0);
                phoneNumber				= applicationForStartDate.genesis__Account__r.Phone;
                if(applicationForStartDate.Stage_Processing_Start_Date_CIBIL__c == NULL)
                {
                    app.Stage_Processing_Start_Date_CIBIL__c = Datetime.now();
                }
                    app.Last_Action_Taken_By_CIBIL__c      = UserInfo.getFirstName()+' '+UserInfo.getLastName();
                    app.Stage_Processing_End_Date_CIBIL__c = Datetime.now();
            }
        
        upsert app;
         }catch(DmlException dmle){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
            return response;
        }
        response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        message  = 'Dear Customer, Your Loan Application has been rejected by our Underwriter. For more details, Kindly check your registered Email.';
         if(!Test.isRunningTest()){
				HttpCalloutToRouteSMS.sendSMS(phoneNumber,message);
	 	}
        return response;
    }
    
    
    /*
    This method would be called from markCibilStageComplete method present in ApplicationMasterController class.
    It marks the CIBIL stage as complete which is the final status for a particular stage 
    */
    public static String markCibilStageAsComplete(Id applicationId){
            String response;
            
        try{
            genesis__Applications__c  app               =   new genesis__Applications__c();
            app.Id                                      =   applicationId;
            app.CIBIL_Stage_Completed__c                =   true;
            app.Stage_Processing_End_Date_CIBIL__c      =   Datetime.now();
            app.Last_Action_Taken_By_CIBIL__c           =   UserInfo.getFirstName()+' '+UserInfo.getLastName();
            upsert app;
        }catch(DmlException dmle){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
            return response;
        }
        response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        return response;
    }
    
}