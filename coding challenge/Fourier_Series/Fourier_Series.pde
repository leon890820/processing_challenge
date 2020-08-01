import processing.sound.*;
float r=100;
float time=0;
int num=100;
FloatList p;
FloatList p1;
PVector location=new PVector(0,0);

void setup(){
  size(800,400);
  p=new FloatList();
}

void draw(){
  background(0);
  translate(200,200);
  float x=0;
  float y=0;
  for(int i=1;i<=num;i+=1){
    circle(x,y,2*r/(2*i-1));
    float fx=x+r*cos((2*i-1)*time)/(2*i-1);
    float fy=y+r*sin((2*i-1)*time)/(2*i-1);
    line(x,y,fx,fy);
    x=fx;
    y=fy; 
  }
  fill(255);
  circle(x,y,8);
  location=new PVector(x,y);
  
  
  
  p.append(location.y);
  p1=p.copy();
  p1.reverse();
  stroke(255);
  line(location.x,location.y,200,p1.get(0));
  translate(200,0);
  noFill();
  stroke(255);
  beginShape();
  for(int i=0;i<p1.size();i+=1){
    vertex(i,p1.get(i));
  }
  endShape();
  if(p.size()>500){
    p.remove(0);
  }
  
  
  
  time-=0.02;
  //if(time<=-2*PI){
  //  time=0;
  //  num+=1;
  //}
}
