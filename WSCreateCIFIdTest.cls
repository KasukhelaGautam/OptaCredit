/*****************************************************************************************************************************
Name of the Class : WSCreateCIFIdTest
Created By : Gautam Kasukhela
Created Date : 25th February, 2016
Description of the class : Test Class for the Webservice that creates a CIF ID in the backend by taking a few inputs
						   from the frontend system.
*******************************************************************************************************************************/
@isTest
private class WSCreateCIFIdTest {
    
    private Static testMethod void createCIF(){
        System.RestContext.request 			= 	new RestRequest();
        Response res = new Response();
        
                
        /*Testing various scenarios for a Personal Loan : START*/
        
        //Success Scenario
        String body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        System.assertEquals(WebServiceConstants.CIF_ID_CREATED, res.responseDetails.get(WebServiceConstants.SUCCESSMESSAGE));
               
        
        body	=	'{"TypeOfLoan" : "","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Employer Linked","EmploymentID":"","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));*/
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody = Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
		body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"","PermanentAddressCity":"Mumbai","PermanentAddressState":"","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Employer Linked","EmploymentID":"1134567","EmployerName":"","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Employer Linked","EmploymentID":"1134567","EmployerName":"","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Employer Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"Maharashtra","PermanentAddressPinCode":"","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Personal","FirstName" : "B","MiddleName":"S","LastName" : "J","EmailID"   : "bsj@gmail.com","MobileNumber" : "899716544","UserID":1000000007,"ProspectID":"PID363738","PANNumber":"BCZSD8198G","AADHAARNumber":112234567890,"VoterID":"ASD23","VoterIDState":"Punjab","VoterIDDistrict":"Chandigarh","PassportNumber":"ASXC345","DrivingLicenseNumber":"MH-02-KJHHS","DrivingLicenseState":"Maharashtra","SubLoanType":"Marketplace Linked","EmploymentID":"1134567","EmployerName":"Ola Cabs","OfficialEmailID":"jsg@pwc.com","TotalExperience":"5.8","PrimaryMarketplace":"Flipkart","PrimaryMarketplaceMerchantID":"FLP345656","PermanentAddress":"Marine Lines","PermanentAddressCity":"Mumbai","PermanentAddressState":"","PermanentAddressPinCode":"468790","DoYouLiveIn":"Rented"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
                
        /*Testing various scenarios for a Personal Loan : END*/
        
        /*Testing various scenarios for a Business Loan : START*/
        
        //success scenario
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_SUCCESS, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        System.assertEquals(WebServiceConstants.CIF_ID_CREATED, res.responseDetails.get(WebServiceConstants.SUCCESSMESSAGE));
        
        body 	= '{"TypeOfLoan" : "","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));

        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "","UserID":1234543213,"ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","ProspectID":"HSHS8765"}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        body 	= '{"TypeOfLoan" : "Business","CompanyName"   : "Coca Cola","EmailID"   : "off@cc.com","MobileNumber" : "999716544","PANOfBusiness" : "BGSDH6787H","VATNumber": "HDHS76HS","CSTNumber": "JSHSGS09","UserID":1234543213,"ProspectID":""}' ;
        RestContext.request.requestBody	= Blob.valueOf(body);
        res = WSCreateCIFId.createCIF();
        System.assertEquals(WebServiceConstants.REQUESTSTATUS_ERROR, res.responseDetails.get(WebServiceConstants.REQUESTSTATUS));
        
        /*Testing various scenarios for a Business Loan : END*/
        
    }

}