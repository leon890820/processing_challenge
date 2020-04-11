Snakes s;
int x1;
int y1;
int[] directions;
int[] walls;
void setup(){
  s=new Snakes();
  directions=new int[4];
  directions[3]=1;
  walls=new int[4];
  background(0);
  frameRate(10);
  size(400,400);
  setLocation();
  
}
void draw(){
  if(s.total<20){
    frameRate(10);
  }
  else{
    frameRate(7+s.total/5);
  }
  background(0);
  
  s.ifwall();
  s.AI(x1*s.scl,y1*s.scl);
  s.update();
  s.death();
  s.show();
  
  if(s.eat(x1*s.scl,y1*s.scl)){
    setLocation();
  }
  fill(255,0,0);
  rect(x1*s.scl,y1*s.scl,s.scl,s.scl);
  
}
void setLocation(){  
  boolean redo=true;
  while(redo){
    redo=false;
    x1=int(random(0,width/s.scl));
    y1=int(random(0,height/s.scl));
    for(int i=0;i<s.tail.length;i+=1){
      if(x1*s.scl==s.tail[i][0]&&y1*s.scl==s.tail[i][1]){
        redo=true;
      }
      
    }
  }
   
}
void keyPressed(){
  if(keyCode==UP){
    s.dir(0,-1);
  }
  if(keyCode==DOWN){
    s.dir(0,1);
  }
  if(keyCode==RIGHT){
    s.dir(1,0);
  }
  if(keyCode==LEFT){
    s.dir(-1,0);
  }
}
