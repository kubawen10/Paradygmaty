object Hi {
    def main(args: Array[String])={
        val zadanie1 = flatten1(List(List(1,2,3), List(4,5,6)))
        println(zadanie1)

        val zadanie2 = count(1, List(1,2,3,4,1))
        println(zadanie2)

        val zadanie3 = replicate(4, 5)
        println(zadanie3)

        val zadanie4 = sqrList(List(1,2,3))
        println(zadanie4)

        val zadanie5 = palindrome(List(1,2,3,2,1))
        println(zadanie5)

        val zadanie6 = listLength(List(1,2,3,2,1))
        println(zadanie6)
    }

    def flatten1[A](xss: List[List[A]]): List[A] = {
        if xss == Nil  then Nil
        else xss.head ::: flatten1[A] (xss.tail)
    }

    def count[A](x: A, xss: List[A]): Int = {
        if xss == Nil then 0
        else if xss.head == x then (1 + count(x, xss.tail))
        else (0 + count(x, xss.tail) )
    }

    def replicate[A](x: A, n: Int): List[A] = {
        if n == 0 then List()
        else List(x) ::: replicate(x, n-1)
    }

    def sqr(x: Int) = x*x
    def sqrList(xss: List[Int]): List[Int] = {
        if xss == Nil then List()
        else List(sqr(xss.head)) ::: sqrList(xss.tail)
    }

    def palindrome[A](xss: List[A]) = xss == xss.reverse

    def listLength[A](xss: List[A]): Int = {
        if xss == Nil then 0
        else 1 + listLength(xss.tail)
    }

}