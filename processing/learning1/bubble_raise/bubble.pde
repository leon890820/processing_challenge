class bubble {
  float x;
  float y;
  float u=random(1,3);
  bubble(){
    x=360;
    y=height;
  }
  
  void create(){
    circle(x,y,24);
  }
  void raise(){
    y-=u;
    x+=random(-5,5);
    if (y<-50){
      y=height+50;
    }
  }
}
