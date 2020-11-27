class Backpad{
  PImage UIbgd;
  PImage ironimg;
  float iron=0;
  float carbon=0;
  UI playerUI;
  Backpad(){
    playerUI=new UI();
    UIbgd=loadImage("Grey_full.png");
    ironimg=loadImage("ironb.png");
  }
  
  void show(PVector location){
    imageMode(CENTER);
    image(UIbgd,location.x,location.y,400,200);
  }
  
  



}
