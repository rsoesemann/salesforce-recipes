({
    init: function(cmp, evt, hlp) {
        cmp.lax.enqueueAll([
            { name: "c.getSObjectName", params: { recordId: cmp.get("v.recordId") }},
            { name: "c.getFieldsFromFieldSet", params: { recordId: cmp.get("v.recordId"), fieldSet: cmp.get("v.fieldSetName") }}
        ])
        .then(([sObjectName, fields]) => {
            cmp.set("v.sObjectName", sObjectName);
            cmp.set("v.fields", fields);
        })
        .catch((e) => {
            cmp.find("toast").toastError(e);
        });
    },


    onSave: function(cmp, evt, hlp) {
        evt.preventDefault();
        cmp.find('recordForm').submit();

        hlp.closeModal();
    },


    onCancel: function(cmp, evt, hlp) {
        evt.preventDefault();

        hlp.closeModal();
    },
});