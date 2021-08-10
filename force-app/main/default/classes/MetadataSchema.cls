public with sharing class MetadataSchema {

    private static final Blob WSDL = loadWsdl('MetadataWsdlBlob');

    private XPath schema;
    private Set<String> subtypes = new Set<String>();


    // CONSTRUCTOR

    public MetadataSchema() {
        schema = new XPath(WSDL.toString());
        subtypes = subtypes();
    }


    // PUBLIC

    public List<Option> nextOptions(Option current) {
        List<Option> result = new List<Option>();
System.debug(LoggingLevel.ERROR, metadataType(current.type) + '/xsd:sequence/xsd:element');

        for(Dom.XmlNode node : schema.find( metadataType(current.type) + '/xsd:sequence/xsd:element')) {
            result.add( new Option(node) );
        }

        return result;
    }


    public List<Option> nextOptions() {
        List<Option> result = new List<Option>();

        for(Dom.XmlNode node : schema.find( metadataTypes() )) {
            node = node.getParent().getParent();

            if(isRootType(node)) {
                result.add( new Option(node) );
            }
        }

        return result;
    }


    // PRIVATE

    private Boolean isRootType(Dom.XmlNode typeNode) {
        String typeName = typeNode.getAttributeValue('name', null);
        return (!subtypes.contains(typeName));
    }


    private Set<String> subtypes() {
        Set<String> result = new Set<String>();

        for(Dom.XmlNode node : schema.find(metadataTypes() + '/xsd:sequence/xsd:element')) {
            result.add(node.getAttributeValue('type', null));
        }

        return result;
    }


    private static Blob loadWsdl(String cachePartition) {
        Blob result;

        if(Cache.Org.contains(cachePartition)) {
            result = (Blob) Cache.Org.get(cachePartition);
        }
        else if(Test.isRunningTest()) {
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


    private String metadataType(String name) {
        String template = '/definitions/types/xsd:schema/xsd:complexType__/xsd:complexContent/xsd:extension[@base="tns:Metadata"]';
        String fragment = (name == null) ? '' : '[@name=' + name + ']';

        return template.replace('__', fragment);
    }


    private String metadataTypes() {
        return metadataType(null);   
    }


    // INNER

    public class Option {
        public String name;
        public String type;

        public Option() {}

        public Option(Dom.XmlNode node) {
            this.name = node.getAttributeValue('name', null);
            this.type = node.getAttributeValue('type', null);
        }
    }
}