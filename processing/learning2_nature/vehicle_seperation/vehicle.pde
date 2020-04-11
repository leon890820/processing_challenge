class vehicle{
  PVector l;
  PVector v;
  PVector a;
  float maxspeed;
  float maxforce;
  float r;
  vehicle(){
    l=new PVector(random(width),random(height));
    v=new PVector(0,0);
    a=new PVector(0,0);
    maxspeed=3;
    maxforce=0.2;
    r=12;
  }
  vehicle(PVector ls){
    l=ls.get();
    v=new PVector(0,0);
    a=new PVector(0,0);
    maxspeed=3;
    maxforce=0.2;
    r=12;
  }
  void run(){
    
    display();
    update();
    borders();
  }
  
  void display(){
    fill(175);
    stroke(0);
    pushMatrix();
    translate(l.x, l.y);
    ellipse(0, 0, r, r);
    popMatrix();
  }
  
  void update(){
    v.add(a);
    v.limit(maxspeed);
    l.add(v);
    a.mult(0);
  }
  void addforce(PVector force){
    a.add(force);
  }
  void seperation(ArrayList<vehicle> vehicles){
    float desireseperation=r*10;
    PVector sum=new PVector();
    int count=0;
    for(vehicle other:vehicles){
      float d=PVector.dist(l,other.l);
      if(d>0&&d<desireseperation){
        PVector diff=PVector.sub(l,other.l);  
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if(count>0){
      sum.setMag(maxspeed);
      PVector steer=PVector.sub(sum,v);
      steer.limit(maxforce);
      addforce(steer);
    }
    
  }
  void borders() {
    if (l.x < -r) l.x = width+r;
    if (l.y < -r) l.y = height+r;
    if (l.x > width+r) l.x = -r;
    if (l.y > height+r) l.y = -r;
  }
}
