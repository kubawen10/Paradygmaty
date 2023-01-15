class ComplexItem extends Item{
  private ArrayList<Item> items;
  
  ComplexItem(Point position){
    this.position = position;
    items = new ArrayList<Item>();
    computeBoundingBox();
  }
  
  void computeBoundingBox(){
    boundingBox = null;
  }
  
  void addItem(Item item){
    item.getBoundingBox().translateBoundingBox(position);
    items.add(item);
    
    if(boundingBox != null){
      boundingBox.enlarge(item.getBoundingBox());
    } else if(item.getBoundingBox() != null) {
      boundingBox = new BoundingBox(item.getBoundingBox());
    }
  }
  
  void translateItem(Point p){
    boundingBox.translateBoundingBox(p);
    
    for(int i = 0; i<items.size(); i++){
      items.get(i).translateItem(p);
    }
  } 
  
  void display(Point relative){
    for(int i = 0; i<items.size(); i++){
      (items.get(i)).display(position.sum(relative)); 
    }
  }
}
