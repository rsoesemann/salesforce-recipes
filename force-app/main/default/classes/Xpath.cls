public with sharing class Xpath {

    public static String convert(String node, String field, String operator, String value) {
        String result = operator(operator);

        if(node == 'name') {
            result = result.replace('NODE', 'pmd:fileName');
        }
        else {
            node = (field == null) ? node : node + '/' + field;
            result = node + '/text[' + result.replace('NODE', '@Image') + ']';
        }

        result = result.replace('VALUE', '\'' + value + '\'');
        return result;
    }



    public static String operator(String cchOperator) {
        return new Map<String, String>{
            'contains' => 'contains(NODE, VALUE)',
            'does not contain' => 'not(contains(NODE, VALUE))',
            'starts with' => 'starts-with(NODE, VALUE)',
            'equals' => 'NODE = VALUE',
            'not equal to' => 'NODE != VALUE',
            'less than' => 'NODE < VALUE',
            'greater than' => 'NODE > VALUE',
            'less or equal' => 'NODE <= VALUE',
            'greater or equal' => 'NODE >= VALUE',
            'is blank' => 'VALUE = \'true\'',
            'is not blank' => 'VALUE = \'false\''
        }
        .get(cchOperator);
    }
}