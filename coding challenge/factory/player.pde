class Player{
  PImage[] playerimages=new PImage[16];
  PImage UIbgd;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float count=1;
  int forward=0;
  boolean pUI=false;
  boolean click=false;
  boolean imform=false;
  Backpad playerBackpad;
  
  Player(){
    for(int i=0;i<playerimages.length;i+=1){
      playerimages[i]=loadImage("player\\player"+(i+1)+".png");
    }
    UIbgd=loadImage("Grey_full.png");
    position=new PVector(0,0);  
    velocity=new PVector(0,0);
    acceleration=new PVector(0,0);
    playerBackpad=new Backpad();
    
  }
  
  void run(){
    show();
    move();
    update();
    if(UI==true) playerBackpad.show(position);
   
  
  }
  void show(){
    imageMode(CENTER);
    image(playerimages[(int)count%4+forward*4],position.x,position.y,29,47);
    
  
  }
  
  
  void update(){
    position.add(velocity);
    velocity.add(acceleration);
  
  }
  
  void move(){
    if(keyPressed){
      if((key=='i'||key=='I') &&click==false){
        pUI=!pUI;
        UI=pUI;
        click=true;
      }
      if(key=='a' || key=='A'){
        velocity=new PVector(-2,0);
        forward=1;
      }
      if(key=='s' || key=='S'){
        velocity=new PVector(0,2);
        forward=0;
      }
      if(key=='d' || key=='D'){
        velocity=new PVector(2,0);
        forward=2;
      }
      if(key=='w' || key=='W'){
        velocity=new PVector(0,-2);
        forward=3;
      }
      count+=0.1;
    }
    else{
      count=1;
      velocity=new PVector(0,0);
      click=false;
    }
  
  }
  void dig(){
    
    digIron();
  
  }
  
  void digIron(){    
    for(int i=0;i<ironCenter.length;i+=1){
      for(int j=0;j<ironCenter[i].irons.length;j+=1){
        PVector m=ironCenter[i].irons[j].location;
        if(position.x>m.x&&position.x<m.x+scl&&position.y>m.y&&position.y<m.y+scl){
          ironCenter[i].irons[j].inform=true;
          playerBackpad.iron+=1;
          
        }
        
      }
    }
  }
  
 
  


}
