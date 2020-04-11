ArrayList<particlesystem> ps;

void setup(){
  size(640,360);
  background(0);
  ps=new ArrayList<particlesystem>();
  ps.add(new particlesystem(new PVector(width/2,50)));
}
void draw(){
  background(0);
  for(particlesystem p:ps){
    p.run();
  }
}
void mousePressed(){
  ps.add(new particlesystem(new PVector(mouseX,mouseY)));
  
}
