({
    getConfiguration: function(cmp) {
        return cmp.find("form").find({instancesOf : "lightning:input"}).map(this.toFormProperty);
    },

    toFormProperty: function(element, index) {
        return {
            value: element.get("v.value"),
            name: element.get("v.name"),
        };
    },
})