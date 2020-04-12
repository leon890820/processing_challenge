float maxvx=1;
float minvx=-1;
float maxvy=1;
float minvy=-1;
float u=0;
float d=0;
void setup(){
  size(640,640);
  
}
void draw(){
  translate(u,d);
  pixelDensity(1);
  loadPixels();
  for(int x=0;x<width;x+=1){
    for(int y=0;y<height;y+=1){
      float a=map(x,0,width,minvx,maxvx);
      float b=map(y,0,height,minvy,maxvy);
      
      float ca=a;
      float cb=b;
      float n=0;
      while(n<100){
        float aa=a*a-b*b;
        float bb=2*a*b;
        a=aa+ca;
        b=bb+cb;
        
        if(a+b>2) break;
        n+=1;
      }
      float bright=map(n,0,100,0,255);
      if (n==100) bright=0;
      float pix=(x+y*width);
      pixels[(int)pix+0]=color(bright,bright,bright,255);
      
    }
  }
  updatePixels();
  float mx=map(mouseX,0,width,minvx,maxvx);
  float my=map(mouseY,0,height,minvy,maxvy);
  float n=0;
  float a=mx;
  float b=my;
  while(n<100){
        float aa=a*a-b*b;
        float bb=2*a*b;
        a=aa+mx;
        b=bb+my;
        float wx=map(a,minvx,maxvx,0,width);
        float wy=map(b,minvy,maxvy,0,height);
        fill(0,0,255);
        noStroke();
        circle(wx,wy,5);
        //if(a+b>2) break;
        n+=1;
      }
}
void keyPressed(){
  if(key=='='){
    maxvx*=0.9;
    maxvy*=0.9;
    minvx*=0.9;
    minvy*=0.9;
  }
  if(key=='-'){
   
    maxvx/=0.9;
    maxvy/=0.9;
    minvx/=0.9;
    minvy/=0.9;
  }
  if(key=='w') {
    maxvy-=0.1;
    minvy-=0.1;
  }
  if(key=='s') {
    maxvy+=0.1;
    minvy+=0.1;
  }
  if(key=='a') {
    maxvx-=0.1;
    minvx-=0.1;
  }
  if(key=='d') {
    maxvx+=0.1;
    minvx+=0.1;
  }
  
}
