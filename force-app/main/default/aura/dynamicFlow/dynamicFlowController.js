({
    init: function(cmp, evt, hlp) {
        cmp.lax.enqueue("c.getFlowName", { recordId: cmp.get("v.recordId"), flowType: "Edit"})
            .then((flowName) => {
                var inputVariables = [{
                    name : "recordId",
                    type : "String",
                    value: cmp.get("v.recordId")
                }];
                cmp.find("wrapper").startFlow(flowName, inputVariables);
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            })
            .finally(() => {
                $A.get("e.force:closeQuickAction").fire();
            });
    },
});