abstract class Item{
  protected Point position;
  protected BoundingBox boundingBox;
  
  public Point getPosition(){
    return position;
  }
  
  public void translateItem(Point p){
    position.translatePoint(p);
    boundingBox.translateBoundingBox(p);
  }
  
  public BoundingBox getBoundingBox(){
    return boundingBox;
  }
  
  protected abstract void setBoundingBox();
  
  public abstract void drawItem();
}
