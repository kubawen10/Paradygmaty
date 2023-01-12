class TextItem extends Item{
  private String text;
  private int textSize = 30;
  private PFont f = createFont("arial", textSize);
  
  TextItem(Point position, String text){
    this.position = position;
    this.text = text;
    
    setBoundingBox();
  }
  
  void setBoundingBox(){
    textFont(f);
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + int(textWidth(text)), position.getY());
    Point p3 = new Point(position.getX() + int(textWidth(text)), position.getY() + textSize);
    Point p4 = new Point(position.getX(), position.getY() + textSize);

    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  String getText(){
    return text;
  }
  
  void display(Point relative){
    fill(0);
    textFont(f);
    text(text, position.getX() + relative.getX(), position.getY()+textSize-textDescent() + relative.getX());
  }
}  
