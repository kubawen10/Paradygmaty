class Time(private var h: Int){
    if (h<0) h = 0

    def hour: Int = h
    def hour_=(x: Int): Unit = {
        if (x < 0) h = 0
        else h = x
    }
}

object Tests{
    def main(args: Array[String])={
        val t: Time = new Time(1)

        println(t.hour)
        t.hour = 8
        println(t.hour)
    }
}
