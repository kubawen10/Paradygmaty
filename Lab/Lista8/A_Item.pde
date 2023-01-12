abstract class Item{
  protected Point position;
  protected BoundingBox boundingBox;
  protected boolean displayBoundingBox = true;
  
  void translateItem(Point p){
    position.translatePoint(p);
    boundingBox.translateBoundingBox(p);
  }
  
  Point getPosition(){
    return position;
  }
  
  BoundingBox getBoundingBox(){
    return boundingBox;
  }
  
  abstract void setBoundingBox();
  
  boolean getDisplayBoundingBox(){
    return displayBoundingBox;
  }
  
  void display(){
    if(displayBoundingBox){
      boundingBox.display();
    }
    
    display(new Point(0,0));
  }
  
  abstract void display(Point relative);
}
