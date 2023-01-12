class Triangle extends Shape{
  private Point p1;
  private Point p2;
  private Point p3;
  
  Triangle(Point p1, Point p2, Point p3){
    if(areaIs0(p1,p2,p3)){
      throw new IllegalArgumentException("Points are collinear!");
    }
    
    this.position = findTopLeftBB(p1,p2,p3);
    
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    
    this.c = color(255,0,0);
    
    setBoundingBox();
  }
  
  // if area is 0 then points are on the same line or we have 2 identical coordinates
  private boolean areaIs0(Point p1, Point p2, Point p3){
    return (((p2.getX()-p1.getX()) * (p3.getY()-p1.getY())) - ((p3.getX()-p1.getX()) * (p2.getY()-p1.getY()))) == 0; 
  }
  
  //method to find top left corner of a boundingbox, its also this.position
  private Point findTopLeftBB(Point p1, Point p2, Point p3){
    int minX = min(p1.getX(), min(p2.getX(), p3.getX()));
    int minY = min(p1.getY(), min(p2.getY(), p3.getY()));
    
    return new Point(minX, minY);
  }
  
  //method to find bottom right corner of a boundingbox
  private Point findBottomRightBB(Point p1, Point p2, Point p3){
    int maxX = max(p1.getX(), max(p2.getX(), p3.getX()));
    int maxY = max(p1.getY(), max(p2.getY(), p3.getY()));
    
    return new Point(maxX, maxY);
  }
  
  void setBoundingBox(){
    Point topLeft = findTopLeftBB(p1,p2,p3);
    Point bottomRight = findBottomRightBB(p1,p2,p3);
    
    int w = bottomRight.getX() - topLeft.getX();
    int h = bottomRight.getY() - topLeft.getY();
    
    Point p2 = new Point(topLeft.getX() + w, topLeft.getY());
    Point p4 = new Point(topLeft.getX(), topLeft.getY() + h);
  
    boundingBox = new BoundingBox(topLeft, p2, bottomRight, p4);
  }
  
  void translateItem(Point p){
    super.translateItem(p);
    
    p1.translatePoint(p);
    p2.translatePoint(p);
    p3.translatePoint(p);
  }
  
  void display(Point relative){
    super.display(relative);
    
    triangle(relative.getX()+p1.getX(), relative.getY()+p1.getY(), relative.getX()+p2.getX(), relative.getY()+p2.getY(), relative.getX()+p3.getX(), relative.getY()+p3.getY());
  }
}
