public with sharing class MultiCommitCtrl {

    // PUBLIC

    public void startFlow() {
        try {
            new Flow.Interview.MultiCommit(new Map<String, Object>{
                                                'contextId' => getContextId()
                                            }).start();
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @InvocableMethod(label='Fake Callout' description='Does an HTTP Callout which comes back after n seconds')
    public static List<String> callout(List<BackendParameter> parameter) {
        List<String> result = new List<String>();

        calloutBackend(parameter.get(0));

        return result;
    }

    @AuraEnabled(cacheable=true)
    public static String getSessionId() {
        return UserInfo.getSessionId();
    }


    // PRIVATE

    private static void calloutBackend(BackendParameter parameter) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://slowwly.robertomurray.co.uk/delay/' + 10000 + '/url/' + parameter.contextId + '-' + parameter.jobName);
        request.setMethod('GET');
        request.setTimeout(20000);
        new Http().send(request);

        updateNotificationRecord(parameter);
    }

    
    private static void updateNotificationRecord(BackendParameter parameter) {
        Notification__c notification = new Notification__c();
        notification.ext_JobId__c = parameter.contextId;
        notification.txt_JobName__c = parameter.jobName;
        notification.txt_Status__c = 'Success';
        upsert notification ext_JobId__c;
    }

    private String getContextId() {
        String result = ApexPages.currentPage() .getParameters().get('contextId');

        if(String.isBlank(result)) {
            result = new Random().string();
        }

        return result.abbreviate(18);
    }


    // INNER

    public class BackendParameter {
        @InvocableVariable public String contextId;
        @InvocableVariable public String jobName;
    }
}
