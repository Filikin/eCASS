/*
	Author: Eamon Kelly, Enclude
	Purpose: Displays the complete care plan for one client. 
	Security note: This class is global so that it can be used in customisations for the client - usually via a modified Visualforce page depending on their
					definition of what a careplan should look like
	Called from: CarePlanPage and the CarePlanPrintPage (the PDF version)
	TODO: The next version will used field sets to control the fields that are displayed in the CarePlanPage
*/
global with sharing class ViewCarePlan 
{
    public List<Care_Plan_Objective__c> carePlanObjectives = new List<Care_Plan_Objective__c>();
    public ID recordID;
    public String recordName;
    global String counsellor {get;set;}
    
    global ViewCarePlan (ApexPages.StandardController controller) 
    {
        sObject con = controller.getRecord();
        recordID = con.id;
        Contact client = [select Name, Counsellor__r.Name from Contact where id = :con.id];
        if (client != null)
        {
            recordName = client.Name;
            counsellor = client.Counsellor__r.Name;
        }
        
        carePlanObjectives = [SELECT ID, Name, Comment_Reasons_achieved_or_not__c, Date_completed__c, Date_objective_set__c, How_will_progress_be_measured__c,
            Lead_Agency_name__c, Lead_Key_Worker_name__c, Next_Review_Date__c, Objective_and_Timescale__c, Objective_Status__c, Outcome__c, Referred_to__c, Time_Frame_short__c,
            Work_to_be_done_to_achieve_objective__c, 
            (select ID, Name, Date__c, Description__c, Status__c, Status_Comment__c, Person_Responsible_for_Action__c, Related_Organisation__c from Care_plan_steps__r order by Date__c DESC)
               FROM Care_Plan_Objective__c where Client__c = :recordID order by CreatedDate DESC, Date_objective_set__c DESC];
    }
    
    global List<Care_Plan_Objective__c> getCarePlanObjectives() 
    {
        return carePlanObjectives;
    }
    
    global List<Care_plan_step__c> getCarePlanSteps() // deprecated 
    {
        return null;
    }

	global PageReference printCarePlan ()
	{
		ecass01__eCASS_settings__c settings = ecass01__eCASS_settings__c.getOrgDefaults();
		String printPage = 'CarePlanPrintPage';
		if (settings.ecass01__Care_Plan_Print_Page__c != null) printPage = settings.ecass01__Care_Plan_Print_Page__c;
		PageReference pdf = new PageReference ('/apex/'+printPage);
		return pdf;
	}
	
	// Tests start here
    public static testMethod ViewCarePlan testViewCarePlan()
    {
        Contact youngPerson = new Contact (LastName = 'Kelly');
        insert youngPerson;
        
        Care_Plan_Objective__c careplan = new Care_Plan_Objective__c (Name='Improve welbeing', Client__c=youngPerson.id);
        insert careplan;
        
        Event e1 = new Event (WhoID=youngPerson.id, OwnerID=UserInfo.getUserId(), WhatID=careplan.id, Subject='Test', StartDateTime=DateTime.newInstance(2012,1,5,12,30,30), EndDateTime=DateTime.newInstance(2012,1,5,13,30,30));
        insert e1;
        
        ApexPages.StandardController contactController = new ApexPages.StandardController(youngPerson);
        return new ViewCarePlan (contactController);
    }
    
    public static testMethod void testRemainingBits ()
    {
        ViewCarePlan thisClass = testViewCarePlan();
        system.assertEquals (1, thisClass.getCarePlanObjectives().size());
        thisClass.getCarePlanSteps(); // deprecated function - the care plan steps are now accessed via the care plan objectives
        system.assertEquals (1, thisClass.getCarePlanObjectives()[0].Care_plan_steps__r.size());
        thisClass.printCarePlan ();
    }

}