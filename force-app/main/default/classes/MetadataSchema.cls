public with sharing class MetadataSchema {

    private Map<String, List<Property>> schema = new Map<String, List<Property>>();


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
        XmlStreamReader result;

        if(Test.isRunningTest()) {
            StaticResource localWsdl = [SELECT Body FROM StaticResource WHERE Name = 'metadata_wsdl' LIMIT 1];
            result = new XmlStreamReader(localWsdl.Body.toString());
        }
        else {
            HttpRequest request = new HttpRequest();
            request.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + '/services/wsdl/metadata');
            request.setMethod('GET');
            request.setHeader('Cookie','sid=' + UserInfo.getSessionId());
            request.setHeader('Content-Type', 'application/xml');
            
            HttpResponse response = new Http().send(request);
            result = response.getXmlStreamReader();
        }
        
        return result;
    }


    private void parse(XmlStreamReader reader) {
        String type;

        while(reader.hasNext()) {
            if(reader.getEventType() == XmlTag.START_ELEMENT) {
                if(reader.getLocalName() == 'complexType') {
                    type = reader.getAttributeValue(null, 'name');
                    schema.put(type, new List<Property>());
                }
                else if(reader.getLocalName() == 'element') {
                    schema.get(type).add(new Property(reader));
                }
            }

            reader.next();
        }
    }


    // INNER

    public class Property {
        public String name;
        public String type;

        public Property(System.XmlStreamReader reader) {
            this(reader.getAttributeValue(null, 'name'));
            type = reader.getAttributeValue(null, 'type');
        }

        public Property(String name) {
            this.name = name;
        }

        public Boolean equals(Object obj) {
            if (obj instanceof Property) {
                Property other = (Property) obj;
                return (other.name == name);
            }

            return false;
        }

        public Integer hashCode() {
            return (31 * name.hashCode()) ^ type.hashCode();
        }
    }
}