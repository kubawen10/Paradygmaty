object zadanie1i2{
    def main(args: Array[String])={

        //zadanie 1
        var count = 0      
        //whileLoop(count<) ({println(count); count = count + 1})

        //zadanie 2
        val t1 = new Array[Int](10)
        t1(0) = 27
        t1(1) = 132
        t1(2) = 3
        t1(3) = 237
        t1(4) = -15
        t1(5) = 0
        t1(6) = -81
        t1(7) = 333
        t1(8) = 92
        t1(9) = 69

        quicksort(t1)

        count = 0
        whileLoop(count < t1.length) ({println(t1(count)); count +=1})

    }

    //zadanie 1
    def whileLoop(condition: => Boolean) (expression: => Unit): Unit = {
        if(condition) {
            expression 
            whileLoop(condition)(expression)
        }
    }

    //zadanie 2a
    def swap(tab: Array[Int], i: Int, j: Int): Unit = {
        val aux = tab(i)
        tab(i) = tab(j)
        tab(j) = aux
    }

    def choosePivot(tab: Array[Int], m: Int, n: Int): Int = {
        tab((m+n)/2)
    } 

    //zadanie 2b
    def partition(tab: Array[Int], l: Int, r: Int): (Int, Int) = {
        var i = l
        var j = r
        var pivot = choosePivot(tab, l, r)

        while(i<=j){
            while(tab(i)<pivot) {
                i+=1
            }

            while(pivot < tab(j)){
                j-=1
            }

            if(i<=j){
                swap(tab, i, j)
                i+=1
                j-=1
            }
        }

        (i, j)
    }

    def quick(tab: Array[Int], l: Int, r: Int): Unit = {
        if(l<r){
            val (i,j) = partition(tab, l, r)
            if(j-l < r-i){
                quick(tab, l, j)
                quick(tab, i, r)
            }
            else {
                quick(tab, i, r)
                quick(tab, l, j)
            }
        }else ()
    }

    def quicksort(tab: Array[Int]): Unit = {
        quick(tab,0, tab.length - 1)
    }
}