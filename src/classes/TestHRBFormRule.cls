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

    static testMethod void testTreatmentCreation1() 
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
 		testTreatment.X21a_Date_This_treatment_started__c = date.valueOf('2011-01-01');
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
        testTreatment.X17a_Assessment_outcome__c = '1. something';
        testTreatment.X17b_Assessment_criterion_fulfilled__c = '1. yes';
        testTreatment.X18a_Clients_treatment_status__c = '1. something';
        testTreatment.X15_Source_of_referral__c = '4. something';
        testTreatment.X15b_If_client_referred__c = '8. something';
        testTreatment.X15b8_Other_specify__c = 'test';
        try
        {
        	insert testTreatment;
        	system.assert (false);
        }
        catch (Exception e)
        {
        	
        }
     }
}