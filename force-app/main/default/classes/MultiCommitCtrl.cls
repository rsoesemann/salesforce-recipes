public with sharing class MultiCommitCtrl {

    // PUBLIC

    public void startFlow(){
        try {
            new Flow.Interview.MultiCommit(new Map<String, Object>{
                                                'contextId' => new Random().string(18)
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


    // INNER

    public class BackendParameter {
        @InvocableVariable public String contextId;
        @InvocableVariable public String jobName;
    }
}
