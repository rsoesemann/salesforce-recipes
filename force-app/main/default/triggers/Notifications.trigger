trigger Notifications on Notification__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    fflib_SObjectDomain.triggerHandler(Notifications.class);
}