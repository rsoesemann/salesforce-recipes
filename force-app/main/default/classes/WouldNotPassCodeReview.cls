global without sharing class wouldNotPassCodeReview {
   public static final string poorly_identified_constant = 'Not the proper way of identifying a constant';

   public void TERRIBLEnAMINGhABITS () {
    System.debug('This is pretty bad...');
    String NAME = 'John';
	String LastName = 'Mueller';
   }

   void dmlInALoop() {
    for (Integer i = 0; i <10; i++) {
        insert new Case();
    }
   }

   void queryInALoop() {
    for (Integer i = 0; i <10; i++) {
        List<Case> cases = [Select Id FROM Case];
    }
   }
}
