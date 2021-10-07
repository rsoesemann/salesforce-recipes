public with sharing class MetadataSchema {

    private static final XPath SCHEMA = new XPath( metadataWsdl().toString() );


    // PUBLIC

    public List<Option> options() {
        List<Option> result = new List<Option>();

        addRootNodeOptions(result);

        return sorted(result);
    }


    public List<Option> options(Option current) {
        List<Option> result = new List<Option>();

        addNodeOptions(current, result);
        addValueOptions(current, result);

        return sorted(result);
    }


    // PRIVATE

    private void addRootNodeOptions(List<Option> result) {
        for(Dom.XmlNode node : SCHEMA.find(complexType() + '/xsd:complexContent/xsd:extension[@base="tns:Metadata"]')) {
            node = node.getParent().getParent();

            Option option = new Option();
            option.name = node.getAttributeValue('name', null);
            option.type = node.getAttributeValue('type', null);
            result.add(option);
        }
    }


    private void addNodeOptions(Option current, List<Option> result) {
        String name = (current.type != null) ? current.type : current.name;
        String complexType = complexType() + '[@name=' + name + ']';

        for(String xpath : new List<String>{ complexType + '/xsd:sequence/xsd:element', 
                                             complexType + '/xsd:complexContent/xsd:extension/xsd:sequence/xsd:element' }) {
            for(Dom.XmlNode node : SCHEMA.find(xpath)) {
                Option option = new Option();
                option.name = node.getAttributeValue('name', null);
                option.type = node.getAttributeValue('type', null);
                result.add(option);
            }
        }
    }


    private void addValueOptions(Option current, List<Option> result) {
        String name = (current.type != null) ? current.type : current.name;

        for(Dom.XmlNode node : SCHEMA.find('/definitions/types/xsd:schema/xsd:simpleType[@name=' + name + ']/xsd:restriction/xsd:enumeration')) {
            Option option = new Option();
            option.name = node.getParent().getParent().getAttributeValue('name', null);
            option.type = node.getParent().getAttributeValue('base', null);
            option.value = node.getAttributeValue('value', null);
            result.add(option);
        }
    }


    private List<Option> sorted(List<Option> options) {
        options.sort();
        return options;
    }


    private String complexType() {
        return '/definitions/types/xsd:schema/xsd:complexType';
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

    public class Option implements Comparable {

        public String name;
        public String type;
        public Object value;

        public Option() {}

        public Boolean equals(Object obj) {
            if(obj instanceof Option) {
                Option other = (Option) obj;
                return (other.name == name && other.type == type && other.value == value);
            }

            return false;
        }
        
        public Integer hashCode() {
            return System.hashCode(this);
        }
        
        public Integer compareTo(Object obj) {
            String otherName = ((Option) obj).name;
            return name.compareTo(otherName);        
        }
    }
}