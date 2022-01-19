public without sharing class AccountsSelector extends fflib_SObjectSelector {

    public Schema.SObjectType getSObjectType() {
        return Account.SObjectType;
    }


    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                            Account.Id,
                            Account.Name,
                            Account.AccountNumber,
                            Account.OwnerId,
                            Account.CreatedById,
                            Account.ParentId,
                            Account.DunsNumber,
                            Account.AccountSource
        };
    }


    public List<Account> byIds(Set<Id> ids) {
        return (List<Account>) Database.query( newQueryFactory()
                                                    .setCondition('Id IN :ids')
                                                    .toSOQL());
    }


    public List<Account> byAmountThreshold(Decimal threshold) {
        return (List<Account>) Database.query( newQueryFactory()
                                                    .setCondition('Amount < :threshold>')
                                                    .setSortSelectFields(true)
                                                    .toSOQL());
    }


    public List<Account> byRegion(String regionCode) {
        return (List<Account>) Database.query( newQueryFactory()
                                                    .setCondition('WHERE DISTANCE (BillingAddress, GEOLOCATION( :zipGl.GeoLoc__Latitude__s, :zipGl.GeoLoc__Longitude__s) < 50')
                                                    .setLimit(200)
                                                    .toSOQL());
    }


    public List<Account> byOpportunities(List<Opportunity> opportunities) {
        return new List<Account>();
    }
}