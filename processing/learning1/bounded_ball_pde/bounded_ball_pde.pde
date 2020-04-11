float x;
float y;
float vx=2;
float vy=2;
void setup(){
  size(640,360);
  background(50);
  x=random(0,640);
  y=random(0,320);
  vx=random(1,10);
  vy=random(1,10);
}
void draw(){
  background(50);
  stroke(50);
  circle(x,y,25);
  x+=vx;
  y+=vy;
  if(x<0||x>width){
  vx=-vx;
  }
  if(y<0||y>height){
  vy=-vy;
  }
}
