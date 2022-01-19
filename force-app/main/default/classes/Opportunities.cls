public class Opportunities extends fflib_SObjectDomain {

    // CONSTRUCTOR

    public Opportunities(List<Opportunity> records) {
        super(records);
    }


    // PUBLIC

    public override void onValidate() {
        new VerifyAmountInAllowedRange().execute(records);
    }


    public override void onAfterInsert() {
        new UpdateAccountStatus().execute(records);
        new AccummulateLineItemStatistics().execute(records);
        new CreateSAPClone().execute(records);
    }


    public override void onBeforeUpdate(Map<Id, SObject> old) {
        new UpdateAccountStatus().execute(records);
        new CalculateLineItemAnalytics().execute(records);
        new SyncHistoryWithSAP().execute(records);
    }


    // INNER

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> records) {
            return new Opportunities(records);
        }
    }
}