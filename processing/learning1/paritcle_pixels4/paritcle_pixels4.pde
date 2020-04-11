particle[] particles;
PImage HGU;
void setup(){
  size(400,314,P2D);
  HGU=loadImage("HGU.jpg");
  background(0);
  particles=new particle[2000];
  for(int i=0;i<particles.length;i+=1){
    particles[i]=new particle();
  }
}
void draw(){
  //background(0);
  for(int i=0;i<particles.length;i+=1){
    particles[i].display();
    particles[i].move();
    particles[i].flex();
  
  }
  
  
}
