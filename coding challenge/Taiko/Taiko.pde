PImage taiko_menu_background;
PImage taiko_menu_background_text;
boolean menu=true;
boolean selectSong=false; 
int selectSongIndex=0;
class Splash{float speed;float time=0;int nowPos=0;float[] path=new float[2];Splash(float start,float end,float s){path[0]=start;path[1]=end;speed=s;}}
Splash splash=new Splash(255,0,2); 

void setup(){
  size(1230,692);
  
  taiko_menu_background=loadImage("taiko_menu_background.png");
  taiko_menu_background_text=loadImage("taiko_menu_background_text.png");
}

void draw(){
  background(0);
  
  if(menu) menu();
  else if(selectSong) selectSong();
  

}

void menu(){ 
  tint(255,255);
  image(taiko_menu_background,0,0);
  float alpha=map(splash.time,0,1,splash.path[splash.nowPos%2],splash.path[(splash.nowPos+1)%2]);
  tint(255,alpha);
  image(taiko_menu_background_text,0,0);
  splash.time+=0.01*splash.speed;
  if(splash.time>1){
    splash.nowPos+=1;
    splash.time=0;
  }
}

void selectSong(){



}
