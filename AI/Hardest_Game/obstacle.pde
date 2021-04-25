class Obstacle{
  PVector position;
  float hei;
  float len;
  Obstacle(float x,float y,float _len,float _hei){
    position=new PVector(x,y);
    hei=_hei;
    len=_len; 
  }
  void show(){
    rectMode(CENTER);
    fill(255);
    noStroke();
    rect(position.x,position.y,len,hei);
  }
}
