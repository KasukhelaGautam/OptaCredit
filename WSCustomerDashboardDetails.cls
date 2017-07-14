/*****************************************************************************************************************************
Name of the Class : WSCustomerDashboardDetails
Created By : Gautam Kasukhela
Created Date : 16th May, 2016
Description of the class : Webservice that retrieves the details for the customer dashboard in the front end.
                           This web service retrieves the current status of the loan application and history
                           of the status that has changed over time. It also retrieves the sanction details of
                           the CL contract corresponding to that loan application, if it exists. 
*******************************************************************************************************************************/
@RestResource (urlMapping = '/optacredit/CustomerDashboardDetails')
global class WSCustomerDashboardDetails {
    
    @HttpPost
    global static Response fetchDetails(){
        
        RestRequest restReq      =  RestContext.request;
        RestResponse restRes     =  RestContext.response;
        Response res             =  new Response();
        Map<String, Object> requestBodyParamsMap = (Map<String, Object>) JSON.deserializeUntyped(restReq.requestBody.toString());
        
        Long        userID;
        String      prospectID;
        Id          applicationId;
        String      currentLoanAppStatus;
        Double      sanctionedLoanAmount;
        Double      term;
        Double      interestRate;
        
        userID                  =   (Long)requestBodyParamsMap.get('UserID') != null ? (Long)requestBodyParamsMap.get('UserID') : null;
        prospectID              =   (String)requestBodyParamsMap.get('ProspectID') != null ? (String)requestBodyParamsMap.get('ProspectID') : null;
        
        if(userID == null){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.USER_ID_BLANK_PUSH_TO_LMS);
            return res;
        }
        if(String.isEmpty(prospectID)){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORCONSTANT, WebServiceConstants.MANDATORY_FIELD_MISSING);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.PROSPECT_ID_BLANK);
            return res;
        }
        
        List<genesis__Applications__c>       appList                =       new     List<genesis__Applications__c>();
        List<genesis__Applications__History> appDetailsHistoryList  =       new     List<genesis__Applications__History>();
        List<loan__Loan_Account__c>          contractList           =       new     List<loan__Loan_Account__c>();
        
        try{
        appList     =       [SELECT     Id,genesis__Status__c,Principal_Amount_that_may_be_sanctioned__c,Derived_Interest_Rate__c,genesis__Term__c
                             FROM       genesis__Applications__c
                             WHERE      Prospect_Number__c =: prospectID AND genesis__Account__r.User_ID__c =: userID
                             LIMIT 1];
        }catch(QueryException qe){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_APPLICATION_DETAILS);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
        }                     
        if(appList != null && appList.size() == 0){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.NO_LOAN_RECORD_FOR_PROSPECT_ID);
            return res;
        }else{
            applicationId           =   appList[0].Id;
            currentLoanAppStatus    =   appList[0].genesis__Status__c;
            sanctionedLoanAmount    =   appList[0].Principal_Amount_that_may_be_sanctioned__c;
            interestRate			=   appList[0].Derived_Interest_Rate__c;
            term					=	appList[0].genesis__Term__c;
        }
        
        try{
        appDetailsHistoryList  =    [SELECT     OldValue,NewValue,CreatedDate
                                     FROM       genesis__Applications__History
                                     WHERE      ParentId =: applicationId AND Field = 'genesis__Status__c'
                                     ORDER BY   CreatedDate
                                     ASC];
        }catch(QueryException qe){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_APPLICATION_DETAILS);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
        }
         
        /*Once the loan application details are fetched, retrieve the CL Contract details if they exist. */
        
        try{
            contractList    =       [SELECT     loan__Loan_Amount__c,loan__Contractual_Interest_Rate__c,loan__Number_of_Installments__c
                                     FROM       loan__Loan_Account__c
                                     WHERE      Prospect_Number__c =: prospectID AND loan__Account__r.User_ID__c =: userID
                                     LIMIT 1];
        }catch(QueryException qe){
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.QUERY_EXCEPTION_RETRIEVING_CONTRACT_DETAILS);
            res.responseDetails.put(WebServiceConstants.EXCEPTIONMESSAGE, qe.getMessage());
            return res;
        }if(contractList != null && contractList.size() != 0){
                sanctionedLoanAmount    =   contractList[0].loan__Loan_Amount__c;
                term                    =   contractList[0].loan__Number_of_Installments__c;
                interestRate            =   contractList[0].loan__Contractual_Interest_Rate__c;
        }else{
            /*In case contract details are not found, do nothing. In that case only the loan application details will be sent to the 
              customer dashboard. */
        }
        
        String jsonResponse     =   formJSONResponse(currentLoanAppStatus,appDetailsHistoryList,sanctionedLoanAmount,
                                                        term,interestRate);
        if(!String.isEmpty(jsonResponse)){
            res.responseDetails.put('CustomerDashboardDetails',jsonResponse);
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_SUCCESS);                                               
            return res;
        }else{
            res.responseDetails.put(WebServiceConstants.REQUESTSTATUS,WebServiceConstants.REQUESTSTATUS_ERROR);
            res.responseDetails.put(WebServiceConstants.ERRORMESSAGE, WebServiceConstants.ERROR_PROCESSING_CUST_DASHBOARD_DATA);
            return res;         
        }                                               
        return res;
    }
    /*This method forms the JSON response string that will be sent to the front end. The response will contain the loan
      application history details (related to the status field), the current status of the loan application and the 
      sanctioned details of the CL contract, if it exists.*/
    private static String formJSONResponse(String currentLoanAppStatus, List<genesis__Applications__History> appDetailsHistoryList,
                                            Double sanctionedLoanAmount, Double term, Double interestRate){
        
        JSONGenerator   jsonGen =   JSON.createGenerator(true);
        jsonGen.writeStartObject();
        if(currentLoanAppStatus != null){
            jsonGen.writeStringField('LoanApplicationCurrentStatus',currentLoanAppStatus);
        }
        if(sanctionedLoanAmount != null){
            jsonGen.writeNumberField('SanctionedLoanAmount',sanctionedLoanAmount);
        }
        if(term != null){
            jsonGen.writeNumberField('Term',term);
        }
        if(interestRate != null){
            jsonGen.writeNumberField('InterestRate',interestRate);
        }
        if(appDetailsHistoryList != null && appDetailsHistoryList.size() != 0){
            jsonGen.writeFieldName('ApplicationStatusHistory');
            jsonGen.writeStartArray();
        for(genesis__Applications__History tempHistoryList : appDetailsHistoryList){
            jsonGen.writeStartObject();
            if(tempHistoryList.OldValue != null){
                jsonGen.writeStringField('OldStatusValue',String.valueOf(tempHistoryList.OldValue));    
            }
            if(tempHistoryList.NewValue != null){
                jsonGen.writeStringField('NewStatusValue',String.valueOf(tempHistoryList.NewValue));
            }
            if(tempHistoryList.CreatedDate != null){
                jsonGen.writeDateField('Date',Date.valueOf(tempHistoryList.CreatedDate));
            }
            jsonGen.writeEndObject();
          }jsonGen.writeEndArray();
        }
        jsonGen.writeEndObject();   
        jsonGen.close();
        
    return jsonGen.getAsString();   
    }
}