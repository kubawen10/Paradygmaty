class Segment extends Primitive{
  private Point p1;
  private Point p2;
  
  Segment(Point p1, Point p2){
    int minX = min(p1.getX(), p2.getX());
    int minY = min(p1.getY(), p2.getY());
    this.position = new Point(minX, minY);
    
    this.p1 = p1;
    this.p2 = p2;
    
    setBoundingBox();
  }
  
  void setBoundingBox(){
    int minX = position.getX();
    int minY = position.getY();
    
    int maxX = max(p1.getX(), p2.getX());
    int maxY = max(p1.getY(), p2.getY());
    
    Point p1 = new Point(minX, minY);
    Point p2 = new Point(maxX, minY);
    Point p3 = new Point(maxX, maxY);
    Point p4 = new Point(minX, maxY);
    
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  void translateItem(Point p){
    super.translateItem(p);
    
    p1.translatePoint(p);
    p2.translatePoint(p);
  }
  
  float getLength(){
    return sqrt(pow(p1.getX() - p2.getX(), 2)+pow(p1.getY() - p2.getY(), 2));
  }
  
  Point getStart(){
    return p1;
  }
  
  Point getEnd(){
    return p2;
  }
  
  void display(Point relative){
    line(relative.getX()+p1.getX(), relative.getY()+p1.getY(), relative.getX()+p2.getX(), relative.getY()+p2.getY());
  }
}
