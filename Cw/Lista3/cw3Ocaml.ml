let rec print_list = function 
[] -> ()
| e::l -> print_int e ; print_string " " ; print_list l;;



(*ZADANIE 1*)
let f1 x = x 2 2;;
(*WYJASNIENIE:  jest to funkcja jednego argumentu x wiec bedzie arg1 -> return, 
                patrzymy na ciało widzimy ze x bierze dwa argumenty int, kazda funkcja cos zwraca ale nie wiemy co zwraca ten x, dlatego x: int -> int -> a' 
                no a ze funkcja musi cos zwracac wiec zwraca wynik tego co dał x czyli a' stąd (int -> int -> a') -> a'*)

let f2 x y z = x(y^z);;
(*WYJASNIENIE:  f2 to funkcja 3 argumentow stad bedzie arg1 -> arg2 -> arg3 -> return,
                patrze na cialo funkcji widze że x to funkcja ktora bierze jeden argument dlatego x: arg1 -> returnX
                wiem tez ze y^z oznacza łączenie stringow y i z, stąd wiem że y i z to stringi no i nie wiem co robi ten x, wiec x: string -> a'
                no i cala funkcja zwraca to co zwroci x, dlatego (string -> a') -> string -> string -> a'*)




(*ZADANIE 2*)
let curry3 f x y z = f (x,y,z);;  (*lukier*)
let curry33 = function f -> function x -> function y -> function z -> f(x,y,z);;  (*bez lukru*)

let uncurry3 f(x,y,z) = f x y z;; (*lukier*)
let uncurry33 = function f -> function (x, y, z) -> f x y z;; (*bez lukru*)

let add (x, y, z) = x + y + z;;
let cur1 = curry3 add 1 2 3;;
print_int cur1;;
print_string "\n";;

let cur2 = curry33 add 4 5 6;;
print_int cur1;;
print_string "\n";;

let sum x y z = x + y + z;;
let unc1 = uncurry3 sum (1,2,3);;
print_int unc1;;
print_string "\n";;

let unc2 = uncurry33 sum (4,5,6);;
print_int unc2;;
print_string "\n";;





(*ZADANIE 3, FOLD_LEFT WYJASNIENIE: arg1 to funkcja, ktora ma dwa argumenty (acc i head) i zwraca nowy acc, arg2 to acc w stanie poczatkowym, arg3 to lista*)
let sumProd list = List.fold_left (fun (s, p) h -> (s + h, p * h)) (0, 1) list

let (z31,z32) = sumProd [1;2;3;4;5];;
print_int z31;;
print_string " ";;
print_int z32;;
print_string "\n";;






(*ZADANIE 4*)
(* a) - nie dzial bo gdy list to np [4,4,6,8,7] to small = [] a large znowu daje [4,6,8,7] i nic sie nie zmienia
   czyli gdy nie ma mniejszych niz pierwszy element i list nieposortowana to nic sie nie zmienia*)
let rec quicksort = function
 [] -> []
 | [x] -> [x]
 | xs -> let small = List.filter (fun y -> y < List.hd xs ) xs
 and large = List.filter (fun y -> y >= List.hd xs ) xs
 in quicksort small @ quicksort large;;

 (* b) -nie dziala bo pomija elementy powtarzajace sie np [4,4,4] -> [4]*)
let rec quicksort' = function
 [] -> []
 | x::xs -> let small = List.filter (fun y -> y < x ) xs
 and large = List.filter (fun y -> y > x ) xs
 in quicksort' small @ (x :: quicksort' large);;

(*dobre rozwiazanie*)
let rec quicksortGood = function
 [] -> []
 |x::xs -> let small = List.filter (fun y -> y < x ) xs
 and large = List.filter (fun y -> y >= x ) xs
 in quicksortGood small @ (x :: quicksortGood large);;





(*ZADANIE 5*)
let insertionsort order list = 
  let rec insert  elem xs =
    match xs with
    [] -> [elem]
    | h::t -> if order elem h then elem::xs
    else h::(insert elem t)
  in List.fold_left (fun acc insertedElement -> insert insertedElement acc) [] list;;

let order a b = fst a < fst b;;
let sorted = insertionsort order [(1,1);(3,0);(2,0);(4,0);(0,0);(1,2)];;

let rec mergesort order list =
  match list with
  [] -> []
  |[h]-> [h]
  |_ -> 
    let splitAtHalf xs= 
      let rec innerSplitAt acc xs n =
        match (xs, n) with 
        (_,0) -> (List.rev acc, xs)
        |(h::t, _) -> innerSplitAt (h::acc) t (n-1)
      in
      innerSplitAt [] xs ((List.length xs) / 2)
    in
    let rec merge xs ys = 
      match (xs, ys) with 
      ([], ys) -> ys
      |(xs, []) -> xs
      |(h1::t1, h2::t2) -> 
        if order h1 h2 then h1 :: merge t1 ys
        else h2 :: merge xs t2
    in
    let (leftSublist, rightSublist) = splitAtHalf list
    in
    merge (mergesort order leftSublist) (mergesort order rightSublist)

let order2 a b = a < b;;
let sorted2 = mergesort order2 [5;2;1;5;2;1;7;9;4;2;11;18;17];;
print_list sorted2;;
