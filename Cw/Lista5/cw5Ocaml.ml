type 'a llist = LNil | LCons of 'a * 'a llist Lazy.t;;
type 'a stream = Nil | Cons of 'a * (unit -> 'a stream);;

let lrepeat k llst = 
  let rec inner n lst = 
    match (n, lst) with
    (0, LCons(h, lazy t)) -> inner k t
    |(x, LCons(h, lazy t)) when x > 0 -> LCons(h, lazy (inner (n-1) lst)) 
    |_ -> LNil

  in inner k llst 

let rec from n = LCons(n, lazy (from (n+1)));;
let natural = from 0;;

let a = lrepeat 5 natural;;

let rec getN list n = 
  if n<=0 then [] else 
    match list with 
    LNil -> []
    |LCons(h, lazy t) -> h :: getN t (n-1);;

let b = getN a 10;;




(*zadanie 2*)
let fib1 =
  let rec fibgen a b=
    LCons(a, lazy (fibgen b (a + b)))
  in fibgen 1 1

(*head of stream*)
let hd (s : 'a stream) : 'a =
  match s with
    Nil -> failwith "hd"
  | Cons (x, _) -> x

(* tail of a stream *)
let tl (s : 'a stream) : 'a stream =
  match s with
    Nil -> failwith "tl"
  | Cons (_, g) -> g () (* get the tail by evaluating the thunk *)

(* n-th element of a stream *)
let rec nth (s : 'a stream) (n : int) : 'a =
  if n = 0 then hd s else nth (tl s) (n - 1)

(* make a stream from a list *)
let from_list (l : 'a list) : 'a stream =
  List.fold_right (fun x s -> Cons (x, fun () -> s)) l Nil

(* make a list from the first n elements of a stream *)
let rec take (s : 'a stream) (n : int) : 'a list =
  if n <= 0 then [] else
  match s with
    Nil -> []
  | _ -> hd s :: take (tl s) (n - 1)

(*zadanie 3*)
type 'a lBT = LEmpty | LNode of 'a * (unit ->'a lBT) * (unit -> 'a lBT);;
let lBreadth(ltt: 'a lBT) = 
    let rec search queue = 
      match queue with 
      [] -> LNil
      |LNode(v,l,r) :: t -> LCons(v, lazy(search (t@[l();r()])))
      |LEmpty::t-> search t
    in search [ltt];;