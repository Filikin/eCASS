/*
	Author: Eamon Kelly, Enclude
	Author: Pedro Gonzalez, Enclude
	Purpose: Extract the fields for the HRB report. 
	Security note: In practice only the administrator will have access to the HRB_Treatment_Report page
	Called from: HRB_Treatment_Report
*/
public with sharing class HRBReportController 
{
    private Treatment__c[] TreatmentsWithClientsList; // these are the HRB forms
    private HRB_Report__c reportParams; // this will be the object with the date range (last year, q1 etc)
    
    public HRBReportController (ApexPages.StandardController controller)
    {
        this.reportParams = (HRB_Report__c)controller.getRecord();
        Initialise ();
    }
    
    public HRBReportController (HRB_Report__c params)
    {
        this.reportParams = params;
        Initialise ();
    }
 
    private void Initialise ()
    {
        reportParams = [select id, Period__c, Year__c, Type_of_report__c from HRB_Report__c where id = :reportParams.id];
        Integer year = reportParams.Year__c.intValue();
        String startMonthDay = '-01-01';
        String endMonthDay = '-12-31';
        if (reportParams.Period__c == 'Quarter 1')
        {
            endMonthDay = '-03-31';
        }
        else if (reportParams.Period__c == 'Quarter 2')
        {
            startMonthDay = '-04-01';
            endMonthDay = '-06-30';
        }
        else if (reportParams.Period__c == 'Quarter 3')
        {
            startMonthDay = '-07-01';
            endMonthDay = '-09-30';
        }
        else if (reportParams.Period__c == 'Quarter 4')
        {
            startMonthDay = '-10-01';
        }
        String startReportPeriod = String.valueOf(year) + startMonthDay;
        String endReportPeriod = String.valueOf(year) + endMonthDay;
        
    String queryString = 'select id,' +
              'id__c,UniqID__c,Contact__r.Area__c,Contact__r.CentreNO__c,Centre_number__c,Contact__r.NUMBER__c,Contact__r.Gender_Code__c,Contact__r.Age__c,Contact__r.Birthdate,Contact__r.LIVING__c,Contact__r.LIVWHERE__c,Contact__r.RegCode__c,Contact__r.AreaRes__c,Contact__r.CCA__c,' +
              'Contact__r.TFA__c,Contact__r.LHO__c,Contact__r.Nationality__c,Contact__r.nation__c,Contact__r.Ethnic__c,Contact__r.EMPLOYMENT__c,Contact__r.X11_Employement_Status_other__c,Contact__r.X12a_Age_left_primary_school__c,' +
              'Contact__r.EDUCATION__c,X13_Date_of_Referral__c,Age__c,Reason__c,X14_Main_Reason_for_Referral_Drug__r.External_ID_Number__c,SPECIFY__c,X14_Main_Reason_for_Referral_Drug__r.DrugCodeX__c,Source__c,TransReason__c,TransReasonSpecify__c,ASSESS__c,Outcome__c,AssCriteria__c,X17b_Assessment_criterion_fulfilled__c,AssCriteriaDate_del__c,' +
              'STATUS__c,X17a_Assessment_outcome__c,X18a_Clients_treatment_status__c,CentreSpecify__c,WaitStatus__c,WaitCentre__c,WaitOther__c,Accepted__c,X19_Accepted_place_at_this_centre__c,X20_Number_times_started_this_year__c,X21a_Date_This_treatment_started__c,' +
              'X21b_Date_substitution_started__c,ALCOHOL__c,DRUG__c,TREATCON__c,X24a_Age_first_use_any_drug__c,X24b_Specify_first_drug_used__r.External_ID_Number__c,FIRSTDRUG__c,X24b_Specify_first_drug_used__r.DrugCodeX__c,X25a_Main_substance__r.External_ID_Number__c,PRIMDRUG__c,X25a_Main_substance__r.DrugCodeX__c,PRIMRTE__c,PRIMFREQ__c,X25d_Age_at_1st_use__c,X26a_Substance_2__r.External_ID_Number__c,DRUG2CODE__c,X26a_Substance_2__r.DrugCode__c,X26a_Substance_2__r.DrugCodeX__c,DRUG2RTE__c,DRUG2FREQ__c,' +
              'DRUG2AGE__c,X26d_Age_of_1st_use__c,X27a_Substance_3__r.External_ID_Number__c,DRUG3CODE__c,X27a_Substance_3__r.DrugCode__c,X27a_Substance_3__r.DrugCodeX__c,DRUG3RTE__c,DRUG3FREQ__c,DRUG3AGE__c,X27d_Age_of_1st_use__c,X28a_Substance_4__r.External_ID_Number__c,DRUG4CODE__c,X28a_Substance_4__r.DrugCode__c,X28a_Substance_4__r.DrugCodeX__c,DRUG4RTE__c,DRUG4FREQ__c,DRUG4AGE__c,X28d_Age_of_1st_use__c,AlcBeer__c,AlcSpirits__c,AlcWine__c,AlcFortified__c,AlcCider__c,' +
              'AlcAlcopops__c,AlcUnspecified__c,AlcOther__c,X28e8_Specify_Other__c,X28f_How_many_drinks_per_occasion__c,X28g_Number_of_days_alcohol_consumed__c,AlcoholExtent__c,AlcoholExtSpecify__c,CURRINJ__c,INJECTED__c,' +
              'X29c_Age_first_injected__c,SHARED__c,X33a24_Sent_to_another_site__c,X33a24_Specify_treatment_site_number__c,X33a25_Key_Worder_appointed__c,X33a26_Case_Manager_appointed__c ,CaseMgrSpecify__c,' +
              'X33b26_Specify_centre__c,X33a27_Care_Plan__c ,X33a28_Facilitated_detox__c,RecYear__c,QUARTER__c,InterMain__c,Inter1__c,X33b1_Date_Commenced__c ,X33c1_Date_Completed__c,' +
              'X33d1_Number_of_Sessions__c,Inter12__c,X33b12_Date_Commenced__c,X33c12_Date_Completed__c,X33d12_Number_of_Sessions__c,Inter13__c,X33b13_Date_Commenced__c,X33c13_Date_Completed__c,X33d13_Number_of_Sessions__c,Inter14__c,X33b14_Date_Commenced__c,X33c14_Date_Completed__c,X33d14_Number_of_Sessions__c,Inter15__c,X33b15_Date_Commenced__c,' +
              'X33c15_Date_Completed__c,X33d15_Number_of_Sessions__c,Inter16__c,X33b16_Date_Commenced__c,X33c16_Date_Completed__c,X33d16_Number_of_Sessions__c,Inter17__c,X33b17_Date_Commenced__c,X33c17_Date_Completed__c,' +
              'X33d17_Number_of_Sesions__c,Inter18__c,X33b18_Date_Commenced__c,X33c18_Date_Completed__c,X33d18_Number_of_Sessions__c,Inter19__c,X33b19_Date_Commenced__c,X33c19_Date_Completed__c,X33d19_Number_of_Sessions__c,' +
              'Inter20__c,X33b20_Date_Commenced__c,X33c20_Date_Completed__c,X33d20_Number_of_Sessions__c,Inter21__c,X33b21_Date_Commenced__c,X33c21_Date_Completed__c,X33d21_Number_of_Sessions__c,Inter23__c,X33b23_Date_Commenced__c,X33c23_Date_Completed__c,X33d23_Number_of_Sessions__c,Inter24__c,X33b25_Date_key_worker_was_appointed__c,X33b26_Date_case_manager_was_appointed__c,X33b27_Date_care_plan_was_put_in_place__c,InterOutcome__c,X34_Outcome_Other__c,NonCompliance__c,ExitCondition__c,' +
              'X36_Clients_condition_Other__c,X37_Date_of_Final_Discharge__c,ExitAfter__c,ExitCentre__c,X38b_Other_site_for_treatment__c,X39_Number_of_others_involved__c,Vaccine1__c,Vaccine2__c,Vaccine3__c,VaccineB4__c,' +
              'VaccineB5__c,Titre__c,BBV1__c,BBV2__c,BBV3__c,Screen__c,ScreenBy__c,CleanDate__c,Added__c,Updated_Date__c,Name,X14_Main_Reason_for_Referral_Drug__r.DrugCode__c ' + 
              'from Treatment__c where ';
         System.Debug (queryString);
          
         if (reportParams.Type_of_report__c == 'Clients who entered during the report period') 
         {
            queryString += 'X16_Date_of_Assessment__c >= ' + startReportPeriod + ' and X16_Date_of_Assessment__c <= ' + endReportPeriod;
         }
         else
         {
            queryString += 'ExitDate__c >= ' + startReportPeriod + ' and ExitDate__c <= ' + endReportPeriod + ' and X16_Date_of_Assessment__c < ' + startReportPeriod;
         }
              
         try
         {
            TreatmentsWithClientsList = Database.query(queryString);
            for (Treatment__c oneTreatment: TreatmentsWithClientsList)
            {
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.External_ID_Number__c == null)
            	{
            		oneTreatment.SpecifyID__c = null;
            	}
            	else
            	{
            		oneTreatment.SpecifyID__c = oneTreatment.X14_Main_Reason_for_Referral_Drug__r.External_ID_Number__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCodeX__c == null)
            	{
            		oneTreatment.SpecifyX__c = null;
            	}
            	else
            	{
            		oneTreatment.SpecifyX__c = oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCodeX__c;
            	}
            	if (oneTreatment.X24b_Specify_first_drug_used__r.External_ID_Number__c == null || oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.FirstdruID__c = null;
            	}
            	else
            	{
            		oneTreatment.FirstdruID__c = oneTreatment.X24b_Specify_first_drug_used__r.External_ID_Number__c;
            	}	
            	if (oneTreatment.X24b_Specify_first_drug_used__r.DrugCodeX__c == null|| oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.FirstdruX__c = null;
            		System.debug ('Setting FirstdruX to 0');
            	}
            	else
            	{
            		System.debug ('X24b is '+oneTreatment.X24b_Specify_first_drug_used__r.DrugCodeX__c);
            		System.debug ('X14 is ' + oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c);
            		System.debug ('X17a is ' + oneTreatment.X17a_Assessment_outcome__c);
            		oneTreatment.FirstdruX__c = oneTreatment.X24b_Specify_first_drug_used__r.DrugCodeX__c;
            	}
            	if (oneTreatment.X25a_Main_substance__r.External_ID_Number__c == null|| oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.PrimdrugID__c = null;
            	}
            	else
            	{
            		oneTreatment.PrimdrugID__c = oneTreatment.X25a_Main_substance__r.External_ID_Number__c;
            	}
            	if (oneTreatment.X25a_Main_substance__r.DrugCodeX__c == null|| oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.PrimdrugX__c = null;
            	}
            	else
            	{
            		oneTreatment.PrimdrugX__c = oneTreatment.X25a_Main_substance__r.DrugCodeX__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.Drug2CodeID__c = null;
            	}
            	else
            	if (oneTreatment.X25a_Main_substance__r.DrugCodeX__c != null && oneTreatment.X26a_Substance_2__r.DrugCode__c == null)
            	{
            		oneTreatment.Drug2CodeID__c = '1';
            	}
            	else
            	{
            		oneTreatment.Drug2CodeID__c = oneTreatment.X26a_Substance_2__r.External_ID_Number__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.Drug2CodeX__c = null;
            	}
            	else
            	if (oneTreatment.X25a_Main_substance__r.DrugCodeX__c != null && oneTreatment.X26a_Substance_2__r.DrugCode__c == null)
            	{
            		oneTreatment.Drug2CodeX__c = '0';
            	}
            	else
            	{
            		oneTreatment.Drug2CodeX__c = oneTreatment.X26a_Substance_2__r.DrugCodeX__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.Drug3CodeID__c = null;
            	}
            	else
            	if (oneTreatment.X25a_Main_substance__r.DrugCodeX__c != null && oneTreatment.X27a_Substance_3__r.DrugCode__c == null)
            	{
            		oneTreatment.Drug3CodeID__c = '1';
            	}
            	else
            	{
            		oneTreatment.Drug3CodeID__c = oneTreatment.X27a_Substance_3__r.External_ID_Number__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.Drug3CodeX__c = null;
            	}
            	else
            	if (oneTreatment.X25a_Main_substance__r.DrugCodeX__c != null && oneTreatment.X27a_Substance_3__r.DrugCode__c == null)
            	{
            		oneTreatment.Drug3CodeX__c = '0';
            	}
            	else
            	{
            		oneTreatment.Drug3CodeX__c = oneTreatment.X27a_Substance_3__r.DrugCodeX__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.Drug4CodeID__c = null;
            	}
            	else
            	if (oneTreatment.X25a_Main_substance__r.DrugCodeX__c != null && oneTreatment.X28a_Substance_4__r.DrugCode__c == null)
            	{
            		oneTreatment.Drug4CodeID__c = '1';
            	}
            	else
            	{
            		oneTreatment.Drug4CodeID__c = oneTreatment.X28a_Substance_4__r.External_ID_Number__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	|| oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'|| oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'
            	|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No')
            	{
            		oneTreatment.Drug4CodeX__c = null;
            	}
            	else
            	if (oneTreatment.X25a_Main_substance__r.DrugCodeX__c != null && oneTreatment.X28a_Substance_4__r.DrugCode__c == null)
            	{
            		oneTreatment.Drug4CodeX__c = '0';
            	}
            	else
            	{
            		oneTreatment.Drug4CodeX__c = oneTreatment.X28a_Substance_4__r.DrugCodeX__c;
            	}
            	if (oneTreatment.X14_Main_Reason_for_Referral_Drug__r.DrugCode__c == '994'|| oneTreatment.X17a_Assessment_outcome__c == '2. Unsuitable for treatment'
            	 || oneTreatment.X17b_Assessment_criterion_fulfilled__c == '2. No'|| oneTreatment.X18a_Clients_treatment_status__c == '3. Transferred to another site'
            	 || oneTreatment.X18a_Clients_treatment_status__c == '4. Psychiatric assessment only'|| oneTreatment.X19_Accepted_place_at_this_centre__c == '2. No'
            	 || Clientonwaitinglist(oneTreatment))
            {
            	
            	oneTreatment.X20_Number_times_started_this_year__c = null;
            	oneTreatment.X21a_Date_This_treatment_started__c = null;
            	oneTreatment.X21b_Date_substitution_started__c = null;
            	oneTreatment.X22_Ever_previously_treated_alc_drug__c = '';
            	oneTreatment.X22_Ever_previously_treated_re_drug__c = '';
            	oneTreatment.X23_Type_of_contact_with_this_centre__c = '';
            	oneTreatment.X24a_Age_first_use_any_drug__c = null;
            	oneTreatment.X25b_Route_of_Admin_Main_sub__c = '';
            	oneTreatment.X25c_Frequency_of_use_in_last_mth__c =  '';
            	oneTreatment.X25d_Age_at_1st_use__c = null;
            	oneTreatment.X26b_Route_of_Admin_Sub2__c =  '';
            	oneTreatment.X26c_Frequency_of_use_in_last_mth__c =  '';
            	oneTreatment.X26d_Age_of_1st_use__c = null;
            	oneTreatment.X27b_Route_of_Admin_Sub3__c =  '';
            	oneTreatment.X27c_Frequency_of_use_in_last_mth__c =  '';
            	oneTreatment.X27d_Age_of_1st_use__c = null;
            	oneTreatment.X28b_Route_of_Admin_Sub4__c =  '';
            	oneTreatment.X28c_Frequency_of_use_in_last_mth__c =  '';
            	oneTreatment.X28d_Age_of_1st_use__c = null;
            	oneTreatment.X28e_Preferred_types_of_alcohol_consumed__c =  '';
            	oneTreatment.X28e8_Specify_Other__c =  '';
            	oneTreatment.X28f_How_many_drinks_per_occasion__c = null;
				oneTreatment.X28g_Number_of_days_alcohol_consumed__c = null;
				oneTreatment.X28h_Extent_of_drinking_problem__c =  '';
				oneTreatment.X29a_Injected_in_past_month__c =  '';
				oneTreatment.X29b_Ever_injected__c =  '';
				oneTreatment.X29c_Age_first_injected__c = null;
				oneTreatment.X30_Ever_shared_any_injecting_equipment__c =  '';
				oneTreatment.X33a_Main_Intervention__c =  '';
				oneTreatment.X33a24_Sent_to_another_site__c =  'FALSE';
				oneTreatment.X33a24_Specify_treatment_site_number__c = null;
				oneTreatment.X33a25_Key_Worder_appointed__c =  'FALSE';
				oneTreatment.X33a26_Case_Manager_appointed__c =  'FALSE';
				oneTreatment.X33a27_Care_Plan__c =  'FALSE';
				oneTreatment.X33a28_Facilitated_detox__c =  'FALSE';
				oneTreatment.X33b1_Date_Commenced__c = null;
				oneTreatment.X33b10_Date_Commenced__c = null;
				oneTreatment.X33b11_Date_Commenced__c = null;
				oneTreatment.X33b12_Date_Commenced__c = null;
				oneTreatment.X33b13_Date_Commenced__c = null;
				oneTreatment.X33b14_Date_Commenced__c = null;
				oneTreatment.X33b15_Date_Commenced__c = null;
				oneTreatment.X33b16_Date_Commenced__c = null;
				oneTreatment.X33b17_Date_Commenced__c = null;
				oneTreatment.X33b18_Date_Commenced__c = null;
				oneTreatment.X33b19_Date_Commenced__c = null;
				oneTreatment.X33b20_Date_Commenced__c = null;
				oneTreatment.X33b21_Date_Commenced__c = null;
				oneTreatment.X33b23_Date_Commenced__c = null;
				oneTreatment.X33b25_Date_key_worker_was_appointed__c = null;
				oneTreatment.X33b26_Date_case_manager_was_appointed__c = null;
				oneTreatment.X33b26_Specify_centre__c =  '';
				oneTreatment.X33b27_Date_care_plan_was_put_in_place__c = null;
				oneTreatment.X33c1_Date_Completed__c = null;
				oneTreatment.X33c12_Date_Completed__c = null;
				oneTreatment.X33c13_Date_Completed__c = null;
				oneTreatment.X33c14_Date_Completed__c = null;
				oneTreatment.X33c15_Date_Completed__c = null;
				oneTreatment.X33c16_Date_Completed__c = null;
				oneTreatment.X33c17_Date_Completed__c = null;
				oneTreatment.X33c18_Date_Completed__c = null;
				oneTreatment.X33c19_Date_Completed__c = null;
				oneTreatment.X33c20_Date_Completed__c = null;
				oneTreatment.X33c21_Date_Completed__c = null;
				oneTreatment.X33c23_Date_Completed__c = null;
				oneTreatment.X33d1_Number_of_Sessions__c = 0;
				oneTreatment.X33d12_Number_of_Sessions__c = 0;
				oneTreatment.X33d13_Number_of_Sessions__c = 0;
				oneTreatment.X33d14_Number_of_Sessions__c = 0;
				oneTreatment.X33d15_Number_of_Sessions__c = 0;
				oneTreatment.X33d16_Number_of_Sessions__c = 0;
				oneTreatment.X33d17_Number_of_Sesions__c = 0;
				oneTreatment.X33d18_Number_of_Sessions__c = 0;
				oneTreatment.X33d19_Number_of_Sessions__c = 0;
				oneTreatment.X33d20_Number_of_Sessions__c = 0;
				oneTreatment.X33d21_Number_of_Sessions__c = 0;
				oneTreatment.X33d23_Number_of_Sessions__c = 0;
				oneTreatment.X34_Outcome_for_MAIN_treatment__c =  '';
				oneTreatment.X34_Outcome_Other__c =  '';
				oneTreatment.X35_Reason_for_exit_6_above__c =  '';
				oneTreatment.X36_Client_s_Condition_on_discharge__c =  '';
				oneTreatment.X36_Clients_condition_Other__c =  '';
				oneTreatment.X37_Date_of_Final_Discharge__c = null;
				oneTreatment.X38a_Aftercare_provided_by_this_centre__c =  '';
				oneTreatment.X38b_Other_site_for_treatment__c =  '';
				oneTreatment.X39_Number_of_others_involved__c = null;
				oneTreatment.X40_Vaccination__c =  '';
				oneTreatment.X41_Viral_Screening_uptake__c =  '';
				oneTreatment.X42a_Urine_screeding_during_treatment__c =  '';
				oneTreatment.X42b_If_screening_ordered_by__c =  '';
            }
 
            }
         }     
         catch (Exception e)
         {
            System.Debug (e);
            TreatmentsWithClientsList = new List<Treatment__c>();
         }
    }
    public Boolean Clientonwaitinglist (Treatment__c treat)
	{
		if ((treat.X18a_Clients_treatment_status__c == '2. Placed on waiting list for opiate substitute' && treat.X18b_Reason_removed_from_waiting_list__c != '1. Treatment offered with this centre')
			|| (treat.X18a_Clients_treatment_status__c == '6. Placed on other drug treatment waiting list' && treat.X18b_Reason_removed_from_waiting_list__c != '1. Treatment offered with this centre')) 
			return true;
		else return false;
	}
    public Treatment__c[] getTreatmentsWithClients()
    {
        return TreatmentsWithClientsList;
    }

    public static testMethod void testGetTreatments ()
    {
        Account acct1 = new Account(name='driver account');
        insert acct1;
            
        Contact driver = new Contact(AccountId=acct1.Id,lastname='Driver',firstname='apex1');
        driver.MailingStreet = '3 test screen \ntest area\ntest city';
        driver.MailingCity = 'Dublin';
        insert driver;
        Drug_HRB__c testDrug = new Drug_HRB__c (Name='testDrug');
        testDrug.DrugCode__c = '994';
        testDrug.Tableyear2012__c = true;
        insert testDrug;
        
        Treatment__c testTreatment = new Treatment__c (Contact__c=driver.id, X16_Date_of_Assessment__c=date.valueOf('2010-01-04'), X37_Date_of_Final_Discharge__c =date.valueOf('2011-07-03'));
        testTreatment.X34_outcome_for_main_treatment__c = '1. Treatment completed';
        testTreatment.X36_Client_s_Condition_on_discharge__c = '1. stable';
        testTreatment.X33b1_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b12_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b13_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b14_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b15_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b16_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b17_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b18_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b19_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b20_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b21_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33b23_Date_Commenced__c = date.valueOf('2011-01-01');
        testTreatment.X33c1_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c12_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c13_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c14_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c15_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c16_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c17_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c18_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c19_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c20_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c21_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33c23_Date_Completed__c = date.valueOf('2011-01-02');
        testTreatment.X33d1_Number_of_Sessions__c = 1;
        testTreatment.X33d12_Number_of_Sessions__c = 1;
        testTreatment.X33d13_Number_of_Sessions__c = 1;
        testTreatment.X33d14_Number_of_Sessions__c = 1;
        testTreatment.X33d15_Number_of_Sessions__c = 1;
        testTreatment.X33d16_Number_of_Sessions__c = 1;
        testTreatment.X33d17_Number_of_Sesions__c = 1;
        testTreatment.X33d18_Number_of_Sessions__c = 1;
        testTreatment.X33d19_Number_of_Sessions__c = 1;
        testTreatment.X33d20_Number_of_Sessions__c = 1;
        testTreatment.X33d21_Number_of_Sessions__c = 1;
        testTreatment.X33d23_Number_of_Sessions__c = 1;
        testTreatment.X33a_Main_Intervention__c = '1. Brief intervention';
        testTreatment.X29a_Injected_in_past_month__c = '1. Yes';
        testTreatment.X29b_Ever_injected__c = '1. Yes';
        testTreatment.X29c_Age_first_injected__c = 10;
        testTreatment.X30_Ever_shared_any_injecting_equipment__c = '1. Yes';
        testTreatment.X13_Date_of_Referral__c = date.valueOf('2010-01-03');
        insert testTreatment;
        
        Treatment__c testTreatment2 = new Treatment__c (Contact__c=driver.id, X16_Date_of_Assessment__c=date.valueOf('2011-01-05'), X37_Date_of_Final_Discharge__c =date.valueOf('2011-07-04'));
       testTreatment2.X14_Main_Reason_for_Referral_Drug__c = testDrug.id;
       testTreatment2.X34_outcome_for_main_treatment__c = '1. Treatment completed';
        testTreatment2.X36_Client_s_Condition_on_discharge__c = '1. stable';
        testTreatment2.X33b1_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b12_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b13_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b14_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b15_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b16_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b17_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b18_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b19_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b20_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b21_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33b23_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment2.X33c1_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c12_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c13_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c14_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c15_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c16_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c17_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c18_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c19_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c20_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c21_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33c23_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment2.X33d1_Number_of_Sessions__c = 1;
        testTreatment2.X33d12_Number_of_Sessions__c = 1;
        testTreatment2.X33d13_Number_of_Sessions__c = 1;
        testTreatment2.X33d14_Number_of_Sessions__c = 1;
        testTreatment2.X33d15_Number_of_Sessions__c = 1;
        testTreatment2.X33d16_Number_of_Sessions__c = 1;
        testTreatment2.X33d17_Number_of_Sesions__c = 1;
        testTreatment2.X33d18_Number_of_Sessions__c = 1;
        testTreatment2.X33d19_Number_of_Sessions__c = 1;
        testTreatment2.X33d20_Number_of_Sessions__c = 1;
        testTreatment2.X33d21_Number_of_Sessions__c = 1;
        testTreatment2.X33d23_Number_of_Sessions__c = 1;
        testTreatment2.X33a_Main_Intervention__c = '1. Brief intervention';
        testTreatment2.X29a_Injected_in_past_month__c = '1. Yes';
        testTreatment2.X29b_Ever_injected__c = '1. Yes';
        testTreatment2.X29c_Age_first_injected__c = 10;
        testTreatment2.X30_Ever_shared_any_injecting_equipment__c = '1. Yes';
        testTreatment2.X13_Date_of_Referral__c = date.valueOf('2011-01-03');
        insert testTreatment2;

        Treatment__c testTreatment3 = new Treatment__c (Contact__c=driver.id, X16_Date_of_Assessment__c=date.valueOf('2011-5-05'), X37_Date_of_Final_Discharge__c =date.valueOf('2012-12-04'));
        testTreatment3.X34_outcome_for_main_treatment__c = '1. Treatment completed';
        testTreatment3.X36_Client_s_Condition_on_discharge__c = '1. stable';
        testTreatment3.X33b1_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b12_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b13_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b14_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b15_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b16_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b17_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b18_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b19_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b20_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b21_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33b23_Date_Commenced__c = date.valueOf('2011-05-06');
        testTreatment3.X33c1_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c12_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c13_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c14_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c15_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c16_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c17_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c18_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c19_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c20_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c21_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33c23_Date_Completed__c = date.valueOf('2011-05-07');
        testTreatment3.X33d1_Number_of_Sessions__c = 1;
        testTreatment3.X33d12_Number_of_Sessions__c = 1;
        testTreatment3.X33d13_Number_of_Sessions__c = 1;
        testTreatment3.X33d14_Number_of_Sessions__c = 1;
        testTreatment3.X33d15_Number_of_Sessions__c = 1;
        testTreatment3.X33d16_Number_of_Sessions__c = 1;
        testTreatment3.X33d17_Number_of_Sesions__c = 1;
        testTreatment3.X33d18_Number_of_Sessions__c = 1;
        testTreatment3.X33d19_Number_of_Sessions__c = 1;
        testTreatment3.X33d20_Number_of_Sessions__c = 1;
        testTreatment3.X33d21_Number_of_Sessions__c = 1;
        testTreatment3.X33d23_Number_of_Sessions__c = 1;
        testTreatment3.X33a_Main_Intervention__c = '1. Brief intervention';
        testTreatment3.X29a_Injected_in_past_month__c = '1. Yes';
        testTreatment3.X29b_Ever_injected__c = '1. Yes';
        testTreatment3.X29c_Age_first_injected__c = 10;
        testTreatment3.X30_Ever_shared_any_injecting_equipment__c = '1. Yes';
        testTreatment3.X13_Date_of_Referral__c = date.valueOf('2011-05-03');
        insert testTreatment3;

        Treatment__c testTreatment4 = new Treatment__c (Contact__c=driver.id, X16_Date_of_Assessment__c=date.valueOf('2010-1-05'), X37_Date_of_Final_Discharge__c =date.valueOf('2012-09-04'));
         testTreatment4.X14_Main_Reason_for_Referral_Drug__c = testDrug.id;
         testTreatment4.X34_outcome_for_main_treatment__c = '1. Treatment completed';
        testTreatment4.X33b1_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b12_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b13_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b14_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b15_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b16_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b17_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b18_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b19_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b20_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b21_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33b23_Date_Commenced__c = date.valueOf('2011-01-06');
        testTreatment4.X33c1_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c12_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c13_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c14_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c15_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c16_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c17_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c18_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c19_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c20_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c21_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33c23_Date_Completed__c = date.valueOf('2011-01-07');
        testTreatment4.X33d1_Number_of_Sessions__c = 1;
        testTreatment4.X33d12_Number_of_Sessions__c = 1;
        testTreatment4.X33d13_Number_of_Sessions__c = 1;
        testTreatment4.X33d14_Number_of_Sessions__c = 1;
        testTreatment4.X33d15_Number_of_Sessions__c = 1;
        testTreatment4.X33d16_Number_of_Sessions__c = 1;
        testTreatment4.X33d17_Number_of_Sesions__c = 1;
        testTreatment4.X33d18_Number_of_Sessions__c = 1;
        testTreatment4.X33d19_Number_of_Sessions__c = 1;
        testTreatment4.X33d20_Number_of_Sessions__c = 1;
        testTreatment4.X33d21_Number_of_Sessions__c = 1;
        testTreatment4.X33d23_Number_of_Sessions__c = 1;
        testTreatment4.X33a_Main_Intervention__c = '1. Brief intervention';
        testTreatment4.X29a_Injected_in_past_month__c = '1. Yes';
        testTreatment4.X29b_Ever_injected__c = '1. Yes';
        testTreatment4.X29c_Age_first_injected__c = 10;
        testTreatment4.X30_Ever_shared_any_injecting_equipment__c = '1. Yes';
        testTreatment4.X36_Client_s_Condition_on_discharge__c = '1. Stable';
        testTreatment4.X13_Date_of_Referral__c = date.valueOf('2010-01-03');
         insert testTreatment4;

        HRB_Report__c params = new HRB_Report__c (Period__c = 'Quarter 1', Year__c = 2011, Type_of_report__c = 'Clients who entered during the report period');
        insert params;
                
        HRBReportController hrb = new HRBReportController(params);

        Treatment__c[] treatments = hrb.getTreatmentsWithClients();
        System.assert(treatments.size() >= 1);
        
        HRB_Report__c params2 = new HRB_Report__c (Period__c = 'Complete Year', Year__c = 2011, Type_of_report__c = 'Clients who entered during the report period');
        insert params2;
                
        hrb = new HRBReportController(params2);

        treatments = hrb.getTreatmentsWithClients();
        System.assert(treatments.size() >= 2);

        HRB_Report__c params3 = new HRB_Report__c (Period__c = 'Quarter 2', Year__c = 2011, Type_of_report__c = 'Clients who entered during the report period');
        insert params3;
                
        hrb = new HRBReportController(params3);

        treatments = hrb.getTreatmentsWithClients();
        System.assert(treatments.size() >= 1);
        
        HRB_Report__c params4 = new HRB_Report__c (Period__c = 'Quarter 4', Year__c = 2011, Type_of_report__c = 'Clients who entered during the report period');
        insert params4;
                
        hrb = new HRBReportController(params4);

        treatments = hrb.getTreatmentsWithClients();
        System.assert(treatments.size() >= 0);

        HRB_Report__c params5 = new HRB_Report__c (Period__c = 'Quarter 3', Year__c = 2011, Type_of_report__c = 'Only clients who entered before the reporting period and exited during the report period');
        insert params5;
                
        hrb = new HRBReportController(params5);

        treatments = hrb.getTreatmentsWithClients();
  		System.assert(treatments.size() > 0);
    } 
}