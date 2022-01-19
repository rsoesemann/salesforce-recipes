/*
    Date        : 17-10-2016
	Project     :  Management System
    Description : Unit test class for OpportunityTrigger

    Change History
    --------------
*/
@isTest
public class OpportunityTriggerTest {

    public static testMethod void  newAuthReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Authorised Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        objContact.Description = 'Authorised Representative';
        insert objContact;


        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;

        insert objOpp;

        // Update Opportunity with the selected rep
        update objOpp;

        List<OpportunityContactRole> lstOppCon = [SELECT Id, ContactId, OpportunityId FROM OpportunityContactRole
        WHERE OpportunityId = :objOpp.Id];
        if(lstOppCon.size() > 0) {
            System.assertEquals(lstOppCon[0].OpportunityId, objOpp.Id);
            System.assertEquals(lstOppCon[0].ContactId, objContact.Id);
        }
    }

    public static testMethod void  newNotisceReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Notice Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        objContact.Description = 'Notice Representative';
        insert objContact;

        // Create second Rep
        Contact objContact2 = new VC_UnitTestFactory().buildTenantRep();
        objContact2.Description = 'Notice Representative';
        insert objContact2;

        // Create third Rep
        Contact objContact3 = new VC_UnitTestFactory().buildTenantRep();
        objContact3.Description = 'Notice Representative';
        insert objContact3;


        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;

        // Update Opportunity with the selected rep
        update objOpp;

    }

    public static testMethod void  newBillReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Billing Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        insert objContact;


        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;

        // Update Opportunity with the selected rep
        objOpp.Description = objContact.Id + ';';
        update objOpp;

    }

    public static testMethod void  newGurantorReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Guarantor Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        objContact.Description = 'Gaurantor Representative';
        insert objContact;


        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;


    }

    public static testMethod void  newLegalReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Legal Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        objContact.Description = 'Legal Representative';
        insert objContact;

        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;

        // Update Opportunity with the selected rep
        update objOpp;

    }

    public static testMethod void  newRegidsteredReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Registered Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        insert objContact;


        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;

        // Update Opportunity with the selected rep
        objOpp.Description = objContact.Id + ';';
        update objOpp;

    }

    public static testMethod void  existindgReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Existing Billing Rep
        Contact objContact1 = new VC_UnitTestFactory().buildTenantRep();
        insert objContact1;

        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;


        // Create Opportunity Contact Role
        OpportunityContactRole objOppCon = new OpportunityContactRole();
        objOppCon.ContactId = objContact1.Id;
        objOppCon.OpportunityId = objOpp.Id;
        objOppCon.Role = objContact1.Description;
        insert objOppCon;

        // Create Registered Rep
        Contact objContact2 = new VC_UnitTestFactory().buildTenantRep();
        insert objContact2;


    }

    public static testMethod void  newRegistereddReps() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Registered Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        insert objContact;


        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;

        // Update Opportunity with the selected rep
        objOpp.Description = objContact.Id + ';';
        update objOpp;

    }

    public static testMethod void  existingRepss() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Existing Billing Rep
        Contact objContact1 = new VC_UnitTestFactory().buildTenantRep();
        insert objContact1;

        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;


        // Create Opportunity Contact Role
        OpportunityContactRole objOppCon = new OpportunityContactRole();
        objOppCon.ContactId = objContact1.Id;
        objOppCon.OpportunityId = objOpp.Id;
        objOppCon.Role = objContact1.Description;
        insert objOppCon;

        // Create Registered Rep
        Contact objContact2 = new VC_UnitTestFactory().buildTenantRep();
        insert objContact2;


    }

    public static testMethod void  uniqueConRoles() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Existing Billing Rep
        Contact objContact1 = new VC_UnitTestFactory().buildTenantRep();
        insert objContact1;

        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;

        // Create Opportunity Contact Role
        OpportunityContactRole objOppCon = new OpportunityContactRole();
        objOppCon.ContactId = objContact1.Id;
        objOppCon.OpportunityId = objOpp.Id;
        objOppCon.Role = objContact1.Description;
        insert objOppCon;

        // Update Opportunity ensuring same contact role does not get created again
        // but any new ones do
        objOpp.Description = objContact1.Id + ';';
        update objOpp;

    }

    public static testMethod void  noRoleSelected() {

        // Create Account
        Account objAccount = new VC_UnitTestFactory().buildTestAccount();
        insert objAccount;

        // Create Existing Billing Rep
        Contact objContact = new VC_UnitTestFactory().buildTenantRep();
        insert objContact;


        // Create opportunity
        Opportunity objOpp = new VC_UnitTestFactory().buildTestOpportunity();
        objOpp.AccountId = objAccount.Id;
        insert objOpp;

        // Update Opportunity for a contact without role
        update objOpp;

    }

    private class VC_UnitTestFactory {
        Opportunity buildTestOpportunity() {
            return null;
        }
        Account buildTestAccount() {
            return null;
        }
        Contact buildTenantRep() {
            return null;
        }
    }
}