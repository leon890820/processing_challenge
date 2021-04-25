PImage yourLife;
PImage[] keys=new PImage[4];
void setup(){
  yourLife=loadImage("life.bmp");
  for(int i=0;i<4;i+=1){
    keys[i]=loadImage("key"+(i+1)+".bmp");
  }
  size(400,400);
  image(yourLife,0,0); 
  loadPixels();
  for(int i=0;i<keys.length;i+=1){
    for(int j=0;j<400*400;j+=1){
      if(keys[i].pixels[j]<-10000) keys[i].pixels[j]=color(0);
      if(pixels[j]<-1000) pixels[j]=color(0);
      if(pixels[j]==keys[i].pixels[j]) pixels[j]=color(255);
      else pixels[j]=color(0);  
  }
  image(yourLife,0,0);
  }
  updatePixels();
}
