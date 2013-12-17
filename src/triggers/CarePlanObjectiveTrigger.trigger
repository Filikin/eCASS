/*
	Author: Eamon Kelly, Enclude
	Purpose: Passes control to the Trigger Dispatcher. 
*/
trigger CarePlanObjectiveTrigger on ecass01__Care_Plan_Objective__c (before insert, before update) 
{
	TriggerDispatcher.MainEntry ('CarePlanObjective', trigger.isBefore, trigger.isDelete, trigger.isAfter, trigger.isInsert, trigger.isUpdate, trigger.isExecuting,
		trigger.new, trigger.newMap, trigger.old, trigger.oldMap);

}