class Vector {
  float x;
  float y;
  Vector(float _x, float _y) {
    x=_x;
    y=_y;
  }
  void rotate(float a) {
    float newx=cos(a)*x-sin(a)*y;
    float newy=sin(a)*x+cos(a)*y;
    x=newx;
    y=newy;
  }
  void translate(PVector p){
    x+=p.x;
    y+=p.y;
  }
  
  float projectOntoLength(PVector p){
    float a=(x*p.x+y*p.y)/(p.magSq());
    return a;  
  }
  PVector projectOnto(PVector p){
    float a=(x*p.x+y*p.y)/(p.magSq());
    PVector r=p.copy();
    return r.mult(a);  
  }
  PVector getNormal(){
    return new PVector(y,-x);
  
  }
}
