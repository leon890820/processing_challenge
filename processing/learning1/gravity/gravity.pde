bubble[] bubbles=new bubble[100];
PImage HGUs[]=new PImage[3];
void setup(){
  size(640,360,P2D);
  background(0);
  for(int i=0;i<bubbles.length;i+=1){
    bubbles[i]=new bubble();
  }
  for(int i=0;i<HGUs.length;i+=1){
    HGUs[i]=loadImage("HGU"+i+".png");
  }
}
void draw(){
  background(0);
  for(int i=0;i<bubbles.length;i+=1){
    bubbles[i].display();
    bubbles[i].usegravity();
    bubbles[i].reset();
    //delay(100);
  }
}
