module type B_TREE_TYPE = sig 
  type 'a bt = Empty | Node of 'a * 'a bt * 'a bt
  val add: 'a bt -> 'a -> 'a bt
  val remove: 'a bt -> 'a -> 'a bt
  val preorder: 'a bt -> 'a list
  val inorder: 'a bt -> 'a list
  val postorder: 'a bt -> 'a list
  val leaves: 'a bt -> 'a list 
end;;

module BTree: B_TREE_TYPE = struct 
  type 'a bt = Empty | Node of 'a * 'a bt * 'a bt

  let add binaryTree x = 
    (*znajdz pierwszy Empty, idz po kolejnych poziomach*)
    let rec findPlace nodeNumber subTreeQueue = 
      match subTreeQueue with  
      [] -> failwith "Error"
      |h::t -> 
        match h with 
        Empty -> nodeNumber
        |Node(v, Empty, r) -> nodeNumber * 2
        |Node(v, l, Empty) -> (nodeNumber * 2 + 1)
        |Node(v, l, r) ->  findPlace (nodeNumber + 1) (t @ [l; r])
    in

    (*wstaw na danej pozycji x, pozycje od 1, kolejno poziomami*)
    let rec insert tree x nodeNumberToInsertTo currentNodeNumber = 
      if nodeNumberToInsertTo = currentNodeNumber then Node(x, Empty, Empty) 
      else 
        match tree with 
        Node(v, l, r) -> Node(v, insert l x nodeNumberToInsertTo (currentNodeNumber * 2), insert r x nodeNumberToInsertTo (currentNodeNumber * 2 + 1))
        |Empty -> Empty
    in

    insert binaryTree x (findPlace 1 [binaryTree]) 1

  let remove binaryTree x =
    (*znajdz najglebszy i najbardziej z prawej; ustaw usuwana wartosc na wartosc ostatnia; usun ostatni node*)
    
    (*ta funkcja jest potrzebna zeby nie usunac ostatniego elementu gdy drzewo nie zawiera x*)
    let rec contains tree value = 
      match tree with 
      Empty -> false 
      |Node(v,l,r) when (v = value) -> true
      |Node(v,l,r) -> (contains l value || contains r value)
    in 

    (*funkcja znajduje najglebszy, najbardziej prawy element*)
    let rec findLastNodeValue queue acc = 
      match queue with 
      [] -> acc (*gdy lista jest pusta bylismy w najnizszym prawym nodzie drzewa*)
      |h::t -> 
        match h with 
        Node(v, Empty, Empty) -> findLastNodeValue t (Option.some v) (*tylko najnizszy node moze byc ostatni*)
        |Node(v, l, r) -> findLastNodeValue (t @ [l; r]) (Option.some v)
        |Empty -> findLastNodeValue t acc
    in

    (*sprawdzam czy modified bo gdy drzewo ma wiecej takich samych wartosci moze zmodyfikowac je wszystkie*)
    let rec changeValue tree fromValue toValue modified = 
      match tree with 
      Node(v, l, r) when (v = fromValue && modified = false) -> Node(toValue, changeValue l fromValue toValue true, changeValue r fromValue toValue true)
      |Node(v, l, r) -> Node(v, changeValue l fromValue toValue modified, changeValue r fromValue toValue modified)
      |Empty -> Empty
    in

    (*znajduje pozycje ostatniego node, tak jak przy add szukalem pierwszego empty, nie moge uzyc kolejki bo gdy drzewo jest nieregularne niekoniecznie dostane dobra liczbe robiac +1*)
    let rec findLastNodePosition tree acc = 
      let greater x y = if x > y then x else y in

      match tree with  
      Empty -> 0
      |Node(v, Empty, Empty) -> acc
      |Node(v, l, Empty) -> findLastNodePosition l (acc * 2)
      |Node(v, Empty, r) -> findLastNodePosition r (acc * 2 + 1)
      |Node(v, l, r) ->  greater (findLastNodePosition l (acc * 2)) (findLastNodePosition r (acc * 2 + 1))
    in

    (*usuwam z danej pozycji node*)
    let rec removeNodeFromPosition tree position curPosition = 
      match tree with 
      Node(_) when position = curPosition -> Empty
      |Node(v, l, r) -> Node(v, removeNodeFromPosition l position (curPosition * 2), removeNodeFromPosition r position (curPosition * 2 + 1))
      |Empty -> Empty 
    in

    let containsX = contains binaryTree x
    in
    match containsX with 
    false -> binaryTree (*jezeli nie zawiera, zwracam to samo drzewo*)
    |_ -> 
      let lastVal = findLastNodeValue [binaryTree] Option.None in (*dolna prawa wartosc*)
      let tempTree = changeValue binaryTree x (Option.get lastVal) false in (*zamieniam pierwszy x z lastVal, last val nie bedzie Node bo containsX eliminuje przypadek Empty*)
      
      let lastNodePosition = findLastNodePosition tempTree 1 in (*usuwam dolny prawy node*)
      removeNodeFromPosition tempTree lastNodePosition 1

  let rec preorder binaryTree = 
    match binaryTree with 
    Node(v,l,r) -> v :: (preorder l) @ (preorder r)
    |Empty -> []

  let rec inorder binaryTree = 
    match binaryTree with 
    Node(v,l,r) -> (inorder l) @ [v] @ (inorder r)
    |Empty -> []

  let rec postorder binaryTree = 
    match binaryTree with 
    Node(v,l,r) -> (postorder l) @ (postorder r) @ [v]
    |Empty -> []

  let rec leaves binaryTree = 
    match binaryTree with 
    Empty -> [] 
    |Node(v, Empty, Empty) -> [v]
    |Node(v, l, Empty) -> leaves l
    |Node(v, Empty, r) -> leaves r
    |Node(v,l,r) -> leaves l @ leaves r

end;;

