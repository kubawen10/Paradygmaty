let rec print_list = function 
[] -> ()
| e::l -> print_int e ; print_string " " ; print_list l;;

(*ZADANIE 1*)
(*a*)
let rec stirling n m = 
  match (n,m) with
  (x,y) when (x=y || y=1 || y=0) -> 1
  |(x,y) -> ((stirling (x-1) (y-1)) + m * (stirling (x-1) y));;

let start = Sys.time();;
let stirlingResult = stirling 25 17;; (*dla wiekszych chyba stackoverflow*)
 let time= Sys.time() -. start;; 
 Printf.printf "Result: %d\t\tTime: %f\n" stirlingResult time;;

(*b*)
let memoized_stirling n m =
  let table = Hashtbl.create 10
in let rec inner_memoized_stirling n m = 
  match Hashtbl.find_opt table (n,m) with
  Some x -> x
  |None -> 
    let result = match (n,m) with 
    (x, y) when (x=y || y=1 || y=0) -> 1
    |(x, y) -> inner_memoized_stirling (x-1) (y-1) + y * (inner_memoized_stirling (x-1) y)

    in Hashtbl.add table (n,m) result;
    result
in 
  inner_memoized_stirling n m ;;

let start = Sys.time();;
let memoStirlingResult = memoized_stirling 25 17;;
let time = Sys.time() -. start;; 
Printf.printf "Result: %d\t\tTime: %f\n" memoStirlingResult time;;


let make_memoize f = 
  let table = Hashtbl.create 10 in 
  let get_or_calculate x = 
    match Hashtbl.find_opt table x with
    Some value -> value
    |None -> 
      let result = f x in 
      Hashtbl.add table x result;
      result
  in fun x -> get_or_calculate x;;

let uncurry f (x, y) = f x y;;
let memoStirling = make_memoize (uncurry stirling);;

let start = Sys.time();;
let vvv = memoStirling (25, 17);;
let time = Sys.time() -. start;; 
Printf.printf "Result: %d\t\tTime: %f\n" vvv time;;

let start = Sys.time();;
let vvv = memoStirling (25, 17);;
let time = Sys.time() -. start;; 
Printf.printf "Result: %d\t\tTime: %f\n" vvv time;;

(*zadanie 3*)
let x = lazy(stirling 35 17);;
(*to nizej sie nie policz bo chyba stackoverflow, czyli wartosc x jest dopiero tu liczona*)
(* let value = Lazy.force x;; *) 




(*ZADANIE 4*)
type 'a sequence = Cons of 'a * (unit -> 'a sequence);;

(*A*)
let bell = 
  let rec calculateBell n k acc= 
    if (n=0 || n=1) then Cons(1, fun() -> calculateBell (n+1) 1 0)
    else if k <= n then calculateBell n (k+1) (acc + memoized_stirling n k)
    else Cons(acc, fun() -> calculateBell (n+1) 1 0)
  in calculateBell 0 1 0;;

(*B*)
let stream_head stream = 
  match stream with
  Cons(h, t) -> h 

let stream_tail stream = 
  match stream with
  Cons(h, t) -> t;;

let first = stream_head bell;;
print_int first;;
print_string "\n";;

let second = stream_head((stream_tail bell)());;
print_int second;;
print_string "\n";;

(*C1*)
let rec list_of_n sequence n = 
  match n with 
  0 -> []
  |n -> (stream_head sequence) :: list_of_n ((stream_tail sequence)()) (n-1);;

print_list (list_of_n bell 20);;
print_string "\n";;

(*C2*)
let rec every_other sequence n =
  match n with 
  0 -> []
  |n -> 
    let next = (stream_tail((stream_tail sequence)()))()
  in (stream_head sequence) :: every_other next (n-1);;

print_list (every_other bell 10);;
print_string "\n";;

(*C3*)
let rec skip sequence n = 
  match n with 
  0 -> sequence
  |n -> skip ((stream_tail sequence)()) (n-1);;

let skipped = skip bell 5;;
print_int (stream_head skipped);;
print_string "\n";;

(*C4*)
let rec from n = Cons(n, fun() -> from(n+1));;
let natural = from 0;;

let rec combine s1 s2 n = 
  match n with 
  0 -> []
  |n -> ((stream_head s1), (stream_head s2)) :: combine ((stream_tail s1)()) ((stream_tail s2)()) (n-1)

let combined = combine natural bell 5;;

(*C5*)
let rec map f s = 
  Cons(f (stream_head s), fun() -> map f ((stream_tail s)()))

let square x = x * x;;
let bellSquared = map square bell;;
print_list(list_of_n bellSquared 4);;