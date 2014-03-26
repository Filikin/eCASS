/*
    Author: Eamon Kelly, Enclude
    Purpose: Need to act as a rollup on the treatment to the contact to count number of HRB Forms (Treatments)
    Called from: TriggerDispatcher
    
    NOTE: the year of the count of the number of treatments, needs to be in some way controlled by the user to allow for
    submissions to the HRB of last year's form - change line:
    	Integer this_year = system.today().year();
*/
public with sharing class TreatmentFormsTriggerClass implements TriggerDispatcher.ITriggerEntry
{
    public void MainEntry (String TriggerObject, Boolean isBefore, Boolean isDelete, Boolean isAfter, Boolean isInsert, Boolean isUpdate, Boolean isExecuting,
        List<SObject> newList, Map<Id, SObject> newMap, List<SObject> oldList, Map<Id, SObject> oldMap)
    {
        if (isInsert)
        {
        	if (isBefore)
        	{
          		VerifyRules (newList);
        		CalculateMaxInterventionCommencementDate (newList);
        		CountNumberOfFormsStartedThisYear (newList);
        	}
         }
        else if (isUpdate)
        {
        	if (isBefore) 
        	{
        		VerifyRules (newList);
        		CalculateMaxInterventionCommencementDate (newList);
        	}
        }
    }

  	public void CountNumberOfFormsStartedThisYear (List<ecass01__Treatment__c> frmList)
 	{
 		set<ID> clientSet = new set<ID>();
 		for (ecass01__Treatment__c oneForm: frmList)
 		{
 			clientSet.add (oneForm.Contact__c);
 		}
 		Integer this_year = system.today().year();
 		map <ID, Contact> clients = new map <ID, Contact>([SELECT ID, (SELECT Id FROM Treatments_del__r where CALENDAR_YEAR(X16_Date_of_Assessment__c) = :this_year) FROM Contact where ID in :clientSet]);
 		
 		for (ecass01__Treatment__c oneForm: frmList)
 		{
 			oneForm.X20_Number_times_started_this_year__c = clients.get(oneForm.Contact__c).Treatments_del__r.size() + 1;
 		}
 		
 	}
 	
	public void CalculateMaxInterventionCommencementDate (List<ecass01__Treatment__c> newList)
	{
        for (ecass01__Treatment__c oneForm: newList)
        {
        	oneForm.Date_latest_intervention_commenced__c = Date.valueOf('2011-1-1');
        	if (oneForm.X33b1_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b1_Date_Commenced__c;
         	if (oneForm.X33b12_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b12_Date_Commenced__c;
        	if (oneForm.X33b13_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b13_Date_Commenced__c;
        	if (oneForm.X33b14_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b14_Date_Commenced__c;
        	if (oneForm.X33b15_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b15_Date_Commenced__c;
        	if (oneForm.X33b16_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b16_Date_Commenced__c;
        	if (oneForm.X33b17_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b17_Date_Commenced__c;
        	if (oneForm.X33b18_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b18_Date_Commenced__c;
        	if (oneForm.X33b19_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b19_Date_Commenced__c;
        	if (oneForm.X33b20_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b20_Date_Commenced__c;
        	if (oneForm.X33b21_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b21_Date_Commenced__c;
        	if (oneForm.X33b23_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b23_Date_Commenced__c;
        }
	}
	
	public void VerifyRules (list<Treatment__c> updatedForms)
    {
    	if (AppConfigSupport.ValidationRulesOn == false) return;
    	
    	for (Treatment__c oneForm: updatedForms)
    	{
    		if (oneForm.Pause__c == false)
    		{
    			Q13_Q16_Dates_in_sequential_order (oneForm);
    			If_Q14_then_Q14_Drug_Must_Be_Filled (oneForm);
    			
    			Q14_type_crosschecks (oneForm);
    			
    			if (oneForm.X14_Main_Drug_Problem_Name__c != 'Concerned Person')
    			{
    				
    				Q15a_must_be_completed (oneForm);		  
    				Q15b_must_be_completed (oneForm);
					
    				Q17_Assessment_Outcome_required (oneForm);
    				
    				
	    			if (oneForm.X17a_Assessment_outcome__c != null && !oneForm.X17a_Assessment_outcome__c.startsWith ('2.'))
	    			{
	    				Q17b_Assessment_criterion_fulfilled (oneForm);
	    				Q17c_Date_assessment_criterion_fulfilled (oneForm);
	    				
	    				if (oneForm.X17b_Assessment_criterion_fulfilled__c != null && !oneForm.X17b_Assessment_criterion_fulfilled__c.startsWith ('2.'))
	    				{
	    					Q18a_3_Transferred_to_another_site_AND_Q18a_Clients_treatment_status_fullfilled (oneForm);
	    					if (oneForm.X18a_Clients_treatment_status__c != null && !oneForm.X18a_Clients_treatment_status__c.startsWith ('3.') && !oneForm.X18a_Clients_treatment_status__c.startsWith('4.'))
	    					{
			    				if (oneForm.X18a_Clients_treatment_status__c.startsWith ('2.') || oneForm.X18a_Clients_treatment_status__c.startsWith('6.'))
			    				{
			    					// go to 18b
			    					Q18b4_Specify_client_transferred_AND_Q18b9_Other_specify (oneForm);
			    				}
			    				if (oneForm.X18a_Clients_treatment_status__c.startsWith ('1.') || oneForm.X18b_Reason_removed_from_waiting_list__c.startsWith('1.'))
			    				{
			    					Q19_Accepted_place (oneForm);
			    					if (oneForm.X19_Accepted_place_at_this_centre__c != null && oneForm.X19_Accepted_place_at_this_centre__c.startsWith ('1.'))
			    					{
			    						// continue with form - Q20 onwards
			    					}
			    				}
	    					}
	    				}
	    			}
    			}
    		}
    	}
    }
    
    public void Q13_Q16_Dates_in_sequential_order (Treatment__c currentForm)
    {
    	if (currentForm.X13_Date_of_Referral__c > currentForm.X16_Date_of_Assessment__c)
    	{
    		currentForm.X16_Date_of_Assessment__c.addError ('Please check dates in sequential order, Q13 <=Q16');
    	}
    }
	
	public void If_Q14_then_Q14_Drug_Must_Be_Filled (Treatment__c currentForm)
	{
		if (currentForm.X14_Main_Reason_for_referral__c != null && currentForm.X14_Main_Reason_for_Referral_Drug__c == null)
		{
			currentForm.X14_Main_Reason_for_Referral_Drug__c.addError ('Please specify main drug or problem');
		}
	}
	
	public void Q14_type_crosschecks (Treatment__c currentForm)
	{
		// Check that drug type on Drugs record matches Q14 type 
		
	}
	
	public void Q15a_must_be_completed (Treatment__c currentForm)
	{
		if (currentForm.X15_Source_of_referral__c == null) currentForm.X15_Source_of_referral__c.addError ('Please complete Q15a');
	}
	
	public void Q15b_must_be_completed (Treatment__c currentForm)
	{
		if (currentForm.X15_Source_of_referral__c != null && currentForm.X15b_If_client_referred__c == null &&
    				(currentForm.X15_Source_of_referral__c.startsWith('4.') || currentForm.X15_Source_of_referral__c.startsWith('5.') ||
    				currentForm.X15_Source_of_referral__c.startsWith('6.') || currentForm.X15_Source_of_referral__c.startsWith('13.') ||
    				currentForm.X15_Source_of_referral__c.startsWith('15.') || currentForm.X15_Source_of_referral__c.startsWith('17.')) ) 
    	{			 
			currentForm.X15b_If_client_referred__c.addError ('Q15b must be completed when Q15a = 4, 5, 6, 13, 15, 17.');
    	}
    	
    	if (currentForm.X15b_If_client_referred__c != null && currentForm.X15b_If_client_referred__c.startsWith('8.') 
    		&& currentForm.X15b8_Other_specify__c == null  )
    	{
    		currentForm.X15b8_Other_specify__c.addError('If Q15b is equal to "8. other specify", Q15b8 is required');
    	}
    	
    	if (currentForm.X15b_If_client_referred__c != null && !currentForm.X15b_If_client_referred__c.startsWith('8.') 
    		&& currentForm.X15b8_Other_specify__c != null  )
    	{
    		currentForm.X15b_If_client_referred__c.addError('Q15b must be set to "8. other specify" if Q15b8 has a value');	
    	}
	}
	
	public void Q17_Assessment_Outcome_required (Treatment__c currentForm)
	{
		if (currentForm.X17a_Assessment_outcome__c == null) currentForm.X17a_Assessment_outcome__c.addError('Q17 must be completed for all clients who reach this question.');
	}
	
	public void Q17b_Assessment_criterion_fulfilled (Treatment__c currentForm)
	{
		if (currentForm.X17b_Assessment_criterion_fulfilled__c == null) currentForm.X17b_Assessment_criterion_fulfilled__c.addError ('If Q17a = 1, please complete Q17b');
	}
	
	public void Q17c_Date_assessment_criterion_fulfilled (Treatment__c currentForm)
	{
		// if 17b is 1 then 17c must be complete
		// if 17c is complete then 17b must be 1
		// 17c must be greater than or equal to 16
		if (currentForm.X17b_Assessment_criterion_fulfilled__c != null && currentForm.X17b_Assessment_criterion_fulfilled__c.startsWith ('1.') && currentForm.X17c_Date_assessment_criteria_fulfilled__c == null)
		{
			currentForm.X17c_Date_assessment_criteria_fulfilled__c.addError ('If Q17a = 1 and Q17b = 1, please complete Q17c');
		}	
		if (currentForm.X17c_Date_assessment_criteria_fulfilled__c != null && (currentForm.X17b_Assessment_criterion_fulfilled__c == null || !currentForm.X17b_Assessment_criterion_fulfilled__c.startsWith ('1.')))
		{
			currentForm.X17b_Assessment_criterion_fulfilled__c.addError ('If Q17c is complete, please set Q17b to 1');
		}
		if (currentForm.X17c_Date_assessment_criteria_fulfilled__c < currentForm.X16_Date_of_Assessment__c)
		{
			currentForm.X17c_Date_assessment_criteria_fulfilled__c.addError ('Q17c must be later than or the same as Q16');
		}		
	}
	
	public void Q18a_3_Transferred_to_another_site_AND_Q18a_Clients_treatment_status_fullfilled (Treatment__c currentForm)
	{
		if (currentForm.X18a_Clients_treatment_status__c == null)
		{
			currentForm.X18a_Clients_treatment_status__c.addError ('If Q17 = 1, please complete Q18a');
		}
		else if (currentForm.X18a_Clients_treatment_status__c.startsWith ('3.') && currentForm.X18a3_Specify_Transferred__c == null)
		{
			currentForm.X18a3_Specify_Transferred__c.addError ('If Q18a = 3, please complete Q18a3 Specify site');
		}
	}
	
	public void Q18b4_Specify_client_transferred_AND_Q18b9_Other_specify (Treatment__c currentForm)
	{
		if (currentForm.X18b_Reason_removed_from_waiting_list__c != null && currentForm.X18b_Reason_removed_from_waiting_list__c.startsWith ('4.') && currentForm.X18b4_Client_transferred_specify_centre__c == null)
		{
			currentForm.X18b4_Client_transferred_specify_centre__c.addError ('If Q18b = 4, please complete Q18b4');
		}
		
		if (currentForm.X18b_Reason_removed_from_waiting_list__c != null && currentForm.X18b_Reason_removed_from_waiting_list__c.startsWith ('9.') && currentForm.X18b9_Other_specify__c == null)
		{
			currentForm.X18b9_Other_specify__c.addError ('If Q18b = 9, please complete Q18b9');
		}
		
	}
	
	public void Q19_Accepted_place (Treatment__c currentForm)
	{
		if (currentForm.X19_Accepted_place_at_this_centre__c == null) currentForm.X19_Accepted_place_at_this_centre__c.addError ('If Q17a = 1 and Q18a = 1, please complete Q19');	
	}
}