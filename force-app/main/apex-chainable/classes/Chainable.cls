public abstract class Chainable {

	private Chainable previous;
	private Chainable next;

	private Map<String, Object> sharedVariables = new Map<String, Object>();

	private List<Id> jobIds = new List<Id>();


	// ABSTRACT

	protected abstract Id executeAsynchronously();
	protected abstract void executeSynchronously(Context ctx);

	
	// PUBLIC

	public Chainable then(Chainable successor) {
		if(next != null) {
			next.then(successor);
		}
		else {
			next = successor;
			next.previous = this;
			
			next.sharedVariables = sharedVariables;
		}

		return this;
	}


	public List<Id> execute() {
		if(Test.isRunningTest()) {
			executeSynchronously(new Context());
			executeNext();
		}
		else {
			Id jobId = executeAsynchronously();
			jobIds.add(jobId);
		}

		return jobIds;
	}


    public Chainable setShared(String key, Object value) {
        sharedVariables.put(key, value);

		return this;
    }


    public Object getShared(String key) {
        return sharedVariables.get(key);
    }


	// PROTECTED

	protected void executeNext() {
		if(next != null) {
			next.execute();
		}
	}


	// INNER

	public class Context {

		private Object originalContext;

		public Context() {}

		public Context(Database.BatchableContext ctx) {
			originalContext = ctx;
		}

		public Context(QueueableContext ctx) {
			originalContext = ctx;
		}

		public Context(SchedulableContext ctx) {
			originalContext = ctx;
		}

		public Object get() {
			return originalContext;
		}
	}
}
