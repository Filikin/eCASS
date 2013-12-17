/*
	Author: Eamon Kelly, Enclude
	Purpose: When a calendar event is created or modified that is associated with a care plan objective, 
		create or modify the care plan step on that care plan objective
	Tested from CreateUpdateCarePlanClass 
*/
trigger CreateUpdateCarePlanStepOnEvent on Event (after insert, after update) 
{
    // need to know what a care plan objective looks like, if none, then we can leave
    String carePlanObjectiveIdentifier='';
    List<Care_Plan_Objective__c>cpo = new List<Care_Plan_Objective__c>();
    cpo = [select id from Care_Plan_Objective__c limit 1];
    if (cpo.size() > 0) carePlanObjectiveIdentifier=((String)(cpo[0].id)).substring(0,3);
    else return;
    
    List <Event>events = [select ID, WhoID, WhatID, StartDateTime, ecass01__Care_plan_step_text__c, Status__c, Status_Comment__c, Person_Responsible_for_Step__c, Related_Organisation__c from Event where ID in :trigger.newMap.keySet()];

    List <Care_plan_step__c>newSteps = new List<Care_plan_step__c>();
    
    List <Care_plan_step__c>currentSteps = [select ID, Date__c, Description__c, Reference__c, Status__c, Status_Comment__c, Person_Responsible_for_Action__c, Related_Organisation__c, ecass01__Care_Plan_Objective__c from Care_plan_step__c where Reference__c in :trigger.newMap.keySet()];
    Map <ID, Care_plan_step__c>currentStepsMap = new Map<ID, Care_plan_step__c>();
    for (Care_plan_step__c oneStep: currentSteps)
    {
        currentStepsMap.put (oneStep.Reference__c, oneStep);
    }
        
    Set <ID> clientsSet = new Set <ID>();
    for (Event oneEvent: events)
		clientsSet.add (oneEvent.WhoID);    
    
    Map <ID, Care_Plan_Objective__c> clientsCarePlanObjectives = new Map <ID, Care_Plan_Objective__c> ([select ID, ecass01__Client__c from Care_Plan_Objective__c where ecass01__Client__c in :clientsSet]);         
    for (Event oneEvent: events)
    {
        if (oneEvent.WhatId != null && ((String)(oneEvent.WhatId)).startsWith (carePlanObjectiveIdentifier))
        {
        	// the care plan objective must belong to the client
        	if (clientsCarePlanObjectives.get(oneEvent.whatID) == null)
        	{
        		trigger.newMap.get(oneEvent.id).whatID.addError ('Care plan objective must be for this client');
        	} 
        	else if (trigger.isInsert || currentStepsMap.get (oneEvent.id) == null)
            {
                Care_plan_step__c oneStep = new Care_plan_step__c (Care_Plan_Objective__c=oneEvent.whatID,
                    Date__c=oneEvent.StartDateTime.Date(), Description__c=oneEvent.ecass01__Care_plan_step_text__c, Reference__c=oneEvent.id,
                    Status__c=oneEvent.Status__c, Status_Comment__c=oneEvent.Status_Comment__c, Person_Responsible_for_Action__c=oneEvent.Person_Responsible_for_Step__c, Related_Organisation__c=oneEvent.Related_Organisation__c);
                newSteps.Add(oneStep);
            }
            else
            {
                Care_plan_step__c oneStep = currentStepsMap.get (oneEvent.id);
                oneStep.ecass01__Care_Plan_Objective__c = oneEvent.WhatId; // just in case it has changed
                oneStep.Date__c=oneEvent.StartDateTime.Date();
                oneStep.Description__c=oneEvent.ecass01__Care_plan_step_text__c;
                oneStep.Status__c=oneEvent.Status__c;
                oneStep.Status_Comment__c=oneEvent.Status_Comment__c;
                oneStep.Person_Responsible_for_Action__c=oneEvent.Person_Responsible_for_Step__c;
                oneStep.Related_Organisation__c=oneEvent.Related_Organisation__c;
            }
        }       
    }
    if (newSteps.size() > 0) insert newSteps;
    if (currentSteps.size()> 0) update currentSteps;
    if (clientsCarePlanObjectives.size()>0) update clientsCarePlanObjectives.values();

}