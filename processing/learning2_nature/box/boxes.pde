class Box{
  float x;
  float y;
  Box(float x1,float y1){
    x=x1;
    y=y1;
  }
  void display(){
    stroke(0);
    fill(100);
    rect(x,y,16,16);
  }

}
