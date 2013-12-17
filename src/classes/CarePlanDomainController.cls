/*
	Author: Eamon Kelly, Enclude
	Purpose: a controller for the component CarePlanDomain
	The component is called from the CarePlanOverview and CarePlanOverviewPrint pages
*/
public with sharing class CarePlanDomainController 
{
    public ecass01__Care_Plan_Objective__c carePlanGoal {get;set;}
    public Boolean adminFlag {get;set;}
}