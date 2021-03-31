public with sharing class Notifications extends fflib_SObjectDomain {

    // CONSTRUCTOR

    public Notifications(List<Notification__c> records) {
        super(records);
    }


    // PUBLIC

    public override void onAfterInsert() {
        new BroadcastNotifications(records).execute();
    }


    public override void onAfterUpdate(Map<Id, SObject> old) {
        new BroadcastNotifications(records).execute();
    }


    // INNER

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> records) {
            return new Notifications(records);
        }
    }
}