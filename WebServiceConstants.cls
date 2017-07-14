/*****************************************************************************************************************************
Name of the Class : WebServiceConstants
Created By : Gautam Kasukhela
Created Date : 22nd February, 2016
Description of the class : This is a class that is used to define constants used in web services.
*******************************************************************************************************************************/

global class WebServiceConstants {
    
    /*REQUESTSTATUS values can be either ERROR or SUCCESS*/
    public static String REQUESTSTATUS                                  =       'RequestStatus';
    public static String REQUESTSTATUS_ERROR                            =       'ERROR';
    public static String REQUESTSTATUS_SUCCESS                          =       'SUCCESS';
    public static String ERRORCONSTANT                                  =       'ErrorConstant';
    public static String ERRORMESSAGE                                   =       'ErrorMessage';
    public static String EXCEPTIONMESSAGE                               =       'ExceptionMessage';
    public static String SUCCESSMESSAGE                                 =       'SuccessMessage';
    public static String MANDATORY_FIELD_MISSING                        =       'MANDATORY_FIELD_NOT_ENTERED';
    public static String SETUP_DATA_MISSING                             =       'MANDATORY_SETUP_DATA_MISSING';
    public static String BUSINESS_VALIDATION_FAILURE                    =       'BUSINESS_VALIDATION_FAILED';
    public static String HEADER_MANDATORY_FIELD_MISSING                 =       'HEADER_MANDATORY_FIELD_NOT_ENTERED';
    public static String NO_RECORDS_FOUND                               =       'NO_RECORDS_FOUND';
    public static String DATABASE_OPERATION_FAILED                      =       'DATABASE_OPERATION_FAILED';
    public static String QUERY_OPERATION_FAILED                         =       'QUERY_OPERATION_FAILED';
    public static String OTHER_EXCEPTIONS                               =       'OTHER_EXCEPTION';
    public static String PROCESSING_ERROR                               =       'PROCESING_ERROR';
    public static String DATA_UPDATION_FAILED                           =       'DATA_UPDATION_FAILED';
    public static String BUSINESS_LOAN                                  =       'Business';
    public static String PERSONAL_LOAN                                  =       'Personal';
    public static String PERSONAL_LOAN_LENDING_PRODUCT                  =       'Personal Loans';
    public static String BUSINESS_LOAN_LENDING_PRODUCT                  =       'Business Loans/E-Commerce';
    public static Integer DEFAULT_INTEREST_RATE_PERSONAL_LOAN           =       16;
    public static Integer DEFAULT_INTEREST_RATE_BUSINESS_LOAN           =       16;
    public static String LEGAL_ENTITY_TYPE_PARTNERSHIP                  =       'Partnership';
    public static String LEGAL_ENTITY_TYPE_PRIVATE_LIMITED              =       'Private Limited';
    public static String LEGAL_ENTITY_TYPE_LLP                          =       'LLP';
    public static String LOAN_APPLICATION_CLOSED_STATUS                 =       'CLOSED';
    public static String CL_CONTRACT_CLOSED_STATUS                      =       'Closed - Obligations met';
    public static String CONTENT_TYPE_PDF                               =       'application/pdf';
    public static String CONTENT_TYPE_JPG                               =       'application/jpg';
    public static String CONTENT_TYPE_DOC                               =       'application/doc';
    public static String INVALID_ATTACHMENT_FORMAT                      =       'ATTACHMENT_FORMAT_NOT_SUPPORTED';
    public static String INVALID_FILE_CATEGORY                          =       'FILE_TYPE_NOT_SUPPORTED';
    public static String FILE_CATEGORY_PAN                              =       'PAN';
    public static String FILE_DESCRIPTION_PAN                           =       'Pan Card';
    public static String FILE_CATEGORY_AADHAAR                          =       'AADHAAR';
    public static String FILE_DESCRIPTION_AADHAAR                       =       'AADHAAR Card';
    public static String FILE_CATEGORY_VOTER_ID                         =       'VOTER_ID';
    public static String FILE_DESCRIPTION_VOTER_ID                      =       'Voter ID';
    public static String FILE_CATEGORY_SALARY_SLIP                      =       'SALARY_SLIP';
    public static String FILE_DESCRIPTION_SALARY_SLIP                   =       'Salary Slip';
    public static String FILE_CATEGORY_LAST_ITR                         =       'LAST_ITR';
    public static String FILE_DESCRIPTION_LAST_ITR                      =       'Last ITR';
    public static String FILE_CATEGORY_OTHER                            =       'OTHER';
    public static String FILE_DESCRIPTION_OTHER                         =       'Other';
    public static String FILE_CATEGORY_CORPORATE_PAN                    =       'CORPORATE_PAN';
    public static String FILE_DESCRIPTION_CORPORATE_PAN                 =       'PAN-Corporate';
    public static String FILE_CATEGORY_CORPORATE_INCOME_STATEMENT       =       'CORPORATE_INCOME_STATEMENT';
    public static String FILE_DESCRIPTION_CORPORATE_INCOME_STATEMENT    =       'Income Statement-Corporate';
    public static String FILE_CATEGORY_CORPORATE_BALANCE_SHEET          =       'CORPORATE_BALANCE_SHEET';
    public static String FILE_DESCRIPTION_CORPORATE_BALANCE_SHEET       =       'Balance Sheet-Corporate';
    public static String FILE_CATEGORY_CORPORATE_INVOICES               =       'CORPORATE_INVOICES';
    public static String FILE_DESCRIPTION_CORPORATE_INVOICES            =       'Invoices-Corporate';
    public static String FILE_CATEGORY_MARKETPLACE_DOCUMENT             =       'MARKETPLACE_DOCUMENT';
    public static String FILE_DESCRIPTION_MARKETPLACE_DOCUMENT          =       'Marketplace Document';
    public static String FILE_CATEGORY_DL                               =       'DRIVING_LICENSE';
    public static String FILE_DESCRIPTION_DL                            =       'Driving License';
    public static String FILE_CATEGORY_BANK_STATEMENT                   =       'BANK_STATEMENT';
    public static String FILE_DESCRIPTION_BANK_STATEMENT                =       'Bank Statement';
    public static String FILE_CATEGORY_VAT                              =       'VAT';
    public static String FILE_DESCRIPTION_VAT                           =       'Vat Statement';
    public static String FILE_CATEGORY_PASSPORT                         =       'PASSPORT';
    public static String FILE_DESCRIPTION_PASSPORT                      =       'Passport';
    public static String APPLICATION_REJECT_STATUS                      =       'REJECTED';
    public static String APPLICATION_APPROVED_STATUS                    =       'APPROVED - APPROVED';
    public static String APPLICATION_EXPIRED_STATUS					    = 		'EXPIRED';
    public static String APPLICATION_EXPIRED_NO_DOCS_RECEIVED_STATUS	= 		'EXPIRED - LOAN DOCUMENTS NOT RECEIVED';
    public static String APPLICATION_REJ_BY_CUSTOMER_STATUS             =       'OFFER REJECTED BY CUSTOMER';
    public static String OFFER_ACCEPTED_BY_CUSTOMER                     =       'ACCEPTED';
    public static String AWAITING_CUSTOMER_TO_ACCEPT                    =       'AWAITING CUSTOMER ACCEPTANCE';
    public static String INTERNAL_RATING_1_BUSINESS                     =       'OC SME 1';
    public static String INTERNAL_RATING_2_BUSINESS                     =       'OC SME 2';
    public static String INTERNAL_RATING_3_BUSINESS                     =       'OC SME 3';
    public static String INTERNAL_RATING_4_BUSINESS                     =       'OC SME 4';
    public static String INTERNAL_RATING_1_PERSONAL_MPL                 =       'OC PLM 1';
    public static String INTERNAL_RATING_2_PERSONAL_MPL                 =       'OC PLM 2';
    public static String INTERNAL_RATING_3_PERSONAL_MPL                 =       'OC PLM 3';
    public static String INTERNAL_RATING_4_PERSONAL_MPL                 =       'OC PLM 4';
    public static String INTERNAL_RATING_1_PERSONAL_EL                  =       'OC PLE 1';
    public static String INTERNAL_RATING_2_PERSONAL_EL                  =       'OC PLE 2';
    public static String INTERNAL_RATING_3_PERSONAL_EL                  =       'OC PLE 3';
    public static String INTERNAL_RATING_4_PERSONAL_EL                  =       'OC PLE 4';
    public static String PRINCIPAL_SANCTIONED_1_BUSINESS                =       '90% of last 3 Months Marketplace Revenues';
    public static String PRINCIPAL_SANCTIONED_2_BUSINESS                =       '70% of last 3 Months Marketplace Revenues';
    public static String PRINCIPAL_SANCTIONED_3_BUSINESS                =       '60% of last 3 Months Marketplace Revenues';
    public static String PRINCIPAL_SANCTIONED_4_BUSINESS                =       '50% of last 3 Months Marketplace Revenues';
    public static String PRINCIPAL_SANCTIONED_1_PERSONAL_MPL            =       '90% of last 3 Months Marketplace Income';
    public static String PRINCIPAL_SANCTIONED_2_PERSONAL_MPL            =       '70% of last 3 Months Marketplace Income';
    public static String PRINCIPAL_SANCTIONED_3_PERSONAL_MPL            =       '60% of last 3 Months Marketplace Income';
    public static String PRINCIPAL_SANCTIONED_4_PERSONAL_MPL            =       '50% of last 3 Months Marketplace Income';
    public static String PRINCIPAL_SANCTIONED_1_PERSONAL_EL             =       '2.5 times Average Monthly Salary';
    public static String PRINCIPAL_SANCTIONED_2_PERSONAL_EL             =       '2 times Average Monthly Salary';
    public static String PRINCIPAL_SANCTIONED_3_PERSONAL_EL             =       '1.5 times Average Monthly Salary';
    public static String PRINCIPAL_SANCTIONED_4_PERSONAL_EL             =       '1 times Average Monthly Salary';
    public static String INTEREST_RATE_RANGE_1                          =       '16 to 18%';
    public static String INTEREST_RATE_RANGE_2                          =       '18 to 20%';
    public static String INTEREST_RATE_RANGE_3                          =       '20 to 22%';
    public static String INTEREST_RATE_RANGE_4                          =       '22 to 24%';    
    public static String DATA_PUSHED_TO_LMS                             =       'Data pushed to LMS successfully.';
    public static String DETAILS_UPDATED_SUCCESSFULLY                   =       'Details updated successfully for User ID: ';
    public static String CIF_ID_CREATED                                 =       'CIF ID created successfully.';
    public static String LOAN_APP_REJECTED_SUCCESSFULLY                 =       'Loan Application rejected successfully.';
    public static String ACCOUNT_DETAILS_REJECTED_SUCCESSFULLY          =       'User details rejected successfully.';
    public static String LOAN_SANCTION_DETAILS_REJECTED_BY_CUSTOMER     =       'Loan Application sanction details rejected by customer.';
    public static String LOAN_SANCTION_DETAILS_ACCEPTED_BY_CUSTOMER     =       'Loan Application sanction details accepted by customer.';
    public static String CIFID                                          =       'CIF ID';
    public static String APPLICATION_ID                                 =       'APPLICATION ID';
    public static String ENCODED_DATA                                   =       'Attachment';
    public static Boolean TRUE_VALUE                                    =       true;    
    public static Boolean FALSE_VALUE                                   =       false;
    public static String  YES                                           =       'Yes';
    public static String  NO                                            =       'No';
    public static String  ENTITY_TYPE_PUBLIC                            =       'Public Limited';
    public static String  ENTITY_TYPE_PRIVATE                           =       'Private Limited';
    public static String  ENTITY_TYPE_LLP                               =       'LLP';
    public static String  ENTITY_TYPE_SOLE                              =       'Sole Proprietorship';
    public static String  ACCOUNT_STATUS_ACTIVE                         =       'Active';
    public static String  ACCOUNT_STATUS_REJECTED                       =       'Rejected';
    public static String  SCORECARD_PERSONAL_MP_LOAN                    =       'Personal Marketplace Linked';
    public static String  SCORECARD_PERSONAL_EMP_LOAN                   =       'Personal Employer Linked';
    public static String  SCORECARD_BUSINESS_LOAN                       =       'Business';
    public static String CONTRACT_PARTIAL_APPLICATION                   =       'Partial Application';
    public static String DATABASE_EXCEPTION_CIF_CREATION                =       'Database exception encountered while creating CIF Id.';
    public static String DATABASE_EXCEPTION_PUSH_ACC_DATA_TO_LMS_PL     =       'Database exception encountered while pushing account details to LMS for Personal Loan.';
    public static String DATABASE_EXCEPTION_PUSH_CON_DATA_TO_LMS_PL     =       'Database exception encountered while pushing contact details to LMS for Personal Loan.';
    public static String DATABASE_EXCEPTION_PUSH_APP_DATA_TO_LMS_PL     =       'Database exception encountered while pushing application details to LMS for Personal Loan.';
    public static String DATABASE_EXCEPTION_PUSH_BANK_DATA_TO_LMS_PL    =       'Database exception encountered while pushing bank details to LMS for Personal Loan.';
    public static String DATABASE_EXCEPTION_PUSH_BOROW_DATA_TO_LMS_PL   =       'Database exception encountered while pushing borrower details to LMS for Personal Loan.';
    public static String DATABASE_EXCEPTION_PUSH_BANK_DATA_TO_LMS_BL    =       'Database exception encountered while pushing bank details to LMS for Business Loan.';
    public static String DATABASE_EXCEPTION_PUSH_ACC_DATA_TO_LMS_BL     =       'Database exception encountered while pushing account details to LMS for Business Loan.';
    public static String DATABASE_EXCEPTION_PUSH_CON_DATA_TO_LMS_BL     =       'Database exception encountered while pushing contact details to LMS for Business Loan.';
    public static String DATABASE_EXCEPTION_PUSH_CON_DATA_TO_LMS_BL_OE  =       'Database exception encountered while pushing contact details to LMS for other entity types for a Business Loan.';
    public static String DATABASE_EXCEPTION_PUSH_APP_DATA_TO_LMS_BL     =       'Database exception encountered while pushing application details to LMS for Business Loan.';
    public static String DATABASE_EXCEPTION_WHILE_UPDATING_DETAILS      =       'Database exception encountered while updating email or mobile number.';
    public static String DATABASE_EXCEPTION_WHILE_UPDATING_APP_DETAILS  =       'Database exception encountered while updating application details.';
    public static String DATABASE_EXCEPTION_WHILE_UPDATING_ACC_DETAILS  =       'Database exception encountered while updating account details.';
    public static String DATABASE_EXCEPTION_WHILE_UPLOADING_DOCUMENT    =       'Database exception encountered while uploading a document.';
    public static String DATABASE_EXCEPTION_SCORECARD_JUNCTION          =       'Database exception encountered while updating Scorecard details.';
    public static String EXCEPTION_CIF_CREATION                         =       'Exception encountered while creating CIF Id.';
    public static String EXCEPTION_PUSH_ACC_DATA_TO_LMS_PL              =       'Exception encountered while pushing account details to LMS for a Personal Loan.';
    public static String EXCEPTION_PUSH_CON_DATA_TO_LMS_PL              =       'Exception encountered while pushing contact details to LMS for a Personal Loan.';
    public static String EXCEPTION_PUSH_APP_DATA_TO_LMS_PL              =       'Exception encountered while pushing application details to LMS for a Personal Loan.';
    public static String EXCEPTION_PUSH_BOROW_DATA_TO_LMS_PL            =       'Exception encountered while pushing borrower details to LMS for a Personal Loan.';
    public static String EXCEPTION_PUSH_BANK_DATA_TO_LMS_PL             =       'Exception encountered while pushing bank details to LMS for a Personal Loan.';
    public static String EXCEPTION_PUSH_ACC_DATA_TO_LMS_BL              =       'Exception encountered while pushing account details to LMS for a Business Loan.';
    public static String EXCEPTION_PUSH_CON_DATA_TO_LMS_BL              =       'Exception encountered while pushing contact details to LMS for a Business Loan.';
    public static String EXCEPTION_PUSH_CON_DATA_TO_LMS_BL_OE           =       'Exception encountered while pushing contact details to LMS for other entity types for a Business Loan.';
    public static String EXCEPTION_PUSH_APP_DATA_TO_LMS_BL              =       'Exception encountered while pushing application details to LMS for a Business Loan.';
    public static String EXCEPTION_PUSH_BANK_DATA_TO_LMS_BL             =       'Exception encountered while pushing bank details to LMS for a Business Loan.';
    public static String EXCEPTION_WHILE_UPDATING_DETAILS               =       'Exception encountered while updating email or mobile number.';
    public static String EXCEPTION_WHILE_UPDATING_APP_DETAILS           =       'Exception encountered while updating application details.';
    public static String EXCEPTION_WHILE_UPDATING_ACC_DETAILS           =       'Exception encountered while updating account details.';
    public static String EXCEPTION_WHILE_UPLOADING_DOCUMENT             =       'Exception encountered while uploading a document.';
    public static String EXCEPTION_WHILE_UPDATING_LRS		            =       'Exception encountered while updating Loan Repayment Schedule.';
    public static String QUERY_EXCEPTION_RETRIEVING_LOAN_STATUS         =       'Query exception encountered while retrieving Loan Status.';
    public static String QUERY_EXCEPTION_RETRIEVING_SCORECARD           =       'Query exception encountered while retrieving Scorecard.';
    public static String QUERY_EXCEPTION_RETRIEVING_CONTRACT_STATUS     =       'Query exception encountered while retrieving Contract Status.';
    public static String QUERY_EXCEPTION_RETRIEVING_APP_ID              =       'Query exception encountered while retrieving Loan Application Id.';
    public static String QUERY_EXCEPTION_RETRIEVING_LOAN_TYPE           =       'Query exception encountered while retrieving Loan type.';
    public static String QUERY_EXCEPTION_RETRIEVING_ACCOUNT_DETAILS     =       'Query exception encountered while retrieving Account details.';
    public static String QUERY_EXCEPTION_RETRIEVING_CONTACT_DETAILS     =       'Query exception encountered while retrieving Contact details.';
    public static String QUERY_EXCEPTION_RETRIEVING_APPLICATION_DETAILS =       'Query exception encountered while retrieving application details.';
    public static String QUERY_EXCEPTION_RETRIEVING_BANK_DETAILS        =       'Query exception encountered while retrieving bank details.';
    public static String QUERY_EXCEPTION_RETRIEVING_CONTRACT_DETAILS    =       'Query exception encountered while retrieving contract details.';
    public static String QUERY_EXCEPTION_RETRIEVING_LRS_DETAILS 	    =       'Query exception encountered while retrieving Loan Repayment Schedule details.';
    public static String QUERY_EXCEPTION_RETRIEVING_APP_CON_LPS_DETAILS =       'Query exception encountered while retrieving either Loan Application or Loan Contract or Loan Repayment Schedule details.';
    public static String EXCEPTION_RETRIEVING_LOAN_STATUS               =       'Exception encountered while retrieving Loan Status.';
    public static String EXCEPTION_RETRIEVING_APP_ID                    =       'Exception encountered while retrieving Loan Id.';
    public static String EXCEPTION_RETRIEVING_LOAN_TYPE                 =       'Exception encountered while retrieving Loan type.';
    public static String EXCEPTION_RETRIEVING_ACCOUNT_DETAILS           =       'Exception encountered while retrieving Account details.';
    public static String EXCEPTION_RETRIEVING_CONTACT_DETAILS           =       'Exception encountered while retrieving Contact details.';
    public static String EXCEPTION_RETRIEVING_APPLICATION_DETAILS       =       'Exception encountered while retrieving application details.';
    public static String EXCEPTION_RETRIEVING_BANK_DETAILS              =       'Exception encountered while retrieving bank details.';
    public static String EXCEPTION_RETRIEVING_CONTRACT_DETAILS          =       'Exception encountered while retrieving contract details.';
    
    public static String EXCEPTION_RETRIEVING_CONTRACT_STATUS           =       'Exception encountered while retrieving Contract Status.';
    public static String CIF_ID_NOT_CREATED                             =       'CIF ID creation failed.';
    public static String CANNOT_CREATE_CIF_FOR_USER_ID                  =       'CIF ID cannot be created for an already existing User Id and Prospect Number combination.';
    
    /*Error Messages*/
    public static String TYPE_OF_LOAN_BLANK                             =       'Type of Loan is a mandatory field. Kindly provide a valid value.';
    public static String EMAIL_ID_BLANK                                 =       'Email ID is a mandatory field. Kindly provide a valid value.';
    public static String MOBILE_NUMBER_BLANK                            =       'Mobile Number is a mandatory field. Kindly provide a valid value.';
    public static String FIRST_NAME_BLANK                               =       'First Name is a mandatory field. Kindly provide a valid value.';
    public static String LAST_NAME_BLANK                                =       'Last Name is a mandatory field. Kindly provide a valid value.';
    public static String DATE_OF_BIRTH_BLANK                            =       'Date of birth is a mandatory field. Kindly provide a valid value.';
    public static String USER_ID_BLANK                                  =       'User ID is a mandatory field. Kindly provide a valid value.';
    public static String PROSPECT_ID_BLANK                              =       'Prospect ID is a mandatory field. Kindly provide a valid value.';
    public static String CIF_ID_BLANK                                   =       'CIF ID is a mandatory field. Kindly provide a valid value.';
    public static String PAN_NUMBER_BLANK                               =       'PAN Number is a mandatory field. Kindly provide a valid value.';
    public static String VOTER_ID_STATE_BLANK                           =       'Voter ID State cannot be blank when Voter ID value is entered.';
    public static String VOTER_ID_DISTRICT_BLANK                        =       'Voter ID District cannot be blank when Voter ID value is entered.';
    public static String DRIVING_LICENSE_STATE_BLANK                    =       'Driving License State cannot be blank when Driving License value is entered.';
    public static String OPTIONAL_UNIQUE_IDENTIFIERS_BLANK              =       'Either AADHAAR Number or Voter ID or Passport Number or Driving License must have a value.';
    public static String COMPANY_NAME_BLANK                             =       'Company name is a mandatory field. Kindly provide a valid value.';
    public static String USER_ID_BLANK_PUSH_TO_LMS                      =       'User ID cannot be blank while pushing data to LMS.';
    public static String NO_CIF_RECORDS_FOR_USER_ID                     =       'No matching records found for the User ID and CIF ID combination.';
    public static String PROSPECT_ID_ALREADY_PRESENT                    =       'The mentioned Prospect number already exists in the LMS System.';
    public static String NO_CONTACT_RECORDS_FOR_USER_ID                 =       'No matching Contact records found for the User ID provided.';
    public static String ACCOUNT_ID_BLANK                               =       'CIF ID or Account ID cannot be blank.';
    public static String CONTACT_ID_BLANK                               =       'Contact ID related to the CIF cannot be blank.';
    public static String GENDER_IS_MANDATORY                            =       'Gender is a mandatory field. Kindly provide a valid value.';
    public static String DATE_OF_BIRTH_IS_MANDATORY                     =       'Date of birth is a mandatory field. Kindly provide a valid value.';
    public static String LOAN_AMOUNT_IS_MANDATORY                       =       'Loan amount is a mandatory field. Kindly provide a valid value.';
    public static String LOAN_TENURE_IS_MANDATORY                       =       'Loan tenure is a mandatory field. Kindly provide a valid value.';
    public static String PAN_IS_MANDATORY                               =       'PAN number is a mandatory field. Kindly provide a valid value.';
    public static String WAREHOUSE_PREMISES_IS_MANDATORY                =       'Warehouse Premises is a mandatory field. Kindly provide a valid value.';
    public static String BUSINESS_PREMISES_IS_MANDATORY                 =       'Business Premises is a mandatory field. Kindly provide a valid value.';
    public static String PERMANENT_ADDRESS_IS_MANDATORY                 =       'Permanent address is a mandatory field. Kindly provide a valid value.';
    public static String PERMANENT_ADDRESS_CITY_IS_MANDATORY            =       'Permanent address city is a mandatory field. Kindly provide a valid value.';
    public static String PERMANENT_ADDRESS_STATE_IS_MANDATORY           =       'Permanent address state is a mandatory field. Kindly provide a valid value.';
    public static String PERMANENT_ADDRESS_PINCODE_IS_MANDATORY         =       'Permanent address pin code is a mandatory field. Kindly provide a valid value.';
    public static String PRESENT_ADDRESS_IS_MANDATORY                 	=       'Present address is a mandatory field. Kindly provide a valid value.';
    public static String PRESENT_ADDRESS_CITY_IS_MANDATORY            	=       'Present address city is a mandatory field. Kindly provide a valid value.';
    public static String PRESENT_ADDRESS_STATE_IS_MANDATORY           	=       'Present address state is a mandatory field. Kindly provide a valid value.';
    public static String PRESENT_ADDRESS_PINCODE_IS_MANDATORY         	=       'Present address pin code is a mandatory field. Kindly provide a valid value.';
    public static String SUB_LOAN_TYPE_EMPLOYER_LINKED                  =       'Employer Linked';
    public static String SUB_LOAN_TYPE_MARKETPLACE_LINKED               =       'Marketplace Linked';
    public static String SUB_LOAN_TYPE_MANDATORY                        =       'Sub loan type is a mandatory field. Kindly provide a valid value.';
    public static String EMPLOYMENT_ID_MANDATORY                        =       'Employment ID is mandatory for Employer Linked details.';
    public static String EMPLOYER_NAME_MANDATORY                        =       'Employer Name is mandatory for Employer Linked details.';
    public static String TOTAL_WORK_EXPERIENCE_MANDATORY                =       'Total work experience is mandatory for Employer Linked details.';
    public static String PRIMARY_MARKETPLACE_MANDATORY                  =       'Primary marketplace is mandatory for Marketplace Linked details.';
    public static String PRIMARY_MERCHANT_ID_MANDATORY                  =       'Primary marketplace merchant ID is mandatory for Marketplace Linked details.';
    public static String MARKETPLACE_EXPERIENCE_MANDATORY               =       'Primary Marketplace experience is a mandatory field. Kindly enter a valid value.';
    public static String ALL_SECOND_MARKETPLACE_DETAILS_NOT_ENTERED     =       'Kindly ensure all the Marketplace details (Marketplace Name,ID,Experience) for the Second Marketplace have been entered.';
    public static String ALL_THIRD_MARKETPLACE_DETAILS_NOT_ENTERED      =       'Kindly ensure all the Marketplace details (Marketplace Name,ID,Experience) for the Third Marketplace have been entered.';
    public static String ALL_OTHER_MARKETPLACE_DETAILS_NOT_ENTERED      =       'Kindly ensure all the Marketplace details (Marketplace Name,ID,Experience) for the Other Marketplace have been entered.';
    public static String LIABILITY_DETAILS_DEBT_MANDATORY               =       'Do you have any existing debt is a mandatory field. Kindly provide a valid value.';
    public static String DO_YOU_LIVE_IN_MANDATORY                       =       'Do you live in is a mandatory field. Kindly provide a valid value.';
    public static String BANK_ACCOUNT_NUMBER_MANDATORY                  =       'Bank Account number is a mandatory field. Kindly provide a valid value.';
    public static String BANK_NAME_MANDATORY                            =       'Bank name is a mandatory field. Kindly provide a valid value.';
    public static String BANK_IFSC_CODE_MANDATORY                       =       'Bank IFSC Code is a mandatory field. Kindly provide a valid value.';
    public static String BANK_ACCOUNT_TYPE_MANDATORY                    =       'Bank Account Type is a mandatory field. Kindly provide a valid value.';
    public static String LOAN_AMOUNT_RANGE_PL                           =       'Loan Amount cannot be less than 50,000 and cannot be more than 5,00,000.';
    public static String LOAN_TENURE_RANGE_PL                           =       'Loan Tenure cannot be less than 1 month and cannot be more than 12 months.';
    public static String LOAN_AMOUNT_RANGE_BL                           =       'Loan Amount cannot be less than 2,00,000 and cannot be more than 50,00,000.';
    public static String LOAN_TENURE_RANGE_BL                           =       'Loan Tenure cannot be less than 1 month and cannot be more than 12 months.';
    public static String COMPANY_NAME_MANDATORY                         =       'Company Name is a mandatory field. Kindly provide a valid value.';
    public static String ENTITY_TYPE_MANDATORY                          =       'Entity Type is a mandatory field. Kindly provide a valid value.';
    public static String DATE_OF_INCORPORATION_MANDATORY                =       'Date of incorporation is a mandatory field. Kindly provide a valid value.';
    public static String PAN_OF_BUSINESS_BLANK                          =       'PAN of Business is a mandatory field. Kindly provide a valid value.';
    public static String VAT_NUMBER_BLANK                               =       'VAT number is a mandatory field. Kindly provide a valid value.';
    public static String REGISTERED_OFFICE_ADDRESS_MANDATORY            =       'Registered Office Address is a mandatory field. Kindly provide a valid value.';
    public static String REGISTERED_OFFICE_ADDRESS_CITY_MANDATORY       =       'Registered Office Address City is a mandatory field. Kindly provide a valid value.';
    public static String REGISTERED_OFFICE_ADDRESS_STATE_MANDATORY      =       'Registered Office Address State is a mandatory field. Kindly provide a valid value.';
    public static String REGISTERED_OFFICE_ADDRESS_PINCODE_MANDATORY    =       'Registered Office Address Pincode is a mandatory field. Kindly provide a valid value.';
    public static String CASH_CREDIT_OVERDRAFT_MANDATORY                =       'Do you have a cash credit or overdraft account is a mandatory field. Kindly provide a valid value.';
    public static String DIN_NUMBER_MANDATORY                           =       'DIN number is mandatory when Entity type is either Public Limited or Private Limited.';
    public static String DPIN_NUMBER_MANDATORY                          =       'DPIN number is mandatory when Entity type is LLP.';
    public static String PARTNER_DETAILS_REQUIRED                       =       'Partner/Director/Member details are required for a company not of entity type Sole Proprietorship.';
    public static String PARTNER_DETAILS_EXCEED_LIMIT                   =       'Maximum of 2 Partner/Director/Member details can be provided.';
    public static String PRIMARY_MARKETPLACE_MANDATORY_BL               =       'Primary marketplace is a mandatory field. Kindly provide a valid value.';
    public static String MERCHANT_ID_1_MANDATORY                        =       'Merchant ID 1 is a mandatory field. Kindly provide a valid value.';
    public static String NEW_LOAN_APP_CANNOT_BE_CREATED                 =       'New loan application cannot be created as there is an open Loan/Contract for this user .';
    public static String NO_LOAN_APP_FOUND_FOR_USER_ID                  =       'No Loan application found in the system for the mentioned User ID.';
    public static String NO_LOAN_TYPE_LINKED_TO_USER_ID                 =       'Loan type is not linked to the User ID.';
    public static String ACCOUNT_DETAILS_NOT_FOUND                      =       'Account details not found for the User ID.';
    public static String CONTACT_DETAILS_NOT_FOUND                      =       'Contact details not found for the User ID.';
    public static String APPLICATION_DETAILS_NOT_FOUND                  =       'Application details not found for the User ID.';
    public static String BANK_DETAILS_NOT_FOUND                         =       'Bank account details not found for the User ID.';
    public static String BOTH_EMAIL_AND_MOBILE_NUMBER_MISSING           =       'Either Email or Mobile Number must be entered for updation.';
    public static String DATE_OF_REJECTION_BLANK                        =       'Date of rejection is a mandatory field. Kindly provide a valid value.';
    public static String NO_LOAN_RECORD_FOR_PROSPECT_ID                 =       'No record found for the User Id and CIF Id combination.';
    public static String NO_LOAN_RECORD_FOR_USER_PROSPECT_ID            =       'No record found for the User Id and Prospect Id combination.';
    public static String REASON_FOR_REJECTION_NOT_FOUND                 =       'Reason for rejection is mandatory when the user rejects the offer. Kindly provide a valid value.';
    public static String SANCTION_DETAILS_RESPONSE_NOT_FOUND            =       'Sanction details response is a mandatory field. Kindly provide a valid value.';
    public static String SANCTION_DETAILS_NOT_AS_PER_STANDARDS          =       'Sanction details response should either be ACCEPTED or REJECTED.';
    public static String USER_ACTION_NOT_POSSIBLE_ON_LOAN_APP           =       'User action is not allowed on this loan application having loan status as: ';
    public static String FILE_NAME_IS_BLANK                             =       'File Name is a mandatory field. Kindly provide a valid value.';
    public static String FILE_CATEGORY_IS_BLANK                         =       'File Category is a mandatory field. Kindly provide a valid value.';
    public static String REQUEST_BODY_FOR_DOC_UPLOAD_IS_BLANK           =       'Request body for document upload cannot be blank. Kindly provide a valid value.';
    public static String DOCUMENT_UPLOAD_SUCCESS                        =       'Document(s) uploaded successfully.';
    public static String INVALID_DOCUMENT_CATEGORY                      =       'Invalid Document Category.';
    public static String ERROR_PROCESSING_CUST_DASHBOARD_DATA           =       'Error encountered while processing Customer Dashboard data.';
    public static String SCORECARD_SETUP_MISSING                        =       'Setup data missing. Kindly contact your administrator.';
    public static String SOCIAL_DETAILS_SCORE_APP_STATUS_MISMATCH       =       'Social details score cannot be updated in the LMS system for this loan application, whose current status is: ';
    public static String SOCIAL_DETAILS_SCORE_UPDATED                   =       'Social details updated Successfully.';
    public static String SOCIAL_DETAILS_SCORE_BLANK                     =       'Social Details Score is a mandatory field. Kindly provide a valid value.';
    public static String ERROR_WHILE_CREATING_CL_CONTRACT               =       'Error encountered while creating a Loan Contract.';
    public static String CL_CONTRACT_SETUP_DATA_MISSING                 =       'Setup data missing. Kindly contact your administrator.';
    public static String FILE_TYPE_BLANK                                =       'File Type is a mandatory field. Kindly provide a valid value.';
    public static String LOAN_CONTRACT_DETAILS_NOT_FOUND                =       'Loan Contract details not found for the mentioned User Id and Prospect Id combination.';
    public static String LOAN_DOCS_NOT_GENERATED                        =       'The required Loan Document has not yet been generated. Kindly try after some time.';
    public static String QUERY_EXCEPTION_FETCHING_ATTACHMENT            =       'Query exception encountered while fetching attachment details.';
    public static String LOAN_DOCUMENT_FETCHED_SUCCESSFULLY             =       'Loan document fetched successfully.';
    public static String INVALID_FILE_TYPE                              =       'File Type specified for download is not valid.';
    public static String DATA_PUSH_ACCOUNT_REJECTED                     =       'Data cannot be sent to the LMS system as the CIF details were Rejected.';
    public static String INVALID_FILE_FORMAT_FOR_UPLOAD                 =       'Invalid File Format. Kindly upload a CSV format file.';
    public static String NO_DATA_IN_CSV                                 =       'No data in the uploaded CSV file.';
    public static String CSV_FILE_COLUMNS_NOT_ORDERED                   =       'Kindly ensure that the columns in the uploaded CSV file are properly ordered.';
    public static String CHECK_EITHER_SUCCESS_FAILURE_OPTION            =       'Kindly check either Success or Failure checkbox for procesing the CSV file.';
    public static String ERROR_WHILE_UPLOADING_BILLS                    =       'Error encountered while uploading Bills. Kindly contact your Administrator.';
    public static String ERROR_WHILE_CREATING_LPT                       =       'Error encountered while creating a Loan Payment Transaction. Kindly contact your Administrator.';
    public static String ERROR_WHILE_CREATING_MANDATE_ACKNOWLEDGEMENT   =       'Error encountered while creating a Mandate Acknowledgement. Kindly contact your Administrator.';
    public static String EMI_CSV_SENT_SUCCESSFULLY					    =       'The Monthly EMI CSV file has been sent to the registered Email Id of OptaCredit Administrator.';
    public static String NO_EMAIL_CONFIGURED_IN_CUSTOM_SETTING		    =       'Setup Data Missing. No Email Id has been registered as OptaCredit Administrator.';
    public static String MANDATE_CSV_SENT_SUCCESSFULLY				    =       'The Mandate CSV file has been sent to the registered Email Id of OptaCredit Administrator.';
    public static String TALLY_XML_SENT_SUCCESSFULLY				    =       'An XML file has been sent to the registered Email Id of OptaCredit Administrator.';
    public static String NO_DATA_PRESRNT_TO_SEND_TO_TALLY			    =       'No new Data is available for generating an XML for Tally.';
    public static String NO_LOANS_TO_GENERATE_EMI_FOR				    =       'Currently there are no Loan Contract(s) in the System for which monthly EMI is due.';
    public static String NO_LOANS_TO_GENERATE_MANDATE_FOR			    =       'Currently there are no Loan Contract(s) in the System for which Mandates have to be registered.';
    public static String OTHERS_MANDATORY							    =       'Comments/Others is mandatory when the Source is anything other than Social Network or Search Engine.';
    public static String NO_LOAN_APPLICATION_FOR_MANDATE_REGISTRATION   =       'No Loan Application(s) found for Mandate Registration.';
    public static String NO_REPAYMENT_SCH_FOR_MANDATE_REGISTRATION		=       'Repayment Schedule not generated for one or more Loan Contract(s).';
    public static String  DATABASE_EXCEPTION_UPDATE_DETAILS 			=       'Database exception encountered while updating disbursal and payment transactions details.';
    public static String  NO_FILE_CHOOSEN_FOR_UPLOAD 					=       'No file chosen for Upload. Kindly select a valid file and try Uploading.';
    public static String  LPT_CREATED_SUCCESSFULLY 						=       'Loan Payment Transaction(s) created Successfully.';
    
    
    
    /*Following contants are added for CIBIL Request:  START*/
    public static String SOURCE_SYSTEM_NAME                             =       'DIRECT';
    public static String BUREAU_REGION                                  =       'QA/UAT';
    public static String BUREAU_REGION_PROD                             =       'Production';
    public static String ADDRESS_TYPE_INDIVIDUAL                        =       'RESIDENCE';
    
    /*Following contants are added for CIBIL Request:  END*/
    
    public static String STATUS_FIELD                                   =       'STATUS';
    public static String CIBIL_ACKNOWLEDGEMENT_ID_FIELD                 =       'ACKNOWLEDGEMENT-ID';
    public static String CIBIL_ERROR_DESCRIPTION_FIELD                  =       'DESCRIPTION';
    public static String CIBIL_ACKNOWLEDGEMENT_SUCCESS                  =       'SUCCESS';
    public static String CIBIL_ACKNOWLEDGEMENT_ERROR                    =       'ERROR';
    public static String CIBIL_ISSUE_SUCCESS_RESPONSE                   =       'COMPLETED';
    public static String CIBIL_ISSUE_INPROCESS_RESPONSE                 =       'IN-PROCESS';
    public static String CIBIL_ISSUE_DLQUEUE_RESPONSE                   =       'DL-QUEUE';
    public static String CIBIL_BUREAU_ERROR			                    =       'BUREAU-ERROR';
    
    public static String APPROVED_STATUS                                =       'Approved';
    public static String REJECTED_STATUS                                =       'Rejected';
    
    /*Default values used in web services*/
    public static String BUSINESS_PREMISES_DEFAULT_VALUE                =       'Rented';
    public static String WAREHOUSE_PREMISES_DEFAULT_VALUE               =       'Rented';
    public static String ENTITY_TYPE_DEFAULT_VALUE                      =       'Sole Proprietorship';
    
    /*Constants added for Jocata*/
    public static String JSON_PAN_RES_STATUSCODE                        =       'statusCode';
    public static String JSON_PAN_RES_PANID                             =       'PAN Id';
    public static String JSON_PAN_RES_FIRST_NAME                        =       'First-Name';
    public static String JSON_PAN_RES_MIDDLE_NAME                       =       'Middle-Name';
    public static String JSON_PAN_RES_LAST_NAME                         =       'Last-Name';
    public static String JSON_PAN_RES_PAN_STATUS                        =       'PAN-Status';
    public static String JSON_AADHAAR_RES_STATUS                        =       'AuthenticateStatus';
    public static String JSON_AADHAAR_RES_AUTH_AADHAAR                  =       'AuthenticateAadhaar';
    public static String MALE                                           =       'MALE';
    public static String FEMALE                                         =       'FEMALE';
    public static String MALE_M                                         =       'M';
    public static String FEMALE_F                                       =       'F';
    public static String PAN_NOT_FOUND_RES                              =       'Record (PAN) Not Found in ITD Database/Invalid PAN';
    public static String DL_STATE_MADHYA_PRADESH                        =       'Madhya Pradesh';
    public static String DL_STATE_MP                                    =       'MP';
    public static String DL_STATE_TELANGANA                             =       'Telangana';
    public static String DL_STATE_TG                                    =       'TG';
    public static String DL_STATE_KERALA                                =       'Kerala';
    public static String DL_STATE_KL                                    =       'KL';
    public static String DL_STATE_DELHI                                 =       'Delhi';
    public static String DL_STATE_DL                                    =       'DL';
    public static String JSON_DL_RES_DL_NUM                             =       'DrivingLicense No.';
    public static String JSON_DL_RES_DL_NAME                            =       'Name';
    public static String JSON_DL_RES_DL_FOH_NAME                        =       'Father/Husband Name';
    public static String JSON_DL_RES_DL_FOH_ADDRESS                     =       'Address';
    public static String JSON_DL_RES_DL_FOH_TRANS_VALIDITY              =       'Non Transport Validity';
    public static String JSON_DL_RES_DL_FOH_NON_TRANS_VALIDITY          =       'Transport Validity';
    
    /*Constants added for the LOG Details object*/
    public static String SERVICE_PROVIDER_SOFTCELL_CIBIL                =       'Softcell CIBIL Details';
    public static String SERVICE_PROVIDER_JOCATA_PAN                    =       'Jocata PAN Details';
    public static String SERVICE_PROVIDER_JOCATA_AADHAAR                =       'Jocata AADHAAR Details';
    public static String SERVICE_PROVIDER_JOCATA_VOTER_ID               =       'Jocata Voter ID Details';
    public static String SERVICE_PROVIDER_JOCATA_DL                     =       'Jocata Driving License Details';
    public static String SERVICE_PROVIDER_JOCATA_TIN                    =       'Jocata TIN Details';
    public static String SERVICE_PROVIDER_JOCATA_COMPANY_INFO           =       'Jocata Company Information Details';
    public static String SERVICE_PROVIDER_JOCATA_CONTACT_POINT          =       'Jocata Contact Point Details';
    public static String SERVICE_PROVIDER_JOCATA_CST                    =       'Jocata CST Details';
    public static String SERVICE_PROVIDER_JOCATA_ITR                    =       'Jocata ITR Details';
    public static String SERVICE_PROVIDER_JOCATA_DIN                    =       'Jocata DIN Details';
    public static String SERVICE_PROVIDER_JOCATA_TAN                    =       'Jocata TAN Details';   
       
    /*Error and Exception codes to capture a scenario for 3rd party integrations*/
    
    public static String DML_EXCEPTION_JOCATA                           =       'ERROR0001';
    public static String EXCEPTION_JOCATA                               =       'ERROR0002';
    public static String DML_EXCEPTION_WHILE_LOGGING_DETAILS            =       'ERROR0023';
    public static String EXCEPTION_WHILE_LOGGING_DETAILS                =       'ERROR0024';
    public static String EXCEPTION_RETRIEVING_PAN_DATA_JOCATA           =       'ERROR0025';
    public static String INVALID_INPUT_PAN_DATA_JOCATA                  =       'ERROR0026';
    public static String QUERY_EXCEPTION_BORROWER_DETAILS               =       'ERROR0027';
    public static String EXCEPTION_BORROWER_DETAILS                     =       'ERROR0028';
    public static String EXCEPTION_RETRIEVING_AADHAAR_DATA_JOCATA       =       'ERROR0029';
    public static String INVALID_INPUT_AADHAAR_DATA_JOCATA              =       'ERROR0030';
    public static String REQUIRED_DATA_MISSING_AADHAAR_JOCATA           =       'ERROR0031';
    public static String NO_RESPONSE_RETURNED_AADHAAR_JOCATA            =       'ERROR0032';
    public static String NO_RESPONSE_RETURNED_PAN_JOCATA                =       'ERROR0033';
    public static String NO_RECORD_FOUND_PAN_JOCATA                     =       'ERROR0034';
    /*Driving License Number of the applicant is not available to fetch the details.*/
    public static String DL_NUMBER_NULL_JOCATA                          =       'ERROR0035';
    /*Driving License validation is not supported for this State/Union Territory.*/
    public static String DL_STATE_NO_SUPPORT_JOCATA                     =       'ERROR0036';
    /*No Driving License details are associated with this applicant.*/
    public static String DL_DETAILS_NOT_FOUND                           =       'ERROR0037';
    /*AADHAAR Number of the applicant is not available to fetch the details.*/
    public static String AADHAAR_NUMBER_NULL_JOCATA                     =       'ERROR0038';
    /*Database exception encountered while fetching application details.*/
    public static String DML_EXCEPTION_FETCH_APP_DETAILS_CIBIL          =       'ERROR0039';
    /*Exception encountered while fetching application details.*/
    public static String EXCEPTION_FETCH_APP_DETAILS_CIBIL              =       'ERROR0040';
    /*Exception encountered while sending data to CIBIL.*/
    public static String CALL_OUT_EXCEPTION_CIBIL                       =       'ERROR0041';
    /*CIBIL response returned an error..*/
    public static String CIBIL_RESPONSE_ERROR                           =       'ERROR0042';
    public static String NO_RECORD_FOUND_VOTERID_JOCATA                 =       'ERROR0043';
    /*Database exception encountered while fetching application details.*/
    public static String QE_EXCEPTION_FETCH_APP_DETAILS_CIBIL           =       'ERROR0044';
    /*Query exception encountered while fetching application details.*/
    public static String QE_EXCEPTION_FETCH_APP_DETAILS                 =       'ERROR0045';
    /*Application details not found.*/
    public static String APP_DETAILS_NOT_FOUND                          =       'ERROR0046';
    /*Score card details not found.*/
    public static String SCORECARD_DETAILS_NOT_FOUND                    =       'ERROR0047';
    /*Score is below the minimum limit.Kindly ensure all the details in the Prerequisites tab have been entered and recalculate the score in the Credit-Scoring Matrix tab.*/
    public static String ALL_THE_DETAILS_MAY_NOT_BE_ENTERED             =       'ERROR0048';
    /*DML Exception encountered while upserting data into application.*/
    public static String DML_EXCEPTION_WHILE_SAVING_APP_DATA            =       'ERROR0049';
    /*Kindly ensure that the Voter ID details are present in the system before fetching the details.*/
    public static String VOTER_ID_BLANK                                 =       'ERROR0050';
    /*Loan Application details not found.*/
    public static String LOAN_APP_DETAILS_NOT_FOUND                     =       'ERROR0051';
    /*Loan Contact can only be created for a Loan Application whose status is APPROVED - APPROVED.*/
    public static String LOAN_APP_STATUS_NOT_VALID                      =       'ERROR0052';
    /*Error encountered while creating a Loan Contract.*/
    public static String ERROR_CL_CONTRACT_CREATE                       =       'ERROR0053';
    /*Setup data missing. Kindly contact your Administrator*/
    public static String SETUP_DATA_NOT_FOUND                           =       'ERROR0054';
    /*Exception while fetching setup data*/
    public static String EXCEPTION_FETCHING_SETUP_DATA_MISSING          =       'ERROR0055';
    /*Exception encountered while generating a Loan Document*/
    public static String EXCEPTION_WHILE_GENERATING_LOAN_DOCUMENT       =       'ERROR0056';
    /*Static resource for the Loan Document not found*/
    public static String STATIC_RESOURCE_NOT_FOUND_FOR_LOAN_DOCUMENT    =       'ERROR0057';
    /*Loan Document cannot be generated as Loan Contract does not exist for this Loan Application.*/
    public static String LOAN_DOCUMENT_CANNOT_BE_GENERATED              =       'ERROR0058';
    /*Error encountered while fetching Bureau Score*/
    public static String ERROR_ENCOUNTERED_WHILE_FETCHING_CIBIL_SCORE   =       'ERROR0059';
    /*Exception encountered while saving Bureau data in LMS System*/
    public static String EXCEPTION_ENCOUNTERED_WHILE_SAVING_DATA        =       'ERROR0060';
    /*Exception encountered while saving Bureau data in LMS System*/
    public static String CIBIL_SETUP_DATA_MISSING                       =       'ERROR0061';
        /*Error encountered while retrieving details from Bank Statement*/
    public static String DETAILS_RETRIEVED_ERROR_PERFIOS                =       'ERROR0062';
        /*Exception encountered while fetching Bank Statement details*/
    public static String XML_EXCEPTION_PERFIOS                          =       'ERROR0063';
        /*Exception encountered while saving Bank Statement details*/
    public static String EXCEPTION_SAVING_PERFIOS_DATA                  =       'ERROR0064';
        /*Kindly upload the XML format of the Bank Statement report before fetching the details. */
    public static String XML_REPORT_NOT_FOUND_PERFIOS                   =       'ERROR0065';
    /*No Loan Contract found for this Loan Application*/
    public static String NO_CL_CONTRACT_FOUND                           =       'ERROR0066';
    /*Loan Application cannot be closed as the associated Loan Contract is not yet closed.*/
    public static String LOAN_APPLICATION_CANNOT_BE_CLOSED              =       'ERROR0067';
        /*Exception encountered while closing the Loan Application.*/
    public static String EXCEPTION_WHILE_CLOSING_LOAN_APPLICATION       =       'ERROR0068';
       /*No Dues Certificate cannot be sent for a Loan Application that is not Closed.*/
    public static String NO_DUES_CERTIFICATE_CANNOT_BE_SENT            =       'ERROR0069';
    /*Exception encountered while sending No Dues Certificate.*/
    public static String EXCEPTION_WHILE_SENDING_NO_DUES_CERTIFICATE    =       'ERROR0070';
    /*Added by Poulomi : Start */
    /*Exception while changing the application status*/
    public static String EXCEPTION_CHANGING_APPLICATION_STATUS          =       'ERROR0071';
  /*Exception while updating the Loan Account */
    public static String EXCEPTION_UPDATING_LOAN_ACCOUNT                =       'ERROR0072';    
  /*Exception while Fetching the Loan Product */
    public static String EXCEPTION_FETCHING_LOAN_PRODUCT                =       'ERROR0073';
    /*Exception while Creating Floating Rate Index */
    public static String EXCEPTION_CREATING_FLOATING_RATE_INDEX         =       'ERROR0074';
    /*Exception while Creating Floating Rate */
    public static String EXCEPTION_CREATING_FLOATING_RATE               =       'ERROR0075';
    /*Exception while Updating Loan Product */
    public static String EXCEPTION_UPDATING_LOAN_PRODUCT                =       'ERROR0076';
    
    /*Exception while Creating Loan Disbursal Transaction */
    public static String EXCEPTION_CREATING_LOAN_DISBURSAL_TRANSACTION  =       'ERROR0077';
    
    /*Exception while Creating Loan Payment Transaction */
    public static String EXCEPTION_CREATING_LOAN_PAYMENT_TRANSACTION    =       'ERROR0078';
    
    /*Exception while Updating Loan Repayment Schedule */
    public static String EXCEPTION_UPDATING_LOAN_REPAYMENT_SCHEDULE     =       'ERROR0079';
       
    /*A Loan Contract is already associated with this Application.*/
    public static String ERROR_CL_CONTRACT_EXISTS                       =       'ERROR0081';
    /*Loan Contract is not associated with this Application*/
    public static String ERROR_CL_CONTRACT_NOT_EXISTS                   =       'ERROR0082';
    
    /*Disbursal Transaction successfully created*/
    public static String SUCCESS_DISBURSAL_TRANSACTION                  =       'Disbursal Transaction successfully created';
    /*Loan Contract can only be created after the customer has accepted the Loan offer.*/
    public static String LOAN_CONTRACT_CREATE_AFTER_OFFER_ACCEPTANCE    =       'ERROR0083';
    /*Added by Poulomi : End */
    /*Loan Application can be marked as Expired only for applications that are in APPROVED - APPROVED status.*/
    public static String LOAN_APP_CANNOT_BE_MARKED_AS_EXPIRED    	    =       'ERROR0084';
    /*Loan Application cannot be marked as Expired before 21 days from the date of sending the first set of documents.*/
    public static String LOAN_APP_CANNOT_BE_EXPIRED_BEFORE_21_DAYS 	    =       'ERROR0085';
    /*The details of the Documents that were sent to the Customer have not yet been updated in the System.*/
    public static String DOCUMENT_SENT_DATE_ON_BLANK					=       'ERROR0086';
    /*Exception encountered while marking the Loan Application as Expired.*/
    public static String EXCEPTION_WHILE_EXPIRING_LOAN_APP	            =       'ERROR0087';
    /*Error encountered while generating an Acknowledgement ID.*/
    public static String ACKNOWLEDGEMENT_ID_GENERATION_ERROR            =       'ERROR0088';
    /*The Bureau is in the process of computing the Score. Kindly try after 30 seconds.*/
    public static String ISSUE_REQUEST_IN_PROCESS			            =       'ERROR0089';
    /*The Bureau is in the process of computing the Score. Kindly try after some time.*/
    public static String ISSUE_REQUEST_IN_DL_QUEUE			            =       'ERROR0090';
    /*Either the request is in Queue for processing or some internal error(s) has or have been encountered.*/
    public static String ISSUE_RESPONSE_REJECTED			            =       'ERROR0091';
    /*The request is still being processed. Kindly try after some time. */
    public static String ISSUE_RESPONSE_IN_PROCESS			            =       'ERROR0092';
    /*A Bureau error has been encountered while processing the request.*/
    public static String ISSUE_RESPONSE_COMPLETED_WITH_ERROR            =       'ERROR0093';
    
    /*Success codes to capture a scenario for 3rd party integrations*/
    public static String SUCCESS_JOCATA_PAN                             =       'SUCCESS0001';
    public static String SUCCESS_JOCATA_AADHAAR                         =       'SUCCESS0002';
    public static String SUCCESS_JOCATA_VOTER_ID                        =       'SUCCESS0003';
    public static String SUCCESS_JOCATA_DL                              =       'SUCCESS0004';
    public static String SUCCESS_JOCATA_TIN                             =       'SUCCESS0005';
    public static String SUCCESS_JOCATA_COMPANY_INFO                    =       'SUCCESS0006';
    public static String SUCCESS_JOCATA_CONTACT_POINT                   =       'SUCCESS0007';
    public static String SUCCESS_JOCATA_CST                             =       'SUCCESS0008';
    public static String SUCCESS_JOCATA_ITR                             =       'SUCCESS0009';
    public static String SUCCESS_JOCATA_DIN                             =       'SUCCESS0010';
    public static String SUCCESS_JOCATA_TAN                             =       'SUCCESS0011';
    public static String ALTERNATE_SCORE_DATA_FETCHED                   =       'SUCCESS0012';
    /*Details Successfully retrieved from the Bank Staement Report*/
    public static String DATA_RETRIEVED_PERFIOS                         =       'SUCCESS0013';
    public static String SUCCESS                                        =       'SUCCESS';
    
    
    
     /*Added by others*/
    public static String APPLICATION_APPROVED_CONVERT_CONTRACT_STATUS   =       'APPROVED - CONVERTED TO CONTRACT';
    public static String DATABASE_EXCEPTION_FETCH_LOAN_DETAILS          =       'Database exception encountered while fetching the CL Contract details';    
    public static String DATABASE_EXCEPTION_FETCH_APPLICATION_DETAILS   =       'Database exception encountered while fetching the Application details';        
    public static String DATABASE_EXCEPTION_FETCH_PAYMENT_DETAILS       =       'Database exception encountered while fetching the Payment details of CL Contract';
    public static String NEWLY_ENTERED_APPLICATION                      =       'NEW - ENTERED';
    public static String SECTION_HEADING_PARTNER_1                      =       'Partner 1';
    public static String SECTION_HEADING_PARTNER_2                      =       'Partner 2';
    public static String SECTION_HEADING_DIRECTOR_1                     =       'Director 1';
    public static String SECTION_HEADING_DIRECTOR_2                     =       'Director 2';
    public static String SECTION_HEADING_KARTA                          =       'Karta';
    public static String SECTION_HEADING_MEMBER_2                       =       'Member 2';
    public static String TO_DATE_MISSING                                =       'To Date is a mandatory field. Kindly provide a valid value.';
    public static String FROM_DATE_MISSING                              =       'From Date is a mandatory field. Kindly provide a valid value.';
    public static String FETCH_LOAN_DETAILS_SUCCESS                     =       'Loan details fetched successfully';
    public static String FETCH_LOAN_DETAILS_ERROR                       =       'Error encountered while fetching Loan Details';
    public static String FETCH_VOTER_ID_END_POINT                       =       'http://evoke.jocatagrid.in/Evoke/webservices/identV2/getVoterIdInfo';
    
     /*Added for Income Category Values*/
    public static String INCOME_CATEGORY_STAGNANT                       =       'STAGNANT';
    public static String INCOME_CATEGORY_DECLINE                        =       'CONTINUOUS DECLINE';
    public static String INCOME_CATEGORY_GROWTH                         =       'GROWTH';
    public static String INCOME_CATEGORY_FLUCTUATING                    =       'FLUCTUATING';
    
    /*Messages used by the front end web service*/
    public static String UNAUTHORIZED_ACCESS                            =       'Unauthorized Access';
    public static String ACTIVE_LOAN_EXISTS                             =       'Active loan Exists';
    public static String DATA_DUPLICATION_FOUND                         =       'Data duplication found for provided details';
    public static String EXCEPTION_ERROR_OCCURED                        =       'Error occured while generating the Prospect Id and User Id. Error Code: ';
    
}