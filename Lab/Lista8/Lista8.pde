ComplexItem snowman;
Item rect;
Item txt;
Scene s;
ArrayList<Star> stars;

void setup(){
  size(640, 640);
  
  snowman = new ComplexItem(new Point(320,320));
  txt = new TextItem(new Point(200,0),"Paint4D");
  
  snowman.addItem(new Circle(new Point(0,0), 30));
  snowman.addItem(new Circle(new Point(0,75), 45));
  snowman.addItem(new Circle(new Point(0,180), 60));
  snowman.addItem(new Circle(new Point(-10,-10), 3));
  snowman.addItem(new Circle(new Point(10,-10), 3));
  snowman.addItem(new Triangle(new Point(-3,0), new Point(3,0), new Point(0,15)));
  snowman.addItem(new Segment(new Point(-10,20), new Point(10,20)));
  snowman.addItem(new Rect(new Point(-30,-45), 60,20));

  s = new Scene();
  s.addItem(snowman);
  s.addItem(txt);
  
  stars = new ArrayList<Star>();
  
  for(int i = 0; i < 50; i++){
    Star star = new Star(new Point(int(random(20,620)),int(random(20,620))), 8, 10, 20);
    stars.add(star);
    s.addItem(star);
  }

}

void draw(){
  s.display();
}

void mousePressed(){
  snowman.translateItem(new Point(int(random(-5,6)),int(random(-5,6))));
  
  for(int i = 0; i < 50; i++){
    stars.get(i).translateItem(new Point(int(random(-5,6)),int(random(-5,6))));
  
  }
 
  //s.addItem();
}
