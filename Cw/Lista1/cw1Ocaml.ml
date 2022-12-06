let rec print_list = function 
[] -> ()
| e::l -> print_int e ; print_string " " ; print_list l;;

let bool_to_str b= 
  if b = true then "true"
  else "false";;

(*zadanie 1*)
let rec flatten1 list = 
  if list = [] then []
  else List.hd list @ flatten1 (List.tl list);;

let z1 = flatten1 [[1;2;3];[4;5;6]];;
print_list z1;;
print_string "\n";;

(*zadanie 2*)
let rec count x list =
  if list = [] then 0 
  else if List.hd list = x then 1 + count x (List.tl list)
  else 0 + count x (List.tl list);;

let z2 = count 3 [1;2;3;4;5;3;3;3;6];;
print_int z2;;
print_string "\n";;

(*zadanie 3*)
let rec replicate x n =
  if n = 0 then []
  else x :: replicate x (n-1);;
let z3 = replicate 3 5;;
print_list z3;;
print_string "\n";;

(*zadanie 4*)
let sqr = fun x -> x*x;;

let rec sqrList list =
  if list = [] then []
  else 
    [sqr (List.hd list)] @ sqrList(List.tl list);;
  
let z4 = sqrList [1;2;3];;
print_list z4;;
print_string "\n";;

(*zadanie 5*)
let palindrome list = 
  list = List.rev list;;
let z5 = palindrome [1;2;3;3;2;1];;
let b = bool_to_str z5;;
print_string b;;
print_string "\n";;

(*zadanie 6*)
let rec list_length list =
  if list = [] then 0
  else 1 + list_length (List.tl list);;

let z6 = list_length [1;2;3;4;5;6;7];;
print_int z6;;
print_string "\n";;