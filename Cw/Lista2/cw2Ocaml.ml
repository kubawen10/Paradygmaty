(*zadanie 2*)
let rec fib n = 
  if n = 0 then 0
  else if n = 1 then 1 
  else fib(n-1) + fib(n-2);;

let z2 = fib 6;;
print_int z2;;
print_string "\n";;

let rec fibTail n = 
  let rec innerFibTail n1 n2 counter = 
    if counter = n then n1 + n2
    else innerFibTail n2 (n1 + n2) (counter + 1)
  in
  if n = 0 then 0
  else if n = 1 then 1
  else innerFibTail 0 1 2;;

let z2Tail = fibTail 6;;
print_int z2Tail;;
print_string "\n";;


let float_abs (x: float) = if (x >= 0.) then x else -1. *. x;;


(*zadanie 3*)
let root3 a = 
  let rec root3_tail xi = 
    if ( float_abs((xi ** 3.) -. a) <= ((10. ** -15.) *. float_abs(a))) then xi
    else root3_tail(xi +. (((a /. (xi ** 2.)) -. xi )/. 3.))
  in 
  if a > 1. then root3_tail(a /. 3.) else root3_tail(a);;

let z3 = root3 1000.;;
print_float z3;;

(*zadanie 4*)
let [_;_;x;_;_] = [-2;-1;0;1;2];;
let [(_,_);(x1,_)] = [(1,2);(0,1)];;

(*zadanie 5*)
let rec initSegment xs ys = 
  match (xs,ys) with 
  ([],_) -> true
  |(_, []) -> false
  |(h1::t1, h2::t2) -> if h1=h2 then initSegment t1 t2 else false


(*zadanie 6*)
let rec replaceNth xs n x =
  match xs with
  h::t -> if n=0 then x::t else h::replaceNth t (n-1) x
  |[]->[]

  (*elementy listy przed n zostana skopiowane do nowej listy a za n bedzie wskazywac do starej listy*)