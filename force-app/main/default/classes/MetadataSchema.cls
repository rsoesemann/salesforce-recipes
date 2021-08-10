public with sharing class MetadataSchema {

    private static final String WSDL = metadataWsdl().toString();

    private XPath schema = new XPath(WSDL);


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

        String complexType = complexType(current);

        for(Dom.XmlNode node : find(new List<String>{ complexType + '/xsd:sequence/xsd:element', 
                                                      complexType + '/xsd:complexContent/xsd:extension/xsd:sequence/xsd:element' })) {
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


    private String complexType(Option option) {
        String name = (option.type != null) ? option.type : option.name;
        return complexType() + '[@name=' + name + ']';
    }


    private static Blob metadataWsdl() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + '/services/wsdl/metadata');
        request.setMethod('GET');
        request.setHeader('Cookie','sid=' + UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/xml');
        
        return new Http().send(request).getBodyAsBlob();
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

        public Boolean equals(Object obj) {
            if(obj instanceof Option) {
                Option other = (Option) obj;
                return (other.name == name && other.type == type);
            }

            return false;
        }
        
        public Integer hashCode() {
            Integer nameHash = (name == null) ? 0 : name.hashCode();
            Integer typeHash = (type == null) ? 0 : type.hashCode();
            return (31 * nameHash) ^ typeHash;
        }
    }
}