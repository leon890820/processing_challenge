PImage[] HGUs=new PImage[20];
float index=0;
void setup(){
  size(500,500);
  for(int i=0;i<HGUs.length;i+=1){
    HGUs[i]=loadImage("H"+(i+1)+".png");
  }
}
void draw(){
  background(0);
  imageMode(CENTER);
  image(HGUs[(int)index],width/2,height/2,195,267);
  index+=1;
  if (index>=20){
    index=0;
  }
  
}
void mousePressed(){
  
}
