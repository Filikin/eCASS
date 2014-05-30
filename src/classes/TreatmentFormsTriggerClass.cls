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
        		System.Debug('In TreatmentFormsTriggerClass ');
          		VerifyRules (newList);
        		CalculateMaxInterventionCommencementDate (newList);
        		CountNumberOfFormsStartedThisYear (newList);
        		System.Debug('FinishingTreatmentFormsTriggerClass');
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
        	if (oneForm.X33b28_Date_Commenced__c > oneForm.Date_latest_intervention_commenced__c) oneForm.Date_latest_intervention_commenced__c = oneForm.X33b28_Date_Commenced__c;
        }
	}
	
	public void VerifyRules (list<Treatment__c> updatedForms)
    {
    	System.Debug('In VerifyRules');
    	if (AppConfigSupport.ValidationRulesOn == false) return;
    	
    	for (Treatment__c oneForm: updatedForms)
    	{
    		System.Debug('Processing each form..');
    		if (oneForm.Pause__c == false)
    		{
    			System.Debug('Starting validation rules.');
    			Q13_Q16_Dates_in_sequential_order (oneForm);
    			If_Q14_then_Q14_Drug_Must_Be_Filled (oneForm);
    			Q14_type_crosschecks (oneForm);
    			
    			if (oneForm.X14_Main_Drug_Problem_Name__c != 'Concerned Person')
    			{
    				system.debug ('Not a concerned person');
    				Q15a_must_be_completed (oneForm);		  
    				Q15b_must_be_completed (oneForm);
    				Q17_Assessment_Outcome_required (oneForm);
    				
	    			if (oneForm.X17a_Assessment_outcome__c != null && !oneForm.X17a_Assessment_outcome__c.startsWith ('2.'))
	    			{
	    				system.debug ('In Q17a');
	    				Q17b_Assessment_criterion_fulfilled (oneForm);
	    				Q17c_Date_assessment_criterion_fulfilled (oneForm);
	    				
	    				if (oneForm.X17b_Assessment_criterion_fulfilled__c != null && !oneForm.X17b_Assessment_criterion_fulfilled__c.startsWith ('2.'))
	    				{
	    				system.debug ('In Q17b');
	    					Q18a_Clients_treatment_status_fullfilled_AND_Q18a_3_Transferred_to_another_site (oneForm);
	    					
	    					if (oneForm.X18a_Clients_treatment_status__c != null && !oneForm.X18a_Clients_treatment_status__c.startsWith ('3.') && !oneForm.X18a_Clients_treatment_status__c.startsWith('4.'))
	    					{
	    				system.debug ('In Q18a');
			    				if (oneForm.X18a_Clients_treatment_status__c.startsWith ('2.') || oneForm.X18a_Clients_treatment_status__c.startsWith('6.'))
			    				{ // will get here if Q18 is 2 or 6 
			    					// go to 18b
			    					Q18b_must_be_completed (oneForm);
			    					Q18b4_Specify_client_transferred_AND_Q18b9_Other_specify (oneForm);
			    				}
			    				if (oneForm.X18a_Clients_treatment_status__c.startsWith ('1.') || oneForm.X18a_Clients_treatment_status__c.startsWith ('2.') || oneForm.X18a_Clients_treatment_status__c.startsWith('6.')
			    					|| (oneForm.X18b_Reason_removed_from_waiting_list__c != null && oneForm.X18b_Reason_removed_from_waiting_list__c.startsWith('1.')))
			    				{ // will get here is Q18 is 1, 2 or 6 or Q18b is 1
			    					system.debug ('In Q18 part 2');
		    						Q19_Accepted_place (oneForm);
		    						
		    						if (oneForm.X19_Accepted_place_at_this_centre__c != null && oneForm.X19_Accepted_place_at_this_centre__c.startsWith ('1.'))
		    						{
			    						// continue with form - Q20 onwards
			    						Q21a_Date_treatment_started_AND_Q16_Q21a_Secential_order (oneForm);
			    						Q14_Main_Reason_for_referral_AND_Q22_Ever_previously_treated_re_alcohol (oneForm);
			    						Q14_Main_Reason_for_referral_2Ilicit_drug_AND_Q22_Ever_previously_treated_re_drug (oneForm);
			    						Q14_Main_Reason_for_referral_3Licit_drug_AND_Q22_Ever_previously_treated_re_drug (oneForm);
			    						Q14_Main_Reason_for_referral_4Other_problem_AND_Q22_Ever_previously_treated_re_drug (oneForm);
			    						Q23_Type_of_contact_with_this_centre (oneForm);
			    						Q24_Substance_use_Excluding_Alcohol (oneForm);
			    						Q25_Substance_use_Including_Alcohol (oneForm);
			    						Q26_Substance_use_Including_Alcohol (oneForm);
										Q27_Substance_use_Including_Alcohol (oneForm);
										Q28_Substance_use_Including_Alcohol (oneForm);
			    						Q25_to_Q28_all_different (oneForm);
			    						Q28e_to_Q28h_are_blank_if_no_alcohol (oneForm);
			    						Q28e_to_Q28h_are_not_blank_if_alcohol (oneForm);
		    							Q29b_Check_If_Ever_Injected (oneForm);
		    							if (oneForm.X37_Date_of_Final_Discharge__c == null)
		    							{
		    								Ensure_That_Q33c_and_Q33d_Are_Blank (oneForm);
		    							}
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
    	if ((currentForm.X13_Date_of_Referral__c != null && currentForm.X16_Date_of_Assessment__c !=null) && (currentForm.X13_Date_of_Referral__c > currentForm.X16_Date_of_Assessment__c))
    	{
    		currentForm.X16_Date_of_Assessment__c.addError ('Please check dates in sequential order Q13 <=Q16');
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
		if (currentForm.X14_Main_Reason_for_referral__c != null && currentForm.X14_Main_Reason_for_Referral_Drug__c != null && 
					(currentForm.X14_Main_Reason_for_referral__c.startsWith('1.') && currentForm.Drug_Type__c != '1. ALCOHOL' ))
		{
			currentForm.X14_Main_Reason_for_Referral_Drug__c.addError ('If Q14 Main Reason for referral is equal to "1. Alcohol",  Q14 specify drug must be alcohol');
		}
		
		if (currentForm.X14_Main_Reason_for_referral__c != null && currentForm.X14_Main_Reason_for_Referral_Drug__c != null &&
					(currentForm.X14_Main_Reason_for_referral__c.startsWith('2.') && currentForm.Drug_Type__c != '2. ILICIT DRUG' ))
		{
			currentForm.X14_Main_Reason_for_Referral_Drug__c.addError ('If Q14 Main Reason for referral is equal to "2. Illicit drug",  Q14 specify drug must be an illicit drug');
		}
		
		if (currentForm.X14_Main_Reason_for_referral__c != null && currentForm.X14_Main_Reason_for_Referral_Drug__c != null &&
					(currentForm.X14_Main_Reason_for_referral__c.startsWith('3.') && currentForm.Drug_Type__c != '3. LICIT DRUG' ))
		{
			currentForm.X14_Main_Reason_for_Referral_Drug__c.addError ('If Q14 Main Reason for referral is equal to "3. Licit drug",  Q14 specify drug must be an Licit drug');
		}
		
		if (currentForm.X14_Main_Reason_for_referral__c != null && currentForm.X14_Main_Reason_for_Referral_Drug__c != null &&
					(currentForm.X14_Main_Reason_for_referral__c.startsWith('4.') && currentForm.Drug_Type__c != '4. Other problem' ))
		{
			currentForm.X14_Main_Reason_for_Referral_Drug__c.addError ('If Q14 Main Reason for referral is equal to "4. Other problem",  Q14 specify drug or problem can not be Alcohol or Drug');
		}
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
	
	public void Q18a_Clients_treatment_status_fullfilled_AND_Q18a_3_Transferred_to_another_site (Treatment__c currentForm)
	{
		if (currentForm.X17a_Assessment_outcome__c.startsWith('1.')  && currentForm.X18a_Clients_treatment_status__c == null)
		{
			currentForm.X18a_Clients_treatment_status__c.addError ('If Q17 = 1, please complete Q18a');
		}
		else if (currentForm.X18a_Clients_treatment_status__c.startsWith ('3.') && currentForm.X18a3_Specify_Transferred__c == null)
		{
			currentForm.X18a3_Specify_Transferred__c.addError ('If Q18a = 3, please complete Q18a3 Specify site');
		}
	}
	
	public void Q18b_must_be_completed (Treatment__c currentForm)
	{
		if((currentForm.X18a_Clients_treatment_status__c.startsWith ('2.') || currentForm.X18a_Clients_treatment_status__c.startsWith ('6.')) && currentForm.X18b_Reason_removed_from_waiting_list__c == null)
		{
			currentForm.X18b_Reason_removed_from_waiting_list__c.addError ('Q18b must be completed when Q18a = 2, 6');
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
		if(currentForm.X18a_Clients_treatment_status__c.startsWith ('1.') && currentForm.X19_Accepted_place_at_this_centre__c == null) // || (currentForm.X18b_Reason_removed_from_waiting_list__c != null && currentForm.X18b_Reason_removed_from_waiting_list__c.startsWith('1.')))
		{
			currentForm.X19_Accepted_place_at_this_centre__c.addError ('If Q18a = 1, please complete Q19');	
		}
		if (currentForm.X18b_Reason_removed_from_waiting_list__c != null && currentForm.X18b_Reason_removed_from_waiting_list__c.startsWith('1.')&& currentForm.X19_Accepted_place_at_this_centre__c == null)
		{
			currentForm.X19_Accepted_place_at_this_centre__c.addError ('If Q18b = 1, please complete Q19');
		} 
	}
	
	public void Q21a_Date_treatment_started_AND_Q16_Q21a_Secential_order (Treatment__c currentForm)
	{
		if (currentForm.X19_Accepted_place_at_this_centre__c != null && currentForm.X19_Accepted_place_at_this_centre__c.startsWith ('1.') && currentForm.X21a_Date_This_treatment_started__c == null) 
		{
			currentForm.X21a_Date_This_treatment_started__c.addError ('If treatment has started, please complete Q21a');	
		}
		
	}
	
	public void Q14_Main_Reason_for_referral_AND_Q22_Ever_previously_treated_re_alcohol (Treatment__c currentForm)
	{
		system.debug ('In Q14_Main_Reason_for_referral_AND_Q22_Ever_previously_treated_re_alcohol');
		if (currentForm.X14_Main_Reason_for_referral__c.startsWith('1.'))
		{
			if(currentForm.X22_Ever_previously_treated_alc_drug__c == null )
			{
				currentForm.X22_Ever_previously_treated_alc_drug__c.addError ('If Q14 = 1. Alcohol, Q22 Re Alcohol must be completed');
			}
			if(currentForm.X22_Ever_previously_treated_alc_drug__c != null && currentForm.X22_Ever_previously_treated_alc_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_alc_drug__c.addError ('If Q14 = 1. Alcohol, Q22 Re Alcohol can not be code 8');
			}
			if(currentForm.X22_Ever_previously_treated_re_drug__c != null && !currentForm.X22_Ever_previously_treated_re_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_re_drug__c.addError ('If Q14 = 1. Alcohol, Q22 Re Drug must be code 8');
			}
		}
		 
	}

	
	public void Q14_Main_Reason_for_referral_2Ilicit_drug_AND_Q22_Ever_previously_treated_re_drug (Treatment__c currentForm)
	{
		if (currentForm.X14_Main_Reason_for_referral__c.startsWith('2.'))
		{
			if(currentForm.X22_Ever_previously_treated_re_drug__c == null )
			{
				currentForm.X22_Ever_previously_treated_re_drug__c.addError ('If Q14 = 2. Ilicit Drug, Q22 Re Drug must be completed');
			}
			if(currentForm.X22_Ever_previously_treated_re_drug__c != null && currentForm.X22_Ever_previously_treated_re_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_re_drug__c.addError ('If Q14 = 2. Ilicit Drug, Q22 Re Drug can not be code 8');
			}
			if(currentForm.X22_Ever_previously_treated_alc_drug__c != null && !currentForm.X22_Ever_previously_treated_alc_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_alc_drug__c.addError ('If Q14 = 2. Ilicit Drug, Q22 Re Alcohol must be code 8');
			}
		}
	}
	
	public void Q14_Main_Reason_for_referral_3Licit_drug_AND_Q22_Ever_previously_treated_re_drug (Treatment__c currentForm)	
	{																
		if(currentForm.X14_Main_Reason_for_referral__c.startsWith('3.'))
		{
			if(currentForm.X22_Ever_previously_treated_re_drug__c == null )
			{
			 	currentForm.X22_Ever_previously_treated_re_drug__c.addError ('If Q14 = 3. Licit Drug, Q22 Re Drug must be completed');
			}
			if(currentForm.X22_Ever_previously_treated_re_drug__c != null && currentForm.X22_Ever_previously_treated_re_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_re_drug__c.addError ('If Q14 = 3. Licit Drug, Q22 Re Drug can not be code 8');
			}
			if(currentForm.X22_Ever_previously_treated_alc_drug__c != null && !currentForm.X22_Ever_previously_treated_alc_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_alc_drug__c.addError ('If Q14 = 3. Licit Drug, Q22 Re Alcohol must be code 8');
			}
		}
	}
	
	public void Q14_Main_Reason_for_referral_4Other_problem_AND_Q22_Ever_previously_treated_re_drug (Treatment__c currentForm)
	{
		if(currentForm.X14_Main_Reason_for_referral__c.startsWith('4.'))
		{
			if (currentForm.X22_Ever_previously_treated_alc_drug__c == null)
			{
				currentForm.X22_Ever_previously_treated_alc_drug__c.addError ('If Q14 = 4. Other Problem, Q22 Re Alcohol must be code 8'); 
			}	 
			if (currentForm.X22_Ever_previously_treated_alc_drug__c != null && !currentForm.X22_Ever_previously_treated_alc_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_alc_drug__c.addError ('If Q14 = 4. Other Problem, Q22 Re Alcohol must be code 8');
			}
			if(currentForm.X22_Ever_previously_treated_re_drug__c == null)
			{
				currentForm.X22_Ever_previously_treated_re_drug__c.addError ('If Q14 = 4. Other Problem, Q22 Re Drug must be code 8');
			}
			if (currentForm.X22_Ever_previously_treated_re_drug__c != null && !currentForm.X22_Ever_previously_treated_re_drug__c.startsWith('8.'))
			{
				currentForm.X22_Ever_previously_treated_re_drug__c.addError ('If Q14 = 4. Other Problem, Q22 Re Drug must be code 8');
			}
		}
	}
		
	public void Q23_Type_of_contact_with_this_centre (Treatment__c currentForm)
	{
		if (currentForm.X21a_Date_This_treatment_started__c != null && currentForm.X23_Type_of_contact_with_this_centre__c == null)
		{
			currentForm.X23_Type_of_contact_with_this_centre__c.addError ('If the treatment has started, please complete Q23');
			
		}
	}
	
	public void Q24_Substance_use_Excluding_alcohol (Treatment__c currentForm)
	{
		if (currentForm.X23_Type_of_contact_with_this_centre__c != null && currentForm.X24a_Age_first_use_any_drug__c == null)
		{
		 	currentForm.X24a_Age_first_use_any_drug__c.addError ('Please complete Q24a, if not applicable add code 88');
		}
		if (currentForm.X24a_Age_first_use_any_drug__c != null && currentForm.X24a_Age_first_use_any_drug__c != 88)
		{
			if (currentForm.X24a_Age_first_use_any_drug__c > currentForm.Age__c )
			{
				currentForm.X24a_Age_first_use_any_drug__c.addError ('Please check the age of the client, Q24a can not be > Age');
			}
			if (currentForm.X24a_Age_first_use_any_drug__c != null && currentForm.X24b_Specify_first_drug_used__c == null)
			{
				currentForm.X24b_Specify_first_drug_used__c.addError ('Please complete Q24b');
			}
		}
	}
	
	public void Q25_Substance_use_Including_Alcohol (Treatment__c currentForm)
	{
		if (currentForm.X23_Type_of_contact_with_this_centre__c != null && currentForm.X24a_Age_first_use_any_drug__c != null)
		{
			if (currentForm.X25a_Main_substance__c == null )
			{
				currentForm.X25a_Main_substance__c.addError ('Please complete Q25a Main substance');
			}
			if (currentForm.X25a_Main_substance__c != null && currentForm.X14_Main_Reason_for_Referral_Drug__c != null)
			{
				if(currentForm.X14_Main_Drug_Problem_Name__c != currentForm.X25_Main_Drug_Problem_Name__c)
				{
					currentForm.X25a_Main_substance__c.addError ('Please check Q14 Main Drug Problem, Q25a must be equal to Q14 drug');
				}
			}
			if (currentForm.X25a_Main_substance__c != null && currentForm.X25b_Route_of_Admin_Main_sub__c == null)
			{
				currentForm.X25b_Route_of_Admin_Main_sub__c.addError ('If Q25a has been indicated, please complete Q25b Route of Admin Main sub');
			}
			if (currentForm.X25a_Main_substance__c != null && currentForm.X25c_Frequency_of_use_in_last_mth__c == null)
			{
				currentForm.X25c_Frequency_of_use_in_last_mth__c.addError ('If Q25a has been indicated, please complete Q25b Frequency of use in last mth');
			}
			if (currentForm.X25a_Main_substance__c != null && currentForm.X25d_Age_at_1st_use__c == null)
			{
				currentForm.X25d_Age_at_1st_use__c.addError ('If Q25a has been indicated, please complete Q25d Age at 1st use');
			}
			if (currentForm.X25a_Main_substance__c != null && currentForm.X25d_Age_at_1st_use__c != null)
			{
				if (currentForm.X25d_Age_at_1st_use__c == 0)
				{
					currentForm.X25d_Age_at_1st_use__c.addError ('If Q25a has been indicated, please complete Q25d Age at 1st use');	
				}
				if (currentForm.X25d_Age_at_1st_use__c > currentForm.Age__c)
				{
					currentForm.X25d_Age_at_1st_use__c.addError ('Please check Q25d Age at 1st use can not be > Clients Age');
				}
				if (currentForm.X24_Main_Drug_Problem_Name__c == currentForm.X25_Main_Drug_Problem_Name__c)
				{
					if(currentForm.X24a_Age_first_use_any_drug__c != currentForm.X25d_Age_at_1st_use__c)
					{
						currentForm.X25d_Age_at_1st_use__c.addError ('If Q25a drug is equal to Q24b first drug used, Q25d must be equal to Q24a');
					}
				}
				if (currentForm.X25_Drug_Type__c == 'Drug'&& (currentForm.X25d_Age_at_1st_use__c < currentForm.X24a_Age_first_use_any_drug__c))
				{
					currentForm.X25d_Age_at_1st_use__c.addError ('If Q25a is either Licit or Illicit drug, Q25d can not be < Q24a');
				}
			}
		}
	}

	public void Q26_Substance_use_Including_Alcohol (Treatment__c currentForm)
	{			
		if(currentForm.X25a_Main_substance__c == null && currentForm.X26a_Substance_2__c != null )
		{
			currentForm.X26a_Substance_2__c.addError ('Please, complete Q25 Main substance before completing Q26');
		}
		if (currentForm.X25a_Main_substance__c != null && currentForm.X26a_Substance_2__c != null)
		{
			if (currentForm.X26b_Route_of_Admin_Sub2__c == null)
			{
				currentForm.X26b_Route_of_Admin_Sub2__c.addError ('If Q26a has been indicated, please complete Q26b');
			}
			if (currentForm.X26c_Frequency_of_use_in_last_mth__c == null)
			{
				currentForm.X26c_Frequency_of_use_in_last_mth__c.addError ('If Q26a has been indicated, please complete Q26c');
			}
			if (currentForm.X26d_Age_of_1st_use__c == null)
			{
				currentForm.X26d_Age_of_1st_use__c.addError ('If Q26a has been indicated, please complete Q26d Age at 1st use');
			}
			if (currentForm.X26d_Age_of_1st_use__c != null)
			{
				if(currentForm.X26d_Age_of_1st_use__c == 0)
				{
					currentForm.X26d_Age_of_1st_use__c.addError ('If Q26a has been indicated, please complete Q26d Age at 1st use');
				}
				if(currentForm.X26d_Age_of_1st_use__c > currentForm.Age__c)
				{
					currentForm.X26d_Age_of_1st_use__c.addError ('Please check Q26d Age at 1st use can not be > the Clients Age');
				}
				if (currentForm.X24_Main_Drug_Problem_Name__c == currentForm.X26_Main_Drug_Problem_Name__c)
				{
					if(currentForm.X24a_Age_first_use_any_drug__c != currentForm.X26d_Age_of_1st_use__c )
					{
						currentForm.X26d_Age_of_1st_use__c.addError ('If Q26a drug is equal to Q24b first drug used, Q26d must be equal to Q24a');
					}
				}
				if (currentForm.X26a_Substance_2__c != null && currentForm.X26_Drug_Type__c == 'Drug')
				{
					if (currentForm.X26d_Age_of_1st_use__c < currentForm.X24a_Age_first_use_any_drug__c)
					{
						currentForm.X26d_Age_of_1st_use__c.addError ('If Q26a is either Licit or Illicit drug, Q26d can not be < Q24a');
					}
				}
			}		
		}
	}
		
	public void Q27_Substance_use_Including_Alcohol (Treatment__c currentForm)
	{	
			if (currentForm.X26a_Substance_2__c == null && currentForm.X27a_Substance_3__c != null)
			{
				currentForm.X27a_Substance_3__c.addError ('Please, complete Q25 and Q26 before completing Q27');
			}
			if (currentForm.X26a_Substance_2__c != null && currentForm.X27a_Substance_3__c != null)
			{
				if(currentForm.X27b_Route_of_Admin_Sub3__c == null)
				{
					currentForm.X27b_Route_of_Admin_Sub3__c.addError ('If Q27a has been indicated, please complete Q27b');
				}
				if(currentForm.X27c_Frequency_of_use_in_last_mth__c == null)
				{
					currentForm.X27c_Frequency_of_use_in_last_mth__c.addError ('If Q27a has been indicated, please complete Q27c');
				}
				if(currentForm.X27d_Age_of_1st_use__c == null)
				{
					currentForm.X27d_Age_of_1st_use__c.addError ('If Q27a has been indicated, please complete Q27d');
				}
				if(currentForm.X27d_Age_of_1st_use__c != null)
					{
						if(currentForm.X27d_Age_of_1st_use__c == 0)
						{
							currentForm.X27d_Age_of_1st_use__c.addError ('If Q27a has been indicated, please complete Q27d');
						}
						if(currentForm.X27d_Age_of_1st_use__c > currentForm.Age__c )
						{
							currentForm.X27d_Age_of_1st_use__c.addError ('Please check Q27d, Age at 1st use can not be > Clients Age');
						}
						if (currentForm.X24_Main_Drug_Problem_Name__c == currentForm.X27_Main_Drug_Problem_Name__c)
						{
							if(currentForm.X24a_Age_first_use_any_drug__c != currentForm.X27d_Age_of_1st_use__c)
							{
								currentForm.X27d_Age_of_1st_use__c.addError ('If Q27a drug is equal to Q24b first drug used, Q27d must be equal to Q24a');
							}
						}
						if (currentForm.X27a_Substance_3__c != null && currentForm.X27_Drug_Type__c == 'Drug')
						{
							if(currentForm.X27d_Age_of_1st_use__c < currentForm.X24a_Age_first_use_any_drug__c )
							{
								currentForm.X27d_Age_of_1st_use__c.addError ('If Q27a is either Licit or Illicit drug, Q27d can not be < Q24a');
							}
						}
					}
			}
	}
	
	public void Q28_Substance_use_Including_Alcohol (Treatment__c currentForm)
	{
			if (currentForm.X27a_Substance_3__c == null && currentForm.X28a_Substance_4__c != null)
			{
				currentForm.X28a_Substance_4__c.addError ('Please, complete Q25, Q26, Q27 before completing Q28');
			}
			if (currentForm.X27a_Substance_3__c != null && currentForm.X28a_Substance_4__c != null)
			{
				if(currentForm.X28b_Route_of_Admin_Sub4__c == null)
				{
					currentForm.X28b_Route_of_Admin_Sub4__c.addError('If Q28a has been indicated, please complete Q278b');
				}
				if(currentForm.X28c_Frequency_of_use_in_last_mth__c == null)
				{
					currentForm.X28c_Frequency_of_use_in_last_mth__c.addError ('If Q28a has been indicated, please complete Q28c');
				}
				if(currentForm.X28d_Age_of_1st_use__c == null)
				{
					currentForm.X28d_Age_of_1st_use__c.addError ('If Q28a has been indicated, please complete Q28d');
				}
				if(currentForm.X28d_Age_of_1st_use__c != null)
					{
						if(currentForm.X28d_Age_of_1st_use__c == 0)
						{
							currentForm.X28d_Age_of_1st_use__c.addError ('If Q28a has been indicated, please complete Q28d');
						}
						if(currentForm.X28d_Age_of_1st_use__c > currentForm.Age__c)
						{
							currentForm.X28d_Age_of_1st_use__c.addError ('Please check Q28d, Age at 1st use can not be > Clients Age');
						}
						if (currentForm.X24_Main_Drug_Problem_Name__c == currentForm.X28_Main_Drug_Problem_Name__c)
						{
							if(currentForm.X24a_Age_first_use_any_drug__c != currentForm.X28d_Age_of_1st_use__c)
							{
								currentForm.X28d_Age_of_1st_use__c.addError ('If Q28a drug is equal to Q24b first drug used, Q28d must be equal to Q24a');
							}
						}
						if (currentForm.X28a_Substance_4__c != null && currentForm.X27_Drug_Type__c == 'Drug')
						{
							if(currentForm.X28d_Age_of_1st_use__c < currentForm.X24a_Age_first_use_any_drug__c )
							{
								currentForm.X28d_Age_of_1st_use__c.addError ('If Q28a is either Licit or Illicit drug, Q28d can not be < Q24a');
							}
						}
					}
			}
	 	}
	 	
	public void Q25_to_Q28_all_different (Treatment__c currentForm)
	{
		if (currentForm.X25a_Main_substance__c != null && currentForm.X26a_Substance_2__c != null)
		{
			if (currentForm.X25a_Main_substance__c == currentForm.X26a_Substance_2__c)
			{
				currentForm.X26a_Substance_2__c.addError ('Q26. Substance 2 cannot be the same as Q25. Main Substance');
			}
			if (currentForm.X27a_Substance_3__c != null)
			{
				if (currentForm.X25a_Main_substance__c == currentForm.X27a_Substance_3__c)
				{
					currentForm.X27a_Substance_3__c.addError ('Q27. Substance 3 cannot be the same as Q25. Main Substance');
				}
				if (currentForm.X26a_Substance_2__c == currentForm.X27a_Substance_3__c)
				{
					currentForm.X27a_Substance_3__c.addError ('Q27. Substance 3 cannot be the same as Q26. Substance 2');
				}
				if (currentForm.X28a_Substance_4__c != null)
				{
					if (currentForm.X25a_Main_substance__c == currentForm.X28a_Substance_4__c)
					{
						currentForm.X28a_Substance_4__c.addError ('Q28. Substance 4 cannot be the same as Q25. Main Substance');
					}
					if (currentForm.X26a_Substance_2__c == currentForm.X28a_Substance_4__c)
					{
						currentForm.X28a_Substance_4__c.addError ('Q28. Substance 4 cannot be the same as Q26. Substance 2');
					}
					if (currentForm.X27a_Substance_3__c == currentForm.X28a_Substance_4__c)
					{
						currentForm.X28a_Substance_4__c.addError ('Q28. Substance 4 cannot be the same as Q27. Substance 3');
					}
				}
			}
		}
	}
	 	
	public void Q28e_to_Q28h_are_blank_if_no_alcohol (Treatment__c currentForm)
	{
		if (currentForm.X25_Drug_Type__c != 'Alcohol' && currentForm.X26_Drug_Type__c != 'Alcohol' && currentForm.X27_Drug_Type__c != 'Alcohol' && currentForm.X28_Drug_Type__c != 'Alcohol')
		{
			system.debug ('currentForm.X28e_Preferred_types_of_alcohol_consumed__c is ' + currentForm.X28e_Preferred_types_of_alcohol_consumed__c);
			if (currentForm.X28e_Preferred_types_of_alcohol_consumed__c != null)
			{
				currentForm.X28e_Preferred_types_of_alcohol_consumed__c.addError ('If alcohol is not listed as a problem, Q28e must be blank');
			}
			if (currentForm.X28f_How_many_drinks_per_occasion__c != null)
			{
				currentForm.X28f_How_many_drinks_per_occasion__c.addError ('If alcohol is not listed as a problem, Q28f must be blank');
			}
			if (currentForm.X28g_Number_of_days_alcohol_consumed__c != null)
			{
				currentForm.X28g_Number_of_days_alcohol_consumed__c.addError ('If alcohol is not listed as a problem, Q28g must be blank');
			}
			if (currentForm.X28h_Extent_of_drinking_problem__c != null)
			{
				currentForm.X28h_Extent_of_drinking_problem__c.addError ('If alcohol is not listed as a problem, Q28h must be blank');
			}
		}
	}
	
	public void Q28e_to_Q28h_are_not_blank_if_alcohol (Treatment__c currentForm)
	{
		if (currentForm.X25_Drug_Type__c == 'Alcohol' || currentForm.X26_Drug_Type__c == 'Alcohol' || currentForm.X27_Drug_Type__c == 'Alcohol' || currentForm.X28_Drug_Type__c == 'Alcohol')
		{
			if (currentForm.X28e_Preferred_types_of_alcohol_consumed__c == null)
			{
				currentForm.X28e_Preferred_types_of_alcohol_consumed__c.addError ('If alcohol is listed as a problem, Q28e must not be blank');
			}
			if (currentForm.X28f_How_many_drinks_per_occasion__c == null)
			{
				currentForm.X28f_How_many_drinks_per_occasion__c.addError ('If alcohol is listed as a problem, Q28f must not be blank');
			}
			if (currentForm.X28g_Number_of_days_alcohol_consumed__c == null)
			{
				currentForm.X28g_Number_of_days_alcohol_consumed__c.addError ('If alcohol is listed as a problem, Q28g must not be blank');
			}
			if (currentForm.X28h_Extent_of_drinking_problem__c == null)
			{
				currentForm.X28h_Extent_of_drinking_problem__c.addError ('If alcohol is listed as a problem, Q28h must not be blank');
			}
		}
	}
	
	public void Q29b_Check_If_Ever_Injected (Treatment__c currentForm)
	{
		if ((currentForm.X25b_Route_of_Admin_Main_sub__c != null && currentForm.X25b_Route_of_Admin_Main_sub__c.startsWith ('1.'))
			 || (currentForm.X26b_Route_of_Admin_Sub2__c != null && currentForm.X26b_Route_of_Admin_Sub2__c.startsWith ('1.'))
			 || (currentForm.X27b_Route_of_Admin_Sub3__c != null && currentForm.X27b_Route_of_Admin_Sub3__c.startsWith ('1.'))
			 || (currentForm.X28b_Route_of_Admin_Sub4__c != null && currentForm.X28b_Route_of_Admin_Sub4__c.startsWith ('1.')))
		{
			currentForm.X29b_Ever_injected__c = '1. Yes';
		}		
	}
	
	public void Ensure_That_Q33c_and_Q33d_Are_Blank (Treatment__c currentForm)
	{
		if (currentForm.X33c1_Date_Completed__c == null)
		{
			currentForm.X33d1_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c12_Date_Completed__c == null)
		{
			currentForm.X33d12_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c13_Date_Completed__c == null)
		{
			currentForm.X33d13_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c14_Date_Completed__c == null)
		{
			currentForm.X33d14_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c15_Date_Completed__c == null)
		{
			currentForm.X33d15_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c16_Date_Completed__c == null)
		{
			currentForm.X33d16_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c17_Date_Completed__c == null)
		{
			currentForm.X33d17_Number_of_Sesions__c = 0;
		}
		if (currentForm.X33c18_Date_Completed__c == null)
		{
			currentForm.X33d18_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c19_Date_Completed__c == null)
		{
			currentForm.X33d19_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c20_Date_Completed__c == null)
		{
			currentForm.X33d20_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c21_Date_Completed__c == null)
		{
			currentForm.X33d21_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c23_Date_Completed__c == null)
		{
			currentForm.X33d23_Number_of_Sessions__c = 0;
		}
		if (currentForm.X33c28_Date_Completed__c == null)
		{
			currentForm.X33d28_Number_of_Sessions__c = 0;
		}
	}
}