class Point{
  private int x;
  private int y;
  
  public Point(int x, int y){
   this.x = x;
   this.y = y;
  }
  
  public Point(Point other){
    this.x = other.x;
    this.y = other.y;
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  public void translatePoint(Point p){
    x += p.getX();
    y += p.getY();
  }
  
  @Override
  public boolean equals(Object other){
    if(this == other){
      return true;
    }
    
    if(other == null || this.getClass() != other.getClass()){
      return false;
    }
    
    Point p = (Point) other;
    return x == p.x && y ==p.y;
  }
}
