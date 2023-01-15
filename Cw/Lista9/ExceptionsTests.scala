object Exceptions:
    //wypisuja sie metody ze stosu które nie zostały ukończone przed wyjątkiem
    def main(args: Array[String])={
        try{
            metoda1()
        }
        catch{
           case e: Exception => {
            println(e.getMessage() + "\n")
            e.printStackTrace()
           }
        }
    }

    def metoda1() = metoda2()

    def metoda2() = metoda3()
    
    def metoda3(): Unit = {
        throw new Exception("Wyjatek z metody3")
    }

