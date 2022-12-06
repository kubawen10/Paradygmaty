object cw3Scala{
    def main(args: Array[String]) = {
        val (x1, x2) = sumProd(List(1,2,3,4))
        println(x1)
        println(x2)

    }

    //ZADANIE 2
    def curry3[A,B,C,D](f: (A,B,C) => D): A=>B=>C=>D = {
        (a:A) => {(b:B) => {(c:C) => f(a,b,c)}}
    }
    def curry3Lukier[A,B,C,D](f:(A,B,C) => D)(a:A)(b:B)(c:C) = f(a,b,c)
    
    def uncurry3[A,B,C,D](f: A=>B=>C=>D): (A,B,C) => D = {
        (a:A, b:B, c:C) => f(a)(b)(c)
    }



    
    //ZADANIE 3
    def sumProd(xs: List[Int]): (Int, Int) = (xs foldLeft (0, 1))((acc, h) => (acc(0) + h, acc(1) * h))




    //ZADANIE 5
    def insertionsort[A](order: (A,A)=> Boolean, list: List[A]) = {
        def insert(element: A, xs: List[A]): List[A] = 
            xs match {
               case Nil => List(element)
               case h::t => if(order(h, element)) element::xs else h::insert(element, t)
            }
            

        (list foldLeft List[A]())((acc, insertedElement) => insert(insertedElement, acc))
    }
    def order(x: Int, y: Int): Boolean = x < y

    def mergesort[A](order: (A,A)=>Boolean, list: List[A]): List[A] = list match {
    case Nil => Nil
    case xs::Nil => List(xs)
    case _ => {
      def merge(xs: List[A], ys: List[A]): List[A] =
        (xs, ys) match {
          case(Nil, ys) => ys
          case(xs, Nil) => xs
          case(h1 :: t1, h2 :: t2) =>
            if (order(h1, h2)) h1::merge(t1, ys)
            else h2 :: merge(xs, t2)
        }

      val(leftSublist, rightSublist) = list.splitAt(list.length / 2)
      merge(mergesort(order, leftSublist), mergesort(order, rightSublist))
    }
  }
}
