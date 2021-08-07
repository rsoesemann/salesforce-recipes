public with sharing class MetadataSchema {

    private Map<String, List<Property>> schema = new Map<String, List<Property>>();
    private static final Set<String> TYPE_NODES = new Set<String>{ 'simpleType', 'complexType' };


    // CONSTRUCTOR

    public MetadataSchema() {
        String partition = 'mdApiTypeAndProperties';

        if(Cache.Org.contains(partition)) {
            schema = (Map<String, List<Property>>) Cache.Org.get(partition);
        }
        else {
            parse( metadataWsdl() );
            Cache.Org.put(partition, schema);
        }
    }

    
    // PUBLIC

    public List<String> types() {
        return new List<String>(schema.keySet());
    }


    public List<Property> properties(String type) {
        return schema.get(type);
    }


    // PRIVATE

    private XmlStreamReader metadataWsdl() {
        StaticResource resource = [SELECT Body FROM StaticResource 
                                   WHERE Name = 'metadata_wsdl' LIMIT 1];
        return new XmlStreamReader(resource.Body.toString());
    }


    private void parse(XmlStreamReader wsdl) {
        String type;

        while(wsdl.hasNext()) {
            if(wsdl.getEventType() == XmlTag.START_ELEMENT) {
                if(TYPE_NODES.contains( wsdl.getLocalName() )) {
                    type = wsdl.getAttributeValue(null, 'name');
                    schema.put(type, new List<Property>());
                }
                else if('element' == wsdl.getLocalName()) {
                    schema.get(type).add(new Property(wsdl));
                }
            }

            wsdl.next();
        }
    }


    // INNER

    public class Property {
        public String name;
        public String type;

        public Property(System.XmlStreamReader reader) {
            name = reader.getAttributeValue(null, 'name');
            type = reader.getAttributeValue(null, 'type');
        }
    }
}