({
    init: function(cmp, evt, hlp) {
        cmp.lax.enqueue("c.fetchConfiguration", { recordId: cmp.get("v.recordId") })
            .then((configuration) => {
                // populateFormWithConfigurationValues();
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    },
    
    save: function (cmp, evt, hlp) {
        
        cmp.lax.enqueue("c.storeConfiguration", { recordId: cmp.get("v.recordId"), configuration: cmp.get("v.configuration") })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    }
})