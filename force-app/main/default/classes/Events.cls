public with sharing class Events extends fflib_SObjectDomain {

    // CONSTRUCTOR

    public Events(List<Event__e> records) {
        super(records);
    }


    // PUBLIC

    public override void onAfterInsert() {
        new Route(records)
                .to( new DoThisOnEvent('PublisherA', '/topic/xyz') )
                .to( new DoThisOnEvent('PublisherB', '/topic/') )
                .now();
    }


    // INNER

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> records) {
            return new Events(records);
        }
    }
}