public class RunJob extends ChainableQueueable {

    private Integer secondsToResponse;


    // CONSTRUCTOR

    public RunJob(String name, Integer secondsToResponse) {
        this.secondsToResponse = secondsToResponse;
    }


    // PUBLIC

	@SuppressWarnings('PMD.ApexInsecureEndpoint')
    protected override void execute(Context ctx) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://slowwly.robertomurray.co.uk/delay/' + secondsToResponse*1000 + '/url/http://api.copa.do/');
        request.setMethod('GET');

        new Http().send(request);
    }
}