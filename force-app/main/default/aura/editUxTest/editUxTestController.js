({
    init: function(cmp) {
        cmp.find("editor")
            .getConfiguration()
            .then((configuration) => {
                cmp.set("v.configuration", JSON.parse(configuration));
            });
    }
});