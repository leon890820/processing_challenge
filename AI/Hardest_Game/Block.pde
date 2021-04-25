class Block{
  PVector position;
  float len;
  float hei;
  color c;
  Block(float x,float y,float _len,float _hei,color _c){
    position=new PVector(x,y);
    len=_len;
    hei=_hei;
    c=_c;
  }
  void show(){
    rectMode(CORNER);
    fill(c);
    noStroke();
    rect(position.x,position.y,len,hei);
  
  
  }

}
