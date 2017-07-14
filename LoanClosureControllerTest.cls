/*****************************************************************************************************************************
Name of the Class : LoanClosureControllerTest
Created By : Poulomi Roy Chowdhury
Created Date : 1st July, 2016
Description of the class : Test Class for the Loan Closure actions.
*******************************************************************************************************************************/

@isTest
public with sharing class LoanClosureControllerTest {
	
/*LOAN CLOSURE:::Scenario where CL Contract is not created for the Loan application*/
	public static testMethod void loanClosure1(){
		
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
		genesis__Applications__c app = CreateTestData.createLoanApplication(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
		String response = LoanClosureController.closeLoan(app.Id,'remarks');
		System.assertEquals(WebServiceConstants.NO_CL_CONTRACT_FOUND,response);
	}
	
/*LOAN CLOSURE:::Scenario where a CL Contract is created for a Loan application.
                 The status of the CL Contract is NOT CLOSED*/
	public static testMethod void loanClosure2(){
		
		loan__Loan_Account__c clcontract = 	CreateTestData.CreateloanAccount();	
		String response = LoanClosureController.closeLoan(clcontract.Loan_Application__c,'remarks');
		System.assertEquals(WebServiceConstants.LOAN_APPLICATION_CANNOT_BE_CLOSED,response);
	}
	
/*LOAN CLOSURE:::Scenario where a CL Contract is created for a Loan application.
                 The status of the CL Contract is CLOSED*/
	public static testMethod void loanClosure3(){
		
		loan__Loan_Account__c clcontract = 	CreateTestData.CreateClosedloanAccount();	
		String response = LoanClosureController.closeLoan(clcontract.Loan_Application__c,'remarks');
		System.assertEquals(WebServiceConstants.SUCCESS,response);
	}	
	
	/*SEND NO DUES CERTIFICATE:::Scenario where Application Id does not fetch any records*/
	public static testMethod void loanClosure4(){
		
		Id appId;
		String response = LoanClosureController.sendNoDuesCertificate(appId,'remarks');
		System.assertEquals(WebServiceConstants.LOAN_APP_DETAILS_NOT_FOUND,response);
	}
	
	/*SEND NO DUES CERTIFICATE:::Scenario where Application exists but is not CLOSED*/
	public static testMethod void loanClosure5(){
		
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
		genesis__Applications__c app = CreateTestData.createLoanApplicationWithDiffStatus(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
		String response = LoanClosureController.sendNoDuesCertificate(app.Id,'remarks');
		System.assertEquals(WebServiceConstants.NO_DUES_CERTIFICATE_CANNOT_BE_SENT,response);
	}
	
	/*SEND NO DUES CERTIFICATE:::Scenario where Application exists and is CLOSED*/
	public static testMethod void loanClosure6(){
		
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
		genesis__Applications__c app = CreateTestData.createLoanApplicationWithClosedStatus(accId,contactId,bankAccountDetails.Id,prospectNumber);
		
		String response = LoanClosureController.sendNoDuesCertificate(app.Id,'remarks');
		System.assertEquals(WebServiceConstants.SUCCESS,response);
	}
}