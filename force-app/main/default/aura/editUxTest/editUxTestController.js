({
    init: function(cmp) {
        cmp.find("editor")
            .getConfiguration()
            .then((configuration) => {
                configuration = (configuration || "{}");
                const asFields = JSON.parse(configuration).reduce((result, configuration) => {
                    result[configuration.name] = configuration.value;
                    return result
                }, {});
                cmp.set("v.configuration", asFields);
            });
    }
});