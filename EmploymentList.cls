/*Class Name: EmploymentList
  Class Description: This class is used as a wrapper class for parsing the CIBIL response's employmentList 
                     tag. The values are parsed in the JSON response and set in this wrapper class.
  Created By: Gautam Kasukhela
  Created On: 04/05/2016                   
*/
public  class EmploymentList {
	
	public String accountType;
	public String dateReported;
	public String occupationCode;
	public String Income;
	public String netGrossIndicator;
	public String monthlyAnnuallyIndicator;
	public String dateOfEntryForErrorCode;
	public String errorCode;
	public String dateOfEntryForCibilRemarksCode;
	public String cibilRemarkCode;
	public String dateOfEntryForErrorOrDisputeRemarksCode;
	public String errorOrDisputeRemarksCode1;
	public String errorOrDisputeRemarksCode2;
	
	public EmploymentList(String mAccountType, String mDateReported, String mOccupationCode, String mIncome, String mNetGrossIndicator,
						  String mMonthlyAnnuallyIndicator, String mDateOfEntryForErrorCode, String mErrorCode,
						  String mDateOfEntryForCibilRemarksCode, String mCibilRemarkCode, String mDateOfEntryForErrorOrDisputeRemarksCode,
						  String mErrorOrDisputeRemarksCode1, String mErrorOrDisputeRemarksCode2){
		accountType								=		mAccountType;
		dateReported							=		mDateReported;
		occupationCode							=		mOccupationCode;
		Income									=		mIncome;
		netGrossIndicator						=		mNetGrossIndicator;
		monthlyAnnuallyIndicator				=		mMonthlyAnnuallyIndicator;
		dateOfEntryForErrorCode					=		mDateOfEntryForErrorCode;
		errorCode								=		mErrorCode;
		dateOfEntryForCibilRemarksCode			=		mDateOfEntryForCibilRemarksCode;
		cibilRemarkCode							=		mCibilRemarkCode;
		dateOfEntryForErrorOrDisputeRemarksCode	=		mDateOfEntryForErrorOrDisputeRemarksCode;
		errorOrDisputeRemarksCode1				=		mErrorOrDisputeRemarksCode1;
		errorOrDisputeRemarksCode2				=		mErrorOrDisputeRemarksCode2;
		
	}

}