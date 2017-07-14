/*Class Name: EnquiryList
  Class Description: This class is used as a wrapper class for parsing the CIBIL response's enquiryList 
                     tag. The values are parsed in the JSON response and set in this wrapper class.
  Created By: Gautam Kasukhela
  Created On: 04/05/2016                   
*/
public  class EnquiryList {
	
	public String dateReported;
	public String enquiryPurpose;
	public String enquiryAmount;
	public String reportingMemberShortName;
	
	public EnquiryList(String mDateReported, String mEnquiryPurpose, String mEnquiryAmount, String mReportingMemberShortName){
		dateReported				=		mDateReported;
		enquiryPurpose				=		mEnquiryPurpose;
		enquiryAmount				=		mEnquiryAmount;
		reportingMemberShortName	=		mReportingMemberShortName;
	}

}