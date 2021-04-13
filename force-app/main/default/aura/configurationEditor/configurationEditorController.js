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
    getConfiguration: function(cmp, evt) {
        return cmp.lax.enqueue("c.fetchConfiguration", { recordId: cmp.get("v.recordId") });
    },

    save: function (cmp, evt, hlp) {
        const configuration = hlp.getConfiguration(cmp);

        cmp.lax.enqueue("c.storeConfiguration", { recordId: cmp.get("v.recordId"), configuration: JSON.stringify(configuration) })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    },
})