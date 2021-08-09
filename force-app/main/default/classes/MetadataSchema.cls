public with sharing class MetadataSchema {

    private static final String PARTITION = 'mdApiTypeAndProperties';

    private Map<String, List<Property>> schema = new Map<String, List<Property>>();


    // CONSTRUCTOR

    public MetadataSchema() {
        schema = (Cache.Org.contains(PARTITION)) ? cachedSchema() : calculatedSchema( metadataWsdl() );
    }


    // PUBLIC

    public List<String> types() {
        return new List<String>(schema.keySet());
    }


    public List<Property> properties(String type) {
        return schema.get(type);
    }


    // PRIVATE

    private Map<String, List<Property>> cachedSchema() {
        return (Map<String, List<Property>>) Cache.Org.get(PARTITION);
    }


    private Map<String, List<Property>> calculatedSchema(Blob wsdl) {
        Map<String, List<Property>> result = parse(wsdl);
        result.keySet().retainAll(topLevelTypes(wsdl));
        Cache.Org.put(PARTITION, result);

        return result;
    }


    private Blob metadataWsdl() {
        Blob result;

        if(Test.isRunningTest()) {
            result = [SELECT Body FROM StaticResource WHERE Name = 'metadata_wsdl' LIMIT 1].Body;
        }
        else {
            HttpRequest request = new HttpRequest();
            request.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + '/services/wsdl/metadata');
            request.setMethod('GET');
            request.setHeader('Cookie','sid=' + UserInfo.getSessionId());
            request.setHeader('Content-Type', 'application/xml');
            
            result = new Http().send(request).getBodyAsBlob();
        }
        
        return result;
    }


    private Map<String, List<Property>> parse(Blob wsdl) {
        Map<String, List<Property>> result = new Map<String, List<Property>>();

        XmlStreamReader reader = new XmlStreamReader(wsdl.toString());
        String type;
        
        while(reader.hasNext()) {
            if(reader.getEventType() == XmlTag.START_ELEMENT) {
                if(reader.getLocalName() == 'complexType') {
                    type = reader.getAttributeValue(null, 'name');
                    result.put(type, new List<Property>());
                }
                else if(reader.getLocalName() == 'element') {
                    result.get(type).add(new Property(reader));
                }
            }

            reader.next();
        }

        return result;
    }


    private Set<String> topLevelTypes(Blob wsdl) {
        Set<String> result = new Set<String>();

        for(MetadataService.DescribeMetadataObject type : mdApi()
                                                            .describeMetadata( apiVersion(wsdl) )
                                                            .metadataObjects) {
            result.add(type.xmlName);
        }

        return result;
    }


    private MetadataService.MetadataPort mdApi() {
        MetadataService.MetadataPort result = new MetadataService.MetadataPort();
        result.SessionHeader = new MetadataService.SessionHeader_element();
        result.SessionHeader.sessionId = UserInfo.getSessionId();
        return result;
    }


    private Double apiVersion(Blob wsdl) {
        String result = wsdl.toString().substringBetween('salesforce.com/services/Soap/m/', '"/>');
        return Double.valueOf(result);
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