public with sharing class DynamicButtonCtrl implements Callable {

    @AuraEnabled(cacheable=true)
    public static void executeCallable(String callableClass) {
        System.debug(LoggingLevel.ERROR, callableClass);

        try {
            ((Callable) Type.forName(callableClass).newInstance())
                                .call('ignored', null);
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    public Object call(String ignoredAction, Map<String,Object> ignoredParams) {
        System.debug(LoggingLevel.ERROR, 'sefsdf');
        throw new ApplicationException('Button was invoked');
    }
}
