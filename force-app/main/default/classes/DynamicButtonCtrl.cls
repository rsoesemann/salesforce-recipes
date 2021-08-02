public with sharing class DynamicButtonCtrl implements Callable {

    @AuraEnabled(cacheable=true)
    public static void executeCallable(String callableClass) {
        ((Callable) Type.forName(callableClass).newInstance()).call('ignored', null);
    }


    public Object call(String ignoredAction, Map<String,Object> ignoredParams) {
        System.debug(LoggingLevel.ERROR, 'Action called');
        return null;
    }
}