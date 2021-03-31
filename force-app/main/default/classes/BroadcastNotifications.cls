public with sharing class BroadcastNotifications {
    
    private List<Notification__c> notifications;


    // CONSTRUCTORS

    public BroadcastNotifications(List<Notification__c> notifications) {
        this.notifications = notifications;
    }


    // PUBLIC

    public void execute() {
        List<NotificationReceived__e> result = new List<NotificationReceived__e>();

        for(Notification__c notification : notifications) {
            result.add( new NotificationReceived__e(ext_JobId__c = '1234', txt_Status__c = notification.txt_Status__c) );
        }

        EventBus.publish(result);
    }
}
