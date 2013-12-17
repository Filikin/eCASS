/*
	Author: Eamon Kelly, Enclude
	Purpose: When an attendence is created or modified that is associated with an enrolment that is linked to a care plan objective, 
		create or modify the care plan step on that care plan objective
	Tested in testCreateAttendanceTrigger 
*/
trigger CreateUpdateCarePlanStepOnAttendance on Attendance__c (after insert, after update) 
{
	// Mapping attended and comment into the care plan step
    List <Attendance__c>attendances = [select ID, Interaction__c, Comment__c, Attended__c, Enrolment__c, Enrolment__r.Care_Plan_Objective__c, Enrolment__r.Care_Plan_Objective__r.Name, Young_Person_name__c, Care_plan_step_date__c, Care_plan_step_description__c from Attendance__c where ID in :trigger.newMap.keySet()];
    
    List <Care_plan_step__c>newSteps = new List<Care_plan_step__c>();
    
    List <Care_plan_step__c>currentSteps = [select ID, Date__c, Description__c, Reference__c from Care_plan_step__c where Reference__c in :trigger.newMap.keySet()];
    Map <ID, Care_plan_step__c>currentStepsMap = new Map<ID, Care_plan_step__c>();
    for (Care_plan_step__c oneStep: currentSteps)
    {
        currentStepsMap.put (oneStep.Reference__c, oneStep);
    }
        
            
    for (Attendance__c oneAttendance: attendances)
    {
        if (oneAttendance.Enrolment__c != null)
        {
            if (oneAttendance.Enrolment__r.Care_Plan_Objective__c != null)
            {
                if (trigger.isInsert)
                {
                    Care_plan_step__c oneStep = new Care_plan_step__c (Care_Plan_Objective__c=oneAttendance.Enrolment__r.Care_Plan_Objective__c, Care_Plan_Objective_Name__c=oneAttendance.Enrolment__r.Care_Plan_Objective__r.Name,
                        Date__c=oneAttendance.Care_plan_step_date__c, Description__c=oneAttendance.Care_plan_step_description__c, Reference__c=oneAttendance.id,
                        Client_name__c=oneAttendance.Young_Person_name__c);
                        
                    oneStep.Status_Comment__c = '';
                    if (oneAttendance.Comment__c != null) oneStep.Status_Comment__c = oneAttendance.Comment__c;
                    if (oneAttendance.Comment__c != null && oneAttendance.Interaction__c != null) oneStep.Status_Comment__c += ' - ';
                    if (oneAttendance.Interaction__c != null) oneStep.Status_Comment__c += 'Interaction: ' + oneAttendance.Interaction__c;
                    oneStep.Status__c = oneAttendance.Attended__c ? 'Attended' : 'Did not attend';
                    newSteps.Add(oneStep);
                }
                else
                {
                    Care_plan_step__c oneStep = currentStepsMap.get (oneAttendance.id);
                    oneStep.Date__c=oneAttendance.Care_plan_step_date__c;
                    oneStep.Description__c=oneAttendance.Care_plan_step_description__c;
                    
                    oneStep.Status_Comment__c = '';
                    if (oneAttendance.Comment__c != null) oneStep.Status_Comment__c = oneAttendance.Comment__c;
                    if (oneAttendance.Comment__c != null && oneAttendance.Interaction__c != null) oneStep.Status_Comment__c += ' - ';
                    if (oneAttendance.Interaction__c != null) oneStep.Status_Comment__c += 'Interaction: ' + oneAttendance.Interaction__c;
                    oneStep.Status__c = oneAttendance.Attended__c ? 'Attended' : 'Did not attend';
                }
            }
        }       
    }
    if (newSteps.size() > 0) insert newSteps;
    if (currentSteps.size()> 0) update currentSteps;
}