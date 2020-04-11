
brench root;
float len=100;
PVector a;
PVector b;
void setup(){
  size(500,500);
  a=new PVector(width/2,height);
  b=new PVector(width/2,height-100);
  root=new brench(a,b);
}
void draw(){
  
  background(0);
  
  root.show();
  
}

  
