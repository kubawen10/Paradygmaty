import java.util.ArrayList;

public class QueueCyclic<E> implements MyQueue<E> {
    private static final int DEFAULT_CAPACITY = 10;
    private final int capacity;
    private ArrayList<E> list;
    private int f;
    private int r;

    public QueueCyclic() {
        this(DEFAULT_CAPACITY);
    }

    public QueueCyclic(int capacity) {
        list = new ArrayList<>(capacity + 1);
        this.capacity = capacity;
        f = 0;
        r = 0;
    }


    @Override
    public void enqueue(E x) throws FullException {
        if (isFull()) throw new FullException("Queue is full!");

        list.add(r, x);
        r = (r + 1) % (capacity + 1);
    }

    @Override
    public void dequeue() {
        if (isEmpty()) return;

        f = (f + 1) % (capacity + 1);
    }

    @Override
    public E first() throws EmptyException {
        if (isEmpty()) throw new EmptyException();

        return list.get(f);
    }

    @Override
    public boolean isEmpty() {
        return f == r;
    }

    @Override
    public boolean isFull() {
        return f == (r + 1) % (capacity + 1);
    }
}
