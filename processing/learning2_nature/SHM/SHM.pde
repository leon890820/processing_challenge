float x;
float y;
float ax;
float vx;
float ay;
float vy;

void setup(){
  size(400,200);
  background(0);
  x=100;
  y=0;
  ax=-0.01*x;
  vy=0;
}
  
void draw(){
  background(0);
  ax=-0.01*x;
  ay=-0.01*y;
  translate(width/2,height/2);
  noStroke();
  fill(255);
  circle(x,y,20);
  vx+=ax;
  x+=vx;
  vy+=ay;
  y+=vy;
}
