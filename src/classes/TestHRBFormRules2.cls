// Continuation of TestHRBForm
@isTest
public class TestHRBFormRules2 
{
	static public Treatment__c checkTreatmentFails (String currentProcedure, Treatment__c treatmentToCheck)
	{
    	try
        {
        	update treatmentToCheck;
        	system.debug ('Failing on: ' + currentProcedure);
        	system.assert (false);
        }
        catch (Exception e)
        {
        
        }
        return treatmentToCheck;
	}
	
    static testMethod Treatment__c TestQ24_Substance_use_Excluding_alcohol() 
    {
    	Treatment__c testTreatment = TestHRBFormRule.testTreatmentQ14MainreasonDrugOPD1();
    	testTreatment.X24a_Age_first_use_any_drug__c = 22;
    	return checkTreatmentFails ('TestQ24_Substance_use_Excluding_alcohol 1', testTreatment);
    }
    
    static testMethod Treatment__c TestQ25_Substance_use_Including_Alcohol ()
    {
    	Treatment__c testTreatment = TestHRBFormRule.testTreatmentQ14MainreasonDrugOPD1();
    	testTreatment.X25a_Main_substance__c = null;
    	checkTreatmentFails ('TestQ25_Substance_use_Including_Alcohol 1', testTreatment);
        
        testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugAlcohol.id;
        testTreatment.X25b_Route_of_Admin_Main_sub__c = null;
        checkTreatmentFails ('TestQ25_Substance_use_Including_Alcohol 2', testTreatment);
        
        testTreatment.X25c_Frequency_of_use_in_last_mth__c = null;
        checkTreatmentFails ('TestQ25_Substance_use_Including_Alcohol 3',  testTreatment);
        
        testTreatment.X25d_Age_at_1st_use__c = null;
        checkTreatmentFails ('TestQ25_Substance_use_Including_Alcohol 4', testTreatment);
        
        testTreatment.X25d_Age_at_1st_use__c = 0;
        checkTreatmentFails ('TestQ25_Substance_use_Including_Alcohol 5', testTreatment);
        
        testTreatment.X25d_Age_at_1st_use__c = 23;
        testTreatment.X24a_Age_first_use_any_drug__c = 22;
        testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugIllegal.id;
        
        checkTreatmentFails ('TestQ25_Substance_use_Including_Alcohol 6', testTreatment);
        
        testTreatment.X25d_Age_at_1st_use__c = 21;
        checkTreatmentFails ('TestQ25_Substance_use_Including_Alcohol 7', testTreatment);
      	return testTreatment;
    }
    
    static testMethod Treatment__c TestQ26_Substance_use_Including_Alcohol ()
    {
    	Treatment__c testTreatment = TestHRBFormRule.testTreatmentQ14MainreasonDrugOPD1();
    	testTreatment.X25a_Main_substance__c = null;
    	testTreatment.X26a_Substance_2__c = TestHRBFormRule.testDrugIllegal.id;
        checkTreatmentFails ('TestQ26_Substance_use_Including_Alcohol 1', testTreatment);
    	
    	testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugAlcohol.id;
    	testTreatment.X26b_Route_of_Admin_Sub2__c = null;
        checkTreatmentFails ('TestQ26_Substance_use_Including_Alcohol 2', testTreatment);
    	
        testTreatment.X26c_Frequency_of_use_in_last_mth__c = null;
        checkTreatmentFails ('TestQ26_Substance_use_Including_Alcohol 3', testTreatment);
        
        testTreatment.X26d_Age_of_1st_use__c = null;
        checkTreatmentFails ('TestQ26_Substance_use_Including_Alcohol 4', testTreatment);
    
        testTreatment.X26d_Age_of_1st_use__c = 0;
        checkTreatmentFails ('TestQ26_Substance_use_Including_Alcohol 5', testTreatment);
        
        testTreatment.X26d_Age_of_1st_use__c = 23;
        testTreatment.X24a_Age_first_use_any_drug__c = 22;
       	checkTreatmentFails ('TestQ26_Substance_use_Including_Alcohol 6', testTreatment);
         
 		testTreatment.X26d_Age_of_1st_use__c = 21;
 	    return checkTreatmentFails ('TestQ26_Substance_use_Including_Alcohol 7', testTreatment);
    }
    
    static testMethod Treatment__c TestQ27_Substance_use_Including_Alcohol ()
    {
    	Treatment__c testTreatment = TestHRBFormRule.testTreatmentQ14MainreasonDrugOPD1();
    	testTreatment.X27a_Substance_3__c = TestHRBFormRule.testDrugIllegal.id;
    	testTreatment.X26a_Substance_2__c = null;
    	checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 1', testTreatment);
    	
    	testTreatment.X26a_Substance_2__c = TestHRBFormRule.testDrugIllegal.id;
    	checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 2', testTreatment);
    
    	testTreatment.X27b_Route_of_Admin_Sub3__c = null;
    	checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 3', testTreatment);
    	
    	testTreatment.X27c_Frequency_of_use_in_last_mth__c = null;
    	checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 4', testTreatment);
    	
    	testTreatment.X27d_Age_of_1st_use__c = null;
        checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 4a', testTreatment);
    
        testTreatment.X27d_Age_of_1st_use__c = 0;
        checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 5', testTreatment);
        
        testTreatment.X27d_Age_of_1st_use__c = 23;
        testTreatment.X24a_Age_first_use_any_drug__c = 22;
       	checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 6', testTreatment);
         
 		testTreatment.X27d_Age_of_1st_use__c = 21;
 	    return checkTreatmentFails ('TestQ27_Substance_use_Including_Alcohol 7', testTreatment);
    }	

