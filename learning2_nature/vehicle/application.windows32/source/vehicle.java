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

public class vehicle extends PApplet {

ArrayList<car> c;
field f;
float n=0;

public void setup(){
  c=new ArrayList<car>();
  f=new field();
  f.build();
  for(int i=0;i<120;i+=1){
    c.add(new car());
  }
  
}
public void draw(){
  PVector mouse=new PVector (mouseX,mouseY);
  background(255);
  
  fill(100);
  //f.build();
  f.update();
  f.display();
  //circle(mouse.x,mouse.y,25);
  for(car c1:c){
    c1.display();
    c1.update(f);
    c1.border();
  }
  n+=0.1f;
  if(mousePressed){
    c.add(new car(new PVector(mouseX,mouseY)));
  }
  
}
public void mousePressed(){
  f.build();
}
class car{
  PVector l;
  PVector v;
  PVector a;
  float r=3;
  float maxspeed=4;
  float maxforce=0.1f;
  PVector mouse;
  car(){
  l=new PVector(random(width),random(height));
  v=new PVector(random(-1,1),random(-1,1));
  a=new PVector(0,0);
  
  }
  car(PVector lo){
    l=lo.get();
    v=new PVector(random(-1,1),random(-1,1));
    a=new PVector(0,0);
  }
  
  public void display(){
    float theta = v.heading2D() + PI/2;
    fill(127);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(l.x,l.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
    
  }
  public void update(field flow){
   mouse=new PVector(mouseX,mouseY);
   float d=dist(mouse.x,mouse.y,l.x,l.y);
  float speed=map(d,0,100,0,maxspeed);
  PVector desire=flow.lookup(l);
  desire.mult(maxspeed);
  PVector force=PVector.sub(desire,v);
  force.limit(maxforce);
  addforce(force);
  //print(l,mouse);
  }
  
  public void addforce(PVector f){
    a.add(f);
    v.add(a);
    v.limit(maxspeed);
    l.add(v);
    a.mult(0);
  }
  public void border(){
    if(l.x<-r) l.x=width+r;
    if(l.y<-r) l.y=height+r;
    if(l.x>width+r) l.x=-r;
    if(l.y>height+r) l.y=-r;
  }

}
class field{
  PVector[][] f;
  int resolution;
  int rows;
  int cols;
  float z=0;
  field(){
    resolution=20;
    rows=height/resolution;
    cols=width/resolution;
    f=new PVector[cols][rows];
  }
  public void build(){
    noiseSeed((int)random(10000));
    float x=0;
    float y=0;
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        float theda=map(noise(x,y),0,1,0,PI*2);
        float t=map(j,0,rows,0,2*PI);
        f[i][j]=new PVector(cos(theda),sin(theda));
        
        y+=0.1f;
      }
      x+=0.1f;
    }
  }
  public void update(){
    //noiseSeed((int)random(10000));
    float x=0;
    
    for(int i=0;i<cols;i+=1){
      float y=0;
      for(int j=0;j<rows;j+=1){
        float theda=map(noise(x,y,z),0,1,0,PI*2);
        float t=map(j,0,rows,0,2*PI);
        f[i][j]=PVector.fromAngle(theda);
        
        y+=0.1f;
      }
      x+=0.1f;
    }
    //z+=0.01;
  }
  public void display(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        drawVector(f[i][j],i*resolution,j*resolution,resolution-2);
      }
    }
  
  }
  public void drawVector(PVector v,float x,float y,float scayl){
    pushMatrix();
    float arrowsize=4;
    translate(x,y);
    stroke(0,100);
    rotate(v.heading2D());
    float len=v.mag()*scayl;
    line(0,0,len,0);
    popMatrix();
  }
  public PVector lookup(PVector lookup){
    int column = PApplet.parseInt(constrain(lookup.x/resolution,0,cols-1));
    int row = PApplet.parseInt(constrain(lookup.y/resolution,0,rows-1));
    return f[column][row].get();
  }
}
  public void settings() {  size(640,640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "vehicle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
