class Circle extends Shape{
  private int radius;
  
  public Circle(Point position, int radius){
    this.position = position;
    this.radius = radius;
    filled = false;
    this.c = color(0,0,255);
    setBoundingBox();
  }
  
  @Override
  protected void setBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + (2*radius), position.getY());
    Point p3 = new Point(position.getX() + (2*radius), position.getY() + (2*radius));
    Point p4 = new Point(position.getX(), position.getY() + (2*radius));
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  public int getRadius(){
    return radius;
  }
  
  @Override
  public void drawItem(){
    super.drawItem();
    
    circle(position.getX(), position.getY(), radius);
  }
}
