(*zadanie 0*)
let rec print_list = function 
[] -> ()
|e::l -> print_int e ; print_string " " ; print_list l;;

let log pref dt text =
  "[" ^ pref ^ "] " ^ dt ^ " \t " ^ text;;

let warnLog = log "Warn";;
let dateWarnLog = warnLog "26.10.2022 11:52";;
let completeLog = dateWarnLog "Helllo";;
print_string completeLog;;
print_string "\n";;

(*zadanie 1 MAP*)
let rec map list f =
  match list with
  [] -> []
  | h::t -> (f h) :: map t f ;;


(*zadanie 2 FILTER*)
let rec filter list pred = 
  match list with
  [] -> []
  |h::t -> if pred h then h::filter t pred
  else filter t pred

(*zadanie 3 REDUCE, kolejnosc op(x,y) ma znaczenie np ^ dodaje string na koncu lub poczatku*)
let rec reduce list op acc =
  match list with 
  [] -> acc
  |h::t -> reduce t op (op acc h)

(*zadanie 4 SREDNIA*)
let avg list = 
  let sum = reduce list (+) 0 
in 
  let rec listLengthTail list acc =
    match list with
    [] -> acc
    |h::t -> listLengthTail t (acc+1)
in
  (float_of_int sum) /. float_of_int(listLengthTail list 0)

let z4 = avg [1;2;3];;
print_float z4;;
print_string "/n";;

(*zadanie 5 AKRONIM*)
let acronym str = 
  let splitted = String.split_on_char ' ' str
in
  let firstLetters = map splitted (fun str -> String.make 1 str.[0])
in 
  reduce firstLetters (^) ""

let z5 = acronym "Hello World Test";;
print_string z5;;
print_string "\n";;

(*zadanie 6 *)
let listSquaredIfCubeNotGreaterThanListSum list =
  let listSum = reduce list (+) 0
in 
  let xCubedNotGreaterThanListSum x =
    x*x*x <= listSum
in 
  let filtered = filter list xCubedNotGreaterThanListSum
in map filtered (fun x -> x*x)

let z6 = listSquaredIfCubeNotGreaterThanListSum [1;2;3;4;5];; (*sum == 15 -> [1;2] zaakceptowane bo 3*3*3 > 15*)
print_list z6;;
print_string "\n";;
let z61 = listSquaredIfCubeNotGreaterThanListSum[1;2;3;4;5;12];; (*sum == 27 -> [1;2;3] zaakceptowane*)
print_list z61;;