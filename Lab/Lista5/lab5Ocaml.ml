(*ZADANIE 1 done*)
type point2D = float * float;;

(*a*)
let distance p1 p2 = 
  let (x1, y1) = p1 in
  let (x2, y2) = p2 in
  Float.sqrt ((x1 -. x2) ** 2. +. (y1 -. y2) ** 2.);;

let (a: point2D) = (1.0, 1.0);;
let (b: point2D) = (2.0, 2.0);;
(* print_float (distance a b);;
print_string "\n";; *)

(*b*)
type pointND = float list;;

let distanceND p1 p2 = 
  let rec sumDifSqr a b acc = 
    match (a,b) with
    ([],[]) -> acc
    |(h1::t1, h2::t2) -> sumDifSqr t1 t2 (acc +. ((h1-.h2)**2.))
    |_ -> -1.
  in 
  if List.length p1 = List.length p2 then Option.Some (Float.sqrt(sumDifSqr p1 p2 0.0)) else Option.None
  

let(aa: pointND) = [1.0;2.0;3.0];;
let(bb: pointND) = [2.0;3.0;4.0];;
let dd = distanceND aa bb;;
(* print_float dd;;
print_string "\n" *)

(*ZADANIE 2 done*)
(*tuple, nie da sie modyfikowac*)
(*imie nazwisko wiek*)
type personT = string * string * int;;
type partnershipT = personT * personT;;

let (person1: personT) = ("Jakub", "Wengrzyn", 10);;
let (person2: personT) = ("Jan", "Wengrzyn", 20);;

let (partnership1: partnershipT) = (person1, person2);;

let printPersonT p= 
  let (name, surname, age) = p
in
  print_string name;;

let getYoungerPersonT partnership = 
  let (p1, p2) = partnership
in let (_, _, age1) = p1 
in let (_, _, age2) = p2
in if age1 < age2 then p1 else p2

let younger = getYoungerPersonT partnership1;;
(* printPersonT younger;;
print_string "\n";; *)

(*named*)
type personN = {name: string; surname: string; mutable age: int};;
let p1 = {name = "jan"; surname = "kowalski"; age = 69};;
let p2 = {name = "adam"; surname = "kowalski"; age = 88};;

let printPersonN p = print_int p.age;;
(* printPersonN p1;;
print_string "\n";; *)

type partnershipN = {person1: personN; person2: personN};;
let part = {person1 = p1; person2 = p2};;

let getYoungerPersonN partnership = 
  if partnership.person1.age < partnership.person2.age then partnership.person1 else partnership.person2;;

let y = getYoungerPersonN part;;
(* 
printPersonN y;;
print_string "\n";; *)

p1.age <- 8;;

(* printPersonN p1;;
print_string "\n";;
printPersonN part.person1;;
print_string "\n";;
print_string "\n";; *)

(*ZADANIE 3 done*)
type weekDay = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday;;

(*a*)
let weekDayToString weekDay = 
  match weekDay with
  Monday -> "Poniedzialek"
  | Tuesday -> "Wtorek"
  | Wednesday -> "Sroda"
  | Thursday -> "Czwartek"
  | Friday -> "Piatek"
  | Saturday -> "Sobota"
  | Sunday-> "Niedziela"

let pon = weekDayToString Monday;;
print_string pon;;
print_string "\n";;

(*b*)
let nextDay weekDay = 
  match weekDay with
  Monday -> Tuesday
  | Tuesday -> Wednesday
  | Wednesday -> Thursday
  | Thursday -> Friday
  | Friday -> Saturday
  | Saturday -> Sunday
  | Sunday -> Monday

let tue = nextDay Monday;;
let wt = weekDayToString tue;;
print_string wt;;
print_string "\n";;

(*ZADANIE 4 done*)
type 'a maybe = Just of 'a | Nothing;;

let safeHead list = 
  match list with 
  [] -> Nothing
  |h::t -> Just h

let getVal maybe = 
  match maybe with
  Just x -> x
  |Nothing -> raise Not_found

let l = [];;
let a = safeHead l;;
print_int (getVal a);;
print_string "\n";;

(*ZADANIE 5 done*)
type solidFigure = 
  | Cuboid of {width: float; length: float; height: float}
  | Cone of {radius: float; height: float}
  | Sphere of {radius: float}
  | Cylinder of {radius: float; height: float};;

let volume figure = 
  match figure with
  Cuboid {width; length; height} -> width *. length *. height
  | Cone {radius; height} -> (1. /. 3.) *. Float.pi *. (Float.pow radius 2.) *. height
  | Sphere {radius} -> (4. /. 3.) *. Float.pi *. (Float.pow radius 3.)
  | Cylinder {radius; height} -> Float.pi *. (Float.pow radius 2.) *. height

let cube = Cuboid {width = 2.; length = 2.; height = 2.};;
let vCube = volume cube;;
print_float vCube;;

