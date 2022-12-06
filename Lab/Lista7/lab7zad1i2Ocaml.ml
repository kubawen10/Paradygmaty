module type POINT_3D_TYPE = sig

  type point3D = IntPoint of int*int*int | FloatPoint of float*float*float

  val distance: point3D -> point3D -> float 
end;;

module Point3D: POINT_3D_TYPE = struct
  type point3D = IntPoint of int*int*int | FloatPoint of float*float*float 

  let convertToFloatPoint point = 
    match point with
    IntPoint(x,y,z) -> FloatPoint(float_of_int x, float_of_int y,float_of_int z)
    |_ -> point

  let rec distance p1 p2 = 
    match (p1, p2) with 
    (FloatPoint(x1,y1,z1), FloatPoint(x2,y2,z2)) -> Float.sqrt ((x1 -. x2) ** 2. +. (y1-. y2) ** 2. +. (z1-. z2) ** 2.)
    |(IntPoint(x1,y1,z1), IntPoint(x2,y2,z2)) -> distance (convertToFloatPoint p1) (convertToFloatPoint p2)
    |(FloatPoint(x1,y1,z1), IntPoint(x2,y2,z2)) -> distance p1 (convertToFloatPoint p2)
    |(IntPoint(x1,y1,z1), FloatPoint(x2,y2,z2)) -> distance (convertToFloatPoint p1) p2
 

end;;


let p1 = Point3D.IntPoint(1, 2, 3);;
let p2 = Point3D.FloatPoint(2., 2., 3.);;
let d = Point3D.distance p1 p2;;
print_float d;;

module type SEGMENT_TYPE = sig
  open Point3D

  type segment = point3D * point3D
  val length: segment -> float 
end;;

module Segment: SEGMENT_TYPE = struct 
  open Point3D

  type segment = point3D * point3D

  let length s = 
    match s with 
    (p1, p2) -> distance p1 p2

end;;