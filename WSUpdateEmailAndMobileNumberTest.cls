/*****************************************************************************************************************************
Name of the Class : WSUpdateEmailAndMobileNumberTest
Created By : Gautam Kasukhela
Created Date : 19th May, 2016
Description of the class : Test class for the Webservice that updates the email id and phone number of a user.
*******************************************************************************************************************************/
@isTest
public class WSUpdateEmailAndMobileNumberTest {
	
	private static testMethod void updateDetails(){
        System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
		Account acc				= CreateTestData.createAccountForAPersonalLoan();
		Id	accId				= acc.Id;
		Account accDetails      = [SELECT 	Unique_CIF_ID__c
								   FROM 	Account
								   WHERE 	Id =: accId];
		String	cifId			= accDetails.Unique_CIF_ID__c;
		String prospectNumber 	= acc.Prospect_Number__c;	
		Contact c 				= CreateTestData.createContact();
		Id contactId 			= c.Id;
		c.AccountId 			= accId;
		c.Id					= contactId;	
		upsert c;
		
		loan__Bank_Account__c bankAccountDetails = CreateTestData.createBankAccount(accId);
		CreateTestData.createLoanApplication(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
		 /*Test case scenario : User ID is null in the request*/
        String body 	= '{"UserID":null,"CIFId":"'+cifId+'","EmailID":"a@a.com","MobileNumber":"33445566"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUpdateEmailAndMobileNumber.updateData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : User Id does not exist*/
        body 	= '{"UserID":1000000016,"CIFId":"'+cifId+'","EmailID":"","MobileNumber":"33445566"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUpdateEmailAndMobileNumber.updateData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : CIF ID Id is blank*/
        body 	= '{"UserID":1000000016,"CIFId":"","EmailID":"","MobileNumber":"33445566"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUpdateEmailAndMobileNumber.updateData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        /*Test case scenario : Email ID and Mobile Number are blank*/
        body 	= '{"UserID":1000000016,"CIFId":"'+cifId+'","EmailID":"","MobileNumber":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUpdateEmailAndMobileNumber.updateData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
         /*Test case scenario : SUCCESS Scenario*/
        body 	= '{"UserID":1234567891,"CIFId":"'+cifId+'","EmailID":"a@a.com","MobileNumber":"33445566"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUpdateEmailAndMobileNumber.updateData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
	}
	
}