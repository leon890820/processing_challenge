float a=0;
Box b;
float radious=400;
float time=0;
ArrayList<Box> sponge;
void setup(){
  size(800,800,P3D);
  b=new Box(0,0,0,radious);
  sponge=new ArrayList<Box>();
  sponge.add(b);
  mousePressed();
  mousePressed();
  mousePressed();
}
void draw(){
  background(0);
  noStroke();
  //stroke(255);
  //noFill();
  lights();
  translate(width/2,height/2);
  rotateX(a);
  rotateZ(a);
  for(Box b:sponge){
    b.show();
  }
  a+=0.01;
  time+=0.05*255/(2*PI);
  
}
void mousePressed(){
  ArrayList<Box> next=new ArrayList<Box>();
  for(int i=0;i<sponge.size();i+=1){
    next.addAll(sponge.get(i).generate());
  }
  sponge=next;
}