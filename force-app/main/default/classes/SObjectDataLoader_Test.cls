@IsTest
private class SObjectDataLoader_Test {
    
    @IsTest
    private static void cloneAttachments() {

        // Setup
        Account_t a = new Account_t();
        Contact_t c1 = new Contact_t(a)
                            .add(new Attachment_t());

        Contact_t c2 = new Contact_t(a)
                            .add(new Attachment_t());
        a.persist();

        // Exercise
        String json = SObjectDataLoader.serialize(new Set<Id>{ c1.Id, c2.Id }, new SObjectDataLoader.SerializeConfig()
                                                                                        .followChild(Attachment.ParentId)
                                                                                        .omit(Contact.AccountId));
        SObjectDataLoader.deserialize(json, new SetParentCallback(a.record));


        // Verify
        System.assertEquals(1, [SELECT Count() FROM Account]);
        System.assertEquals(4, [SELECT Count() FROM Contact]);
        System.assertEquals(4, [SELECT Count() FROM Attachment]);
    }


    // INNER

    private class SetParentCallback implements SObjectDataLoader.IDeserializeCallback {
        private Id parentId;

        public SetParentCallback(SObject parent) {
            parentId = parent.Id;
        }

        public void unresolvedReferences(SObjectType type, List<SObjectDataLoader.UnresolvedReferences> unresolved) {
            if(type == Contact.SObjectType) {
                for(SObjectDataLoader.UnresolvedReferences refs : unresolved) {
                    if (refs.References.contains(Contact.AccountId)) {
                        refs.Record.put(Contact.AccountId, parentId);
                    }
                }
            }
        }
    }
}
