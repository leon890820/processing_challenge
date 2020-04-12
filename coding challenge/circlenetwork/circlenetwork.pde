void setup(){
  size(300,300);
  background(0);
  
  
  drawline(2,6,1,2);
  drawline(6,1,2,3);
  noStroke();
  drawcircle(2,1);
  drawcircle(6,2);
  drawcircle(1,3);
}

void drawcircle(int num,int w){
  for(int i=0;i<num;i+=1){
    circle(width*w/4,(i+1)*height/(num+1),20);
  }
}
void drawline(int w1,int w2,int q1,int q2){
   for(int i=0;i<w1;i+=1){
     for(int j=0;j<w2;j+=1){
       if(random(1)<0.5) stroke(0,0,255);
       else stroke(255,0,0);
       line(width*q1/4,(i+1)*height/(w1+1),width*q2/4,(j+1)*height/(w2+1));  
     }
   }
}
