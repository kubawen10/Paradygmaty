class Rect extends Shape{
  private int w;
  private int h;
  
  Rect(Point position, int w, int h){
    this.position = position;
    this.w = w;
    this.h = h;
    this.c = color(0,255,0);
    setBoundingBox();
  }

  void setBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + w, position.getY());
    Point p3 = new Point(position.getX() + w, position.getY() + h);
    Point p4 = new Point(position.getX(), position.getY() + h);
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  int getWidth(){
    return w;
  }
  
  int getHeight(){
    return h;
  }
  
  void display(Point relative){
    super.display(relative);
    
    rect(relative.getX()+position.getX(), relative.getY()+position.getY(), w, h);
  }
}
