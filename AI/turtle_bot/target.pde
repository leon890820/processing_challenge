class Target{
  PVector position;
  int radious=40;
  Target(){
    position=new PVector(random(100,width-100),random(100,height-100));
  
  }
  void show(){
    noStroke();
    fill(255,0,0,100);
    rectMode(CENTER);
    rect(position.x,position.y,radious,radious);
  
  
  }


}
