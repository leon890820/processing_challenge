ArrayList<vehicle> v;
void setup(){
  size(640,360);
  v=new ArrayList<vehicle>();
  for(int i=0;i<120;i+=1){
    v.add(new vehicle());
  }
  background(255);
}
void draw(){
  background(255);
  for(vehicle v1:v){
    v1.seperation(v);
    v1.run();
  }
  if(mousePressed){
    v.add(new vehicle(new PVector(mouseX,mouseY)));
  }
}
