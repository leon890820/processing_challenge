

import controlP5.*;
ControlP5 cp5;
float slider=3;
float n1=0.5;
float n2=0.5;
float n3=16;
float m1=16;
float m2=16;
float a=1;
float b=1;
float c=0;
//color [] colors = new color[7]; 
void setup(){
  size(400,400);
  cp5=new ControlP5(this);
  
  //cp5.addSlider("n").setPosition(0,0).setRange(0,5);
}

void draw(){
   background(0);
  translate(width/2,height/2);
 
  stroke(255);
  noFill();
  //float r=100;
  beginShape();
   for(float i=0;i<2*PI;i+=0.001){
    float r=supershape(i); 
    float x=50*r*cos(i);
    float y=50*r*sin(i);
   // float na=2/n;
    //float x=pow(abs(cos(i)),na)*a*sgn(cos(i))+200;
    //float y=pow(abs(sin(i)),na)*b*sgn(sin(i))+200;
    
    vertex(x,y);
  }
  endShape(CLOSE);
  c+=0.01;
  n1=cos(c);
}

float sgn(float a){
  if(a>0) return 1;
  else if(a==0) return 0;
  else return -1;
}
float supershape(float theda){
  float t1=pow(abs(cos(m1*theda/4)/a),n2);
  float t2=pow(abs(sin(m2*theda/4)/b),n3);
  float r=pow(t1+t2,1/n1);
  
  
  return 1/r;
}
