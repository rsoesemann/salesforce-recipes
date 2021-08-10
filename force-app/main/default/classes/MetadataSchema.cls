public with sharing class MetadataSchema {

    private static final Blob WSDL = loadWsdl('MetadataWsdlBlob');

    private XPath schema = new XPath(WSDL.toString());


    // PUBLIC

    public List<Option> options() {
        List<Option> result = new List<Option>();

        for(Dom.XmlNode node : schema.find(complexType() + '/xsd:complexContent/xsd:extension[@base="tns:Metadata"]')) {
            result.add( new Option(node.getParent().getParent()) );
        }

        return result;
    }


    public List<Option> options(Option current) {
        List<Option> result = new List<Option>();

        String complexType = complexType() + '[@name=' + current.type + ']';

        for(Dom.XmlNode node : find(new List<String>{ complexType + '/xsd:sequence/xsd:element', 
                                                      complexType + '/xsd:extension/xsd:sequence/xsd:element' })) {
            result.add( new Option(node) );
        }

        return result;
    }


    // PRIVATE

    private List<Dom.XmlNode> find(List<String> xpaths) {
        List<Dom.XmlNode> result = new List<Dom.XmlNode>();

        for(String xpath : xpaths) {
            result.addAll( schema.find(xpath) );
        }

        return result;
    }


    private String complexType() {
        return '/definitions/types/xsd:schema/xsd:complexType';
    }


    private static Blob loadWsdl(String cachePartition) {
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


    // INNER

    public class Option {
        public String name;
        public String type;

        public Option(String name) {
            this.name = name;
        }

        public Option(Dom.XmlNode node) {
            this( node.getAttributeValue('name', null) );
            this.type = node.getAttributeValue('type', null);
        }

        public Boolean equals(Object obj) {
            if(obj instanceof Option) {
                Option other = (Option) obj;
                return (other.name == name && other.type == type);
            }

            return false;
        }
        
        public Integer hashCode() {
            return (31 * name.hashCode()) ^ type.hashCode();
        }
    }
}