ComplexItem snowman;
Triangle t1;
Item txt;
Scene s;



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

  t1 = new Triangle(new Point(10,10), new Point(150, 10), new Point(10,150));

  s = new Scene();
  s.addItem(snowman);
  s.addItem(txt);
  s.addItem(t1);
}

void draw(){
  s.display();
}

void mousePressed(){
    Point p1 = new Point(int(random(5, 20)), int(random(5, 20)));
    Point p2 = new Point(int(random(5, 20)), int(random(100, 200)));
    Point p3 = new Point(int(random(100, 200)), int(random(5, 20)));
    s.addItem(new Triangle(p1,p2,p3));
}
