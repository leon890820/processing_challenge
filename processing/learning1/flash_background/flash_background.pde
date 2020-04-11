float c1;
float c2;
float c3;
void setup(){
size(640,360);
background(0);
}
void draw(){
  
  background(0);
  stroke(255);
  for(int x=0;x<width;x+=20){
    line(x,0,x,height);
  }
  for(int y=0;y<height;y+=20){
    line(0,y,width,y);
  }
  
  for(int i=0;i<height;i+=20){
    for(int j=0;j<width;j+=20){
   
      fill(random(0,255));
      rect(j,i,20,20);
    }
  }
  delay(100);
  
}
