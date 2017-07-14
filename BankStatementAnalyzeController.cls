/*Class Name: BankStatementAnalyzeController
  Class Description: This class is used to handle the actions on the page for the Bank Statement Analyzer Stage.
  Created By: Gautam Kasukhela
  Created On: 22/06/2016                   
*/
global class BankStatementAnalyzeController {
        
/*    Method Name:approvePerfiosStage()
      Method Description: This method approves the Bank statement analyzer stage.
      Created Date:24/05/2016
      Created By: Gautam Kasukhela*/
webservice static String approvePerfiosStage(Id applicationID,String remarks) {
        String response;
        genesis__Applications__c  application                   =   new genesis__Applications__c();
        Integer countOfPerfiosDocs = 0;
        Integer countOfPDFDoc = 0;
        Integer countOfXMLDoc = 0;
        try{
            countOfPDFDoc       = [SELECT   COUNT()
                                   FROM     Attachment
                                   WHERE    ParentId =: applicationID
                                   AND      Description = 'PERFIOS_STATEMENT'
                                   AND      Name LIKE '%.pdf'];
                                   
            countOfXMLDoc       = [SELECT   COUNT()
                                   FROM     Attachment
                                   WHERE    ParentId =: applicationID
                                   AND      Description = 'PERFIOS_STATEMENT'
                                   AND      Name LIKE '%.xml'];     
            countOfPerfiosDocs  =   countOfPDFDoc + countOfXMLDoc;                                 
            if(countOfPerfiosDocs < 2){
                return 'DOCUMENTS_NOT_UPLOADED';
            }                                                   
            
            application.Id                                      =   applicationId;
            application.Underwriter_remarks_for_Perfios__c      =   remarks;
            application.Bank_Statement_Stage_Approval_Status__c =   WebServiceConstants.APPROVED_STATUS;
            application.Last_Action_Taken_By_Perfios__c         =   UserInfo.getFirstName()+' '+UserInfo.getLastName();
            upsert application;
        }catch(Exception e){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
        }
        if(application != null){
            response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        }else{
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
        }
        return response;
    }
    
/*    Method Name:rejectPerfiosStage()
      Method Description: This method rejects the Bank statement analyzer stage.
      Created Date:24/05/2016
      Created By: Gautam Kasukhela*/
webservice static String rejectPerfiosStage(Id applicationID,String remarks) {
        String response;
        genesis__Applications__c  application                   =   new genesis__Applications__c();
        try{
            application.Id                                      =   applicationId;
            application.Underwriter_remarks_for_Perfios__c      =   remarks;
            application.Bank_Statement_Stage_Approval_Status__c =   WebServiceConstants.REJECTED_STATUS;
            application.genesis__Status__c                      =   WebServiceConstants.APPLICATION_REJECT_STATUS;
            application.Last_Action_Taken_By_Perfios__c         =   UserInfo.getFirstName()+' '+UserInfo.getLastName();
            application.Application_Rejection_Timestamp__c      =   Date.today();
            upsert application;
        }catch(Exception e){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
        }
        if(application != null){
            response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        }else{
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
        }
        return response;
    }

/*    Method Name:markeStageCompletePerfios()
      Method Description: This method marks the Bank statement analyzer stage as complete.
      Created Date:24/05/2016
      Created By: Gautam Kasukhela*/
webservice static String markeStageCompletePerfios(Id applicationID,String remarks) {
        String response;
        genesis__Applications__c  application                   =   new genesis__Applications__c();
        try{
            application.Id                                      =   applicationId;
            application.Underwriter_remarks_for_Perfios__c      =   remarks;
            application.Last_Action_Taken_By_Perfios__c         =   UserInfo.getFirstName()+' '+UserInfo.getLastName();
            application.Bank_Statement_Stage_Completed__c       =   true;
            upsert application;
        }catch(Exception e){
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
        }
        if(application != null){
            response = WebServiceConstants.REQUESTSTATUS_SUCCESS;
        }else{
            response = WebServiceConstants.REQUESTSTATUS_ERROR;
        }
        return response;
    }

 /*   Method Name:savePerfiosDetails()
      Method Description: This method parses the XML file that was uploaded and reads the .
      Created Date:24/05/2016
      Created By: Gautam Kasukhela*/
  webservice static String savePerfiosDetails(Id applicationID) {
        String response;
        genesis__Applications__c  application       =   new genesis__Applications__c();
        List<Attachment>    attachmentList          =   new List<Attachment>();
        Blob                blobData;
        String              bodyOfAttachment;
        String              name;
        String              address;
        String              landline;
        String              mobile;
        String              email;
        String              pan;
        String              startDate;
        String              endDate;
        String              duration;
        /*Fetching the body of the XML document that was uploaded*/
        attachmentList                              =   [SELECT     Body
                                                         FROM       Attachment
                                                         WHERE      ParentId =: applicationID
                                                         AND        Description = 'PERFIOS_STATEMENT'
                                                         AND        Name LIKE '%.xml'
                                                         ORDER BY   CreatedDate
                                                         LIMIT 1];
        if(attachmentList != null && attachmentList.size() != 0){
                blobData    =   attachmentList[0].Body;
                if(blobData != null){
                    bodyOfAttachment    =   blobData.toString();
                    
                }
        }else{
                    return WebServiceConstants.XML_REPORT_NOT_FOUND_PERFIOS;
                }
            /*Parse the XML Body that was retrieved from the Attachment Object*/
        try{    
        String attributeName;    
        Dom.Document doc = new Dom.Document();
        doc.load(bodyOfAttachment);
        //Retrieve the root element for this document.
        Dom.XMLNode root= doc.getRootElement();
        
        if(root != null){
                Dom.XmlNode childElement = root.getChildElement('CustomerInfo', null);
                Integer count;
                if(childElement != null){
                	count = childElement.getAttributeCount();
                }
                
                for(integer i = 0; i < count ; i++){
                    attributeName = childElement.getAttributeKeyAt(i);
                    if(attributeName.equals('name')){
                            name  = childElement.getAttributeValue(attributeName,null); 
                            
                    }else if(attributeName.equals('address')){
                            address = childElement.getAttributeValue(attributeName,null);  
                                                        
                    }else if(attributeName.equals('landline')){
                            landline = childElement.getAttributeValue(attributeName,null); 
                                                        
                    }else if(attributeName.equals('mobile')){
                            mobile = childElement.getAttributeValue(attributeName,null); 
                                                        
                    }else if(attributeName.equals('email')){
                            email = childElement.getAttributeValue(attributeName,null); 
                                                        
                    }else if(attributeName.equals('pan')){
                            pan = childElement.getAttributeValue(attributeName,null); 
                                                        
                    }else if(attributeName.equals('startDate')){
                            startDate = childElement.getAttributeValue(attributeName,null);
                                                        
                    }else if(attributeName.equals('endDate')){
                            endDate =  childElement.getAttributeValue(attributeName,null);
                                                        
                    }else if(attributeName.equals('durationInMonths')){
                            duration = childElement.getAttributeValue(attributeName,null); 
                                                        
                    }
                }
            }
         }catch(XmlException xmle){
                 return WebServiceConstants.XML_EXCEPTION_PERFIOS ;
             }
                         
             
        /*Save the details that were retrieved after parsing the XML in the application object*/
        try{
                application.Id                                     =   applicationId;
            if(name != null || name != ''){
                application.Name_as_per_Perfios__c                 =   name;
            }
            if(address != null ||address != ''){
                application.Address_as_per_Perfios__c              =  address;
            }
            if(landline != null ||landline != ''){
                application.Landline_Number__c                     =  landline;
            }
            if(mobile != null ||mobile != ''){
                application.Mobile_Number__c                       =  mobile;
            }
            if(email != null ||email != ''){
                application.Email_ID_as_per_Perfios__c             =  email;
            }
            if(pan != null ||pan != ''){
                application.PAN_Number__c                          =  pan;
            }
            if(startDate != null ||startDate != ''){
                application.Statement_Start_Date__c                =  startDate ;
            }
            if(endDate != null ||endDate != ''){
                application.Statement_End_Date__c                  =  endDate;
            }
            if(duration != null ||duration != ''){
                application.Statement_Duration__c                  =  duration;
            }
            upsert application;
            
        }catch(Exception e){
            response = WebServiceConstants.EXCEPTION_SAVING_PERFIOS_DATA;
            return response;
        }
        if(application != null){
            response = WebServiceConstants.DATA_RETRIEVED_PERFIOS;
        }else{
            response = WebServiceConstants.DETAILS_RETRIEVED_ERROR_PERFIOS;
        }
        return response;
    }
    
}