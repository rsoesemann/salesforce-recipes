global class Voldemort {

	// CONSTRUCTORS

	public Voldemort() {
		delete [SELECT Id FROM Account];
	}


	public Voldemort(ApexPages.StandardController ctrl) {
		delete [SELECT Id FROM Account];
	}


	// PUBLIC

	public static void incorrectDebugs() {
		System.debug('Not allowed');
		System.debug(LoggingLevel.ERROR, 'Allowed');
	}


	public static Blob badCrypo(String secret) {
		Blob iv = Blob.valueOf('NameOfMyDog');
		Blob key = Blob.valueOf('21353we45242');

		System.debug(secret);

		return Crypto.encrypt('AES128', key, iv, Blob.valueOf(secret));
	}


	public static void crudViolation(String id, String email) {
		Contact c = [SELECT Email FROM Contact WHERE Id = :id];
		c.Email = email;
		update c;
	}


	public static void insecureEndpoint() {
		new HttpRequest().setEndpoint('http://localhost:com');
	}


	public static PageReference openRedirect() {
		String url = ApexPages.currentPage().getParameters().get('url_param');
		return new PageReference(url);
	}


	public static Account soqlInjection(Id id) {
		return (Account) Database.query('SELECT Id FROM Account WHERE Id = ' + id);
	}


	public static void betterUseNamedCredential(String username, String password) {
		Blob headerValue = Blob.valueOf(username + ':' + password);
		String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
		new HttpRequest().setHeader('Authorization', authorizationHeader);
	}


	public static void xssFromUrlParam() {
		String url = ApexPages.currentPage().getParameters().get('url_param');
		doStuff(url);
	}


	public static void deeplyNestedIf(Integer x, Integer y, Integer z) {
		if(x>y) {
			if(y>z) {
				if(z==x) {
					Integer space = x * y * z;
					// ...
				}
			}
		}
	}


	public void dmlInLoops(List<Account> accounts) {
		for(Account a : accounts) {
			update a;
		}
	}


	public void avoidHardcodingIds(Account a) {
		if(a.Id == '012500000009WAr') {
			a.Description = 'VIP';
		}
	}


	public void badVariableNaming() {
		String NAME = 'John';
		String LastName = 'Mueller';
		Integer annual_Salary = 100000;
	}


	public void Bad_Method_NAMING() {
		doStuff(null);
	}
}
