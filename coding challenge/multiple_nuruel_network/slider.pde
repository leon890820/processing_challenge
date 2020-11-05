class slider{
  PVector startposition;
  PVector  endposition;
  PVector position;
  float value=0;
  float len;
  float hei;
  float max;
  float min;
  float v;
  boolean touch=false;
  String name;
  button sliderbutton;
  slider(String _name,float startpx,float startpy,float endpx,float endpy,float _len,float _hei,float _min,float _max){
    name=_name;
    startposition=new PVector(startpx,startpy);
    endposition=new PVector(endpx,endpy);
    position=startposition.copy();
    len=_len;
    hei=_hei;
    max=_max;
    min=_min;
    sliderbutton=new button("",startposition.x,startposition.y,0,_len,_hei);
    v=(max-min)*value/100+min;  
}
  void run(){
    position=sliderbutton.sliderselect();
    constrainbutton();
    calcValue();
    show();
  }
  void constrainbutton(){
    if(position.x<startposition.x) position.x=startposition.x;
    if(position.y<startposition.y) position.y=startposition.y;
    if(position.x>endposition.x) position.x=endposition.x;
    if(position.y>endposition.y) position.y=endposition.y;
    sliderbutton.position=position;
  }
  void calcValue(){    
    float d=dist(startposition.x,startposition.y,endposition.x,endposition.y);
    float v=dist(position.x,position.y,startposition.x,startposition.y);
    value=v/d*100;
  }
  void show(){
    rectMode(CENTER);
    fill(200);
    noStroke();
    v=(max-min)*value/100+min;
    rect((startposition.x+endposition.x)/2,(startposition.y+endposition.y)/2,endposition.x-startposition.x+len,endposition.y-startposition.y+hei);
    sliderbutton.slidershow();
    
  
  }
  void showtext(float _x,float _y,int a){
    textSize(16);
    float v=(max-min)*value/100+min;
    text(name+" : "+str((int)v),_x,_y);
    
  }
  void showtext(float _x,float _y){
    textSize(16);
    
    text(name+" : "+str(v),_x,_y);
    
  }
  
  
}
