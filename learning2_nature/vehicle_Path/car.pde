class car{
  PVector l;
  PVector v;
  PVector a;
  float maxspeed;
  float maxforce;
  float r=3;
  car(PVector location){
    l=location.get();
    v=new PVector(random(0,1),random(-1,1));
    a=new PVector(0,0);
    maxspeed=random(2,4);
    maxforce=random(0.08,0.15);
  }
  void run(){
    update();
    display();
  }
  void display(){
    
    float theta = v.heading2D() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(l.x, l.y);
    rotate(theta);
    beginShape(PConstants.TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
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
  
  void follow(path p){
    PVector predict=v.get();
    predict.normalize();
    predict.mult(50);
    PVector ppos=PVector.add(l,predict);
    
    PVector normal=null;
    PVector target=null;
    float worldrecord=1000000;
    
    for(int i=0;i<p.points.size()-1;i+=1){
      PVector a=p.points.get(i);
      PVector b=p.points.get(i+1);
      PVector normalPoint=getnormalPoint(ppos,a,b);
      if(normalPoint.x < a.x||normalPoint.x>b.x){
        normalPoint=b.get();
      }
      float distance=PVector.dist(ppos,normalPoint);
      if(distance<worldrecord){
        worldrecord=distance;
        normal=normalPoint;
        PVector dir = PVector.sub(b, a);
        dir.normalize();
        // This is an oversimplification
        // Should be based on distance to path & velocity
        dir.mult(10);
        target = normalPoint.get();
        target.add(dir);
        }
      }
      if(worldrecord>p.r){
        seek(target);
      }
    
    /*
    
    PVector a=p.start;
    PVector b=p.end;
    PVector normalPoint =getnormalizePoint(ppos,a,b);
    
    PVector dir =PVector.sub(b,a);
    dir.normalize();
    dir.mult(10);
    PVector target=PVector.add(normalPoint,dir);
    
    float distance=PVector.dist(ppos,normalPoint);
    
    if(distance>p.r){
      seek(target);
    }
    */
    if(debug){
      fill(0);
      stroke(0);
      line(l.x,l.y,ppos.x,ppos.y);
      circle(ppos.x,ppos.y,4);
      
      fill(0);
      stroke(0);
      line(ppos.x,ppos.y,normal.x,normal.y);
      ellipse(normal.x, normal.y, 4, 4);
      stroke(0);
      if (worldrecord > p.r) fill(255, 0, 0);
      noStroke();
      ellipse(target.x, target.y, 8, 8);
    }
  }
  PVector getnormalPoint(PVector p,PVector a,PVector b){
    PVector ap=PVector.sub(p,a);
    PVector ab=PVector.sub(b,a);
    ab.normalize();
    ab.mult(ap.dot(ab));
    PVector n=PVector.add(a,ab);
    return n;
  }
  void seek(PVector s){
    PVector desire=PVector.sub(s,l);
    
    if(desire.mag()==0) return;
    
    desire.normalize();
    desire.mult(maxspeed);
    
    PVector steer=PVector.sub(desire,v);
    steer.limit(maxforce);
    addforce(steer);
  }
  void border(path p){
    if (l.x > p.end.x + r) {
      l.x = p.getstart().x - r;
      l.y = p.getstart().y + (l.y-p.getend().y);
    }
  
  }
  
  
  
}
