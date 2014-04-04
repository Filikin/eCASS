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
private class TestHRBFormRule {

    static testMethod Treatment__c testTreatmentCreation1() 
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
        
        Treatment__c testTreatment = new Treatment__c (Contact__c=driver.id, X16_Date_of_Assessment__c=date.valueOf('2014-01-03'), X37_Date_of_Final_Discharge__c =date.valueOf('2015-07-03'));
 		testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-03');
        testTreatment.X34_outcome_for_main_treatment__c = '1. Treatment completed';
        testTreatment.X13_Date_of_Referral__c = date.valueOf('2014-01-03');
        testTreatment.X14_Main_Reason_for_referral__c = '1. something';
        testTreatment.X14_Main_Reason_for_Referral_Drug__c = 'a0AG000000AiWGw';
        testTreatment.X15_Source_of_referral__c = '4. something';
        testTreatment.X15b_If_client_referred__c = '8. something';
        testTreatment.X15b8_Other_specify__c = 'test';
        testTreatment.X17a_Assessment_outcome__c = '1. something';
        testTreatment.X16_Date_of_Assessment__c = date.valueOf('2014-01-04');
        testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. yes';
        testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-04');
        testTreatment.X18a_Clients_treatment_status__c = '1. something';
        /*
        
        
        testTreatment.X18b9_Other_specify__c = 'test';
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
        
       ;
        */
        try
        {
        	insert testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
        testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
        testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-04');
        testTreatment.X21b_Date_substitution_started__c= date.valueOf('2014-01-04');
        testTreatment.X22_Ever_previously_treated_alc_drug__c = '1. something';
        testTreatment.X22_Ever_previously_treated_re_drug__c = '8. something';
        testTreatment.X23_Type_of_contact_with_this_centre__c = '1. something';
        testTreatment.X24b_Specify_first_drug_used__c = 'a0AG000000AiWGv';
        testTreatment.X24a_Age_first_use_any_drug__c = 10;
        testTreatment.X25a_Main_substance__c = 'a0AG000000AiWGw';
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
         insert testTreatment;
         testTreatment.X28d_Age_of_1st_use__c = 11;
         update testTreatment;
        return testTreatment;
      }
      
    static testMethod Treatment__c testTreatmentQ18b() 
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X18a_Clients_treatment_status__c = '1. something';
      update testTreatment;
      return testTreatment;
	}
	static testMethod Treatment__c testTreatmentQ13() 
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X13_Date_of_Referral__c = date.valueOf('2014-01-05');
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
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = 'a0AG000000AiWGv';
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
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = 'a0AG000000AiWGw';
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
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = 'a0AG000000AiWGw';
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
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = 'a0AG000000AiWGw';
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
	static testMethod Treatment__c testTreatmentQ18notequal2or6()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X18a_Clients_treatment_status__c = '1. something';
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
	static testMethod Treatment__c testTreatmentQ19Acepted()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

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
	static testMethod Treatment__c testTreatmentQ14MainreasonAlcohol()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonAlcoholB()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonAlcoholC()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '1. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonDrug()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugB()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugC()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '2. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugLB()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '3. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugLC()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '3. something';
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
	static testMethod Treatment__c testTreatmentQ14MainreasonDrugOPD1()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '4. something';
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
    	Treatment__c testTreatment = testTreatmentCreation1 ();

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
	static testMethod Treatment__c testTreatmentQ24()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X23_Type_of_contact_with_this_centre__c = '1. something';
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
	static testMethod Treatment__c testTreatmentQ24andAge()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X24a_Age_first_use_any_drug__c = 8;
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
	static testMethod Treatment__c testTreatmentQ25Drug()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X23_Type_of_contact_with_this_centre__c = '1. something';
      testTreatment.X24a_Age_first_use_any_drug__c = 10;
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
	static testMethod Treatment__c testTreatmentQ25Route()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X25a_Main_substance__c = 'a0AG000000AiWGw';
      testTreatment.X25b_Route_of_Admin_Main_sub__c = null;
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
	static testMethod Treatment__c testTreatmentQ25Freq()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X25a_Main_substance__c = 'a0AG000000AiWGw';
      testTreatment.X25c_Frequency_of_use_in_last_mth__c = null;
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
	static testMethod Treatment__c testTreatmentQ25Age()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X25a_Main_substance__c = 'a0AG000000AiWGw';
      testTreatment.X25d_Age_at_1st_use__c = null;
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
	static testMethod Treatment__c testTreatmentQ25Age0()
    {
    	Treatment__c testTreatment = testTreatmentCreation1 ();

      testTreatment.X25a_Main_substance__c = 'a0AG000000AiWGw';
      testTreatment.X25d_Age_at_1st_use__c = 0;
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
    	Treatment__c testTreatment = testTreatmentCreation1 ();

	  testTreatment.X24b_Specify_first_drug_used__c = 'a0AG000000AiWGw';
      testTreatment.X25a_Main_substance__c = 'a0AG000000AiWGw';
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