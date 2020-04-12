float a=0;
Box b;
ArrayList<Box> sponge;
void setup(){
  size(500,500,P3D);
  b=new Box(0,0,0,200);
  sponge=new ArrayList<Box>();
  sponge.add(b);
}
void draw(){
  background(0);
  stroke(255);
  //noFill();
  lights();
  translate(width/2,height/2);
  rotateX(a);
  rotateZ(a);
  for(Box b:sponge){
    b.show();
  }
  a+=0.01;
}
void mousePressed(){
  ArrayList<Box> next=new ArrayList<Box>();
  for(int i=0;i<sponge.size();i+=1){
    next.addAll(sponge.get(i).generate());
  }
  sponge=next;
}
