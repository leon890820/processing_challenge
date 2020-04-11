circle b1,b2;
void setup(){
  
  size(640,360);
  background(0);
  b1=new circle(100,100,100);
  b2=new circle(300,300,200);
  
}
void draw(){
  background(0);
  b1.x=mouseX;
  b1.y=mouseY;
  
  b1.particle();
  b2.particle();
  b1.touch(b2);
  
}
