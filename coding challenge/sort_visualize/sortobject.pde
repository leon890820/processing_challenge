class SortObject{
  float wid;
  float hei;
  PVector position;
  color c;
  SortObject(float posX,float _wid,float _hei,color _c){
    wid=_wid;
    hei=_hei;  
    position=new PVector(posX,height-_hei);
    c=_c;
  }
  
  
  void show(){
    fill(c);
    //noStroke();
    rect(position.x,position.y,wid,hei);
  
  }


}
