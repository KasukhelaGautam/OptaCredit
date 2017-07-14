/*****************************************************************************************************************************
Name of the Class : WSDownloadLoanDocumentsTest
Created By : Gautam Kasukhela
Created Date : 19th May, 2016
Description of the class : Test class for the Webservice that captures the user response to the offer details made to him/her.
*******************************************************************************************************************************/
@isTest

public class WSDownloadLoanDocumentsTest {
	
	private static testMethod void downloadDocs(){
		
		System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
        /*Create Test Data*/
       loan__Loan_Account__c loanAccount = CreateTestData.CreateloanAccount();
	   
	    /*Test case scenario : User ID is null in the request*/
        String body 	= '{"UserID":null,"ProspectID":"ASW34AA","FileType":"Authorization Letter"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Prospect Id is blank*/
        body 	= '{"UserID":1234567891,"ProspectID":"","FileType":"Authorization Letter"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test Case scenario : File Type is blank*/
        body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","FileType":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test Case scenario : File Type is an invalid category*/
        body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","FileType":"Others"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
	   	
	}
	
	private static testMethod void downloadDocs1(){
		
		System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
        /*Create Test Data (Application only)*/
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
        
	    /*Test Case scenario : When a Loan Application is not present for the user id and prospect id combination*/
        String body 	= '{"UserID":1734567891,"ProspectID":"ASW34AA","FileType":"Loan Agreement"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : When loan Application is present but CL Contract is not created*/
        body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","FileType":"Loan Agreement"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
	}
	
	private static testMethod void downloadDocs2(){
		
		System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
        /*Create Test Data (Application and Contract)*/
       loan__Loan_Account__c loanAccount = CreateTestData.CreateloanAccount();
        
	    /*Test Case scenario : When a Loan Application and a Loan Contract is present but Attachment is not present*/
        String body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","FileType":"Loan Agreement"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
      }
	
	private static testMethod void downloadDocs3(){
		
		System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
        /*Create Test Data (Loan  App, Contract and Attachment)*/
               
       loan__Loan_Account__c loanAccount = CreateTestData.CreateloanAccount();
       
	   String s ='dummy data';
	   Blob b = Blob.valueOf(s);
	   Attachment a 	= 	new Attachment();
	   a.Body			=	b;
	   a.Name			=	'demo.pdf';
	   a.Description	=	'Loan Agreement';
	   a.ParentId		=	loanAccount.Loan_Application__c;
	   upsert a;
	   
	    /*Test Case scenario : File Type is an invalid category*/
        String body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","FileType":"Loan Agreement"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSDownloadLoanDocuments.getDocument();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
	}

}