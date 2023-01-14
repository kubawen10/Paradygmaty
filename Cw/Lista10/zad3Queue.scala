class UnderflowException(msg: String) extends Exception(msg)

class MyQueue[+T] private (private val queue: (List[T], List[T])) {
    def swap[S>:T](q: (List[S], List[S])): (List[S], List[S]) = {
        q match 
            case (Nil, l2) => (l2.reverse(), Nil)
            case _ => q
    }

    def enqueue[S>:T](x: S): MyQueue[S] = swap(queue(0), x::queue(1))

    def dequeue(): MyQueue[T] = 
        queue match 
            case (Nil, l2) => MyQueue.empty
            case (h1::t1, q2) => swap(t1, q2) 

    def first(): T = 
        queue match 
            case (Nil, l2) => throw new UnderflowException("Queue is empty")
            case (h1::t1, q2) => h1

    def isEmpty(): Boolean = 
        queue match 
            case (Nil, _) => true
            case _ => false 
}

object MyStack{ // obiekt towarzyszący
    def main(args: Array[String])={
        
    }
    def apply[T](xs: T*) = new MyStack[T](xs.toList.reverse)
    def empty[T] = new MyStack[T](Nil)
}

