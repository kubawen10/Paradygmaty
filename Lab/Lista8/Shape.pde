abstract class Shape extends Primitive{
  protected boolean filled;
  protected color c;
  
  protected boolean isFilled(){
    return filled;
  }
  
  protected void setFilled(boolean value){
     filled = value;
  }
  
  @Override
  public void drawItem(){
    if(filled){
      fill(c);
    }else {
      noFill();
    }
  }
}
