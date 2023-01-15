class BoundingBox{
  private Point p1;
  private Point p2;
  private Point p3;
  private Point p4;
  
  BoundingBox(Point p1, Point p2, Point p3, Point p4){
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
  }
  
  BoundingBox(BoundingBox other){
    this.p1 = new Point(other.p1);
    this.p2 = new Point(other.p2);
    this.p3 = new Point(other.p3);
    this.p4 = new Point(other.p4);
  }
  
  void translateBoundingBox(Point p){
    p1.translatePoint(p);
    p2.translatePoint(p);
    p3.translatePoint(p);
    p4.translatePoint(p);
  }
  
  //used in complexItem when adding new item, it enlarges if addd item is ooutside of the current bounds
  void enlarge(BoundingBox other){
    if(other == null) {
     return; 
    }
    
    int otherX = other.p1.getX();
    int otherY = other.p1.getY();
    int curX = p1.getX();
    int curY = p1.getY();
    
    if(otherX < curX || otherY < curY){
      int minX = min(otherX, curX);
      int minY = min(otherY, curY);
      
      p1.setX(minX);
      p1.setY(minY);
    }
    
    otherX = other.p3.getX();
    otherY = other.p3.getY();
    curX = p3.getX();
    curY = p3.getY();
    
    if(otherX > curX || otherY > curY){
      int maxX = max(otherX, curX);
      int maxY = max(otherY, curY);
      
      p3.setX(maxX);
      p3.setY(maxY);
    }
    
    p2.setX(p3.getX());
    p2.setY(p1.getY());
    
    p4.setX(p1.getX());
    p4.setY(p3.getY());
  }
  
  void display(){
    noFill();
    
    stroke(0);
    rect(p1.getX(), p1.getY(), p3.getX()-p1.getX(), p3.getY()-p1.getY());
  }
  
  String toString(){
    return "BB: " + p1 + " - " + p2 + " - " + p3 + " - " + p4;
    
  }
}