	static testMethod Treatment__c TestQ28_Substance_use_Including_Alcohol ()
    {
    	Treatment__c testTreatment = TestHRBFormRule.testTreatmentQ14MainreasonDrugOPD1();
    	testTreatment.X28a_Substance_4__c = TestHRBFormRule.testDrugIllegal.id;
    	testTreatment.X27a_Substance_3__c = null;
    	checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 1', testTreatment);
    	
    	testTreatment.X27a_Substance_3__c = TestHRBFormRule.testDrugIllegal.id;
    	checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 2', testTreatment);
    
    	testTreatment.X28b_Route_of_Admin_Sub4__c = null;
    	checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 3', testTreatment);
    	
    	testTreatment.X28c_Frequency_of_use_in_last_mth__c = null;
    	checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 4', testTreatment);
    	
    	testTreatment.X28d_Age_of_1st_use__c = null;
        checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 4a', testTreatment);
    
        testTreatment.X28d_Age_of_1st_use__c = 0;
        checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 5', testTreatment);
        
        testTreatment.X28d_Age_of_1st_use__c = 23;
        testTreatment.X24a_Age_first_use_any_drug__c = 22;
       	checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 6', testTreatment);
         
 		testTreatment.X28d_Age_of_1st_use__c = 21;
 	    return checkTreatmentFails ('TestQ28_Substance_use_Including_Alcohol 7', testTreatment);
    }
    
    static testMethod Treatment__c TestQ25_to_Q28_Substances_are_not_the_same ()
    {
    	Treatment__c testTreatment = TestHRBFormRule.testTreatmentQ14MainreasonDrugOPD1();
    	testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugIllegal.id;
    	testTreatment.X26a_Substance_2__c = TestHRBFormRule.testDrugIllegal.id;
    	checkTreatmentFails ('TestQ25_to_Q28_Substances_are_not_the_same 1', testTreatment);

    	testTreatment.X26a_Substance_2__c = TestHRBFormRule.testDrugLegal.id;
    	testTreatment.X27a_Substance_3__c = TestHRBFormRule.testDrugIllegal.id;
    	checkTreatmentFails ('TestQ25_to_Q28_Substances_are_not_the_same 2', testTreatment);
    	
    	testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugLegal.id;
    	testTreatment.X26a_Substance_2__c = TestHRBFormRule.testDrugIllegal.id;
    	checkTreatmentFails ('TestQ25_to_Q28_Substances_are_not_the_same 3', testTreatment);
    	
    	testTreatment.X28a_Substance_4__c = TestHRBFormRule.testDrugIllegal.id;
    	testTreatment.X27a_Substance_3__c = TestHRBFormRule.testDrugAlcohol.id;
    	testTreatment.X26a_Substance_2__c = TestHRBFormRule.testDrugLegal.id;
    	testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugIllegal.id;
    	checkTreatmentFails ('TestQ25_to_Q28_Substances_are_not_the_same 4', testTreatment);
    	
    	testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugOtherProblem.id;
    	testTreatment.X28a_Substance_4__c = TestHRBFormRule.testDrugAlcohol.id;
    	checkTreatmentFails ('TestQ25_to_Q28_Substances_are_not_the_same 5', testTreatment);

    	testTreatment.X28a_Substance_4__c = TestHRBFormRule.testDrugLegal.id;
    	return checkTreatmentFails ('TestQ25_to_Q28_Substances_are_not_the_same 6', testTreatment);
    }
    
