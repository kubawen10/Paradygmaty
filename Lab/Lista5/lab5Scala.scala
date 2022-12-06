import scala.math.sqrt
import scala.math.Pi
import scala.annotation.tailrec

object list5ScalaLab{
    

    def main(args: Array[String]) = {

        //ZADANIE 1
        val p1: Point2D = (1, 1)
        val p2: Point2D = (2, 2)

        println(distance(p1,p2))

        val p11: PointND = List(1,1,1)
        val p21: PointND = List(1,1,1)

        println(distanceND(p11,p21))


        //ZADANIE 2
        val person1T: PersonT = ("Jakub", "Wengrzyn", 20)
        val person2T: PersonT = ("Jan", "Wengrzyn", 10)

        val partnershipT: PartnershipT = (person1T, person2T)

        val youngerT = getYoungerPersonT(partnershipT)
        println(youngerT)

        val person1N = PersonN("Jakub", "Wengrzyn", 10)
        val person2N = PersonN("Jan", "Wengrzyn", 20)

        val partnershipN = PartnershipN(person1N, person2N)
        val youngerN = partnershipN.getYoungerPersonN()

        println(youngerN)

        println(partnershipN)
        person1N.name = "zmiana"
        println(partnershipN)


        //ZADANIE 3
        println(weekDayToString(WeekDay.Monday))

        val next = nextWeekDay(WeekDay.Monday)
        println(weekDayToString(next))
        
        //ZADANIE 4
        val l = List(1)
        val aa = safeHead(l)
        println(aa)

        //ZADANIE 5 
        val cube = SolidFigure.Cuboid(2,2,2)
        val vol = volume(cube)
        println(vol)
        
        val cylinder = SolidFigure.Cylinder(1, 1)
        val cylVol = volume(cylinder)
        println(cylVol)
    }
    
    //ZADANIE 1
    type Point2D = (Float, Float)
    type PointND = List[Float]
    def distance(p1: Point2D, p2: Point2D): Float = {
        val (x1, y1) = p1
        val (x2, y2) = p2

        sqrt((x1 - x2) * (x1 - x2)  + (y1 - y2) * (y1 - y2)).toFloat
    }

    def distanceND(p1: PointND, p2: PointND): Float = {
        @tailrec
        def sumDifSqr(p1: PointND, p2: PointND, acc: Float): Float = {
            (p1, p2) match {
                case (Nil, Nil) => acc
                case (h1 :: t1, h2 :: t2) => sumDifSqr(t1, t2, acc + ((h1 - h2) * (h1 - h2)))
                case _ => -1.0
            }
        }

        if(p1.length == p2.length) then sqrt(sumDifSqr(p1, p2,  0)).toFloat else -1.0
    }

    

    //ZADANIE 2
    type PersonT = (String, String, Float)
    type PartnershipT = (PersonT, PersonT)

    def getYoungerPersonT(p: PartnershipT): PersonT = {
        val (p1, p2) = p

        val (_, _, age1) = p1
        val (_, _, age2) = p2

        if (age1 < age2) then p1 else p2
    }


    class PersonN(var name: String, var surname: String, var age: Int):
        override def toString(): String = s"$name $surname $age"
    end PersonN

    class PartnershipN(var person1: PersonN, var person2: PersonN):
        def getYoungerPersonN(): PersonN = 
            if person1.age < person2.age then person1 else person2

        override def toString(): String = s"$person1 - $person2"
    end PartnershipN 


    //ZADANIE 3
    enum WeekDay:
        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday

    def weekDayToString(weekDay: WeekDay): String = 
        weekDay match {
            case WeekDay.Monday => "Poniedzialek"
            case WeekDay.Tuesday => "Wtorek"
            case WeekDay.Wednesday => "Sroda"
            case WeekDay.Thursday => "Czwartek"
            case WeekDay.Friday => "Piatek"
            case WeekDay.Saturday => "Sobota"
            case WeekDay.Sunday=> "Niedziela"
        }

    def nextWeekDay(weekDay: WeekDay): WeekDay = {
        val nextWeekDayNumber = (weekDay.ordinal + 1 ) % 7
        WeekDay.fromOrdinal(nextWeekDayNumber)
    }


    //ZADANIE 4
    enum Maybe[+T]:
        case Just(x: T)
        case Nothing

    def safeHead[T](list: List[T]): Maybe[T] = 
        list match {
            case Nil => Maybe.Nothing
            case h::t => Maybe.Just(h)
        }

    //ZADANIE 5
    enum SolidFigure:
        case Cuboid(width: Float, length: Float, height: Float)
        case Cone(radius: Float, height: Float)
        case Sphere(radius: Float)
        case Cylinder(radius: Float, height: Float)

    def volume(figure: SolidFigure): Float = 
        figure match{
            case SolidFigure.Cuboid(width: Float, length: Float, height: Float) => width * length * height
            case SolidFigure.Cone(radius: Float, height: Float) => (1.0/3.0).toFloat * Pi.toFloat * radius * radius * height
            case SolidFigure.Sphere(radius: Float) => (4.0/3.0).toFloat * Pi.toFloat * radius * radius * radius
            case SolidFigure.Cylinder(radius: Float, height: Float) => Pi.toFloat * radius * radius * height
        }
        
}