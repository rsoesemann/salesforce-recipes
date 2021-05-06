public with sharing class Route {
    
    private List<Event__e> events = new List<Event__e>();
    private List<Command> commands = new List<Command>();


    // CONSTRUCTOR

    public Route(List<Event__e> events) {
        this.events = events;
    }


    // PUBLIC

    public Route to(Command command) {
        commands.add(command);
        return this;
    }


    public void now() {
        for(Event__e event : events) {
            for(Command command : commands) {
                if(command.applies(event)) {
                    command.execute(event);
                }
            }
        }
    }


    // INNER

    public interface Command {
        Boolean applies(Event__e event);
        void execute(Event__e event);
    }
}
