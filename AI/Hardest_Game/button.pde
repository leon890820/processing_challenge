class Button {
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  float r;
  boolean touch=false;
  boolean pressed=false;
  Button(String _name, float _x, float _y, int _num, float _len, float _hei,float _r) {
    name=_name;
    position=new PVector(_x, _y);
    num=_num;
    len=_len;
    hei=_hei;
    r=_r;
    pp=position.copy();
  }
  void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    //strokeWeight(4);
    //rect(position.x, position.y, len, hei);
    smoothRect(position.x, position.y, len, hei,r);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  
  void smoothRect(float x,float y,float l,float h,float r){
    float prx=x+l/2-r;
    float nrx=x-l/2+r;
    float pry=y+h/2-r;
    float nry=y-h/2+r;
    
    
    beginShape();
    vertex(nrx,nry-r);
    vertex(prx,nry-r);
    quarterCircle(prx,nry,-PI/2,0,r);
    vertex(prx+r,nry);
    vertex(prx+r,pry);
    quarterCircle(prx,pry,0,PI/2,r);
    vertex(prx,pry+r);
    vertex(nrx,pry+r);
    quarterCircle(nrx,pry,PI/2,PI,r);
    vertex(nrx-r,pry);
    vertex(nrx-r,nry);
    quarterCircle(nrx,nry,PI,3*PI/2,r);
    endShape(CLOSE);
  
  
  }
  void quarterCircle(float x,float y,float sa,float ea,float r){
    for(int i=0;i<=90;i+=1){
      float theda=map(i,0,90,sa,ea);
      
      vertex(x+(r)*cos(theda),y+(r)*sin(theda));
    }
  }
  
  void run(String s) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        if(s=="play") play();
        else if(s=="back") back();
        else if(s=="reset") reset();
        else if(s=="restart") restart();
        else if(s=="backToMenu") backToMenu();
        else if(s=="edit") edit();
        
        pressed=true;
      }
    } else pressed=false;
  }
  void edit(){
    menu=false;
    gameMode=false;
    trainMode=false;
    editMode=true;
    win=false;
  
  }
  void restart(){
    win=false;
    setup();
  
  
  }
  void backToMenu(){
    reset();
    menu=true;
    gameMode=false;
    trainMode=false;
    editMode=false;
    win=false;
  }
  void play(){
    win=false;
    menu=false;
    gameMode=true;
    trainMode=false;
    editMode=false;
  
  }
  void back(){
    menu=true;
    gameMode=false;
    trainMode=false;
    editMode=false;
  
  
  }
  void reset(){
    
    setup();
    
  
  }
  
}
