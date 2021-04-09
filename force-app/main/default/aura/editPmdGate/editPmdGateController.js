({
    init: function(cmp, evt, hlp) {
        cmp.lax.enqueue("c.fetchConfiguration", { recordId: cmp.get("v.recordId") })
            .then((configuration) => {
                cmp.set("v.configuration", configuration || {});
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    },

    save: function (cmp, evt, hlp) {
        const configuration = hlp.getConfiguration(cmp);

        cmp.lax.enqueue("c.storeConfiguration", { recordId: cmp.get("v.recordId"), configuration: configuration })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    },
})