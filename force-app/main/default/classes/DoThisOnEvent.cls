public with sharing class DoThisOnEvent implements Route.Command {
    
    @TestVisible
    private static List<String> called = new List<String>();

    private String publisher;
    private String topic;
    

    // CONSTRUCTOR

    public DoThisOnEvent(String publisher, String topic) {
        this.publisher = publisher;
        this.topic = topic;
    }


    // PUBLIC

    public Boolean matches(Event__e event) {
        return (event.Publisher__c == publisher 
                    && event.Topic__c.startsWith(topic));
    }


    public void execute(Event__e event) {
        called.add(event.Publisher__c + '_' + event.Topic__c);
    }
}
