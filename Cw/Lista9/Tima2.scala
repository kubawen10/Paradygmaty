class TimeA(private var h: Int, private var m: Int):
    require(0 <= h && h < 24, s"h=$h")
    require(0 <= m && m < 60, s"m=$m")

    def hour: Int = h

    def hour_=(newHour: Int): Unit = {
        require(0 <= newHour && newHour < 24, s"newHour=$newHour")
        h = newHour
    }

    def minute: Int = m

    def minute_=(newMinute: Int): Unit = {
        require(0 <= newMinute && newMinute < 60, s"newMinute=$newMinute")
        m = newMinute
    }

    def before(other: TimeA): Boolean = {
        h < other.h || (h == other.h && m < other.m)
    }


class TimeB(h: Int, m: Int):
    require(0 <= h && h < 24, s"h=$h")
    require(0 <= m && m < 60, s"m=$m")
    private var minutesAfterMidnight = h*60 + m

    def hour: Int = minutesAfterMidnight / 60

    def hour_=(newHour: Int): Unit = {
        require(0 <= newHour && newHour < 24, s"newHour=$newHour")
        minutesAfterMidnight = newHour*60 + minute
    }

    def minute: Int = minutesAfterMidnight % 60

    def minute_=(newMinute: Int): Unit = {
        require(0 <= newMinute && newMinute < 60, s"newMinute=$newMinute")
        minutesAfterMidnight = hour + newMinute
    }

    def before(other: TimeB): Boolean = {
        minutesAfterMidnight < other.minutesAfterMidnight
    }


object Tests:
    def main(args: Array[String])={
        val t1: TimeA = new TimeA(6, 30)
        val t2: TimeA = new TimeA(8, 30)

        println(t1.before(t2))

        val t3: TimeB = new TimeB(6, 30)
        val t4: TimeB = new TimeB(5, 30)

        println(t3.before(t4))
    }
