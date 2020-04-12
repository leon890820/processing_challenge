float x=0.01;
import peasy.*;
float y=0.01;
float z=0.01;
float a=10;
float b=28;
float c=8.0/3.0;
float alpha=0.01;
ArrayList<PVector> points;
PeasyCam cam;

void setup(){
  size(1000,1000,P3D);
  cam=new PeasyCam(this,200);
  colorMode(HSB);
  points=new ArrayList<PVector>();
  
}
void draw(){
  background(0);
  
  float dt=0.01;
  float dx=(a*(y-x))*dt;
  float dy=(x*(b-z)-y)*dt;
  float dz=(x*y-c*z)*dt;
  float hs=0;
  x+=dx;
  y+=dy;
  z+=dz;
  points.add(new PVector(x,y,z));
  //translate(width/2,height/2);
  stroke(255);
  float mx=map(mouseX,-width/2,width/2,-3.14,3.14);
  float my=map(mouseY,-height/2,height/2,-3.14,3.14);
  //rotateX(-my);
  //rotateY(-mx);
  //scale(5);
  noFill();
  beginShape();
   for(PVector v:points){
     stroke(hs,255,255);
      vertex(v.x,v.y,v.z);
      PVector offset=PVector.random3D();
      offset.mult(0.1);
      //v.add(offset);
      hs+=0.1;
      if(hs>255) hs=0;
   }
   endShape();
  //a+=0.01;
}
