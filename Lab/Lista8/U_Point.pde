class Point{ 
  private int x;
  private int y;
  
  Point(int x, int y){
   this.x = x;
   this.y = y;
  }
  
  Point(Point other){
    this.x = other.x;
    this.y = other.y;
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  void setX(int x){
    this.x = x;
  }
  
  void setY(int y){
    this.y = y;
  }
  
  void translatePoint(Point p){
    x += p.getX();
    y += p.getY();
  }
  
  Point sum(Point other){
    return new Point(this.x+other.x, this.y+other.y);
  }
  
  String toString(){
    return "Point: (" + x + ", " + y + ")";
  }
}
