import scala.annotation.tailrec

object list3ScalaLab
{
    def main(args: Array[String]) = {
        val z1 = lastElement(List(1,2,3,4))
        //println(z1)

        val z2 = lastTwoElements(List(1,2,3,4,5))
        //println(z2)

        val z3 = listLength(List(1,2,3))
        //println(z3)

        val z4 = reverse(List(1,2,3))
        //println(z4)

        val z5 = palindrome(List(1,2,3,2,1))
        //println(z5)

        val z6 = deleteDuplicates(List(1,2,3,4,2,1))
        //println(z6)

        val z7 = evenIndexes(List(1,2,3,4,5,6,7))
        //println(z7)

        val z8 = isPrime(30)
        //println(z8)
    }

    //zadanie 1
    def lastElement[A](list: List[A]): Option[A] = 
        list match {
            case Nil => None
            case h::Nil => Option(h)
            case h::t => lastElement(t)
        }

    //zadanie 2
    def lastTwoElements[A](list: List[A]): Option[List[A]] = 
        list match {
            case Nil | List(_) => None
            case List(x,y) => Option(list)
            case h::m::t => lastTwoElements(m::t)
        }

    //zadanie 3
    def listLength[A](list: List[A]): Int = 
        list match {
            case Nil => 0
            case h :: t => 1 + listLength(t)
        }

    //zadanie 4
    def reverse[A](list: List[A]): List[A] = 
        list match {
            case Nil => Nil
            case h :: t => reverse(t) ::: List(h)
        }

    //zadanie 5
    def palindrome[A](list: List[A]) = list == reverse(list)

    //zadanie 6
    def deleteDuplicates[A] (list: List[A]): List[A] = {
        def isInList[A](x: A, list: List[A]): Boolean =
            list match {
                case Nil => false
                case h::t => 
                    {if (h==x) then true
                    else isInList(x, t)}
                
            }

        @tailrec //?
        def innerDeleteDuplicates[A](output: List[A], list: List[A]): List[A] = 
            list match {
                case Nil => output
                case h :: t => 
                    if (isInList(h, output)) then innerDeleteDuplicates(output, t)
                    else innerDeleteDuplicates(output ::: List(h), t)
                
            }

        innerDeleteDuplicates(Nil, list)
    }

    //zadanie 7
    def evenIndexes[A] (list: List[A]): List[A] = {
        def innerEvenIndexes[A](output: List[A], list: List[A], counter: Int): List[A] = 
            list match {
                case Nil => output
                case h::t =>
                    if (counter % 2 == 0) then innerEvenIndexes(output ::: List(h), t, counter + 1)
                    else innerEvenIndexes(output, t, counter + 1)
            }

        innerEvenIndexes(Nil, list, 1)
    }

    //zadanie 8
    def isPrime(x: Int): Boolean ={
        def innerPrime(x: Int, k: Int): Boolean = {
            if (x%k != 0 && k*k <= x) then innerPrime(x, k+2)
            else 
                k*k > x
        }

        (x % 2 != 0) && (x >= 2) && innerPrime(x, 3)
    }
}
