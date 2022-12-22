class Rect extends Shape{
  private int w;
  private int h;
  
  public Rect(Point position, int w, int h){
    this.position = position;
    this.w = w;
    this.h = h;
    filled = false;
    this.c = color(0,255,0);
    setBoundingBox();
  }
  
  @Override
  protected void setBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + w, position.getY());
    Point p3 = new Point(position.getX() + w, position.getY() + h);
    Point p4 = new Point(position.getX(), position.getY() + h);
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  public int getWidth(){
    return w;
  }
  
  public int getHeight(){
    return h;
  }
  
  @Override
  public void drawItem(){
    super.drawItem();
    
    rect(position.getX(), position.getY(), w, h);
  }
}
