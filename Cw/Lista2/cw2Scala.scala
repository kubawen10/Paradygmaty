import scala.annotation.tailrec
import scala.math.pow
import scala.math.abs

object cw2Scala{
    def main(args: Array[String]) = {
        //      ZADANIE 1 
        //W scali 4 bo nie optymalizuje jako ogonowa rekursja przez JVM
        //nie optymalizuje bo jest to rekursja do funkcji o innej nazwie
        //w ocaml 1 bo optyymalizuje



        //      ZADANIE 2
        //      A)
        //val fib1 = fib(42) //9s
        //println(fib1)

        lazy val fibFun: Int => Int = n => {
            if(n == 0) then 0
            else if (n==1) then 1
            else fibFun(n-1) + fibFun(n-2)
        }
        //val fib2 = fibFun(5)
        //println(fib2)

        //      B)
        //val fibTail1 = fibTail(42) //3s
        //println(fibTail1)

        val fibTTailFun: Int => Int = n => {
            lazy val innerFibTail: (Int, Int, Int) => Int = (n1, n2, counter) => {
                if(counter == n) then n1 + n2 
                else innerFibTail(n2, n1 + n2, counter + 1)
            }
                
            if(n == 0) then 0
            else if (n==1) then 1
            else innerFibTail(0, 1, 2) 
        }
        val fibTail2 = fibTTailFun(5)
        //println(fibTail2)


        //      ZADANIE 3
        //val r3 = root3(8)
        //println(r3)

        val root3Fun: Double => Double = a => {
            val x0 = if(a>1) then a/3 else a

            lazy val root3Tail: Double => Double = xi => {
                if(abs(pow(xi, 3) - a) <= (pow(10, -15) * abs(a))) then xi
                else root3Tail(xi + (( (a / pow(xi, 2)) - xi )/3))
            }

            root3Tail(x0)
        }
        val r3F = root3Fun(8)
        //println(r3F)


        //      ZADANIE 4 w terminalu widac
        //      A)
        val List(_,_,x,_,_) = List(-2,-1,0,1,2)
        //      B)
        val List((_,_),(x1,_)) = List((1,2),(0,1))



        //      ZADANIE 5
        val isInit = initSegment(List(2), List(1,2,3,4))
        //println(isInit)

        val z6 = replaceNth(List(1,2,3,4,5), 6, 8)
        println(z6)


    }


    //      ZADANIE 2
    //      A)
    def fib(n: BigInt): BigInt = {
        if(n == 0) then 0
        else if (n==1) then 1
        else fib(n-1) + fib(n-2)
    }    

    //      B)
    def fibTail(n: BigInt): BigInt ={
        @tailrec
        def innerFibTail(n1: BigInt, n2: BigInt, counter: Int): BigInt =
            if(counter == n) then n1 + n2 
            else innerFibTail(n2, n1 + n2, counter + 1)
        
        if(n == 0) then 0
        else if (n==1) then 1
        else innerFibTail(0, 1, 2) 
    }
        


    //      ZADANIE 3
    // root3 using Newton-Raphson method
    def root3(a: Double): Double = {
        @tailrec
        def root3Tail(xi: Double): Double = 
            if( abs(pow(xi, 3) - a) <= (pow(10, -15) * abs(a))) then xi
            else root3Tail(xi + (( (a / pow(xi, 2)) - xi )/3))

        if(a>1) then root3Tail(a/3) else root3Tail(a)
    }

    //      ZADANIE 5
    def initSegment[A](xs: List[A], ys: List[A]): Boolean = 
        (xs, ys) match {
            case (Nil, _) => true
            case (_, Nil) => false
            case (h1::t1, h2::t2) => if h1==h2 then initSegment(t1, t2) else false
        }

    //      ZADANIE 6
    def replaceNth[A](xs: List[A], n: Int, x: A): List[A] = 
        xs match {
            case h::t => if n == 0 then x::t else h::replaceNth(t, n-1, x)
            case Nil => Nil
        }
}



