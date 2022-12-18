module type POINT_3D_TYPE = sig
  type point3D = IntPoint of {x: int; y: int; z: int} | FloatPoint of {x: float; y: float; z: float} 
  val distance: point3D -> point3D -> float 
end;;

module Point3D: POINT_3D_TYPE = struct
  type point3D = IntPoint of {x: int; y: int; z: int} | FloatPoint of {x: float; y: float; z: float}

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

module type Make_Point_Type = sig 
  val p: int*int*int
end;;

module Make_Point: Make_Point_Type = struct
  let p = (10,100,1000)
end;; 

module type Translation_Values_Type = sig 
  val p: int*int*int
end;;

module Translation_Values: Translation_Values_Type = struct
  let p = (1,2,3)
end;; 


module Translation(T: Translation_Values_Type)(M: Make_Point_Type):Make_Point_Type = struct 
  let p =
  let (x,y,z) = M.p in
  let (dx,dy,dz) = T.p in 
  (x+dx, y+dy, z+dz)
end;;

module Point_After = Translation(Translation_Values)(Make_Point);;

let (x,y,z) = Point_After.p;;


(* print_int x;;
print_int y;;
print_int z;; *)


module type Make_Segment_Type = sig 
  val p1: int*int*int 
  val p2: int*int*int
end;;

module Make_Segment: Make_Segment_Type = struct
  let p1 = (1,1,1)
  let p2 = (2,2,2)
end;; 


module TranslationSegment(T: Translation_Values_Type)(M: Make_Segment_Type):Make_Segment_Type = struct 
  let p1 =
    let (x,y,z) = M.p1 in
    let (dx,dy,dz) = T.p in 
    (x+dx, y+dy, z+dz)

  let p2 =
    let (x,y,z) = M.p2 in
    let (dx,dy,dz) = T.p in 
    (x+dx, y+dy, z+dz)
end;;

module Segment_After = TranslationSegment(Translation_Values)(Make_Segment);;

let (x,y,z) = Segment_After.p1;;
print_int x;;