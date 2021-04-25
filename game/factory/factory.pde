PImage imgiron;
PImage imgplayer;
Player player;
IronCenter[] ironCenter=new IronCenter[5];
boolean UI=false;
float scl=20;
PImage UIbgd;
void setup(){
  size(600,600);
  imgiron=loadImage("iron.png");
  imgplayer=loadImage("player.png");
  player=new Player();
  UIbgd=loadImage("Grey_full.png");
  for(int i=0;i<ironCenter.length;i+=1){
    ironCenter[i]=new IronCenter();
  }
}

void draw(){
  background(0);
  
  translate(width/2-player.position.x,height/2-player.position.y);
  for(int i=0;i<ironCenter.length;i+=1){
    ironCenter[i].run();
  }
  player.run();
  if(UI==true) UI();
  
}


void UI(){
  

}



void keyReleased(){
  
}

void mousePressed(){
  if(UI==false){    
    player.dig();
  }
  else{
  
  }

}

void keyPressed(){
  if(key=='E'|| key=='e'){
    UI=!UI;
  }

}
