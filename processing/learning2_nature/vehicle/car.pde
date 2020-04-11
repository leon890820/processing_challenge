class car{
  PVector l;
  PVector v;
  PVector a;
  float r=3;
  float maxspeed=4;
  float maxforce=0.1;
  PVector mouse;
  car(){
  l=new PVector(random(width),random(height));
  v=new PVector(random(-1,1),random(-1,1));
  a=new PVector(0,0);
  
  }
  car(PVector lo){
    l=lo.get();
    v=new PVector(random(-1,1),random(-1,1));
    a=new PVector(0,0);
  }
  
  void display(){
    float theta = v.heading2D() + PI/2;
    fill(127);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(l.x,l.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
    
  }
  void update(field flow){
   mouse=new PVector(mouseX,mouseY);
   float d=dist(mouse.x,mouse.y,l.x,l.y);
  float speed=map(d,0,100,0,maxspeed);
  PVector desire=flow.lookup(l);
  desire.mult(maxspeed);
  PVector force=PVector.sub(desire,v);
  force.limit(maxforce);
  addforce(force);
  //print(l,mouse);
  }
  
  void addforce(PVector f){
    a.add(f);
    v.add(a);
    v.limit(maxspeed);
    l.add(v);
    a.mult(0);
  }
  void border(){
    if(l.x<-r) l.x=width+r;
    if(l.y<-r) l.y=height+r;
    if(l.x>width+r) l.x=-r;
    if(l.y>height+r) l.y=-r;
  }

}
