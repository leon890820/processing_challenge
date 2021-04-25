class Point{
  PVector position;
  Point(float x,float y){
    
    position=new PVector(x,y);
  }
  void show(){
    fill(255);
    noStroke();
    circle(position.x,position.y,10);
  }
}
