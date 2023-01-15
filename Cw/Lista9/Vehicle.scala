class Vehicle(private val producent: String, private val model: String, private val year: Int = -1, private var plate: String = ""):
    override def toString(): String = s"Producent: $producent, Model: $model, Year: $year, Plate: $plate"



object Tests:
    def main(args: Array[String])={
        val v: Vehicle = new Vehicle("BMW", "E36", 3)
        println(v)
    }
