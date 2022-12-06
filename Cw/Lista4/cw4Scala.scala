import scala.collection.mutable.Queue

object cw4Scala{
    def main(args: Array[String]) =
    {
        val tree = Node(1, 
                  Node(2, 
                      Node(4, 
                          Empty, 
                          Empty), 
                      Empty), 
                  Node(3, 
                      Node(5,
                          Empty,
                          Node(6,
                              Empty,
                              Empty)),
                      Empty))
        val b = breadthBT(tree)
        println(b)

        val id = internalDepth(tree)
        println(id)

        val ed = externalDepth(tree)
        println(ed)

        val g = Graph((i: Int) =>
            i match
            case 0 => List(3)
            case 1 => List(0, 2, 4)
            case 2 => List(1)
            case 3 => Nil
            case 4 => List(0, 2)
            case n => throw new Exception(s"Graph g: node $n doesn't exist")
            )
        val dfs = depthSearch(g, 1)
        println(dfs)




    }
    sealed trait BT[+A]
    case object Empty extends BT[Nothing]
    case class Node[+A](elem: A, left: BT[A], right: BT[A]) extends BT[A]

    //ZADANIE 3
    def breadthBT[A](bt: BT[A]): List[A] = {
        def iterate(queue: List[BT[A]], acc: List[A]):List[A] = 
            queue match {
                case Nil => acc.reverse
                case h::t => h match {
                    case Empty => iterate(t,acc)
                    case Node(v,l,r) => iterate(t ::: List(l,r), v::acc)

                }
            }

        iterate (List(bt), Nil)
    }

    //ZADANIE 4a
    def internalDepth[A](tree: BT[A]): Int = {
        def innerInternalDepth(t: BT[A], depth: Int): Int = 
            t match {
                case Empty => 0
                case Node(e, l, r) => depth + innerInternalDepth(l, depth + 1) + innerInternalDepth(r, depth + 1) 
            }
        innerInternalDepth(tree, 0)
    }

    //ZADANIE 4b
    def externalDepth[A](tree: BT[A]): Int = {
        def innerExternalDepth(t: BT[A], depth: Int): Int = 
            t match {
                case Empty => depth
                case Node(e, l, r) => innerExternalDepth(l, depth + 1) + innerExternalDepth(r, depth + 1) 
            }

        innerExternalDepth(tree, 0)
    }

    //ZADANIE 5
    sealed trait Graphs[A]
    case class Graph[A](succ: A=>List[A]) extends Graphs[A]

    def depthSearch[A](graph: Graph[A], startNode: A): List[A] = {
        def search(visited: List[A], stack: List[A]): List[A] = 
            stack match {
                case Nil => Nil
                case h::t => 
                    if visited.contains(h) then search(visited, t)
                    else h :: search(h::visited, (graph succ h) ::: stack)
            }
        search(Nil, List(startNode))

    }


}