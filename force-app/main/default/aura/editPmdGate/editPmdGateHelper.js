({
    getConfiguration: function(cmp) {
        const form = cmp.find("form").elements;
        return Array.from(form)
                    .filter(element => element.nodeName === "INPUT")
                    .map(this.toFormProperty);
    },

    toFormProperty: function(element, index) {
        return {
            value: element.value,
            name: element.name,
        };
    },
})