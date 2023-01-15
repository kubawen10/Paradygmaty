/* autogenerated by Processing revision 1289 on 2023-01-14 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Lista8 extends PApplet {

ComplexItem snowman;
Item rect;
Item txt;
Scene s;
ArrayList<Star> stars;

public void setup(){
  /* size commented out by preprocessor */;

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
    Star star = new Star(new Point(PApplet.parseInt(random(20,620)),PApplet.parseInt(random(20,620))), 8, 10, 20);
    stars.add(star);
    s.addItem(star);
  }

}

public void draw(){
  s.display();
}

public void mousePressed(){
  snowman.translateItem(new Point(PApplet.parseInt(random(-5,6)),PApplet.parseInt(random(-5,6))));
  
  for(int i = 0; i < 50; i++){
    stars.get(i).translateItem(new Point(PApplet.parseInt(random(-5,6)),PApplet.parseInt(random(-5,6))));
  
  }
}
abstract class Item{
  protected Point position;
  protected BoundingBox boundingBox;
  protected boolean displayBoundingBox = true;
  
  public void translateItem(Point p){
    position.translatePoint(p);
    boundingBox.translateBoundingBox(p);
  }
  
  public Point getPosition(){
    return position;
  }
  
  public BoundingBox getBoundingBox(){
    return boundingBox;
  }
  
  public abstract void computeBoundingBox();
  
  public boolean getDisplayBoundingBox(){
    return displayBoundingBox;
  }
  
  public void display(){
    display(new Point(0,0));
  }
  
  public abstract void display(Point relative);
}
abstract class Primitive extends Item{
}
abstract class Shape extends Primitive{
  boolean filled = true;
  int c;
  
  public boolean getFilled(){
    return filled;
  }
  
  public void setFilled(boolean value){
     filled = value;
  }
  
  public void display(Point relative){
    if(filled){
      fill(c);
    } else {
      noFill();
    }
  }
}
class Circle extends Shape{
  private int radius;
  
  Circle(Point center, int radius){
    center.translatePoint(new Point(-radius, -radius));
    this.position = center;
    this.radius = radius;
    this.c = color(0,0,255);
    computeBoundingBox();
  }
  
  public void computeBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + (2*radius), position.getY());
    Point p3 = new Point(position.getX() + (2*radius), position.getY() + (2*radius));
    Point p4 = new Point(position.getX()             , position.getY() + (2*radius));
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  public int getRadius(){
    return radius;
  }
  
  public void display(Point relative){
    super.display(relative);
    
    circle(relative.getX() + position.getX() + radius, relative.getY() + position.getY() + radius, radius*2);
  }
}
class ComplexItem extends Item{
  private ArrayList<Item> items;
  
  ComplexItem(Point position){
    this.position = position;
    items = new ArrayList<Item>();
    computeBoundingBox();
  }
  
  public void computeBoundingBox(){
    boundingBox = null;
  }
  
  public void addItem(Item item){
    item.getBoundingBox().translateBoundingBox(position);
    items.add(item);
    
    if(boundingBox != null){
      boundingBox.enlarge(item.getBoundingBox());
    } else if(item.getBoundingBox() != null) {
      boundingBox = new BoundingBox(item.getBoundingBox());
    }
  }
  
  public void translateItem(Point p){
    boundingBox.translateBoundingBox(p);
    
    for(int i = 0; i<items.size(); i++){
      items.get(i).translateItem(p);
    }
  } 
  
  public void display(Point relative){
    for(int i = 0; i<items.size(); i++){
      (items.get(i)).display(position.sum(relative)); 
    }
  }
}
class Rect extends Shape{
  private int w;
  private int h;
  
  Rect(Point position, int w, int h){
    this.position = position;
    this.w = w;
    this.h = h;
    this.c = color(0,255,0);
    computeBoundingBox();
  }

  public void computeBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + w, position.getY());
    Point p3 = new Point(position.getX() + w, position.getY() + h);
    Point p4 = new Point(position.getX(), position.getY() + h);
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  public int getWidth(){
    return w;
  }
  
  public int getHeight(){
    return h;
  }
  
  public void display(Point relative){
    super.display(relative);
    
    rect(relative.getX()+position.getX(), relative.getY()+position.getY(), w, h);
  }
}
class Segment extends Primitive{
  private Point p1;
  private Point p2;
  
