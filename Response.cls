/*****************************************************************************************************************************
Name of the Class : Response
Created By : Gautam Kasukhela
Created Date : 22nd February, 2016
Description of the class : This is a response class that is used in webservices to return the response to the frontend.

*******************************************************************************************************************************/


global class Response{

    public Map<String,String> responseDetails {get;set;}
    
    public Response(){
        responseDetails 	= 	new Map<String,String>();
    }

}