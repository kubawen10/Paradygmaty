object cw5Scala{
    def main(args: Array[String]) = {
        //zadanie 2
        val lfib = {
            def fibgen(a: Int, b: Int): Stream[Int] = a #:: fibgen(b, a + b)
            fibgen(1, 1)
        }

        println(lfib.take(5).toList)

        println(lrepeat(3)(LazyList.from(1)).take(15).toList)


    }

    //zadanie 1
    def lrepeat[A](k: Int)(llst: LazyList[A]): LazyList[A] = {
        def inner(n: Int)(lst: LazyList[A]): LazyList[A] = {
            (n, lst) match {
                case(0, h#::t) => inner (k) (t)
                case(x, h#::t) => h #:: inner (x-1) (lst)
                case(_) => LazyList()
            }
        }
        inner(k)(llst)
    }
}