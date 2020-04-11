class rocket{
  PVector l;
  PVector v;
  PVector a;
  float r;
  DNA dna;
  boolean hittarget=false;
  float fitness;
  //int lifecount=0;
  
  rocket(PVector ls,DNA dna_){
    l=ls.get();
    v=new PVector(0,0);
    a=new PVector(0,0);
    dna=dna_;
    r=4;
  }
  void fitness(){
    float d=dist(l.x,l.y,target.x,target.y);
     fitness=pow(1/d,4);
  }
  void run(){
    checktarget();
    if(hittarget==false){
      addforce(dna.gene[lifecount]);
      //lifecount+=1;
      update();
    }
    display();
  }
  void display(){
    float theta = v.heading2D() + PI/2;
    fill(200, 100);
    stroke(0);
    pushMatrix();
    translate(l.x, l.y);
    rotate(theta);

    // Thrusters
    rectMode(CENTER);
    fill(0);
    rect(-r/2, r*2, r/2, r);
    rect(r/2, r*2, r/2, r);

    // Rocket body
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();

    popMatrix();
  }
  void update(){
    v.add(a);
    l.add(v);
    a.mult(0);
  }
  void addforce(PVector f){
    a.add(f);
  }
  void checktarget(){
     float d=dist(l.x,l.y,target.x,target.y);
     if(d<12){
       hittarget=true;
     }
  }
}
