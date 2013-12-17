/*
	Author: Eamon Kelly, Enclude
	Purpose: Standalone page to allow multiple students to be added to courses
	Called from: EnrolmentListPage
*/
global with sharing class EnrolmentListController 
{
	private List<Contact> studentList;
	private List<Enrolment__c> enrolments;
	private List<Program_Service__c> services;
	public string serviceRequired {get;set;}
	
	public EnrolmentListController(ApexPages.StandardSetController stdSetController) 
	{
    	studentList = (List<Contact>)stdSetController.getSelected();
		Initialise();
	}
	
	public EnrolmentListController() // used only for testing
	{
		studentList = [select ID, Name from Contact limit 2];
		Initialise();
	}

	public void Initialise ()
	{
		services = [select ID, Name from Program_Service__c limit 1000];
    	studentList = [select ID, Name from Contact where id in :studentList order by Name];
    	CreateRows ();
	}	
	
	public SelectOption[] getServices ()
	{
 	  	List<SelectOption> serviceList = new List<SelectOption>();
 		for(Program_Service__c oneService : services)
		{
 			serviceList.add(new SelectOption (oneService.id, oneService.Name));
		}
		return serviceList;	
	}
	
	public Enrolment__c[] getRows ()
	{
		return enrolments;
	}
	
	public void CreateRows ()
	{
		enrolments = new List<Enrolment__c>();
		for (Contact oneStudent: studentList)
		{
			try
			{
				Enrolment__c oneEnrolment = new Enrolment__c (Young_Person__c=oneStudent.id, Date_joined_program__c=system.today(), Status_on_Programme__c='Active');
				enrolments.add (oneEnrolment);
			}
			catch (Exception e)
			{
	    		String msg = 'Error ' + e.getMessage();
	    		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, msg);
	            ApexPages.addMessage(myMsg);
			}				
		}
	}
	
	// Make sure current students are not listed
	private List<Enrolment__c> FilterCurrentContactsFromList ()
	{
		List<Enrolment__c> filteredEnrolments = new List<Enrolment__c>{};
		Set<ID> youngPeopleEnroled = new Set<ID>{};
		
		List<Enrolment__c> currentEnrolments = [select ID, Young_Person__c from Enrolment__c where Program_Service__c = :serviceRequired];
		for (Enrolment__c oneEnrolment: currentEnrolments)
		{
			youngPeopleEnroled.add (oneEnrolment.Young_Person__c);
		}
		
		for (Enrolment__c oneEnrolment: enrolments)
		{
			if (!youngPeopleEnroled.contains(oneEnrolment.Young_Person__c))
			{
				filteredEnrolments.Add(oneEnrolment);
				oneEnrolment.Comment__c = 'Enrolled';
			}
			else
			{
				oneEnrolment.Comment__c = 'Already in service';
			}
		}
		return filteredEnrolments;
	}
	
	public PageReference Save() 
  	{
  		try
  		{
 	  		String serviceName = [select Name from Program_Service__c where ID =:serviceRequired limit 1].Name;
 			String msg = 'Nobody added to ' + serviceName;
  			List<Enrolment__c> filteredEnrolments = FilterCurrentContactsFromList();
  			if (filteredEnrolments.size() > 0)
  			{
	  			Integer count=0;
	  			
		    	for (Enrolment__c oneEnrolment: filteredEnrolments)
		    	{
		    		oneEnrolment.Program_Service__c = (id)serviceRequired;
		    		count++;
		    	}
		    	insert filteredEnrolments;
		    	
		    	msg = count + ' young people added to service ' + serviceName;
  			}
	    	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, msg);
	        ApexPages.addMessage(myMsg);
  		}
		catch (Exception e)
		{
	    	String msg = 'Error ' + e.getMessage() + ' Service: ' + serviceRequired;
	    	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, msg);
	        ApexPages.addMessage(myMsg);
		}				
  		
    	return null;
  	}
  	
  	// tests start here
	public static testMethod void testRows ()
	{
        Contact student1 = new Contact(lastname='Student',firstname='apex'); 
        insert student1;
        
        Contact student2 = new Contact(lastname='Student2',firstname='apex2'); 
        insert student2;

		Program_Service__c testService = new Program_Service__c (Name = 'test service');
		insert testService;
		
 		EnrolmentListController ec = new EnrolmentListController();
 		ec.CreateRows();
 		system.assertEquals (2, ec.getRows().size());
 		system.assertEquals (1, ec.getServices().size());
 		ec.serviceRequired = testService.id;
 		
 		List<Enrolment__c> noEnrolmentsAtStart = [select id from Enrolment__c];
 		system.assertEquals (0, noEnrolmentsAtStart.size());

 		ec.Save();
 		List<Enrolment__c> enrolmentsAfterSave = [select id from Enrolment__c];
 		system.assertEquals (2, enrolmentsAfterSave.size());

 		ec.Save(); // make sure that a second save does not add anything extra
 		List<Enrolment__c> enrolmentsAfter2ndSave = [select id from Enrolment__c];
 		system.assertEquals (2, enrolmentsAfter2ndSave.size());
	}

}