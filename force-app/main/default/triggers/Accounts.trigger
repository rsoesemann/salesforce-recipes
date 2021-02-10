trigger Accounts on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    fflib_SObjectDomain.triggerHandler(Accounts.class);
}