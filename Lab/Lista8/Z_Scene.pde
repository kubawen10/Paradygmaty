class Scene implements SceneInterface{
  private ArrayList<Item> items;
  
  Scene(){
    items = new ArrayList<Item>();
  }
  
  void addItem(Item item){
   items.add(item); 
  }

  ArrayList<Item> getItems(){
    return items;
  }
  
  void display(){
    background(255);
    for(int i = 0; i < items.size(); i++){
      items.get(i).display();
    }
  }
}
