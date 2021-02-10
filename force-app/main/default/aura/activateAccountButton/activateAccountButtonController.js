({
    init: function(cmp, evt, hlp) {
        cmp.lax.enqueue("c.fromAura", { accountId : cmp.get("v.recordId") })
            .then(() => {
                cmp.find("toast").toastSuccess("Activated successfully.");

                $A.get("e.force:navigateToSObject")
               		.setParams({
               		    "recordId": cmp.get("v.recordId"),
               		    "slideDevName": "detail"
               		})
               		.fire();
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            })
            .finally(() => {
                $A.get("e.force:closeQuickAction").fire();
            });
    },
});