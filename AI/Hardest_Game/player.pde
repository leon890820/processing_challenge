class Player {
  PVector position;
  float playerSize=20;
  float v=4;
  boolean death=false;
  boolean[] collision={false,false,false,false};
  float deathAnimation=0;
  PVector IP;
  color c;
  int deathTime=0;
  Player(float x,float y) {
    position=new PVector(x, y);
    IP=new PVector(x,y);
    c=color(255,0,0,255);
  }
  
  void death(){
    for(int i=0;i<enemys.size();i+=1){
      if(dist(position.x,position.y,enemys.get(i).position.x,enemys.get(i).position.y)<playerSize/2+enemys.get(i).radius){
        death=true;
      }
    }
    if(death){
      
      deathAnimation();
    
    }
  }
  
  void deathAnimation(){
    float alpha=map(deathAnimation,0,1,255,0);
    c=color(255,0,0,alpha);
    deathAnimation+=0.01;
    if(deathAnimation>1){
      c=color(255,0,0,255);
      deathAnimation=0;
      death=false;
      position=new PVector(IP.x,IP.y);
      deathTime+=1;
    }
  }
  
  void win(){
    if(position.x>end.position.x&&position.x<end.position.x+end.len&&position.y>end.position.y&&position.y<end.position.y+end.hei){
      win=true;
    }
  
  }
  
  void show() {
    rectMode(CENTER);
    fill(c);
    stroke(255);
    rect(position.x, position.y, playerSize, playerSize);
  }
  void move() {
    for(int i=0;i<collision.length;i+=1) {
      collision[i]=false;
    }
    collision();
    PVector dir=new PVector(0, 0);
    if (keyboardDetect[0]==true) dir.add(new PVector(-v, 0));
    if (keyboardDetect[1]==true) dir.add(new PVector(0, v));
    if (keyboardDetect[2]==true) dir.add(new PVector(v, 0));
    if (keyboardDetect[3]==true) dir.add(new PVector(0, -v));
    dir.normalize();
    dir.mult(v);
    if(collision[0]==true && dir.x<0) dir.x=0;
    if(collision[1]==true && dir.y>0) dir.y=0;
    if(collision[2]==true && dir.x>0) dir.x=0;
    if(collision[3]==true && dir.y<0) dir.y=0;
    movePlayer(dir.x, dir.y);
    
  }
  void movePlayer(float x, float y) {
    player.position.add(new PVector(x, y));
  }
  void collision() {
    for (Obstacle o : obstacles) {
      isCollision(o);     
    }
  }
  void isCollision(Obstacle o){   
    PVector lu=new PVector(position.x-playerSize/2,position.y-playerSize/2);
    PVector ru=new PVector(position.x+playerSize/2,position.y-playerSize/2);
    PVector rd=new PVector(position.x+playerSize/2,position.y+playerSize/2);
    PVector ld=new PVector(position.x-playerSize/2,position.y+playerSize/2);
    PVector lc=new PVector(position.x-playerSize/2,position.y);
    PVector rc=new PVector(position.x+playerSize/2,position.y);
    PVector uc=new PVector(position.x,position.y-playerSize/2);
    PVector dc=new PVector(position.x,position.y+playerSize/2);
    if(isin(lc,o)) collision[0]=true;
    if(isin(dc,o)) collision[1]=true;
    if(isin(rc,o)) collision[2]=true;
    if(isin(uc,o)) collision[3]=true;
  }
  boolean isin(PVector p,Obstacle o){
    if(p.x<o.position.x+o.len/2&&p.x>o.position.x-o.len/2&&p.y<o.position.y+o.hei/2&&p.y>o.position.y-o.hei/2) return true;
    else return false;
  }
}