  Segment(Point p1, Point p2){
    int minX = min(p1.getX(), p2.getX());
    int minY = min(p1.getY(), p2.getY());
    this.position = new Point(minX, minY);
    
    this.p1 = p1;
    this.p2 = p2;
    
    computeBoundingBox();
  }
  
  public void computeBoundingBox(){
    int minX = position.getX();
    int minY = position.getY();
    
    int maxX = max(p1.getX(), p2.getX());
    int maxY = max(p1.getY(), p2.getY());
    
    Point p1 = new Point(minX, minY);
    Point p2 = new Point(maxX, minY);
    Point p3 = new Point(maxX, maxY);
    Point p4 = new Point(minX, maxY);
    
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  public void translateItem(Point p){
    super.translateItem(p);
    
    p1.translatePoint(p);
    p2.translatePoint(p);
  }
  
  public float getLength(){
    return sqrt(pow(p1.getX() - p2.getX(), 2)+pow(p1.getY() - p2.getY(), 2));
  }
  
  public Point getStart(){
    return p1;
  }
  
  public Point getEnd(){
    return p2;
  }
  
  public void display(Point relative){
    line(relative.getX()+p1.getX(), relative.getY()+p1.getY(), relative.getX()+p2.getX(), relative.getY()+p2.getY());
  }
}
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
    
