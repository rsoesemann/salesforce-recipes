public abstract class ChainableQueueable extends Chainable
                                         implements Queueable, Database.AllowsCallouts {
    // ABSTRACT

    protected abstract void execute(Context ctx);


    // PUBLIC

    public void execute(QueueableContext ctx) {
        execute(new Context(ctx));

        executeNext();
    }


    // OVERRIDE

    public override Id executeAsynchronously() {
        return System.enqueueJob(this);
    }


    public override void executeSynchronously(Context ctx) {
        execute(ctx);
    }
}
