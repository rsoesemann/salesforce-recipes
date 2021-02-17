@IsTest
public class CopadoDomain_Test {

    @IsTest
    private static void happyPath() {

        // Setup
        setup();


        // Exercise
        new Environment()
                .add( new Credential() );

        new Project()
                .add( new Pipeline()
                        .add( new Connection() )
                        .add( new Connection() ))

                .add( new Release() )
                .add( new Release() )
                .persist();


        // Verify
        System.assertEquals(1, [SELECT Count() FROM copado__Project__c]);
        System.assertEquals(1, [SELECT Count() FROM copado__Git_Repository__c]);
        System.assertEquals(1, [SELECT Count() FROM copado__Environment__c]);
        System.assertEquals(1, [SELECT Count() FROM copado__Org__c]);
        System.assertEquals(1, [SELECT Count() FROM copado__Deployment_Flow__c]);
        System.assertEquals(2, [SELECT Count() FROM copado__Deployment_Flow_Step__c]);
        System.assertEquals(2, [SELECT Count() FROM copado__Release__c]);
    }


    // HELPER

    private static void setup() {
        copado.GlobalAPI.UserLicense licence = new copado.GlobalAPI.UserLicense();
        licence.isCADEnabled=true;
        licence.isCCHEnabled=true;
        licence.isCCMEnabled=true;
        licence.isCopadoEnabled=true;
        licence.isCSTEnabled =true;
        licence.userId = UserInfo.getUserId();

        new copado.GlobalAPI().upsertCopadoLicense(licence);
    }
}