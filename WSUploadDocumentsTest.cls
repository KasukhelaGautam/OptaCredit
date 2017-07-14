/*****************************************************************************************************************************
Name of the Class : WSUploadDocumentsTest
Created By : Gautam Kasukhela
Created Date : 19th May, 2016
Description of the class : Test class for the Webservice that enables uploading of documents.
*******************************************************************************************************************************/
@isTest
public with sharing class WSUploadDocumentsTest {
	
	private static testMethod void upload(){
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
		
		
		 /*Test case scenario : User ID is balnk in the request header*/
        String body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
         /*Test case scenario : Prospect Number is blank in the request header*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : File Name is blank in the request header*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileCategory','AADHAAR');
        RestContext.request.addHeader('FileName','');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.debug('RESPONSE '+res);
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : File Category is blank in the request header*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Attachment body is blank in the request header*/
        body 	= '' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','AADHAAR');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
         /*Test case scenario : Details do not exist*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567999');
        RestContext.request.addHeader('ProspectID','ASW34AXSA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','AADHAAR');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Invalid File Category*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','XYZ');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
	}
		
		private static testMethod void upload1(){
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
		
		
		 /*Test case scenario : Success scenario for PAN*/
        String body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','PAN');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for AADHAAR*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','AADHAAR');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for VOTER_ID*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','VOTER_ID');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
		/*Test case scenario : Success scenario for SALARY_SLIP*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','SALARY_SLIP');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for LAST_ITR*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','LAST_ITR');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for OTHER*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','OTHER');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for CORPORATE_PAN*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','CORPORATE_PAN');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
		/*Test case scenario : Success scenario for CORPORATE_INCOME_STATEMENT*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','CORPORATE_INCOME_STATEMENT');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		}
		
		private static testMethod void upload2(){
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
		
		
		 /*Test case scenario : Success scenario for CORPORATE_BALANCE_SHEET*/
        String body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','CORPORATE_BALANCE_SHEET');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for CORPORATE_INVOICES*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','CORPORATE_INVOICES');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for MARKETPLACE_DOCUMENT*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','MARKETPLACE_DOCUMENT');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
		
		/*Test case scenario : Success scenario for DRIVING_LICENSE*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','DRIVING_LICENSE');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for BANK_STATEMENT*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','BANK_STATEMENT');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for VAT*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','VAT');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Test case scenario : Success scenario for PASSPORT*/
        body 	= '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMQEBAQDxMSFRUWFxcVEBAQGBUPGBUVFhUYFxUVGBgYHiggGBolGxUWIjEhJSkrLi4uGB8zODMsNygtLisBCgoKDg0OFxAQGC0dHR0rKytLS0rLy0rLS0rLS0tLSstKy0yKy0rLS0tLTUrLi0tKy0uNy03KystKy0rLTIrK//AABEIALQBFwMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQBAgUGB//EAD8QAAEDAQUDCQF' ;
        RestContext.request.addHeader('UserID','1234567891');
        RestContext.request.addHeader('ProspectID','ASW34AA');
        RestContext.request.addHeader('FileName','a.jpg');
        RestContext.request.addHeader('FileCategory','PASSPORT');
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSUploadDocuments.upload();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
		}
}