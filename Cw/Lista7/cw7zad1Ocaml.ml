module type QUEUE_FUN = sig
  type 'a t
  exception Empty of string
  val empty: unit -> 'a t
  val enqueue: 'a * 'a t -> 'a t
  val dequeue: 'a t -> 'a t 
  val first: 'a t -> 'a
  val isEmpty: 'a t -> bool 
end;;

module QueueNormal: QUEUE_FUN = struct 
  type 'a t = 'a list
  exception Empty of string

  let empty () = []

  let enqueue(x, queue) = queue @ [x]

  let dequeue queue = 
    match queue with
    [] -> []
    |h::t -> t

  let first queue = 
    match queue with
    [] -> raise(Empty "Queue is empty")
    |h::t -> h

  let isEmpty queue = 
    queue = []
end;;


module QueuePair: QUEUE_FUN = struct 
  type 'a t = 'a list * 'a list
  exception Empty of string

  let swap queue = 
    match queue with
    ([], second) -> (List.rev second, [])
    |good -> good

  let empty () = ([],[])

  let enqueue(x, queue) = swap(fst queue, x:: (snd queue))

  let dequeue queue = 
    match queue with
    ([],q2) -> ([],[])
    |(h1::t1, q2) -> swap(t1, q2)

  let first queue = 
    match queue with
    ([],q2) -> raise(Empty "Queue is empty")
    |(h1::t1, q2) -> h1

  let isEmpty queue = 
    match queue with 
    ([], _) -> true
    |_ -> false

end;;
