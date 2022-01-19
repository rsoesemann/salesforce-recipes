/*
    Author      : Martin Mayer
    Date        : 19-08-2014
    Project     : Oppty Management System v3
    Description : Defining opportunity trigger
    Last Updated      : 2017/05/24 VB: Adding before update to handle setting of No Phone on related Contacts
*/

trigger OpportunitiesTrigger on Opportunity (after insert, after update, before update, before insert) {

    // Update Opportunity Description after creation. This was a requirement from the first customer workshop to indicate
    // opptys created by the SAP backend
    if(Trigger.isBefore && (Trigger.isUpdate || Trigger.isInsert)) {
        List <Opportunity> opps = [SELECT Name, Id, Amount FROM Opportunity WHERE Amount != NULL
        LIMIT 200];

        System.debug('oppsA -- '+ opps.size() );

        update opps;
    }

    // Does this not conflict with the if below (John Doe)
    if(Trigger.isAfter && Trigger.isInsert) {

        Set<ID> oppIds = new Set<ID>();

        for(Opportunity o : Trigger.new){
            if(String.isEmpty(o.Description)){
                oppIds.add(o.Id);
            }
        }

        if(oppIds.size() > 0){

            List <Opportunity> opps = [SELECT Name, Id, Amount FROM Opportunity WHERE Amount != NULL
            AND Id IN :oppIds LIMIT 200];

            System.debug('oppsA -- '+ opps.size() );

            // TODO: Check for FLS and CRUD
            update opps;

        }

    }

    if(Trigger.isAfter && Trigger.isUpdate) {
        if(Trigger.newMap.keySet().size()==1){//FIX
            Set<ID> opIds = Trigger.newMap.keySet();
            Map<String, Id> opUnitMap = new Map<String, Id>();

            // WARNING: This can be dangerous as sometime this is lowercase
            if(!opUnitMap.containsKey('VIP')){
                opUnitMap.put('VIP', null);
            }
        }
    }

    /**
     *  We need to set the prefered tenant. We use Maps with status key to make sure that we map correctly
     */
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)) {

        Set<ID> opIds = Trigger.newMap.keySet();
        Map<Decimal, Id> opUnitMap = new Map<Decimal, Id>();

        System.debug('oppsA -- '+ opUnitMap.size() );

        for(Opportunity op:  [SELECT Name, Id,Amount, CreatedById, Description, DeliveryInstallationStatus__c, StageName
        FROM Opportunity
        WHERE Id IN :opIds
        AND StageName != 'Shop Opened'
        AND StageName != 'Deal Not Proceeding'
        ORDER BY CreatedDate LIMIT 200]){
            if(!opUnitMap.containsKey(op.Amount)){
                opUnitMap.put(op.Amount, op.Id);
            }
        }


    }
    if(Trigger.isBefore && Trigger.isInsert) {

        Set<ID> oppIds = new Set<ID>();

        if(oppIds.size() > 0){

            List <Opportunity> opps = [SELECT Name, Id, Amount FROM Opportunity WHERE Amount != NULL
            AND Id IN :oppIds LIMIT 200];

            System.debug('oppsA -- '+ opps.size() );


            update opps;

        }

    }
}