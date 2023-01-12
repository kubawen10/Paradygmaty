abstract class Shape extends Primitive{
  boolean filled = true;
  color c;
  
  boolean getFilled(){
    return filled;
  }
  
  void setFilled(boolean value){
     filled = value;
  }
  
  void display(Point relative){
    if(filled){
      fill(c);
    } else {
      noFill();
    }
  }
}