    static public testMethod Treatment__c TestQ25_to_Q28_Substances_are_all_different ()
    {
//    	Treatment__c testTreatment = TestHRBFormRule.testTreatmentQ14MainreasonDrugOPD1();
	  Treatment__c testTreatment = TestHRBFormRule.testTreatmentCreation1 ();

      testTreatment.X14_Main_Reason_for_referral__c = '4. something';
      testTreatment.X14_Main_Reason_for_Referral_Drug__c = TestHRBFormRule.testDrugOtherProblem.id;
      testTreatment.X15_Source_of_referral__c = '4. something';
      testTreatment.X15b_If_client_referred__c = '8. something';
      testTreatment.X15b8_Other_specify__c = 'test';
      testTreatment.X17a_Assessment_outcome__c = '1. something';
      testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. something';
      testTreatment.X17c_Date_assessment_criteria_fulfilled__c = date.valueOf('2014-01-05');
      testTreatment.X18b_Reason_removed_from_waiting_list__c = '1. something';
      testTreatment.X19_Accepted_place_at_this_centre__c = '1. something';
      testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2014-01-05');

       	testTreatment.X28a_Substance_4__c = TestHRBFormRule.testDrugIllegal.id;
    	testTreatment.X27a_Substance_3__c = TestHRBFormRule.testDrugCocaine.id;
    	testTreatment.X26a_Substance_2__c = TestHRBFormRule.testDrugLegal.id;
    	testTreatment.X25a_Main_substance__c = TestHRBFormRule.testDrugOtherProblem.id;
    	testTreatment.X24a_Age_first_use_any_drug__c = 19;
		testTreatment.X25d_Age_at_1st_use__c = 19;
    	testTreatment.X26d_Age_of_1st_use__c = 19;
    	testTreatment.X27d_Age_of_1st_use__c = 19;
 		testTreatment.X28d_Age_of_1st_use__c = 19;
 		
 		testTreatment.X25b_Route_of_Admin_Main_sub__c = '1. something';
    	testTreatment.X25c_Frequency_of_use_in_last_mth__c = '1. something';
 		testTreatment.X26b_Route_of_Admin_Sub2__c = '1. something';
    	testTreatment.X26c_Frequency_of_use_in_last_mth__c = '1. something';
 		testTreatment.X27b_Route_of_Admin_Sub3__c = '1. something';
    	testTreatment.X27c_Frequency_of_use_in_last_mth__c = '1. something';
 		testTreatment.X28b_Route_of_Admin_Sub4__c = '1. something';
    	testTreatment.X28c_Frequency_of_use_in_last_mth__c = '1. something';
 		
		testTreatment.X22_Ever_previously_treated_alc_drug__c = '8. something';
 		testTreatment.X22_Ever_previously_treated_re_drug__c = '8. something';
 		
 		testTreatment.X18a_Clients_treatment_status__c = '2. something';
    	update testTreatment;
    	return testTreatment;
    }
    
    static testMethod Treatment__c TestQ28e_to_Q28h_are_blank_if_no_alcohol ()
    {
     	Treatment__c testTreatment = TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X27a_Substance_3__c = TestHRBFormRule.testDrugCocaine.id;
     	testTreatment.X28e_Preferred_types_of_alcohol_consumed__c = '2. Beer';
     	checkTreatmentFails ('TestQ28e_to_Q28h_are_blank_if_no_alcohol 1', testTreatment);
     	
     	testTreatment.X28f_How_many_drinks_per_occasion__c = 5;
     	checkTreatmentFails ('TestQ28e_to_Q28h_are_blank_if_no_alcohol 2', testTreatment);

     	testTreatment.X28g_Number_of_days_alcohol_consumed__c = 5;
     	checkTreatmentFails ('TestQ28e_to_Q28h_are_blank_if_no_alcohol 3', testTreatment);

     	testTreatment.X28h_Extent_of_drinking_problem__c = '2. Hazardous drinker';
     	return checkTreatmentFails ('TestQ28e_to_Q28h_are_blank_if_no_alcohol 4', testTreatment);
    }

    static testMethod Treatment__c TestQ28e_to_Q28h_are_not_blank_if_alcohol ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	
     	testTreatment.X27a_Substance_3__c = TestHRBFormRule.testDrugAlcohol.id;
     	
     	testTreatment.X28e_Preferred_types_of_alcohol_consumed__c = '2. Beer';
     	testTreatment.X28f_How_many_drinks_per_occasion__c = 5;
     	testTreatment.X28g_Number_of_days_alcohol_consumed__c = 5;
     	testTreatment.X28h_Extent_of_drinking_problem__c = '2. Hazardous drinker';
     	
     	testTreatment.X28e_Preferred_types_of_alcohol_consumed__c = null;
     	TestHRBFormRules2.checkTreatmentFails ('TestQ28e_to_Q28h_are_not_blank_if_alcohol 1', testTreatment);

     	testTreatment.X28e_Preferred_types_of_alcohol_consumed__c = '2. Beer';
     	testTreatment.X28f_How_many_drinks_per_occasion__c = null;
     	TestHRBFormRules2.checkTreatmentFails ('TestQ28e_to_Q28h_are_not_blank_if_alcohol 2', testTreatment);

     	testTreatment.X28f_How_many_drinks_per_occasion__c = 5;
     	testTreatment.X28g_Number_of_days_alcohol_consumed__c = null;
     	TestHRBFormRules2.checkTreatmentFails ('TestQ28e_to_Q28h_are_not_blank_if_alcohol 3', testTreatment);

     	testTreatment.X28g_Number_of_days_alcohol_consumed__c = 5;
     	testTreatment.X28h_Extent_of_drinking_problem__c = null;
     	return TestHRBFormRules2.checkTreatmentFails ('TestQ28e_to_Q28h_are_not_blank_if_alcohol 4', testTreatment);
    }
    
    static testMethod void TestQ29b_Check_If_Ever_Injected ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	Treatment__c checkTreatment = [select X29b_Ever_injected__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals ('1. Yes', checkTreatment.X29b_Ever_injected__c);
    }
    
 }