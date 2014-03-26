public with sharing class CheckForOpenHRBFormsController 
{
	public list<ecass01__Treatment__c>openForms {get;set;}
	
	public CheckForOpenHRBFormsController(ApexPages.StandardController controller) 
	{
	}
	
	public pageReference countOpenHRBForms ()
	{
		Schema.DescribeSObjectResult dsr = ecass01__Treatment__c.SObjectType.getDescribe();
		try
		{
			// find the ID from the parameters
			ID contactID = null;
			map<String,String> parametersMap = ApexPages.currentPage().getParameters();
			for (String oneKey: parametersMap.keySet())
			{
				if (oneKey.contains('_lkid'))
				{
					contactID = (ID)parametersMap.get(oneKey);
					break;
				}
			}
			openForms = [SELECT Id, Name FROM ecass01__Treatment__c where ecass01__X37_Date_of_Final_Discharge__c = null and Contact__c = :contactID Limit 100];
			if (openForms.size() > 0)
			{
	    		String msg = Label.HRB_Form_Open_Msg;
	    		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, msg);
	            ApexPages.addMessage(myMsg);
	            return null;
			}		
			else
			{
				PageReference newHRBFormPage = new PageReference('/' + dsr.getKeyPrefix() + '/e?nooverride=1');
				newHRBFormPage.setRedirect(true);
				newHRBFormPage.getParameters().putall(parametersMap);
				return newHRBFormPage;
			}
		}
		catch (Exception e)
		{
			// page not called from the contact page, so just show the normal new HRB Form page
			PageReference newHRBFormPage = new PageReference('/' + dsr.getKeyPrefix() + '/e?nooverride=1');
			newHRBFormPage.setRedirect(true);
			return newHRBFormPage;
		}		
	}
}