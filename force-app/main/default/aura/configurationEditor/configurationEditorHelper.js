({
    getConfiguration: function(cmp) {
        // const form = cmp.find("form").find({instancesOf : "lightning:input"});
        // return Array.from(form)
        //             .filter(element => element.nodeName === "INPUT")
        //             .map(this.toFormProperty);

        return cmp.find("form").find({instancesOf : "lightning:input"}).map(this.toFormProperty);
    },

    toFormProperty: function(element, index) {
        return {
            value: element.get("v.value"),
            name: element.get("v.name"),
        };
    },
})