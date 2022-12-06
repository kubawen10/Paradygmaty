//zadanie 1
object list1ScalaEx{
    def main(args: Array[String])={
        val z1 = flatten1(List(List(1,2,3), List(4,5,6)))
        println(z1) 

        val z2 = count(1, List(1,2,3,4,5,3,2,1,1,2,1,1,2))
        println(z2)

        val z3 = replicate(1,5)
        println(z3)

        val z4 = sqrList(List(1,2,3,4))
        println(z4)

        val z5 = palindrome(List(1,2,3,4,3,2,1))
        println(z5)

        val z6 = listLength(List(1,2,3,4,3,2,1))
        println(z6)

    }

    //zadanie 1
    def flatten1[A](xss: List[List[A]]): List[A] = {
        if (xss == Nil) then Nil
        else xss.head ::: flatten1(xss.tail)
    }

    //zadanie 2
    def count[A](x: A, xs: List[A]): Int = {
        if (xs == Nil) then 0
        else if (xs.head == x) then 1 + count(x, xs.tail)
        else 0 + count(x, xs.tail)
    }

    //zadanie 3
    def replicate[A](x: A, n: Int): List[A] = {
        if (n==0) then Nil 
        else List(x) ::: replicate(x,n-1)
    }

    //zadanie 4
    def sqrList(xs: List[Int]): List[Int] = {
        if (xs == Nil) then Nil
        else List( ((x:Int) => x*x)(xs.head) ) ::: sqrList(xs.tail)
    } 

    //zadanie 5
    def palindrome[A](xs:List[A]): Boolean = {
        xs == xs.reverse
    }

    //zadanie 6
    def listLength[A](xs:List[A]): Int = {
        if(xs == Nil) then 0
        else 1 + listLength(xs.tail)
    }
        
}


    



