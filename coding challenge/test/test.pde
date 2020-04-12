PImage img;
int sl=1;
PImage[] imgs=new PImage[100];
int row=width/sl;
int cul=height/sl;
float p=float(600)/float(640);
void setup(){
  size(640,640);
  img=loadImage("aya.png");
  loadPixels();
  int count=1;
  for(int x=0;x<row;x+=1){
    
    for(int y =0;y<cul;y+=1){
      
      color c=img.get(int(x*sl*p),int(y*sl*p));
      stroke(c);
      fill(c,255);
      rect(x*sl,y*sl,sl,sl);
 
    }
    fill(0);
    text(count,x*sl,10);
    count+=1;
  }
  //updatePixels();
  
  
}
