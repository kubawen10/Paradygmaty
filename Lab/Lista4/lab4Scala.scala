object list4Scala
{
    def main(args: Array[String]) = {
        val z4 = avg(List(1,2,3,4,5,6)) //3.5
        println(z4)
        val z5 = acronym("Prawo i Sprawiedliwosc") //"PiS"
        println(z5)
        val z6 = listSquaredIfCubeNotGreaterThanListSum(List(1,2,3,4,5,12)) //[1,4,9]
        println(z6)
    }

    //zadanie 1 MAP
    def map[A](list: List[A], f: A=>A): List[A] = 
        list match {
            case Nil => Nil
            case h::t => f(h) :: map(t,f)
        }


    //zadanie 2 FILTER
    def filter[A](list: List[A], pred: A=>Boolean): List[A] =
        list match {
            case Nil => Nil
            case h::t => if pred(h) then h::filter(t, pred) else filter(t,pred)
        }

    //zadanie 3 REDUCE
    def reduce[A](list: List[A], op: (A, A)=>A, acc: A): A = 
        list match {
            case Nil => acc
            case h::t => reduce(t, op, op(acc, h))
        }

    //zadanie 4 SREDNIA
    def avg(list: List[Int]): Double = {
        val sum = listIntSum(list)
        def listLengthTail(l: List[Int], acc: Int): Int = 
            l match {
                case Nil => acc
                case h::t => listLengthTail(t, acc+1)
            }
        
        sum.toDouble / listLengthTail(list, 0) 
    }

    //zadanie 5 ACRONYM
    def acronym(str: String): String = {
        val splitted = str.split(" ").toList
        val firstLetters = map(splitted, (x: String) => x.charAt(0).toString())

        reduce(firstLetters, (x: String, y: String) => x + y, "")
    }

    //zadanie 6
    def listSquaredIfCubeNotGreaterThanListSum(list: List[Int]): List[Int] = {
        val sum = listIntSum(list)
        def xCubedNotGreaterThanListSum(x: Int): Boolean = x*x*x <= sum

        val filtered = filter(list, xCubedNotGreaterThanListSum)
        map(filtered, (x: Int)=> x*x)
    }

    def listIntSum(list: List[Int]): Int = {
        reduce(list, (x: Int, y: Int)=> x+y, 0)
    }
}