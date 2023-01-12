class Star extends Shape{
  private PShape s;
  private Point center;

  private int outerRadius;
  
  Star(Point center, int numberOfSpikes, int innerRadius, int outerRadius ) {
    this.position = new Point(center.getX() - outerRadius, center.getY()-outerRadius);
    this.center = center;
    this.outerRadius = outerRadius;
    this.c = color(235, 235, 52);
    makeStar(innerRadius, outerRadius, numberOfSpikes);
    
    setBoundingBox();
  }
  
  void makeStar(int radius1, int radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
  
    s = createShape();
    s.beginShape();
    for (float a = -TWO_PI/4; a <= 2*TWO_PI - TWO_PI/4; a += angle) {
      float sx = cos(a) * radius2;
      float sy = sin(a) * radius2;
      s.vertex(sx, sy);
      sx = cos(a+halfAngle) * radius1;
      sy = sin(a+halfAngle) * radius1;
      s.vertex(sx, sy);
    }
  
    s.endShape(CLOSE);
  }
  
  void setBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + 2*outerRadius, position.getY());
    Point p3 = new Point(position.getX() + 2*outerRadius, position.getY() + 2*outerRadius);
    Point p4 = new Point(position.getX(), position.getY() + 2*outerRadius);
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  void translateItem(Point p){
    super.translateItem(p);
    
    center.translatePoint(p);
  }

  void display(Point relative) {
    if(filled){
      s.beginShape();
      s.fill(c);
      s.endShape();
    }else{
      s.beginShape();
      s.noFill();
      s.endShape();
    }
    shape(s, relative.getX()+center.getX(), relative.getY()+center.getY());
  }
}
