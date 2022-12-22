Item circle;
Item rect;
Item triangle;

void setup(){
  size(640, 640);
  fill(0);
  
  circle = new Circle(new Point(420,420), 69);
  rect = new Rect(new Point(10,10), 69, 100);
  triangle = new Triangle(new Point(70,70),new Point(80,80), new Point(80,70));
  
  
  ((Shape)circle).setFilled(true);
}

void draw(){
  circle.drawItem();
  rect.drawItem();
  triangle.drawItem();
  
}
