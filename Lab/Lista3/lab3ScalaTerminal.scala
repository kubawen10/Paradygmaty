import scala.annotation.tailrec

//zadanie 1
@tailrec
def lastElement[A](list: List[A]): Option[A] = 
    list match {
        case Nil => None
        case h::Nil => Option(h)
        case h::t => lastElement(t)
    }

//zadanie 2
@tailrec
def lastTwoElements[A](list: List[A]): Option[List[A]] = 
    list match {
        case Nil | List(_) => None
        case List(x,y) => Option(list)
        case h::t => lastTwoElements(t)
    }

//zadanie 3
def listLength[A](list: List[A]): Int = 
    @tailrec
    def innerListLength[A](list: List[A], len: Int): Int =
        list match {
        case Nil => len
        case h :: t => innerListLength(t, len+1)
        }
    innerListLength(list, 0)

    

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

    @tailrec
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
    @tailrec
    def innerEvenIndexes[A](output: List[A], list: List[A], counter: Int): List[A] = 
        list match {
            case Nil => output
            case h::t =>
                if (counter % 2 == 0) then innerEvenIndexes(output ::: List(h), t, counter + 1)
                else innerEvenIndexes(output, t, counter + 1)
        }

    innerEvenIndexes(Nil, list, 0)
}

//zadanie 8
def isPrime(x: Int): Boolean ={
    @tailrec
    def innerPrime(x: Int, k: Int): Boolean = {
        if (x%k != 0 && k*k <= x) then innerPrime(x, k+2)
        else 
            k*k > x
    }

    (x % 2 != 0) && (x >= 2) && innerPrime(x, 3)
}