class ball{
  float x;
  float y;
  float vx;
  float vy;
  ball[] other;
  ball(float ranx,float rany,ball[] oin){
    
    x=ranx;
    
    y=rany;
    
    vx=random(-5,5);
   
    vy=random(-5,5);
    
    other=oin;
  }
  
  
  void display(){
    
    circle(x,y,10);
  }
  
  void move(){
   
    x+=vx;
    y+=vy;
  }
  void touch(){
    for(int i=0;i<balls.length;i+=1){
    
      float dx=(x-other[i].x);
      float dy=y-other[i].y;
      float cvx;
      float cvy;
      float dr=sqrt(dx*dx+dy*dy);
      if(abs(dr)<10){
        float theda=atan(dy/dx);
        cvx=vx;
        vx=other[i].vx;//*cos(theda);
        other[i].vx=cvx;//*cos(theda);
        cvy=vy;
        vy=other[i].vy;//*sin(theda);
        other[i].vy=cvy;//*sin(theda);
              
        
    }
    }
  
  }
  void bounded(){
    if(x<0){
      x=0;
      vx=-vx;
    }
    if(x>width){
      x=width;
      vx=-vx;
    }
     if(y<0){
      y=0;
      vy=-vy;
    }
    if(y>height){
      y=height;
      vy=-vy;
    }
  }


}
