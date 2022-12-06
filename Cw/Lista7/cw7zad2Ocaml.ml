module type QUEUE_MUT =
sig
  type 'a t
  (* The type of queues containing elements of type ['a]. *)
  exception Empty of string
  (* Raised when [first q] is applied to an empty queue [q]. *)
  exception Full of string
  (* Raised when [enqueue(x,q)] is applied to a full queue [q]. *)
  val empty: int -> 'a t
  (* [empty n] returns a new queue of length [n], initially empty. *)
  val enqueue: 'a * 'a t -> unit
  (* [enqueue (x,q)] adds the element [x] at the end of a queue [q]. *)
  val dequeue: 'a t -> unit
  (* [dequeue q] removes the first element in queue [q] *) 
  val first: 'a t -> 'a
  (* [first q] returns the first element in queue [q] without removing 
  it from the queue, or raises [Empty] if the queue is empty. *) 
  val isEmpty: 'a t -> bool
  (* [isEmpty q] returns [true] if queue [q] is empty, 
  otherwise returns [false]. *)
  val isFull: 'a t -> bool
  (* [isFull q] returns [true] if queue [q] is full, 
  otherwise returns [false]. *)
end;;


module QueueMutable: QUEUE_MUT = struct
  type 'a t = {mutable q: 'a option array; mutable f: int; mutable r: int}

  exception Empty of string

  exception Full of string
  
  let empty n = {q = Array.make (n + 1) None; f = 0; r = 0}
  
  let isEmpty queue = 
    queue.r = queue.f

  let isFull queue = 
    queue.f = (queue.r + 1) mod Array.length queue.q

  let enqueue (x, queue) = 
    if (isFull queue) then raise(Full "Queue is full")
    else 
      queue.q.(queue.r) <- Some x;
      queue.r <- ((queue.r + 1) mod Array.length queue.q)

  let dequeue queue = 
    if (isEmpty queue) then ()
    else 
      queue.f <- (queue.f + 1) mod Array.length queue.q

  let first queue = 
    if (isEmpty queue) then raise(Empty "Queue is empty")
    else 
      Option.get(queue.q.(queue.f))

end;;