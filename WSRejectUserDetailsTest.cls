/*****************************************************************************************************************************
Name of the Class : WSRejectUserDetailsTest
Created By : Gautam Kasukhela
Created Date : 19th May, 2016
Description of the class : Test class for the Webservice that updates the status of the account to rejected, with a reason.
*******************************************************************************************************************************/
@isTest

public class WSRejectUserDetailsTest {
	
		private static testMethod void rejectDetails(){
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
		
		
		 /*Test case scenario : User ID is null in the request*/
        String body 	= '{"UserID":null,"CIFId":"'+cifId+'","ReasonForRejection":"Details not proper"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSRejectUserDetails.updateAccountStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : CIF Id does not exist*/
        body 	= '{"UserID":1000000018,"CIFId":"","ReasonForRejection":"Details not proper"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSRejectUserDetails.updateAccountStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Reason for rejection is blank*/
        body 	= '{"UserID":1000000018,"CIFId":"'+cifId+'","ReasonForRejection":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSRejectUserDetails.updateAccountStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
		 /*Test case scenario : Details do not exist in the LMS system*/
        body 	= '{"UserID":1000000018,"CIFId":"'+cifId+'","ReasonForRejection":"NA"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSRejectUserDetails.updateAccountStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
		        
         /*Test case scenario : SUCCESS Scenario*/
        body 	= '{"UserID":1234567891,"CIFId":"'+cifId+'","ReasonForRejection":"Details not proper"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSRejectUserDetails.updateAccountStatus();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
	}

}