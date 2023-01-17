class Scene{
  private ArrayList<Item> items;
  
  Scene(){
    items = new ArrayList<Item>();
  }
  
  void addItem(Item item){
    boolean added = false;
    if(item instanceof Singleton){
      println("Adding new instance");
      added = changeIfInstanceExists(item);
    }

    if(!added){
      items.add(item); 
    }
  }

  private boolean changeIfInstanceExists(Item singletonItem){
    for(int i = 0; i < items.size(); i++){
      if(singletonItem.getClass().equals(items.get(i).getClass())){
        println("found");
        items.set(i, singletonItem);
        return true;
      }
    }
    println("Not found");
    return false;
  }
  
  void display(){
    background(255);
    for(int i = 0; i < items.size(); i++){
      items.get(i).display();
    }
  }
}
