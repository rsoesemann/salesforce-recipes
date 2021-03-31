public with sharing class MultiCommitCtrl {

    // PUBLIC

    @AuraEnabled
    public static void startFlow(){
        try {
            new Flow.Interview.MultiCommit( new Map<String, Object>() ).start();
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @InvocableMethod(label='Fake Callout' description='Does an HTTP Callout which comes back after n seconds')
    public static List<String> callout(List<Integer> responseWaitSec) {
        List<String> result = new List<String>();

        calloutBackend(responseWaitSec.get(0));

        return result;
    }


    // PRIVATE

    private static void calloutBackend(Integer responseWaitSec) {
        Integer waitForResponse = responseWaitSec * 1000;

        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://slowwly.robertomurray.co.uk/delay/' + waitForResponse + '/url/http://api.copa.do/');
        request.setMethod('GET');
        request.setTimeout(waitForResponse * 2);
        new Http().send(request);

        updateNotificationRecord();
    }

    
    private static void updateNotificationRecord() {
        Notification__c notification = new Notification__c(ext_JobId__c = '1234');
        notification.txt_Status__c = 'Success';
        upsert notification ext_JobId__c;
    }
}
