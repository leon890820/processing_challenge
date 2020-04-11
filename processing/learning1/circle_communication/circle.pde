class circle{
  float x;
  float y;
  float r;
  color col;
  circle(float tx,float ty,float tr){
    x=tx;
    y=ty;
    r=tr;
  }
  void particle(){
    stroke(255);
    fill(col);
    circle(x,y,r);
  }
  void touch(circle other){
    float d=dist(x,y,other.x,other.y);
    if(d<=(r+other.r)/2){
        col=color(255,0,0,100);
        other.col=color(0,255,0,100);
    }
    else{
        col=color(0);
        other.col=color(0);
     }
  }
}
