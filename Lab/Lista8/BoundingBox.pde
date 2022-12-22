class BoundingBox{
  Point p1;
  Point p2;
  Point p3;
  Point p4;
  
  public BoundingBox(Point p1, Point p2, Point p3, Point p4){
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
  }
  
  public void translateBoundingBox(Point p){
    p1.translatePoint(p);
    p2.translatePoint(p);
    p3.translatePoint(p);
    p4.translatePoint(p);
  }
}
