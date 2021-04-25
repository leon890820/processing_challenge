class sortDot {
  float theda;
  float phi;
  int index;
  int label;
  float radious;
  float a=1;
  float b=1;
  sortDot(int _t, int _l) {
    index=_t;
    label=_l;
    theda=int(index/sqrt(num));
    phi=index%sqrt(num);
    radious=200;
  }
  void show() {
    colorMode(HSB);
    //float t=map(theda,0,2*PI,0,num);
    float r=min(abs(index-label), abs(abs(index-label)-num));
    float thedam=map(theda, 0, sqrt(num), 0, PI);
    float phim=map(phi, 0, sqrt(num), 0, 2*PI);
    float r1=supershape(thedam,4,100,100,100);
    float r2=supershape(phim,4,100,100,100);
    r=radious-map(r, 0, num/2, 0, radious);
    float x=r*r1*r2*sin(thedam)*cos(phim);
    float y=r*r1*r2*sin(thedam)*sin(phim);
    float z=r*r1*cos(thedam);
    float th=map(label, 0, num, 0, 255);
    color c=color(th, 255, 255);
    noStroke();
    fill(c);
    pushMatrix();
    translate(x, y, z);
    circle(0, 0, 4);
    popMatrix();
  }

  float supershape(float theda, float m, float n1, float n2, float n3) {
    float t1=pow(abs(cos(m*theda/4)/a), n2);
    float t2=pow(abs(sin(m*theda/4)/b), n3);
    float r=pow(t1+t2, -1/n1);

    return r;
  }
}  
