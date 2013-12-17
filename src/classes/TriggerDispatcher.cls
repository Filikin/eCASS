/*
	Author: Eamon Kelly, Enclude
	Purpose: Dispatcher for triggers - currently only used for the CarePlanObjective. 
	Called from: CarePlanObjectiveTrigger
	Test notes: This class is tested in testCarePlanEventTrigger 
*/
public class TriggerDispatcher 
{
	public static Boolean InTrigger = false;
	public interface ITriggerEntry 
	{
		void MainEntry (String TriggerObject, Boolean isBefore, Boolean isDelete, Boolean isAfter, Boolean isInsert, Boolean isUpdate, Boolean isExecuting,
			List<SObject> newList, Map<Id, SObject> newMap, List<SObject> oldList, Map<Id, SObject> oldMap);
	}
	
	public static ITriggerEntry activeFunction = null;
	
	public static void MainEntry (String TriggerObject, Boolean isBefore, Boolean isDelete, Boolean isAfter, Boolean isInsert, Boolean isUpdate, Boolean isExecuting,
		List<SObject> newList, Map<Id, SObject> newMap, List<SObject> oldList, Map<Id, SObject> oldMap)
	{
		if (TriggerObject == 'CarePlanObjective')
		{
			InTrigger = true;
			activeFunction = new CreateUpdateCarePlanClass();
			activeFunction.MainEntry (TriggerObject, isBefore, isDelete, isAfter, isInsert, isUpdate, isExecuting, newList, newMap, oldList, oldMap);
			InTrigger = false;
		}
	}
}