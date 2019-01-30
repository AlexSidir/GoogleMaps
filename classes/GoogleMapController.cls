public with sharing class GoogleMapController {
    
    public class GeneralInfoWrapper{
        @AuraEnabled public string icon{get;set;} 
        @AuraEnabled public string title{get;set;} 
        @AuraEnabled public string description{get;set;} 
        @AuraEnabled public LocationWrapper location{get;set;} 
    }
    
    public class LocationWrapper{
        @AuraEnabled public string Street{get;set;}
        @AuraEnabled public string PostalCode{get;set;}
        @AuraEnabled public string City{get;set;}
        @AuraEnabled public string State{get;set;}
        @AuraEnabled public string Country{get;set;}
    }
    
    @AuraEnabled
    public static list<GeneralInfoWrapper> getData() {
        
        List<GeneralInfoWrapper> generalInfoWrapperList = new List<GeneralInfoWrapper>();
        for(Account a : [SELECT Name,Description, BillingCountry, BillingCity, BillingPostalCode, BillingStreet, BillingState
                         FROM Account WHERE BillingCountry != NULL AND BillingCity != NULL]){
                             LocationWrapper locationWrapper = new LocationWrapper();
                             locationWrapper.Street = a.BillingStreet;
                             locationWrapper.PostalCode = a.BillingPostalCode;
                             locationWrapper.City = a.BillingCity;
                             locationWrapper.State = a.BillingState;
                             locationWrapper.Country = a.BillingCountry;
                             
                             GeneralInfoWrapper generalWrapper = new GeneralInfoWrapper();
                             generalWrapper.icon = 'standard:location'; 
                             generalWrapper.title = a.Name;
                             generalWrapper.description = a.Description;
                             generalWrapper.location = locationWrapper;
                             
                             generalInfoWrapperList.add(generalWrapper);
                         }
        return generalInfoWrapperList;
    }
    
    @AuraEnabled
    public static list<GeneralInfoWrapper> updateData(String countries, String customerPriority){
        List<GeneralInfoWrapper> generalInfoWrapperList = new List<GeneralInfoWrapper>();
        
        List<String> tmpStringCountries = new List<String>();
        tmpStringCountries.addAll(countries.split(';'));
        
        if(tmpStringCountries.contains('All')) {
            tmpStringCountries.clear();
        }
        
        List<String> tmpStringCustomerPriority = new List<String>();
        tmpStringCustomerPriority.addAll(customerPriority.split(';'));
        
        if(tmpStringCustomerPriority.contains('All')) {
            tmpStringCustomerPriority.clear();
        }
        
        List<Account> accounts = new List<Account>();
        if(tmpStringCountries.isEmpty() && tmpStringCustomerPriority.isEmpty()) {
            accounts = [SELECT Name,Description, BillingCountry, BillingCity, BillingPostalCode, BillingStreet, BillingState
                        FROM Account WHERE BillingCountry != NULL AND BillingCity != NULL];
        } else if (!tmpStringCountries.isEmpty() && tmpStringCustomerPriority.isEmpty()){
            accounts = [SELECT Name,Description, BillingCountry, BillingCity, BillingPostalCode, BillingStreet, BillingState
                        FROM Account WHERE BillingCountry != NULL AND BillingCity != NULL AND BillingCountry IN: tmpStringCountries];
        } else if (tmpStringCountries.isEmpty() && !tmpStringCustomerPriority.isEmpty()){
            accounts = [SELECT Name,Description, BillingCountry, BillingCity, BillingPostalCode, BillingStreet, BillingState
                        FROM Account WHERE BillingCountry != NULL AND BillingCity != NULL AND CustomerPriority__c IN: tmpStringCustomerPriority];
        } else if (!tmpStringCountries.isEmpty() && !tmpStringCustomerPriority.isEmpty()){
            accounts = [SELECT Name,Description, BillingCountry, BillingCity, BillingPostalCode, BillingStreet, BillingState
                        FROM Account WHERE BillingCountry != NULL AND BillingCity != NULL AND CustomerPriority__c IN: tmpStringCustomerPriority
                        AND BillingCountry IN: tmpStringCountries];
        }
        
        for(Account a : accounts){
            LocationWrapper locationWrapper = new LocationWrapper();
            locationWrapper.Street = a.BillingStreet;
            locationWrapper.PostalCode = a.BillingPostalCode;
            locationWrapper.City = a.BillingCity;
            locationWrapper.State = a.BillingState;
            locationWrapper.Country = a.BillingCountry;
            
            GeneralInfoWrapper generalWrapper = new GeneralInfoWrapper();
            generalWrapper.icon = 'standard:location'; 
            generalWrapper.title = a.Name;
            generalWrapper.description = a.Description;
            generalWrapper.location = locationWrapper;
            
            generalInfoWrapperList.add(generalWrapper);
        }
        return generalInfoWrapperList;
    }   
}
