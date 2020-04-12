PImage HGU;
void setup(){
  size(400,314);
  HGU=loadImage("HGU.jpg");
  background(0);
}
void draw(){
  loadPixels();
  for(int x=0;x<width-1;x+=1){
    for(int y=0;y<height;y+=1){
      int loc1=x+y*width;
      int loc2=(x+1)+y*width;
      float b1=brightness(HGU.pixels[loc1]);
      float b2=brightness(HGU.pixels[loc2]);
      float diff=abs(b1-b2);
      pixels[loc1]=color(diff);
    }
  }
  
  updatePixels();
}
