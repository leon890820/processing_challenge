class drop{
  PVector l;
  PVector a;
  PVector a1;
  PVector v;
  float len;
  float thick;
  drop(){
    l=new PVector(random(-200,width+100),random(-200,-100));
    v=new PVector(0,random(1,4));
    a=new PVector(0,random(0.05,0.1));
    len=random(10,20);
    thick=random(0,3);
    a1=a.get();
  }
  void fall(){
    addforce(a);
    l.add(v);
    v.add(a1);
    a1.mult(0);
  }
  void show(){
    strokeWeight(thick);
    stroke(138,43,226);
    line(l.x,l.y,l.x+v.x,l.y+len);
  }
  void addforce(PVector f){
    a1.add(f);
  }
}
