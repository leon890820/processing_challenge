PImage HGU;
void setup(){
  size(400,314);
  HGU=loadImage("HGU.jpg");
  background(0);
}
void draw(){
  loadPixels();
  HGU.loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      float r=red(HGU.pixels[x+y*width]);
      float g=green(HGU.pixels[x+y*width]);
      float b=blue(HGU.pixels[x+y*width]);
      float d=dist(x,y,mouseX,mouseY);
      float d1=map(d,0,100,1,0);
      pixels[x+y*width]=color(r*d1,g*d1,b*d1);
    }
    updatePixels();
  }

}
