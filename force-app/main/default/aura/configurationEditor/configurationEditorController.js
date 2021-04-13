({
    getConfiguration: function(cmp, evt) {
        return cmp.lax.enqueue("c.fetchConfiguration", { recordId: cmp.get("v.recordId") });
    },

    save: function (cmp, evt, hlp) {
        evt.preventDefault();

        const configuration = hlp.getConfiguration(cmp);

        cmp.lax.enqueue("c.storeConfiguration", { recordId: cmp.get("v.recordId"), configuration: JSON.stringify(configuration) })
            .then(() => {
                $A.get('e.force:refreshView').fire();
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    },
})