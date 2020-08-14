lightning light;

void setup(){
  size(600,600);
  light=new lightning();
}
void draw(){
  background(0);
  light.run();
}
