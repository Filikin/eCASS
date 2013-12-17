/*
	Author: Eamon Kelly, Enclude
	Purpose: Update the overall outcome field with the current outcome in the care plan
	Called from: Trigger dispatcher
*/
public with sharing class CreateUpdateCarePlanClass implements TriggerDispatcher.ITriggerEntry
{
	public void MainEntry (String TriggerObject, Boolean isBefore, Boolean isDelete, Boolean isAfter, Boolean isInsert, Boolean isUpdate, Boolean isExecuting,
		List<SObject> newList, Map<Id, SObject> newMap, List<SObject> oldList, Map<Id, SObject> oldMap)
	{
		if (trigger.isInsert)
		{
			CarePlanBeingInserted (newList);
		}
		else if (trigger.isUpdate)
		{
			CarePlanBeingUpdated (oldMap, newList);
		}
	}

	public void CarePlanBeingInserted (List<ecass01__Care_Plan_Objective__c> cmList)
	{
		UpdateOutcomeFromLatestOutcome (cmList);
	}

	public void CarePlanBeingUpdated (Map<ID, sObject> oldCMMap, List<ecass01__Care_Plan_Objective__c> cmList)
	{
		UpdateOutcomeFromLatestOutcome (cmList);
	}

	/* The user enters the current outcome into the ecass01__Outcome__c field, this routine takes this outcome and appends it to Overall_Outcome__c with the 
		current date and user name */ 
	public void UpdateOutcomeFromLatestOutcome (List<ecass01__Care_Plan_Objective__c> cpList)
	{
	    for(ecass01__Care_Plan_Objective__c c: cpList)
   		{
	    	if (c.ecass01__Outcome__c <> null)
	    	{
	    		if (c.Overall_Outcome__c == null) c.Overall_Outcome__c = '';
	    		c.Overall_Outcome__c = system.today().format() + ' ' + UserInfo.getName() + ' ' + c.ecass01__Outcome__c + '\r\n' + c.Overall_Outcome__c;
	    		c.ecass01__Latest_Outcome__c = c.ecass01__Outcome__c;
	    		c.ecass01__Outcome__c = '';
	    	}
   		}
    }
	
	// Tests start here 
	static List<Contact> createTestObjects (Integer numberOfContacts)
	{
		List<Contact> contacts = new List<Contact>();
		for (Integer i=1; i<=numberOfContacts; i++)
		{
			Contact newContact = new Contact (firstName='Fred'+i, lastName='Test'+i, BirthDate=Date.newInstance (1993, 2, i), ecass01__X4_Gender__c='1. Male');
			contacts.add(newContact);
		}
		insert contacts;
		return contacts;
	}

	static testMethod void testCarePlanCreated ()
    {
     	List<Contact> newContacts = createTestObjects (5);
 
        ecass01__Care_Plan_Objective__c careplan = new ecass01__Care_Plan_Objective__c (Name='Improve welbeing', ecass01__Client__c=newContacts[0].id);
        insert careplan;
        
        
        Integer preCarePlanSteps = [select count() from ecass01__Care_plan_step__c where ecass01__Reference__c != null];
        
        Event e1 = new Event (WhoID=newContacts[0].id, OwnerID=UserInfo.getUserId(), WhatID=careplan.id, Subject='Test', StartDateTime=DateTime.newInstance(2012,1,5,12,30,30), EndDateTime=DateTime.newInstance(2012,1,5,13,30,30));
        insert e1;
        
        Integer postCarePlanSteps = [select count() from ecass01__Care_plan_step__c where ecass01__Reference__c != null];
 
        System.Assert (postCarePlanSteps == preCarePlanSteps + 1);
        
        e1.Subject='Finished';
        update e1;
        
        ecass01__Care_plan_step__c careplanstep = [select ID, ecass01__Reference__c, ecass01__Description__c from ecass01__Care_plan_step__c where ecass01__Care_Plan_Objective__c = :careplan.id];
        System.debug(careplanstep.ecass01__Description__c);
        System.assert(careplanstep.ecass01__Description__c.contains ('Finished'));
    }

	static testMethod void testCarePlanUpdated ()
    {
     	List<Contact> newContacts = createTestObjects (5);
 
        ecass01__Care_Plan_Objective__c careplan = new ecass01__Care_Plan_Objective__c (Name='Improve welbeing', ecass01__Client__c=newContacts[0].id);
        insert careplan;
        
        careplan.ecass01__Outcome__c = 'A test outcome';
        update careplan;
        
        careplan = [select ID, Overall_Outcome__c from ecass01__Care_Plan_Objective__c where id = :careplan.id];
        system.assert (careplan.Overall_Outcome__c.contains ('test outcome'));
    }

	static testMethod void testCarePlanDeleted ()
    {
     	List<Contact> newContacts = createTestObjects (5);
 
        ecass01__Care_Plan_Objective__c careplan = new ecass01__Care_Plan_Objective__c (Name='Improve welbeing', ecass01__Client__c=newContacts[0].id);
        insert careplan;
        
        List <ecass01__Care_Plan_Objective__c> plansBefore = [select ID from ecass01__Care_Plan_Objective__c];
        delete careplan;
        
        List <ecass01__Care_Plan_Objective__c> plansAfter = [select ID from ecass01__Care_Plan_Objective__c];
        system.assert (plansBefore.size() > plansAfter.size());
        
    }

}