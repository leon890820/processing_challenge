lightning light;
float time=255;
void setup(){
  size(600,600);
  light=new lightning();
}
void draw(){
  background(0);
  light.run();
  time-=5;
}
