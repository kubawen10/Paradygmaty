class Time(private var h: Int){
    if (h<0) h = 0

    def hour: Int = h
    def hour_=(x: Int) = {
        if (x < 0) h = 0
        else h = x
    }
}
