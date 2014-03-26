/*
	Author: Eamon Kelly, Enclude
	Purpose: List all the clients who were due to attend a session so that they can be marked as attended and comments added. 
	Security note: This class is global so that it can be used in customisations for the client
	Called from: ProgramSessionAttendancePage
	TODO: The next version will used field sets to control the fields that are displayed in the ProgramSessionAttendancePage
	Test notes: This class is tested in testCreateAttendanceTrigger 
	
	27/1/2014 - adding CRUD support
*/
global with sharing class ProgramAttendanceListView 
{
	private Program_Session__c session = null;
	private Attendance__c [] attendances = null;
	public Boolean userCanUpdate {get;set;}
	
	public ProgramAttendanceListView (ApexPages.StandardController controller)
	{
		session = (Program_Session__c)controller.getRecord();
		Initialise ();
	}
	
    public ProgramAttendanceListView (Program_Session__c sess)
    {
    	session = sess;
	  	Initialise ();
    }
    
    private void Initialise ()
    {
    	userCanUpdate = Schema.sObjectType.Attendance__c.isUpdateable();
		attendances = [select Name, id, Young_Person_Name__c, young_person__c, attended__c, Interaction__c,comment__c from Attendance__c where Program_Session__c = :session.id];
    }
    
    public Attendance__c [] getAttendanceList ()
    {
    	return attendances;
    }
    
    public PageReference submit ()
    {
    	update attendances;
    	String theId = ApexPages.currentPage().getParameters().get('id');
 
    	// Redirect the user back to the original page
        PageReference pageRef = new PageReference('/' + theId);
        pageRef.setRedirect(true);
        return pageRef;
    }
}