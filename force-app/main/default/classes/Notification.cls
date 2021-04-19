public with sharing class Notification {

    private Messaging.CustomNotification message;
    private List<String> parts = new List<String>();
    private Set<String> userIds = new Set<String>();

    // CTOR

    public Notification() {
        this(UserInfo.getUserId());
    }


    public Notification(Id userId) {
        userIds.add(userId);

        message = new Messaging.CustomNotification();
        message.setNotificationTypeId( [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'GenericNotification'].Id );
        message.setTitle('Notification');
        message.setTargetId('000000000000000AAA');
    }

    // PUBLIC

    public Notification with(Object value) {
        parts.add(String.valueOf(value));
        return this;
    }


    public Notification title(String value) {
        message.setTitle(value);
        return this;
    }


    public Notification target(Id value) {
        message.setTargetId(value);
        return this;
    }


    public Notification target(String pageRef) {
        message.setTargetPageRef(pageRef);
        return this;
    }


    public void send(String bodyText) {
        message.setBody( String.format(bodyText, parts) );
        message.send(userIds);
    }
}