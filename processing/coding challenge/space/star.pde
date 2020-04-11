class star{
  float x;
  float y;
  float z;
  float pz;
  star(){
    x=random(-width,width);
    y=random(-height,height);
    z=random(height);
    pz=z;
  }
  void show(){
    fill(255);
    noStroke();
    float sx=map(x/z,0,1,0,width);
    float sy=map(y/z,0,1,0,height);
    float r=map(z,0,width,50,0);
    //circle(sx,sy,r);
    float px=map(x/pz,0,1,0,width);
    float py=map(y/pz,0,1,0,height);
    stroke(255);
    pz=z;
    line(px,py,sx,sy);
  }
  void update(){
    z-=speed;
    if(z<1){
      z=random(height);
      x=random(-width,width);
      y=random(-height,height);
      pz=z;
    }
  }


}
