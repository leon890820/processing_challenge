lightning light;
ArrayList<lightning> lights;

void setup(){
  size(600,600);
  light=new lightning();
  lights= new ArrayList<lightning>();
}
void draw(){
  background(0);
  light.run();
  if(random(1)<0.05){
    lights.add(new lightning());
  }
  for(lightning l:lights){
    l.run();
  }
  for(int i=lights.size()-1;i>=0;i-=1){
    if(lights.get(i).time<0) lights.remove(i);
  }
}
