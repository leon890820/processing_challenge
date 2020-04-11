class bubble{
  //PImage HGU;
  float x;
  float y;
  float vx;
  float vy;
  float g=-0.1;
  float ins=random(50,100);
  int ran=int(random(0,HGUs.length));
  bubble(){
    x=width/2;
    y=100;
    vx=random(-2,2);
    vy=random(1,5);
    //HGU=loadImage("HUG.png");
  }
  
  void display(){
    
    stroke(255,ins);
    fill(255,ins);
    //circle(x,y,15);
    tint(255,200);
    imageMode(CENTER);
    image(HGUs[ran],x,y,50,50);
  }
  void usegravity(){
    x+=vx;
    y-=vy;
    vy+=g;
  }
  void reset(){
    if(y>height+50){
      x=width/2;
      y=100;
      vx=random(-2,2);
      vy=random(1,5);
    }
  }


}
