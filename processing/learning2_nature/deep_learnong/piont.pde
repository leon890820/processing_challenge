class point{
  float x;
  float y;
  float px;
  float py;
  int lable;
  float bias;
  point(float x_,float y_){
    x=x_;
    y=y_;
    px=map(x,-1,1,0,width);
    py=map(y,-1,1,height,0);
    bias=1;
  }
  point(){
    x=random(-1,1);
    y=random(-1,1);
    px=map(x,-1,1,0,width);
    py=map(y,-1,1,height,0);
    bias=1;
    if(y>f(x)) lable=1;
    else lable =-1;
  }
  void show(){
    noStroke();
    if(lable==1) fill(255);
    else fill(0);
    
    circle(px,py,16);
  }
}
