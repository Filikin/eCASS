@isTest
private class TestHRBFormRules3 {

    static testMethod void TestEnsure_That_Q331c_and_Q331d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c1_Date_Completed__c, X33d1_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d1_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c1_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3312c_and_Q3312d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c12_Date_Completed__c, X33d12_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d12_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c12_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3313c_and_Q3313d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c13_Date_Completed__c, X33d13_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d13_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c13_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3314c_and_Q3314d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c14_Date_Completed__c, X33d14_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d14_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c14_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3315c_and_Q3315d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c15_Date_Completed__c, X33d15_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d15_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c15_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3316c_and_Q3316d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c16_Date_Completed__c, X33d16_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d16_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c16_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3317c_and_Q3317d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c17_Date_Completed__c, X33d17_Number_of_Sesions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d17_Number_of_Sesions__c);
     	system.assertEquals (null, checkTreatment.X33c17_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3318c_and_Q3318d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c18_Date_Completed__c, X33d18_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d18_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c18_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3319c_and_Q3319d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c19_Date_Completed__c, X33d19_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d19_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c19_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3320c_and_Q3320d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c20_Date_Completed__c, X33d20_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d20_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c20_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3321c_and_Q3321d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c21_Date_Completed__c, X33d21_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d21_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c21_Date_Completed__c);
     	
     	
    }
    
    static testMethod void TestEnsure_That_Q3323c_and_Q3323d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c23_Date_Completed__c, X33d23_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d23_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c23_Date_Completed__c);
     	
     	
    }
    static testMethod void TestEnsure_That_Q3328c_and_Q3328d_Are_Blank ()
    {
     	Treatment__c testTreatment = TestHRBFormRules2.TestQ25_to_Q28_Substances_are_all_different();
     	testTreatment.X37_Date_of_Final_Discharge__c = null;
     	testTreatment.X33b1_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d1_Number_of_Sessions__c = 5;
     	testTreatment.X33b12_Date_Commenced__c = testTreatment.X21a_Date_This_treatment_started__c;
     	testTreatment.X33d12_Number_of_Sessions__c = 5;
     	update testTreatment;
     	
     	Treatment__c checkTreatment = [select X33c28_Date_Completed__c, X33d28_Number_of_Sessions__c from Treatment__c where id = :testTreatment.id];
     	system.assertEquals (0, checkTreatment.X33d28_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c28_Date_Completed__c);
     	
     	
    }
}