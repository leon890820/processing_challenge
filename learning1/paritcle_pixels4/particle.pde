class particle{
  float x;
  float y;
  float vx;
  float vy;
  float speed;
  float theda;
  
  particle(){
    x=width/2;
    y=height/2;
    speed=random(1,2);
    theda=random(0,2*PI);
    vx=cos(theda)*speed;
    vy=sin(theda)*speed;
    
  }
  
  void display(){
    color c=HGU.get(int(x),int(y));
    stroke(c,20);
    fill(c,20);
    circle(x,y,1);
  }
  void move(){
    x+=vx;
    y+=vy;
  }
  void flex(){
    if (x<0){
      x=0;
      vx=-vx;
    }
    if (y<0){
      y=0;
      vy=-vy;
    }
    if (x>width){
      x=width;
      vx=-vx;
    }
    if (y>height){
      y=height;
      vy=-vy;
    }
  
  }

}
