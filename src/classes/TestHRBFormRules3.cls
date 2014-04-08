@isTest
private class TestHRBFormRules3 {

    static testMethod void TestEnsure_That_Q33c_and_Q33d_Are_Blank ()
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
     	system.assertEquals (0, checkTreatment.X33d12_Number_of_Sessions__c);
     	system.assertEquals (null, checkTreatment.X33c12_Date_Completed__c);
    }
}