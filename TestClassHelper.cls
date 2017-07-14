/*****************************************************************************************************************************
Name of the Class : TestClassHelper
Created By : Gautam Kasukhela
Created Date : 26th February, 2016
Description of the class : Class for creating dummy data which will be consumed by the test classes of the web services.
*******************************************************************************************************************************/

public class TestClassHelper {

    /*Creates a test Account record */
    public static Account createAccount(){
        Account a 		=	new Account();
        a.Name 			=	'Test Account';
        insert 	a;
        return a;
    }
    
    /*Creates a test Contact record*/
    public static Contact createContact(){
        Contact c		=	new Contact();
        c.FirstName 	=	'Roger';
        c.LastName		=	'Federer';
        c.AccountId		=	createAccount().Id;
        insert c;
        return c;
    }
    
    /*Creates a genesis application record*/
    public static genesis__Applications__c createGenesisApplication(){
    	genesis.BorrowerAPI bApi = genesis.APIFactory.getBorrowerAPI();
    	genesis__Applications__c application = bApi.createLoanApplication(createAccount().Id, createContact().Id, 10000,
                                                                          WebServiceConstants.DEFAULT_INTEREST_RATE_PERSONAL_LOAN, 
                                              							  12, null, null, null, 
                                                                          null,null,null,null);
        insert application;
        return application;
    }
}