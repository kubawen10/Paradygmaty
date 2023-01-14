import scala.collection.mutable.Seq
def copy[T](dest: Seq[T], src: Seq[T]): Unit = {
    require(dest.length >= src.length)
    var index = 0

    src.foreach(i => dest.update(index++, i))
}