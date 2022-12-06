import scala.collection.mutable.HashMap
object lab6Scala{
    def main(args: Array[String]) = { 
        val s1 = stirling(10,2)
        val s2 = memoized_stirling(10,2)
        println(s1)
        println(s2) 

        lazy val x = stirling (100, 25)
        //println(x)

    }

    //1a
    def stirling(n: Int, m: Int): Int = 
        (n, m) match {
        case (n, m) if (n == m || m == 1) => 1
        case (n, m) => stirling (n - 1, m - 1) + m * stirling (n - 1, m)
        }

    //1b
    def memoized_stirling(n: Int, m: Int): Int = {
        val table: HashMap[(Int, Int), Int] = HashMap.empty[(Int, Int), Int]
        def inner_memoized_stirling(n: Int, m: Int): Int = 
            table.get((n,m)) match {
                case Some(x) => x
                case None => 
                    val result = (n, m) match {
                        case (n, m) if (n == m || m == 1) => 1
                        case (n, m) => inner_memoized_stirling(n-1, m-1) + m * inner_memoized_stirling(n-1, m)
                    } 
                    table.addOne(((n,m), result))
                    result
            }

        inner_memoized_stirling(n,m)
    }

    def make_memoize[A,B](f: A => B): A => B = {
        val table: HashMap[A,B] = HashMap.empty[A,B]
            
        (x: A) => table.get(x) match {
                case Some(value) => value
                case None => {
                    val result = f(x)
                    table.addOne((x, result))
                    result
                }
            }
    } 

    def fib (x: Int): Int =
    x match {
        case 0 => 0
        case 1 => 1
        case x => fib(x - 1) + fib(x - 2)
    }



    
}
