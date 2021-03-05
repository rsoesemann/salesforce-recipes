public class Attachment_t extends DomainBuilder {

	public Attachment_t() {
		super(Attachment.SObjectType);
		
		name('file.txt');
        body(new Random().blob());
	}


	public Attachment_t name(String value) {
		return (Attachment_t) set(Attachment.Name, value);
	}


	public Attachment_t body(Blob value) {
		return (Attachment_t) set(Attachment.Body, value);
	}
}