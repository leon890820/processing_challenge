class particle{
  PVector location;
  PVector v;
  PVector a;
  float life;
  float ran=int(random(5));
  PVector wind=new PVector(random(-0.1,0.1),0);
  particle(){
    location =new PVector(mouseX,mouseY);
    v =new PVector(random(-0.8,0.8),0);
    a =new PVector(0,0);
    life=255;
  }
  
  void display(){
    fill(255,life);
    imageMode(CENTER);
    tint(life);
    image(imgs[int(ran)],location.x,location.y,32,32);
     //circle(location.x,location.y,10);
  
  }
  void update(){
    location.add(v);
    v.add(a);
    a.mult(0);
    life-=2;
  }
  boolean isdeath(){
    if(life>0) return false;
    else return true;
  }
  void addforce(PVector force){
    a.add(force);
  }
   void addforce(){
     PVector wind=new PVector(random(-0.5,0.5),0);
    a.add(wind);
  }
  
}
