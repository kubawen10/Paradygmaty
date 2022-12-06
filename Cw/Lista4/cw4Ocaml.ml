(*zadanie 1a*)
let f1 x y z = x y z;;
(*x jest funkcja co przyjmuje dwa argumenty x i z, dlatego (a->b->c)*)
(*do tego zostaja dwa argumenty y i z stad ()->a->b*)
(*funkcja x zwraca jakies c zatem cala funkcja tez to zwraca*)

(*zadanie 1b*)
let f2 x y = function z -> x::y;;
(*x musi byc typu 'a i y musi byc tupu 'a list*)
(*dlatego poczatek to 'a->'a list*)
(*funkcja ta zwraca inna funkcje ktora nie robi niz ze swoim argumentem z i zwraca x::y*)
(*dlatego ta zwracan funkcja to 'b -> 'a list*)
(*czyli calosc to 'a -> 'a list -> 'b -> 'a list*)

(*zadanie 2*)
let rec f x = raise Not_found;;
let f1 x = List.hd [];;

(*zadanie 3*)
let rec print_list = function 
  [] -> ()
  | e::l -> print_int e ; print_string " " ; print_list l;;

type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

let breadthBT bt = 
  let rec iterate queue acc = 
    match queue with 
    [] -> List.rev acc
    |h::t -> match h with 
      Node(v,l,r) -> iterate (t @ [l; r]) (v :: acc)
      |Empty -> iterate t acc

  in 
  iterate [bt] []

let emptyTree = Empty;;
let l = breadthBT emptyTree;;

let oneNode = Node(1, Empty, Empty);;
let l1 = breadthBT oneNode;;

let deeper = Node(1, 
                  Node(2, 
                      Node(4, Empty, Empty), 
                      Empty), 
                  Node(3, 
                      Node(5,Empty,Empty), 
                      Node(6,Empty,Empty)));;
let l2 = breadthBT deeper;;

let exTree = Node(1, 
                  Node(2, 
                      Node(4, 
                          Empty, 
                          Empty), 
                      Empty), 
                  Node(3, 
                      Node(5,
                          Empty,
                          Node(6,
                              Empty,
                              Empty)),
                      Empty));;

let l3 = breadthBT exTree;;

(*zadnie 4 a*)
let internalDepth tree = 
  let rec innerInternalDepth t depth = 
    match t with
    Empty -> 0
    |Node(v, l, r) -> depth + innerInternalDepth l (depth + 1) + innerInternalDepth r (depth + 1)
  in innerInternalDepth tree 0;;

let dEmpty = internalDepth emptyTree;;
Printf.printf "IDepth empty: %d\n" dEmpty;;

let dExTree = internalDepth exTree;;
Printf.printf "IDepth example: %d\n" dExTree;;

(*zadanie 4 b*)
let externalDepth tree = 
  let rec innerExternalDepth t depth = 
    match t with 
    Empty -> depth 
    |Node(v, l, r) -> ((innerExternalDepth l (depth + 1)) + (innerExternalDepth r (depth + 1)))
  in innerExternalDepth tree 0;;

Printf.printf "EDepth example: %d\n" (externalDepth exTree);;

(*zadanie 5*)
type 'a graph = Graph of ('a -> 'a list);;

let g = Graph(
  function
  0 -> [3]
| 1 -> [0;2;4]
| 2 -> [1]
| 3 -> []
| 4 -> [0;2]
| n -> failwith ("Graph g: node "^string_of_int n^" doesn't exist")

);;

let depthSearch (Graph successors) startNode = 
  let rec search visited stack = 
    match stack with
    [] -> []
    |h :: t -> if List.mem h visited then search visited t
              else h :: search (h::visited) ((successors h) @ stack) 
    in search [] [startNode];;

let depth = depthSearch g 1;;
print_list depth;;