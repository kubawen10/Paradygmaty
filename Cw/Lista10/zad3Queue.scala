class UnderflowException(msg: String) extends Exception(msg)

class MyQueue[+T] private (private val queue: (List[T], List[T])) {
    def swap[S>:T](list1: List[S], list2: List[S]): (List[S], List[S]) =
        (list1, list2) match 
            case (Nil, l2) => (l2.reverse, Nil)
            case _ => (list1, list2)

    //done
    def enqueue[S>:T](x: S): MyQueue[S] = new MyQueue[S](swap(queue(0), x::queue(1)))

    //done
    def dequeue: MyQueue[T] = 
        queue match 
            case (Nil, l2) => MyQueue.empty
            case (h1::t1, q2) => new MyQueue(swap(t1, q2) )

    //done
    def first: T = 
        queue match 
            case (Nil, l2) => throw new UnderflowException("Queue is empty")
            case (h1::t1, q2) => h1

    //done
    def isEmpty: Boolean = 
        queue match 
            case (Nil, _) => true
            case _ => false 
}

object MyQueue{ // obiekt towarzyszący
    def main(args: Array[String])={
        var q = empty[Number]

        println(q.isEmpty)
        q = q.enqueue(1)
        println(q.first)
        q = q.enqueue(1.1)
        println(q.dequeue.first)

    }
    def apply[T](xs: T*) = new MyQueue[T](xs.toList, Nil)
    def empty[T] = new MyQueue[T](Nil, Nil)
}

