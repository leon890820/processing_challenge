preceptron p;
point[] points;
point p1;
point p2;
point p3;
point p4;

void setup(){
  size(400,400);
  p=new preceptron();
  points=new point[100];
  p1=new point(-1,f(-1));
  p2=new point(1,f(1));
  
  
  for (int i=0;i<points.length;i+=1){
    points[i]=new point();
  }
  
}
void draw(){
  p3=new point(-1,p.guessY(-1));
  p4=new point(1,p.guessY(1));
  background(100,100);
  stroke(0);
  line(p1.px,p1.py,p2.px,p2.py);
  line(p3.px,p3.py,p4.px,p4.py);
  for (point pt:points){
    pt.show();
  }
  for(point pt:points){
    float[] inputs={pt.x,pt.y,pt.bias};
    p.train(inputs,pt.lable);
    int guess=p.guess(inputs);
    //print(guess+"\n");
    noStroke();
    if(guess==pt.lable) fill(0,255,0);
    else fill(255,0,0);
    circle(pt.px,pt.py,4);
  }
  print(p.weight[0],p.weight[1]+"\n");

}
float f(float x){
  float y=2*x+0.2;
  return y;
}
