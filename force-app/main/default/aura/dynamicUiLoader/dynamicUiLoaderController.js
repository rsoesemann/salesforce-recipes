({
    init: function(cmp, evt, hlp) {
console.log(cmp.get("v.recordId"));
console.log(cmp.get("v.uiLocation"));
        cmp.lax.enqueue("c.getUiComponent", { recordId: cmp.get("v.recordId"), uiLocation: cmp.get("v.uiLocation")})
            .then((component) => {

console.log(component.type);
console.log(component.fqName);
                if(component.type === "Screen Flow") {
                    var params = [
                        {
                            name : "recordId",
                            type : "String",
                            value: cmp.get("v.recordId")
                        }
                    ];
                    cmp.find("flow").startFlow(component.fqName, params);
                }
                else if(component.type === "Aura") {
                    $A.createComponent(
                        component.fqName, { "recordId": cmp.get("v.recordId") },
                        function(newComponent, status, errorMessage) {
                            var container = cmp.find("aura");
                            var body = container.get("v.body");
                            body.push(newComponent);
                            container.set("v.body", body); 
                        }
                );
                }
                
            })
            .catch((e) => {
                cmp.find("toast").toastError(e);
            })
            .finally(() => {
                $A.get("e.force:closeQuickAction").fire();
            });
    },
});