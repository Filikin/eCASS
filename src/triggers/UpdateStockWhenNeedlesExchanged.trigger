/*
	Author: Eamon Kelly, Enclude
	Purpose: When a needle exchange is created or modified, adjust the stock levels at the warehouse 
	Tested in TestTriggers 
*/
trigger UpdateStockWhenNeedlesExchanged on Needle_Exchange__c (after insert, after update) 
{
	List <Needle_Syringe_Stock__c> stockToUpdate = new List<Needle_Syringe_Stock__c>();
   	if (trigger.new.size() < 50) // not required for mass import
	{
	    Needle_Exchange__c lastExchange=null;
	    for (Needle_Exchange__c oneExchange: Trigger.New)
	    {
	        try
	        {
	            String location=oneExchange.Location__c;
	            
	            Needle_Syringe_Stock__c stock = [Select X1ml_Diabetic__c, X1ml_Filter__c, X1ml_Nevershare__c, X1ml_Omnifix__c, X2ml_Green__c, X2ml_Never_Share_Syringe__c,
	                X2ml_Orange__c, X2ml_Syringe__c, X5ml_Syringe__c, Baby_Brown__c, Bins__c, Blue__c, Brown__c, Citric__c, Condoms__c, Green__c, Orange__c, Long_Orange__c, Pipes__c,
	                Stericups__c, Swabs__c, Tooters__c, Tourniquet__c, VitC__c, Water__c
	             from Needle_Syringe_Stock__c where Name = :location limit 1];
	             
	            if (Trigger.isUpdate)
	            {
	                lastExchange = Trigger.oldMap.get (oneExchange.id); 
	            }
	            else lastExchange = null;
	            
	            if (stock.X1ml_Diabetic__c == null) stock.X1ml_Diabetic__c = 0;
	            stock.X1ml_Diabetic__c -= UpdateStock (oneExchange, lastExchange, 'X1ml_Diabetic_Dispensed__c');
	            
	            if (stock.X1ml_Filter__c == null) stock.X1ml_Filter__c = 0;
	            stock.X1ml_Filter__c -= UpdateStock (oneExchange, lastExchange, 'X1ml_Filter_Dispensed__c');
	            
	            if (stock.X1ml_Nevershare__c == null) stock.X1ml_Nevershare__c = 0;
	            stock.X1ml_Nevershare__c -= UpdateStock (oneExchange, lastExchange, 'X1ml_Nevershare_Dispensed__c'); 
	            
	            if (stock.X1ml_Omnifix__c == null) stock.X1ml_Omnifix__c = 0;
	            stock.X1ml_Omnifix__c -= UpdateStock (oneExchange, lastExchange, 'X1ml_Omnifix_Dispensed__c'); 
	            
	            if (stock.X2ml_Green__c == null) stock.X2ml_Green__c = 0;
	            stock.X2ml_Green__c -= UpdateStock (oneExchange, lastExchange, 'X2ml_Green_Dispensed__c'); 
	            
	            if (stock.X2ml_Never_Share_Syringe__c == null) stock.X2ml_Never_Share_Syringe__c = 0;
	            stock.X2ml_Never_Share_Syringe__c -= UpdateStock (oneExchange, lastExchange, 'X2ml_Never_Share_Syringe_Dispensed__c'); 
	            
	            if (stock.X2ml_Orange__c == null) stock.X2ml_Orange__c = 0;
	            stock.X2ml_Orange__c -= UpdateStock (oneExchange, lastExchange, 'X2ml_Orange_Dispensed__c'); 
	            
	            if (stock.X2ml_Syringe__c == null) stock.X2ml_Syringe__c = 0;
	            stock.X2ml_Syringe__c -= UpdateStock (oneExchange, lastExchange, 'X2ml_Syringe_Dispensed__c'); 
	            
	            if (stock.X5ml_Syringe__c == null) stock.X5ml_Syringe__c = 0;
	            stock.X5ml_Syringe__c -= UpdateStock (oneExchange, lastExchange, 'X5ml_Syringe_Dispensed__c'); 
	            
	            if (stock.Baby_Brown__c == null) stock.Baby_Brown__c = 0;
	            stock.Baby_Brown__c -= UpdateStock (oneExchange, lastExchange, 'Baby_Brown_Dispensed__c'); 
	            
	            if (stock.Bins__c == null) stock.Bins__c = 0;
	            stock.Bins__c -= UpdateStock (oneExchange, lastExchange, 'Bins_Dispensed__c'); 
	            
	            if (stock.Blue__c == null) stock.Blue__c = 0;
	            stock.Blue__c -= UpdateStock (oneExchange, lastExchange, 'Blue_Dispensed__c'); 
	            
	            if (stock.Brown__c == null) stock.Brown__c = 0;
	            stock.Brown__c -= UpdateStock (oneExchange, lastExchange, 'Brown_Dispensed__c'); 
	            
	            if (stock.Citric__c == null) stock.Citric__c = 0;
	            stock.Citric__c -= UpdateStock (oneExchange, lastExchange, 'Citric_Dispensed__c'); 
	            
	            if (stock.Condoms__c == null) stock.Condoms__c = 0;
	            stock.Condoms__c -= UpdateStock (oneExchange, lastExchange, 'Condoms_Dispensed__c'); 
	            
	            if (stock.Green__c == null) stock.Green__c = 0;
	            stock.Green__c -= UpdateStock (oneExchange, lastExchange, 'Green_Dispensed__c'); 
	            
	            if (stock.Orange__c == null) stock.Orange__c = 0;
	            stock.Orange__c -= UpdateStock (oneExchange, lastExchange, 'Orange_Dispensed__c'); 
	            
	            if (stock.Long_Orange__c == null) stock.Long_Orange__c = 0;
	            stock.Long_Orange__c -= UpdateStock (oneExchange, lastExchange, 'Long_Orange_Dispensed__c'); 
	            
	            if (stock.Pipes__c == null) stock.Pipes__c = 0;
	            stock.Pipes__c -= UpdateStock (oneExchange, lastExchange, 'Pipes_Dispensed__c'); 
	            
	            if (stock.Stericups__c == null) stock.Stericups__c = 0;
	            stock.Stericups__c -= UpdateStock (oneExchange, lastExchange, 'Stericups_Dispensed__c'); 
	            
	            if (stock.Swabs__c == null) stock.Swabs__c = 0;
	            stock.Swabs__c -= UpdateStock (oneExchange, lastExchange, 'Swabs_Dispensed__c'); 
	            
	            if (stock.Tooters__c == null) stock.Tooters__c = 0;
	            stock.Tooters__c -= UpdateStock (oneExchange, lastExchange, 'Tooters_Dispensed__c'); 
	            
	            if (stock.Tourniquet__c == null) stock.Tourniquet__c = 0;
	            stock.Tourniquet__c -= UpdateStock (oneExchange, lastExchange, 'Tourniquet_Dispensed__c'); 
	            
	            if (stock.VitC__c == null) stock.VitC__c = 0;
	            stock.VitC__c -= UpdateStock (oneExchange, lastExchange, 'Vit_C_Dispensed__c'); 
	            
	            if (stock.Water__c == null) stock.Water__c = 0;
	            stock.Water__c -= UpdateStock (oneExchange, lastExchange, 'Water_Dispensed__c'); 
	    
	            stockToUpdate.add (stock);
	        }
	        catch (Exception e)
	        {
	            // failed to update the stock
	        }
	    }
	    if (stockToUpdate.size() > 0) update stockToUpdate;
    }
    
    public Decimal UpdateStock (sObject thisExchange, sObject oldExchange, String fieldName)
    {
        if (isValid (thisExchange, fieldName)) 
            if (isValid (oldExchange, fieldName)) return (Decimal)thisExchange.get(fieldName) - (Decimal)oldExchange.get(fieldName);
            else return (Decimal)thisExchange.get(fieldName);
        else if (isValid (oldExchange, fieldName)) return - (Decimal)oldExchange.get(fieldName);
            else return 0;
    }
    
    public Boolean isValid (sObject dispensed, String fieldName)
    {
        if (dispensed == null || dispensed.get(fieldName) == null)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
}