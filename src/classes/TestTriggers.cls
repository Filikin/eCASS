@isTest
private class TestTriggers 
{
    static testMethod void updateStockTest() 
    {
        Needle_Syringe_Stock__c testStock = new Needle_Syringe_Stock__c (Name='Dublin', X1ml_Diabetic__c=100, X1ml_Filter__c=100);
        insert testStock;
        
        ID clientRecordTypeID = [select ID from RecordType where Name='Client'].id;
        Contact client = new Contact (LastName = 'Fred', Gender__c = 'Male', RecordTypeID=clientRecordTypeID);
        insert client;
 
        Needle_Exchange__c intervention1 = new Needle_Exchange__c (Client__c=client.id, Date_Exchange__c = system.today(), Location__c='Dublin', X1ml_Filter_Dispensed__c=5);
        insert intervention1;

        testStock = [select id, X1ml_Filter__c from Needle_Syringe_Stock__c where id=:testStock.id];
        System.assertEquals(95, testStock.X1ml_Filter__c);
                
        intervention1.X1ml_Diabetic_Dispensed__c = 10;
        update intervention1;
        
        testStock = [select id, X1ml_Filter__c, X1ml_Diabetic__c from Needle_Syringe_Stock__c where id=:testStock.id];
        
        System.assertEquals(95, testStock.X1ml_Filter__c);
        System.assertEquals(90, testStock.X1ml_Diabetic__c);
    }
 }