class Sparticle extends particle{
  Sparticle(PVector o){
    super(o);
  }
  void display(){
    stroke(255,dis);
    fill(255,dis);
    rectMode(CENTER);
    rect(location.x,location.y,10,10);
    dis-=2;
  }

}
