({
    init: function(cmp, evt, hlp) {
        debugger;
        cmp.find("editor")
            .getConfiguration()
            .then((configuration) => {
                cmp.set("v.configuration", JSON.parse(configuration));
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    }
});