    computeBoundingBox();
  }
  
  private void makeStar(int radius1, int radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0f;
  
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
  
  public void computeBoundingBox(){
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + 2*outerRadius, position.getY());
    Point p3 = new Point(position.getX() + 2*outerRadius, position.getY() + 2*outerRadius);
    Point p4 = new Point(position.getX(), position.getY() + 2*outerRadius);
    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  public void translateItem(Point p){
    super.translateItem(p);
    
    center.translatePoint(p);
  }

  public void display(Point relative) {
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
class TextItem extends Item{
  private String text;
  private int textSize = 30;
  private PFont f = createFont("arial", textSize);
  
  TextItem(Point position, String text){
    this.position = position;
    this.text = text;
    
    computeBoundingBox();
  }
  
  public void computeBoundingBox(){
    textFont(f);
    Point p1 = new Point(position);
    Point p2 = new Point(position.getX() + PApplet.parseInt(textWidth(text)), position.getY());
    Point p3 = new Point(position.getX() + PApplet.parseInt(textWidth(text)), position.getY() + textSize);
    Point p4 = new Point(position.getX(), position.getY() + textSize);

    boundingBox = new BoundingBox(p1,p2,p3,p4);
  }
  
  public String getText(){
    return text;
  }
  
  public void display(Point relative){
    fill(0);
    textFont(f);
    text(text, position.getX() + relative.getX(), position.getY()+textSize-textDescent() + relative.getX());
  }
}  
class Triangle extends Shape{
  private Point p1;
  private Point p2;
  private Point p3;
  
  Triangle(Point p1, Point p2, Point p3){
    if(areaIs0(p1,p2,p3)){
      throw new IllegalArgumentException("Points are collinear!");
    }
    
    this.position = findTopLeftBB(p1,p2,p3);
    
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    
    this.c = color(255,0,0);
    
    computeBoundingBox();
  }
  
  // if area is 0 then points are on the same line or we have 2 identical coordinates
  private boolean areaIs0(Point p1, Point p2, Point p3){
    return (((p2.getX()-p1.getX()) * (p3.getY()-p1.getY())) - ((p3.getX()-p1.getX()) * (p2.getY()-p1.getY()))) == 0; 
  }
  
  //method to find top left corner of a boundingbox, its also this.position
  private Point findTopLeftBB(Point p1, Point p2, Point p3){
    int minX = min(p1.getX(), min(p2.getX(), p3.getX()));
    int minY = min(p1.getY(), min(p2.getY(), p3.getY()));
    
    return new Point(minX, minY);
  }
  
  //method to find bottom right corner of a boundingbox
  private Point findBottomRightBB(Point p1, Point p2, Point p3){
    int maxX = max(p1.getX(), max(p2.getX(), p3.getX()));
    int maxY = max(p1.getY(), max(p2.getY(), p3.getY()));
    
    return new Point(maxX, maxY);
  }
  
  public void computeBoundingBox(){
    Point topLeft = findTopLeftBB(p1,p2,p3);
    Point bottomRight = findBottomRightBB(p1,p2,p3);
    
    int w = bottomRight.getX() - topLeft.getX();
    int h = bottomRight.getY() - topLeft.getY();
    
    Point p2 = new Point(topLeft.getX() + w, topLeft.getY());
    Point p4 = new Point(topLeft.getX(), topLeft.getY() + h);
  
    boundingBox = new BoundingBox(topLeft, p2, bottomRight, p4);
  }
  
  public void translateItem(Point p){
    super.translateItem(p);
    
    p1.translatePoint(p);
    p2.translatePoint(p);
    p3.translatePoint(p);
  }
  
  public void display(Point relative){
    super.display(relative);
    
    triangle(relative.getX()+p1.getX(), relative.getY()+p1.getY(), relative.getX()+p2.getX(), relative.getY()+p2.getY(), relative.getX()+p3.getX(), relative.getY()+p3.getY());
  }
}
class BoundingBox{
  private Point p1;
  private Point p2;
  private Point p3;
  private Point p4;
  
  BoundingBox(Point p1, Point p2, Point p3, Point p4){
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
  }
  
  BoundingBox(BoundingBox other){
    this.p1 = new Point(other.p1);
    this.p2 = new Point(other.p2);
    this.p3 = new Point(other.p3);
    this.p4 = new Point(other.p4);
  }
  
  public void translateBoundingBox(Point p){
    p1.translatePoint(p);
    p2.translatePoint(p);
    p3.translatePoint(p);
    p4.translatePoint(p);
  }
  
  //used in complexItem when adding new item, it enlarges if addd item is ooutside of the current bounds
  public void enlarge(BoundingBox other){
    if(other == null) {
     return; 
    }
    
    int otherX = other.p1.getX();
    int otherY = other.p1.getY();
    int curX = p1.getX();
    int curY = p1.getY();
    
    if(otherX < curX || otherY < curY){
      int minX = min(otherX, curX);
      int minY = min(otherY, curY);
      
      p1.setX(minX);
      p1.setY(minY);
    }
    
    otherX = other.p3.getX();
    otherY = other.p3.getY();
    curX = p3.getX();
    curY = p3.getY();
    
    if(otherX > curX || otherY > curY){
      int maxX = max(otherX, curX);
      int maxY = max(otherY, curY);
      
      p3.setX(maxX);
      p3.setY(maxY);
    }
    
    p2.setX(p3.getX());
    p2.setY(p1.getY());
    
    p4.setX(p1.getX());
    p4.setY(p3.getY());
  }
  
  public void display(){
    noFill();
    
    color(0);
    rect(p1.getX(), p1.getY(), p3.getX()-p1.getX(), p3.getY()-p1.getY());
  }
  
  public String toString(){
    return "BB: " + p1 + " - " + p2 + " - " + p3 + " - " + p4;
    
  }
}
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
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  public void setX(int x){
    this.x = x;
  }
  
  public void setY(int y){
    this.y = y;
  }
  
  public void translatePoint(Point p){
    x += p.getX();
    y += p.getY();
  }
  
  public Point sum(Point other){
    return new Point(this.x+other.x, this.y+other.y);
  }
  
  public String toString(){
    return "Point: (" + x + ", " + y + ")";
  }
}
class Scene{
  private ArrayList<Item> items;
  
  Scene(){
    items = new ArrayList<Item>();
  }
  
  public void addItem(Item item){
   items.add(item); 
  }
  
  public void display(){
    background(255);
    for(int i = 0; i < items.size(); i++){
      items.get(i).display();
    }
  }
}


  public void settings() { size(640, 640); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Lista8" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
