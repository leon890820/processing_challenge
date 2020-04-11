walker w;
void setup(){
  size(800,600);
  w= new walker();
  background(255);
}
void draw(){
  w.display();
  w.step();
}
