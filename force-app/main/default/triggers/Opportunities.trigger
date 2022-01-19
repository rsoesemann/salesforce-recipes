trigger Opportunities on Opportunity (before insert, before update, after insert, after update, before delete) {
    fflib_SObjectDomain.triggerHandler(Opportunities.class);
}