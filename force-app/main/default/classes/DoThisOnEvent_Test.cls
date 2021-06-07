@IsTest
private class DoThisOnEvent_Test {
    
    @IsTest
    private static void onlyRelevantCalled() {

        // Exercise
        send( new List<Event__e>{ 
                    event('PublisherA', '/topic/1234'),
                    event('PublisherB', '/topic/')
        });


        // Verify
        System.assertEquals(1, DoThisOnEvent.called.size() );
    }
    

    @IsTest
    private static void calledMultipleTimes() {

        // Exercise
        send( new List<Event__e>{
            event('PublisherB', '/topic/'),
            event('PublisherA', '/topic/xyz')
        });

        // Verify
        System.assertEquals(2, DoThisOnEvent.called.size() );
    }
    

    @IsTest
    private static void notCalledWhenNotApplies() {

        // Exercise
        send( new List<Event__e>{ 
            event('PublisherA', '/topic/1234'),
            event('PublisherX', '/topic/')
        });


        // Verify
        System.assert( DoThisOnEvent.called.isEmpty() );
    }


    // HELPER
    
    private static Event__e event(String publisher, String topic) {
        return new Event__e(Publisher__c = publisher, Topic__c = topic);
    }


    private static void send(List<Event__e> events) {
        Test.startTest();

        EventBus.publish(events);
        Test.getEventBus().deliver();

        Test.stopTest();
    }
}
