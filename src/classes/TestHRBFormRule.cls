/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class TestHRBFormRule 
{
	public static Drug_HRB__c testDrugConcernedPerson = null;
	public static Drug_HRB__c testDrugAlcohol = null;
	public static Drug_HRB__c testDrugIllegal = null;
	public static Drug_HRB__c testDrugLegal = null;
	public static Drug_HRB__c testDrugOtherProblem = null;
	public static Drug_HRB__c testDrugCocaine = null;
	
	static public void setupDrugs ()
	{
        testDrugConcernedPerson = new Drug_HRB__c (Name='concernedPerson');
        testDrugConcernedPerson.DrugCode__c = '994';
        testDrugConcernedPerson.Tableyear2012__c = true;
        testDrugConcernedPerson.drugtype__c = '4';
        insert testDrugConcernedPerson;
		
        testDrugAlcohol = new Drug_HRB__c (Name='Beer');
        testDrugAlcohol.DrugCode__c = '702';
        testDrugAlcohol.Tableyear2012__c = true;
        testDrugAlcohol.drugtype__c = '1';
        insert testDrugAlcohol;

        testDrugIllegal = new Drug_HRB__c (Name='Cannabis');
        testDrugIllegal.DrugCode__c = '688';
        testDrugIllegal.Tableyear2012__c = true;
        testDrugIllegal.drugtype__c = '2';
        insert testDrugIllegal;

        testDrugLegal = new Drug_HRB__c (Name='Antabuse');
        testDrugLegal.DrugCode__c = '888';
        testDrugLegal.Tableyear2012__c = true;
        testDrugLegal.drugtype__c = '3';
        insert testDrugLegal;
        
        testDrugOtherProblem = new Drug_HRB__c (Name='Gambling');
        testDrugOtherProblem.DrugCode__c = '996';
        testDrugOtherProblem.Tableyear2012__c = true;
        testDrugOtherProblem.drugtype__c = '4';
        insert testDrugOtherProblem;
        
        testDrugCocaine = new Drug_HRB__c (Name='Cocaine');
        testDrugCocaine.DrugCode__c = '210';
        testDrugCocaine.Tableyear2012__c = true;
        testDrugCocaine.drugtype__c = '2';
        insert testDrugCocaine;
        
	}
	
    static public testMethod Treatment__c testTreatmentCreation1() 
    {
       Account acct1 = new Account(name='driver account');
        insert acct1;
            
        Contact driver = new Contact(AccountId=acct1.Id,lastname='Driver',firstname='apex1');
        driver.MailingStreet = '3 test screen \ntest area\ntest city';
        driver.MailingCity = 'Dublin';
        driver.Birthdate = date.valueOf('1994-01-03');
        insert driver;
        
        setupDrugs();
        
        Treatment__c testTreatment = new Treatment__c (Contact__c=driver.id, X16_Date_of_Assessment__c=date.valueOf('2014-01-03'), X37_Date_of_Final_Discharge__c =date.valueOf('2015-07-03'));
 		testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-03');
        testTreatment.X34_outcome_for_main_treatment__c = '1. Treatment completed';
        testTreatment.X13_Date_of_Referral__c = date.valueOf('2014-01-03');
        testTreatment.X14_Main_Reason_for_referral__c = '1. something';
        testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
        testTreatment.X15_Source_of_referral__c = '4. something';
        testTreatment.X15b_If_client_referred__c = '8. something';
        testTreatment.X15b8_Other_specify__c = 'test';
        testTreatment.X16_Date_of_Assessment__c = date.valueOf('2014-01-04');
        testTreatment.X17a_Assessment_outcome__c = '1. something';
        testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. yes';
        testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-04');  
        try
        {
        	insert testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
        testTreatment.X18a_Clients_treatment_status__c = '1. something';
        testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
        testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-04');
        testTreatment.X21b_Date_substitution_started__c= date.valueOf('2014-01-04');
        testTreatment.X22_Ever_previously_treated_alc_drug__c = '1. something';
        testTreatment.X22_Ever_previously_treated_re_drug__c = '8. something';
        testTreatment.X23_Type_of_contact_with_this_centre__c = '1. something';
        testTreatment.X24b_Specify_first_drug_used__c = testDrugIllegal.id;
        testTreatment.X24a_Age_first_use_any_drug__c = 10;
        testTreatment.X25a_Main_substance__c = testDrugAlcohol.id;
        testTreatment.X25b_Route_of_Admin_Main_sub__c = '1. something';
        testTreatment.X25c_Frequency_of_use_in_last_mth__c = '1. something';
        testTreatment.X25d_Age_at_1st_use__c = 10;
        testTreatment.X26b_Route_of_Admin_Sub2__c = '1. something';
        testTreatment.X26c_Frequency_of_use_in_last_mth__c = '1. something';
        testTreatment.X26d_Age_of_1st_use__c = 10;
        testTreatment.X27b_Route_of_Admin_Sub3__c = '1. something';
        testTreatment.X27c_Frequency_of_use_in_last_mth__c = '1. something';
        testTreatment.X27d_Age_of_1st_use__c = 10;
        testTreatment.X28b_Route_of_Admin_Sub4__c = '1. something';
        testTreatment.X28c_Frequency_of_use_in_last_mth__c = '1. something';
        testTreatment.X28d_Age_of_1st_use__c = 10;
        testTreatment.X28e_Preferred_types_of_alcohol_consumed__c = '2. something';
        testTreatment.X28f_How_many_drinks_per_occasion__c = 10;
        testTreatment.X28g_Number_of_days_alcohol_consumed__c = 2;
        testTreatment.X28h_Extent_of_drinking_problem__c = '2. something';
         insert testTreatment;
         testTreatment.X28d_Age_of_1st_use__c = 11;
         update testTreatment;
        return testTreatment;
      }
     
	static testMethod Treatment__c testTreatmentQ13() 
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X13_Date_of_Referral__c = date.valueOf('2014-01-03');
      testTreatment.X16_Date_of_Assessment__c = date.valueOf('2014-01-02');
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ14reDrug()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ14reDrugTypeA()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugIllegal.id;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ14reDrugTypeDI()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ14reDrugTypeDL()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '3. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ14reDrugTypeCP()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '4. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ15()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ15other()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ15otherNotrequired()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X15b_If_client_referred__c = '1. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ17()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ17Dateadded()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X17b_Assessment_criterion_fulfilled__c = null;
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ17DateSO()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X16_Date_of_Assessment__c = date.valueOf('2014-01-06');
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ18()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X18a_Clients_treatment_status__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ18transferred()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X18a_Clients_treatment_status__c = '3. something';
      testTreatment.X18a3_Specify_Transferred__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ18equal2()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ18equal6()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X18a_Clients_treatment_status__c = '6. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ18b4centrespecified ()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();
    	
	  testTreatment.X18a_Clients_treatment_status__c = '6. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '4. something';
      testTreatment.X18b4_Client_transferred_specify_centre__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ18b9othersppecified ()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();
    	
	  testTreatment.X18a_Clients_treatment_status__c = '6. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '9. something';
      testTreatment.X18b9_Other_specify__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ18a2Q19Accepted()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ18a6Q19Accepted()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ19AcceptedQ21()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ21andQ16()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X16_Date_of_Assessment__c = date.valueOf('2014-01-05');
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2000-01-01');
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugA()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugAQ22redrugNull()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugAQ228()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = '8. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugAQ22drug1()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugAlcohol.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = '1. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugDrug()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugIllegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugDrugQ22reAlcNull()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugIllegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugILQ22drug8()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugIllegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = '8. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugILQ22alc1()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugIllegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = '1. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugL()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '3. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugLegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugLQ22reAlcNull()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '3. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugLegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugLQ22Drug8()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '3. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugLegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = '8. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugLalc1()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '3. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugLegal.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = '1. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugOPA()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '4. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugOtherProblem.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugOPD()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '4. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugOtherProblem.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugOPA1()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '4. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugOtherProblem.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_alc_drug__c = '1. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static public testMethod Treatment__c testTreatmentQ14MainreasonDrugOPD1()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '4. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = testDrugOtherProblem.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18a_Clients_treatment_status__c = '2. something';
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X22_Ever_previously_treated_re_drug__c = '1. something';
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ23()
    {
    	Treatment__c testTreatment = testTreatmentQ14MainreasonDrugOPD1 ();
    	
	  testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X23_Type_of_contact_with_this_centre__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ24Age()
    {
    	Treatment__c testTreatment = testTreatmentQ14MainreasonDrugOPD1 ();
    	
	  testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');
      testTreatment.X23_Type_of_contact_with_this_centre__c = ('1. something');
      testTreatment.X24a_Age_first_use_any_drug__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static public testMethod Treatment__c testTreatmentQ24drug()
    {
    	Treatment__c testTreatment = testTreatmentQ14MainreasonDrugOPD1 ();
    	
      testTreatment.X24a_Age_first_use_any_drug__c = 10;
      testTreatment.X24b_Specify_first_drug_used__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static public testMethod Treatment__c testTreatmentQ24drugnotapplicable()
    {
    	Treatment__c testTreatment = testTreatmentQ14MainreasonDrugOPD1 ();
    	
      testTreatment.X24a_Age_first_use_any_drug__c = 88;
      testTreatment.X24b_Specify_first_drug_used__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static public testMethod Treatment__c testTreatmentQ25MainDrugSpecify()
    {
    	Treatment__c testTreatment = testTreatmentQ14MainreasonDrugOPD1 ();
    	
      testTreatment.X24a_Age_first_use_any_drug__c = 10;
      testTreatment.X24b_Specify_first_drug_used__c = testDrugIllegal.id ;
      testTreatment.X25a_Main_substance__c = null;
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
	static testMethod Treatment__c testTreatmentQ24DrugequalQ25Drug()
    {
    	Treatment__c testTreatment = testTreatmentQ14MainreasonDrugOPD1();

	  testTreatment.X24b_Specify_first_drug_used__c = testDrugIllegal.id ;
      testTreatment.X25a_Main_substance__c = testDrugIllegal.id ;
      testTreatment.X24a_Age_first_use_any_drug__c = 10;
      testTreatment.X25d_Age_at_1st_use__c = 8; 
      try
        {
        	update testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
      return testTreatment;
	}
	
}