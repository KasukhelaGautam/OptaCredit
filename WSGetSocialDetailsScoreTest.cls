/*****************************************************************************************************************************
Name of the Class : WSGetSocialDetailsScoreTest
Created By : Gautam Kasukhela
Created Date : 3rd June, 2016
Description of the class : Test Class for the Webservice that creates takes the Lenddo Score from the front end.
*******************************************************************************************************************************/
@isTest
private class WSGetSocialDetailsScoreTest {
    
    private Static testMethod void getLenddoScore(){
		System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
        /*Create Test Data*/
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
        
        String body 	= '{"UserID":null,"ProspectID":"ANJS8765","SocialDetailsScore":"850"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSGetSocialDetailsScore.getScore();
        System.debug('res 0 '+res);
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"UserID":1000000016,"ProspectID":"","SocialDetailsScore":"850"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSGetSocialDetailsScore.getScore();
        System.debug('res 00 '+res);
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"UserID":1000000016,"ProspectID":"ANJS8765","SocialDetailsScore":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSGetSocialDetailsScore.getScore();
        System.debug('res 000 '+res);
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));  
        
        body 	= '{    "UserID":1234567891,    "ProspectID":"ASW34AA",    "SocialDetailsScore":"650",	"VerificationResponse":{	"partner_script_id": "575a4576f7a579443c4ff2b5",	"updated": "1467884258",	"duplicate_profiles": [		"114555625637162FB",		"abc.testing@rtengines.comEM"	],	"verified_by_facebook": "false",	"facebook_photo_url": "https://graph.facebook.com/114555625637162/picture?type=large",	"created": "1467884258",	"flags": [		"DB00",		"DB02",		"DB05",		"DUPLICATE_PROFILE",		"EM01",		"EM02",		"NM02",		"NM03",		"UN01",		"UN02",		"EPH00"	],	"verifications": {		"name": "true",		"university": "false",		"employer": "true",		"phone": "false",		"birthday": "true",		"top_employer": "true"	},	"client_id": "LEDEMO422941433496118900",	"_id": "575a4576f7a579443c4ff2b5.LEDEMO422941433496118900",	"partner_id": "575a4576f7a579443c4ff2b4",	"probes": {		"name": [			"",			"",			"testing"		],		"university": {			"university": ""		},		"employer": {			"employer": ""		},		"phone": "",		"birthday": "",		"top_employer": "I"	}}}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSGetSocialDetailsScore.getScore();
        System.debug('res 10 '+res);
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));      
    }
    
     private Static testMethod void getLenddoScore1(){
		System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
        /*Create Test Data*/
        Account acc				= CreateTestData.createAccountForAPersonalLoan();
		Id	accId				= acc.Id;
		String prospectNumber 	= acc.Prospect_Number__c;	
		Contact c 				= CreateTestData.createContact();
		Id contactId 			= c.Id;
		c.AccountId 			= accId;
		c.Id					= contactId;	
		upsert c;      
		
        
        String body 	= '{    "UserID":1234567891,    "ProspectID":"ASW34AA",    "SocialDetailsScore":"650",	"VerificationResponse":{	"partner_script_id": "575a4576f7a579443c4ff2b5",	"updated": "1467884258",	"duplicate_profiles": [		"114555625637162FB",		"abc.testing@rtengines.comEM"	],	"verified_by_facebook": "false",	"facebook_photo_url": "https://graph.facebook.com/114555625637162/picture?type=large",	"created": "1467884258",	"flags": [		"DB00",		"DB02",		"DB05",		"DUPLICATE_PROFILE",		"EM01",		"EM02",		"NM02",		"NM03",		"UN01",		"UN02",		"EPH00"	],	"verifications": {		"name": "",		"university": "",		"employer": "",		"phone": "",		"birthday": "",		"top_employer": ""	},	"client_id": "LEDEMO422941433496118900",	"_id": "575a4576f7a579443c4ff2b5.LEDEMO422941433496118900",	"partner_id": "575a4576f7a579443c4ff2b4",	"probes": {		"name": [			"",			"",			"testing"		],		"university": {			"university": ""		},		"employer": {			"employer": ""		},		"phone": "",		"birthday": "",		"top_employer": "I"	}}}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSGetSocialDetailsScore.getScore();
        System.debug('res 1 '+res);
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{    "UserID":1230999999,    "ProspectID":"ASW34AA",    "SocialDetailsScore":"650",	"VerificationResponse":{	"partner_script_id": "575a4576f7a579443c4ff2b5",	"updated": "1467884258",	"duplicate_profiles": [		"114555625637162FB",		"abc.testing@rtengines.comEM"	],	"verified_by_facebook": "false",	"facebook_photo_url": "https://graph.facebook.com/114555625637162/picture?type=large",	"created": "1467884258",	"flags": [		"DB00",		"DB02",		"DB05",		"DUPLICATE_PROFILE",		"EM01",		"EM02",		"NM02",		"NM03",		"UN01",		"UN02",		"EPH00"	],	"verifications": {		"name": "",		"university": "",		"employer": "",		"phone": "",		"birthday": "",		"top_employer": ""	},	"client_id": "LEDEMO422941433496118900",	"_id": "575a4576f7a579443c4ff2b5.LEDEMO422941433496118900",	"partner_id": "575a4576f7a579443c4ff2b4",	"probes": {		"name": [			"",			"",			"testing"		],		"university": {			"university": ""		},		"employer": {			"employer": ""		},		"phone": "",		"birthday": "",		"top_employer": "I"	}}}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSGetSocialDetailsScore.getScore();
        System.debug('res 11 '+res);
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));      
    }
    
    private Static testMethod void getLenddoScore2(){
		System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
        /*Create Test Data*/
        Account acc				= CreateTestData.createAccountForAPersonalLoan();
		Id	accId				= acc.Id;
		String prospectNumber 	= acc.Prospect_Number__c;	
		Contact c 				= CreateTestData.createContact();
		Id contactId 			= c.Id;
		c.AccountId 			= accId;
		c.Id					= contactId;	
		upsert c;      
		loan__Bank_Account__c bankAccountDetails = CreateTestData.createBankAccount(accId);
		CreateTestData.createLoanApplicationWithDiffStatus(accId,contactId,bankAccountDetails.Id,prospectNumber);
        
        String body 	= '{"UserID":1234567891,"ProspectID":"ASW34AA","SocialDetailsScore":"850"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSGetSocialDetailsScore.getScore();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
    }
}