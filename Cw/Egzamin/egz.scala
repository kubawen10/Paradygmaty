object egz{
    def main(args: Array[String])={
        println(f(List(1,2) :: List(1)))


    }

    def f(list: Any) = list match {
        case a::b::Nil => true
        case _ => false
    }
}