PVector l=new PVector(0,0);
void setup(){
  size(500,500);
  background(0);
  
}
void draw(){
  for(int i=0;i<10;i+=1){
  int r=(int)random(100);
  if(r<1){
    l=translate1(l);
  }
  else if(1<=r&&r<86){
    l=translate2(l);
  }
   else if(86<=r&&r<93){
    l=translate3(l);
  }
  else{
    l=translate4(l);
  }
  float lx=map(l.x,0,1,0,500);
  float ly=map(l.y,0,1,500,0);
  fill(255);
  noStroke();
  circle(lx,ly,1);
  print(lx,ly,"\n");
  }
}
PVector translate1(PVector l_){
  l_.x=0*l.x+0*l.y+0.5;
  l_.y=0*l.x+0.16*l.y+0;
  return l_;
}

PVector translate2(PVector l_){
  l_.x=0.85*l.x+0.04*l.y+0.08;
  l_.y=-0.04*l.x+0.85*l.y+0.18;
  return l_;
}
PVector translate3(PVector l_){
  l_.x=0.2*l.x-0.26*l.y+0.4;
  l_.y=0.23*l.x+0.22*l.y+0.05;
  return l_;
}
PVector translate4(PVector l_){
  l_.x=-0.15*l.x+0.28*l.y+0.58;
  l_.y=0.26*l.x+0.24*l.y-0.09;
  return l_;
}
