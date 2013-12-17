/*
	Author: Eamon Kelly, Enclude
	Purpose: additions to the care plan to support care care plan domains - each care plan objective can be part of one of six care plan domains
	Called from CarePlanOverview  - a version of the care plan that groups the objectives by domain
*/

public with sharing class ViewCarePlanExtension 
{
    public List<ecass01__Care_Plan_Objective__c> carePlanGoalsAdmin {get;set;}
    public List<ecass01__Care_Plan_Objective__c> carePlanGoalsDrugAlcoholUse {get;set;}
    public List<ecass01__Care_Plan_Objective__c> carePlanGoalsPhysical {get;set;}
    public List<ecass01__Care_Plan_Objective__c> carePlanGoalsLegal {get;set;}
    public List<ecass01__Care_Plan_Objective__c> carePlanGoalsSocial {get;set;}
    public List<ecass01__Care_Plan_Objective__c> carePlanGoalsRisk {get;set;}
    
    ID recordID;
    String recordName;
    public String CaseManager {get;set;}

	public Boolean showInternal {get;set;}
	
	public ViewCarePlanExtension (ApexPages.StandardController controller) 
    {
        sObject con = controller.getRecord();
        recordID = con.id;
        Contact client = [select Name, ecass01__Counsellor__r.Name from Contact where id = :con.id];
        if (client != null)
        {
            recordName = client.Name;
            CaseManager = client.ecass01__Counsellor__r.Name;
        }
 
        carePlanGoalsAdmin = getCarePlanGoals ('Care Plan Administration');
        carePlanGoalsDrugAlcoholUse = getCarePlanGoals ('Drug & Alcohol Use');
        carePlanGoalsPhysical = getCarePlanGoals ('Physical & Psychological Problems');
        carePlanGoalsLegal = getCarePlanGoals ('Legal Problems');
        carePlanGoalsSocial = getCarePlanGoals ('Social Functioning');
        carePlanGoalsRisk = getCarePlanGoals ('Risk Assessment');
     }
    
    private List <ecass01__Care_Plan_Objective__c> getCarePlanGoals (String area)
    {
         List <ecass01__Care_Plan_Objective__c>carePlanObjectives = [SELECT ID, Name, ecass01__Latest_Outcome__c, ecass01__Outcome__c, ecass01__Objective_and_Timescale__c, ecass01__Date_objective_set__c, ecass01__Next_Review_Date__c, 
         	ecass01__Date_completed__c, ecass01__Objective_Status__c, ecass01__How_will_progress_be_measured__c, ecass01__Tools_used__c, ecass01__Lead_Agency_name__c,
	         (SELECT ID, Name, ecass01__Description__c, ecass01__Person_Responsible_for_Action__c, ecass01__Date__c, ecass01__Status__c, ecass01__Status_Comment__c
	          FROM ecass01__Care_plan_steps__r order by ecass01__Date__c DESC, ecass01__Description__c DESC)
              FROM ecass01__Care_Plan_Objective__c 
              where ecass01__Client__c = :recordID and Area__c = :area and (ecass01__Objective_Status__c = 'In Progress' or ecass01__Objective_Status__c = 'Draft' or ecass01__Objective_Status__c = 'Blocked') 
              order by CreatedDate DESC, ecass01__Date_objective_set__c DESC, Name DESC];
        
   		return carePlanObjectives;
    }
    
    public PageReference printCarePlan ()
	{
		ecass01__eCASS_settings__c settings = ecass01__eCASS_settings__c.getOrgDefaults();
		String printPage = 'CarePlanOverviewPrint';
		if (settings.ecass01__Care_Plan_Overview_Print_Page__c != null) printPage = settings.ecass01__Care_Plan_Overview_Print_Page__c;
		PageReference pdf = new PageReference ('/apex/'+printPage);
		return pdf;
	}
	
    public static testMethod void testViewCarePlan()
    {
        Contact youngPerson = new Contact (LastName = 'Kelly');
        insert youngPerson;
        
        ecass01__Care_Plan_Objective__c careplan = new ecass01__Care_Plan_Objective__c (Name='Improve welbeing', ecass01__Client__c=youngPerson.id, Area__c = 'Drug & Alcohol Use',ecass01__Objective_Status__c = 'In Progress');
        insert careplan;
        
        Event e1 = new Event (WhoID=youngPerson.id, OwnerID=UserInfo.getUserId(), WhatID=careplan.id, Subject='Test', StartDateTime=DateTime.newInstance(2012,1,5,12,30,30), EndDateTime=DateTime.newInstance(2012,1,5,13,30,30));
        insert e1;
        
        Integer carePlanSteps = [select count() from ecass01__Care_plan_step__c where ecass01__Reference__c != null];
        system.assertEquals(1, carePlanSteps);
        
        ApexPages.StandardController contactController = new ApexPages.StandardController(youngPerson);
        ViewCarePlanExtension vc = new ViewCarePlanExtension (contactController);
        vc.printCarePlan();
    }
}