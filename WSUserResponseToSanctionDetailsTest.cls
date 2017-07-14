/*****************************************************************************************************************************
Name of the Class : WSUserResponseToSanctionDetailsTest
Created By : Gautam Kasukhela
Created Date : 19th May, 2016
Description of the class : Test class for the Webservice that captures the user response to the offer details made to him/her.
*******************************************************************************************************************************/
@isTest

public class WSUserResponseToSanctionDetailsTest {
	
	private static testMethod void updateLoanAppStatus(){
        System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
		Account acc				= CreateTestData.createAccountForAPersonalLoan();
		Id	accId				= acc.Id;
		String prospectNumber 	= acc.Prospect_Number__c;	
		Contact c 				= CreateTestData.createContact();
		Id contactId 			= c.Id;
		c.AccountId 			= accId;
		c.Id					= contactId;	
		upsert c;
		loan__Bank_Account__c bankAccountDetails = CreateTestData.createBankAccount(accId);
		CreateTestData.createLoanApplication(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
		
		 /*Test case scenario : User ID is null in the request*/
        String body 	= '{"UserID":null,"ProspectID":"ANJS8765","SanctionDetailsResponse":"ACCEPTED","ReasonForRejection":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Prospect Id is blank*/
        body 	= '{"UserID":1999999999,"ProspectID":"","SanctionDetailsResponse":"ACCEPTED","ReasonForRejection":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Reason for rejection is blank*/
        body 	= '{"UserID":1999999999,"ProspectID":"ANJS8765","SanctionDetailsResponse":"","ReasonForRejection":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
		 /*Test case scenario : When sanction details is anything other than ACCEPTED or REJECTED*/
        body 	= '{"UserID":1999999999,"ProspectID":"ANJS8765","SanctionDetailsResponse":"XYZ","ReasonForRejection":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
		/*Test case scenario : Details do not exist in the LMS system*/
        body 	= '{"UserID":1999999999,"ProspectID":"XXXXX","SanctionDetailsResponse":"REJECTED","ReasonForRejection":"None"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
		/*Test case scenario : When the status of the loan application is not AWAITING CUSTOMER ACCEPTANCE*/
        body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","SanctionDetailsResponse":"REJECTED","ReasonForRejection":"None"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : When the reason for rejection is blank and the status is REJECTED*/
        body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","SanctionDetailsResponse":"REJECTED","ReasonForRejection":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
	}
	
	private static testMethod void updateLoanAppStatus1(){
        System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
		Account acc				= CreateTestData.createAccountForOtherBusinessLoan();
		Id	accId				= acc.Id;
		String prospectNumber 	= acc.Prospect_Number__c;	
		Contact c 				= CreateTestData.createContact();
		Id contactId 			= c.Id;
		c.AccountId 			= accId;
		c.Id					= contactId;	
		upsert c;
		loan__Bank_Account__c bankAccountDetails = CreateTestData.createBankAccount(accId);
		CreateTestData.createLoanApplicationWithDiffStatus(accId,contactId,bankAccountDetails.Id,prospectNumber);
		/*Test case scenario : SUCCESS Scenario when customer accepts the offer*/
        String body 	= '{"UserID":1234567892,"ProspectID":"ASW34AA","SanctionDetailsResponse":"ACCEPTED","ReasonForRejection":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
	}
	
	private static testMethod void updateLoanAppStatus2(){
        System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
		Account acc				= CreateTestData.createAccountForOtherBusinessLoan();
		Id	accId				= acc.Id;
		String prospectNumber 	= acc.Prospect_Number__c;	
		Contact c 				= CreateTestData.createContact();
		Id contactId 			= c.Id;
		c.AccountId 			= accId;
		c.Id					= contactId;	
		upsert c;
		loan__Bank_Account__c bankAccountDetails = CreateTestData.createBankAccount(accId);
		CreateTestData.createLoanApplicationWithDiffStatus(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
		/*Test case scenario : SUCCESS Scenario when customer rejects the offer*/
        String body 	= '{"UserID":1234567892,"ProspectID":"ASW34AA","SanctionDetailsResponse":"REJECTED","ReasonForRejection":"None"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUserResponseToSanctionDetails.updateLoanAppStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
	}
}