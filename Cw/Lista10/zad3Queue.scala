class UnderflowException(msg: String) extends Exception(msg)

class MyQueue[+T] private (private val queue: (List[T], List[T])):
    def swap[S>:T](list1: List[S], list2: List[S]): (List[S], List[S]) =
        (list1, list2) match 
            case (Nil, l2) => (l2.reverse, Nil)
            case _ => (list1, list2)

    //gdy mam kolejke Double to podanie Int (1)(Int>:Double) jest git bo Int<:Double czyli (1) daje (Double>:Double)
    // a gdy mam kolejke Integer a podam Double to Double>:Integer i tworzy sie nowa kolejka typu Double
    def enqueue[S>:T](x: S): MyQueue[S] = new MyQueue[S](swap(queue(0), x::queue(1)))

    
    def dequeue: MyQueue[T] = 
        queue match 
            case (Nil, l2) => MyQueue.empty
            case (h1::t1, q2) => new MyQueue(swap(t1, q2) )

    
    def first: T = 
        queue match 
            case (Nil, l2) => throw new UnderflowException("Queue is empty")
            case (h1::t1, q2) => h1

    
    def isEmpty: Boolean = 
        queue match 
            case (Nil, _) => true
            case _ => false 


object MyQueue: // obiekt towarzyszący
    def main(args: Array[String])={
        var q = empty[Integer]

        println(q.isEmpty)
        q = q.enqueue(1)
        println(q.first)
        //tu jest tworzony MyQueuep[Double]
        val qq = q.enqueue(1.1)
        println(qq.dequeue.first)
    }
    def apply[T](xs: T*) = new MyQueue[T](xs.toList, Nil)
    def empty[T] = new MyQueue[T](Nil, Nil)


