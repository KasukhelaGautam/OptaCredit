/*Class Name: PersonalDetailsJocata
  Class Description: This class is used as a wrapper class for parsing the request coming from the frontend with the 
                     Jocata details of an individual. This is used both for a personal loan and a business loan.
  Created By: Gautam Kasukhela
  Created On: 06/05/2016                   
*/
public  class PersonalDetailsJocata {
	
	public String dateReported;
	public String enquiryPurpose;
	public String enquiryAmount;
	public String reportingMemberShortName;
	
	public PersonalDetailsJocata(String mDateReported, String mEnquiryPurpose, String mEnquiryAmount, String mReportingMemberShortName){
		dateReported				=		mDateReported;
		enquiryPurpose				=		mEnquiryPurpose;
		enquiryAmount				=		mEnquiryAmount;
		reportingMemberShortName	=		mReportingMemberShortName;
	}

}