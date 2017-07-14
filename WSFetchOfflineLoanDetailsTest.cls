/*****************************************************************************************************************************
Name of the Class : WSFetchOfflineLoanDetailsTest
Created By : Gautam Kasukhela
Created Date : 25th February, 2016
Description of the class : Test Class for the Webservice that fetches the details of a lona application.
*******************************************************************************************************************************/
@isTest
private class WSFetchOfflineLoanDetailsTest {
    
    private static testMethod void fetchDetailsPersonal(){
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
        String body 	= '{"UserID":null,"ProspectNumber":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSFetchOfflineLoanDetails.fetchData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Prospect Number is blank*/
        body 	= '{"UserID":123456789,"ProspectNumber":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSFetchOfflineLoanDetails.fetchData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
         /*Test case scenario : Scenario where no record exists for the user ID*/
        body 	= '{"UserID":1434567891,"ProspectNumber":"ASWZ4AA"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSFetchOfflineLoanDetails.fetchData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
          /*Test case scenario : Scenario where no record exists for the Prospect Number*/
        body 	= '{"UserID":1234567891,"ProspectNumber":"ASWZ4AA"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSFetchOfflineLoanDetails.fetchData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        /*Test case scenario : Success Scenario*/
        body 	= '{"UserID":1234567891,"ProspectNumber":"ASW34AA"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSFetchOfflineLoanDetails.fetchData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
                
    }
    
    private static testMethod void fetchDetailsBusinessSoleProp(){
        System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
		Account acc				= CreateTestData.createAccountForSPBusinessLoan();
		Id	accId				= acc.Id;
		String prospectNumber 	= acc.Prospect_Number__c;	
		Contact c 				= CreateTestData.createContact();
		Id contactId 			= c.Id;
		c.AccountId 			= accId;
		c.Id					= contactId;	
		upsert c;      
		loan__Bank_Account__c bankAccountDetails = CreateTestData.createBankAccount(accId);
		CreateTestData.createLoanApplication(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
        /*Test case scenario : Success Scenario*/
        String body 	= '{"UserID":1234567891,"ProspectNumber":"ASW34AA"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSFetchOfflineLoanDetails.fetchData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
                
    }
    
        private static testMethod void fetchDetailsBusinessOthers(){
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
		CreateTestData.createLoanApplication(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
        /*Test case scenario : Success Scenario*/
        String body 	= '{"UserID":1234567892,"ProspectNumber":"ASW34AA"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSFetchOfflineLoanDetails.fetchData();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
                
    }
    	
}