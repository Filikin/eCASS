/*
	Author: Eamon Kelly, Enclude
	Purpose: Test the treatments to make sure they pass the validation rules by adding a pointer to the HRB Report object
	Called from: AddTreatmentToReport page which is called from a button on the HRB Report page
	Tested in: TestAddTreatmentToReport
*/
public with sharing class AddTreatmentToReport 
{
	public class TreatmentMessages
	{
		public ID treatmentID {get;set;}
		public String errorMsg {get;set;}
		public TreatmentMessages (Treatment__c treat, String msg)
		{
			treatmentID = treat.Id;
			errorMsg = msg;
		}	
	}
	
    public Treatment__c[] TreatmentsWithClientsList; // these are the HRB forms
    public HRB_Report__c reportParams {get;set;} // this will be the object with the date range (last year, q1 etc)
	public list<TreatmentMessages> passed {get;set;}
	public list<TreatmentMessages> failed {get; set;}
	public Integer TreatmentsListSize {get;set;}
	public Integer TreatmentsToProcess {get;set;}
	
	public AddTreatmentToReport (ApexPages.StandardController controller)
	{
		passed = new list<TreatmentMessages>();
		failed = new list<TreatmentMessages>();
		this.reportParams = (HRB_Report__c)controller.getRecord();
	}
	
	public void Initialise ()
	{
		reportParams = [select id, Name, Period__c, Year__c, Type_of_report__c from HRB_Report__c where id = :reportParams.id];
        Integer year = reportParams.Year__c.intValue();
        String startMonthDay = '-01-01';
        String endMonthDay = '-12-31';
        if (reportParams.Period__c == 'Quarter 1')
        {
            endMonthDay = '-03-31';
        }
        else if (reportParams.Period__c == 'Quarter 2')
        {
            startMonthDay = '-04-01';
            endMonthDay = '-06-30';
        }
        else if (reportParams.Period__c == 'Quarter 3')
        {
            startMonthDay = '-07-01';
            endMonthDay = '-09-30';
        }
        else if (reportParams.Period__c == 'Quarter 4')
        {
            startMonthDay = '-10-01';
        }
        String startReportPeriod = String.valueOf(year) + startMonthDay;
        String endReportPeriod = String.valueOf(year) + endMonthDay;
 
 		String queryString = 'select id, Name, HRB_Report__c, Contact_Record_Valid__c, Main_Intervention_Valid__c, Drug_Validation__c, Number_of_Treatments__c from Treatment__c where HRB_Report__c != \'' + reportParams.Id + '\' and ';
 		
 		 if (reportParams.Type_of_report__c == 'Clients who entered during the report period') 
         {
            queryString += 'X16_Date_of_Assessment__c >= ' + startReportPeriod + ' and X16_Date_of_Assessment__c <= ' + endReportPeriod;
         }
         else
         {
            queryString += 'ExitDate__c >= ' + startReportPeriod + ' and ExitDate__c <= ' + endReportPeriod + ' and X16_Date_of_Assessment__c < ' + startReportPeriod;
         }
         
         TreatmentsWithClientsList = Database.query(queryString);
         TreatmentsListSize = TreatmentsWithClientsList.size();
         TreatmentsToProcess = math.min (TreatmentsListSize, Limits.getLimitDmlRows());
         if (TreatmentsToProcess < TreatmentsListSize)
         {
         	queryString += ' limit ' + TreatmentsToProcess;
         	TreatmentsWithClientsList = Database.query(queryString);
         }
         system.debug ('Number of possible treatments: ' + TreatmentsWithClientsList.size());
         for (Treatment__c oneTreatment: TreatmentsWithClientsList)
         {
         	system.debug ('Treatment limits rows: ' + Limits.getLimitDmlRows() + ' queries: ' + Limits.getLimitQueries());
			if (oneTreatment.Contact_Record_Valid__c != 'HRB OK') 
			{
				failed.add (new TreatmentMessages(oneTreatment, oneTreatment.name + ' Failed because client record error: ' + oneTreatment.Contact_Record_Valid__c));
			}
			else if (oneTreatment.Main_Intervention_Valid__c != 'HRB OK')
			{
				failed.add (new TreatmentMessages(oneTreatment, oneTreatment.name + ' Failed because: ' + oneTreatment.Main_Intervention_Valid__c));
			}
			else if (oneTreatment.Number_of_Treatments__c != 'HRB OK')
			{
				failed.add (new TreatmentMessages(oneTreatment, oneTreatment.name + ' Failed because: ' + oneTreatment.Main_Intervention_Valid__c));
			}
			else if (oneTreatment.Drug_Validation__c != 'HRB OK')
			{
				failed.add (new TreatmentMessages(oneTreatment, oneTreatment.name + ' Failed because: ' + oneTreatment.Main_Intervention_Valid__c));
			}
			else
			{
				oneTreatment.HRB_Report__c = reportParams.id;
				try
				{
	 				update oneTreatment;
		            passed.add (new TreatmentMessages(oneTreatment, oneTreatment.name + ' Attached'));
		            system.debug ('Treatment added ' + oneTreatment.name);
				}
			    catch (Exception e)
			    {
			    	system.debug ('Treatment failed ' + e.getMessage());
			    	string errorMsg = e.getMessage().subString (e.getMessage().indexOf ('first error:'));
			       	failed.add (new TreatmentMessages(oneTreatment, oneTreatment.name + ' Failed ' + errorMsg));
			    }
			}
         }
	}
}