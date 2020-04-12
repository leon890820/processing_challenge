PImage img;
void setup(){
  size(840,640);
  img=loadImage("sponge.jpg");
}
void draw(){
  background(0);
  image(img,0,0);
}
