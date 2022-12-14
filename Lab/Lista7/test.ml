module type POINT_3D_TYPE = sig
  type point3D = IntPoint of {x: int; y: int; z: int} | FloatPoint of {x: float; y: float; z: float} and 'a point = {x: 'a; y: 'a; z: 'a}
  val distance: point3D -> point3D -> float 
end;;

module Point3D: POINT_3D_TYPE = struct
  type point3D = IntPoint of {x: int; y: int; z: int} | FloatPoint of {x: float; y: float; z: float} and 'a point = {x: 'a; y: 'a; z: 'a}

  let convertToFloatPoint point = 
    match point with
    IntPoint{x = x1; y = y1; z = z1} -> FloatPoint{x = (float_of_int x1); y = (float_of_int y1); z = (float_of_int z1)}
    |_ -> point

  let rec distance p1 p2 = 
    match (p1, p2) with
    (FloatPoint{x = x1; y = y1; z = z1}, FloatPoint{x = x2; y = y2; z = z2}) -> Float.sqrt ((x1 -. x2) ** 2. +. (y1-. y2) ** 2. +. (z1-. z2) ** 2.)
    |_ -> distance (convertToFloatPoint p1) (convertToFloatPoint p2)
end;;

(*dziala ladnie*)
let p1 = Point3D.IntPoint{x=1; y=2; z=3};;
let p2 = Point3D.FloatPoint{x=2.; y=2.; z=3.};;
let d = Point3D.distance p1 p2;;
(* print_float d;; *)

(*nie dziala distance, inny typ*)
let p3 = Point3D.{x=1; y=2; z=3};;


module type SEGMENT_TYPE = sig
  open Point3D
  type segment = {p1: point3D; p2: point3D}
  val length: segment -> float 
end;;

module Segment: SEGMENT_TYPE = struct 
  open Point3D
  type segment = {p1: point3D; p2: point3D}

  let length s = 
    distance s.p1 s.p2
end;;

let s = Segment.{p1 = p1; p2 = p2};;
let l = Segment.length s;;
(* print_float l;; *)



module type TYPE = sig
  type t
end

module Make_Point(Type: TYPE) = struct
  type t = Type.t

  (* let create x y z = 
    match (x,y,z) with 
    (Type.Int(a), Type.Int(b), Type.Int(c)) -> Point3D.IntPoint(a,b,c)
    |(Type.Float(a), Type.Float(b), Type.Float(c)) -> Point3D.FloatPoint(a,b,c) *)

  let create (x:t) (y:t) (z:t) = Point3D.{x;y;z}

  (*moze tak ? ale wtedy nie trzeba type definiowac tylko mam inna funkcje a to != funktor chyba*)
  let createIntPoint x y z = Point3D.IntPoint{x;y;z}
  let createFloatPoint x y z = Point3D.FloatPoint{x;y;z}
end;; 

module Make_Int_Point = 
Make_Point(struct 
  type t = int
end);;
let intPoint = Make_Int_Point.create 1 2 3;;

module Make_Float_Point = 
Make_Point(struct 
  type t = float
end);;
let floatPoint = Make_Float_Point.create 1. 2. 3.;;

(*dla segment w sumie nie ma znaczenia typ*)
module Make_Segment(S: SEGMENT_TYPE) = struct 
  let make_segment p1 p2 = Segment.{p1;p2}
end;;


