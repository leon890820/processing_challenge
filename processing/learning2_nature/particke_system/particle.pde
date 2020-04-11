class particle{
  PVector location;
  PVector v;
  PVector a;
  float dis;
  particle(PVector o){
    location=o.get();
    v=new PVector (random(-2,2),random(-5,0));
    a=new PVector (0,0.1);
    dis=255;
  }
  void display(){
    stroke(255,dis);
    fill(255,dis);
    circle(location.x,location.y,10);
    dis-=2;
  }
  void update(){
    location.add(v);
    v.add(a);
  }
  boolean isdead(){
    if(dis<0) return true;
    else return false;
  }
}
