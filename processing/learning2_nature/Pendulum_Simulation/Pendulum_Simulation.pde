force m;
PVector g= new PVector (0,0.01);
float angle=PI/4;
float L;


void setup(){
  size(640,360);
  background(0);
  m= new force();
  L=100;
  //frameRate(3);
  
}
void draw(){
  background(0);
  translate(width/2,0);
  m.display();
  m.update();
  
  
  
  
}
