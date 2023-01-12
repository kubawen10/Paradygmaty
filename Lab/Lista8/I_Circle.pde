class Circle extends Shape{
  private int radius;
  
  Circle(Point center, int radius){
    center.translatePoint(new Point(-radius, -radius));
    this.position = center;
    this.radius = radius;
    this.c = color(0,0,255);
    setBoundingBox();
  }
  
  void setBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + (2*radius), position.getY());
    Point p3 = new Point(position.getX() + (2*radius), position.getY() + (2*radius));
    Point p4 = new Point(position.getX()             , position.getY() + (2*radius));
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  int getRadius(){
    return radius;
  }
  
  void display(Point relative){
    super.display(relative);
    
    circle(relative.getX() + position.getX() + radius, relative.getY() + position.getY() + radius, radius*2);
  }
}
