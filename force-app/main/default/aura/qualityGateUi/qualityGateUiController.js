({
    init: function(cmp, evt, hlp) {
        cmp.lax.enqueue("c.getComponentForRecord", { recordId : cmp.get("v.recordId") })
            .then((componentApiName) => {
                $A.createComponent(
                    componentApiName, { recordId: cmp.get("v.recordId") },
                    function(component, status, errorMessage){
                        var renderDiv = cmp.find("renderDiv");
                        var body = renderDiv.get("v.body") || [];
                        body.push(component);
                        renderDiv.set("v.body", body);
                    }
                );
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            });
    },
});