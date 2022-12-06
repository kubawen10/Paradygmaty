(*printing*)
let rec print_list = function 
[] -> ()
|e::l -> print_int e ; print_string " " ; print_list l;;

let print_bool x = 
  match x with
  true-> print_string "true"
  |false-> print_string "false";;

(*zadanie 1*)
let rec last list = 
  match list with
  [] -> Option.None
  |[x] -> Option.some x
  |h::t -> last t;;

(*zadanie 2*)
let rec last_two_elements list =
  match list with
  [] | [_] -> Option.None
  |[x;y] -> Option.some [x;y]
  |h::m::t -> last_two_elements(m::t);;

(* zadanie 3*)
let list_length list =
  let rec inner_list_length list len =
    match list with
    [] -> len
    | h::t -> inner_list_length t (len+1)

  in inner_list_length list 0;;

(*zadanie 4*)
let rec reverse list = 
  match list with 
  [] -> []
  |h::t -> reverse t @ [h];;


(*zadanie 5*)
let palindrome list = list = reverse list;;

(*zadanie 6*)
let delete_duplicates list =
  let rec is_in_list(x, list) =
    match list with
    []->false
    |h::t -> if h=x then true else 
      is_in_list (x, t)
  in
  let rec inner_delete_duplicates(output, list) =
    match list with 
    [] -> output
    |h::t -> if (is_in_list(h, output)) then inner_delete_duplicates(output, t) else
    inner_delete_duplicates ((output @ [h]), t)
  in inner_delete_duplicates([], list);;

(*zadanie 7*)
let even_indexes list = 
  let rec inner_even_indexes output list counter = 
    match list with
    [] -> output
    |h::t -> if counter mod 2 = 0 then inner_even_indexes (output @ [h]) t (counter +1) else
      inner_even_indexes output t (counter + 1)
  in inner_even_indexes [] list 1;;

(*zadanie 8*)
let is_prime x =
  let rec inner_prime x k =
    if x mod k <> 0 && k*k <= x then inner_prime x (k+2) else k*k>x

  in x mod 2 <> 0 && x >= 2 && inner_prime x 3;;
