/*
	Author: Eamon Kelly, Enclude
	Purpose: When a new program session is created, find everyone who is enrolled in the course and create attendances for them in the session
	Tested in testCreateAttendanceTrigger 
*/
trigger CreateAttendencesOnNewSession on Program_Session__c (after insert) 
{
    private Program_Session__c[] newSessions =Trigger.new;
    private Attendance__c[] attendances = new Attendance__c[0];
	if (trigger.new.size() < 10) // not required for mass import
	{
	    For (Program_Session__c sNew: newSessions)
	    {
	        Enrolment__c [] youngPeople = [select Young_Person__c from Enrolment__c where Program_Service__c = :sNew.Program_Service__c and Status_on_Programme__c = 'Active'];
	        for (Enrolment__c onePersonEnrolment: youngPeople)
	        {
	            Attendance__c oneAttended = new Attendance__c (Young_Person__c=onePersonEnrolment.Young_Person__c, Program_Session__c=sNew.id, Enrolment__c=onePersonEnrolment.id);
	            attendances.add (oneAttended);
	        } 
	    }
	    insert attendances;
	}
}