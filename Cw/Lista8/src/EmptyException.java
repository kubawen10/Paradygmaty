public class EmptyException extends Exception {
    public EmptyException( ) {
        super("Empty Exception");
    }
    public EmptyException(String message) {
        super(message);
    }
}