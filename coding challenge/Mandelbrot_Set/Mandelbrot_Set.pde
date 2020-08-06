import peasy.*;
PeasyCam cam;
float maxvx=2;
float minvx=-2;
float maxvy=2;
float minvy=-2;
PVector scalePoint=new PVector(-1.42,0);
float xspace=maxvx-minvx;
float yspace=maxvy-minvy;
float xspmax=abs(maxvx-scalePoint.x)/(maxvx-minvx);
float xspmin=abs(minvx-scalePoint.x)/(maxvx-minvx);
float yspmax=abs(maxvy-scalePoint.y)/(maxvy-minvy);
float yspmin=abs(minvy-scalePoint.y)/(maxvy-minvy);
float u=0;
float d=0;
void setup(){
  size(600,600);
  cam=new PeasyCam(this,100);
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
      float bright=map(n,0,100,80,255);
      if (n==100) {
        bright=0;
        float pix=(x+y*width);
        pixels[(int)pix+0]=color(bright,bright,bright,255);
      }
      else{
        float pix=(x+y*width);
        colorMode(HSB);
        pixels[(int)pix+0]=color(255-bright,255,200);
      }
      
    }
  }
  updatePixels();
  float mx=map(mouseX,0,width,minvx,maxvx);
  float my=map(mouseY,0,height,minvy,maxvy);
  float n=0;
  float a=mx;
  float b=my;
  //while(n<100){
  //      float aa=a*a-b*b;
  //      float bb=2*a*b;
  //      a=aa+mx;
  //      b=bb+my;
  //      float wx=map(a,minvx,maxvx,0,width);
  //      float wy=map(b,minvy,maxvy,0,height);
  //      fill(0,0,255);
  //      noStroke();
  //      circle(wx,wy,5);
  //      //if(a+b>2) break;
  //      n+=1;
  //    }
    root();
}
void root(){
    xspace*=0.9;
    yspace*=0.9;
    maxvx=xspace*xspmax+scalePoint.x;
    minvx=-xspace*xspmin+scalePoint.x;
    maxvy=yspace*yspmax+scalePoint.y;
    minvy=-yspace*yspmin+scalePoint.y;
    

}

void keyPressed(){
  if(key=='='){
    xspace*=0.999;
    yspace*=0.999;
    maxvx=xspace*xspmax+scalePoint.x;
    minvx=-xspace*xspmin+scalePoint.x;
    maxvy=yspace*yspmax+scalePoint.y;
    minvy=-yspace*yspmin+scalePoint.y;
    
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
