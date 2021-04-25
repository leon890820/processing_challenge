class Ray {
  PVector position;
  PVector dir;
  Ray(float x, float y, float angle) {
    position=new PVector(x, y);
    dir=new PVector(cos(angle), sin(angle));
  }
  PVector show(Boundary wall) {
    return checkwall(wall);
  }
    

  PVector checkwall(Boundary wall) {
    float x3=position.x;
    float y3=position.y;
    float x4=position.x+dir.x;
    float y4=position.y+dir.y;
    float x1=wall.start.x;
    float y1=wall.start.y;
    float x2=wall.end.x;
    float y2=wall.end.y;

    float delta=(x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
    if (delta==0) return null;
    float t=((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/delta;
    float u=((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/delta;
    if (t>0 && t<1 && u>0) {
      float px=x1+t*(x2-x1);
      float py=y1+t*(y2-y1);
      return new PVector(px,py);
    } else return null;
  }
}
