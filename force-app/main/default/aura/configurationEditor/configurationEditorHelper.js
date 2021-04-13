({
    getConfiguration: function(cmp) {
        const result = cmp.find("form").find({instancesOf : "lightning:input"});
        result.push(...cmp.find("form").find({instancesOf : "lightning:textarea"}) );
        return result.map(this.toFormProperty);
    },

    toFormProperty: function(element, index) {
        return {
            value: element.get("v.value"),
            name: element.get("v.name"),
        };
    },
})