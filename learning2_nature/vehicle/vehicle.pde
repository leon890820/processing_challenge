ArrayList<car> c;
field f;
float n=0;

void setup(){
  c=new ArrayList<car>();
  f=new field();
  f.build();
  for(int i=0;i<120;i+=1){
    c.add(new car());
  }
  size(640,640);
}
void draw(){
  PVector mouse=new PVector (mouseX,mouseY);
  background(255);
  
  fill(100);
  //f.build();
  f.update();
  f.display();
  //circle(mouse.x,mouse.y,25);
  for(car c1:c){
    c1.display();
    c1.update(f);
    c1.border();
  }
  n+=0.1;
  if(mousePressed){
    c.add(new car(new PVector(mouseX,mouseY)));
  }
  
}
void mousePressed(){
  f.build();
}
