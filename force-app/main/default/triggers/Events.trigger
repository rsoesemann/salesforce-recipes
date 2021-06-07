trigger Events on Event__e (after insert) {
    fflib_SObjectDomain.triggerHandler(Events.class);
}