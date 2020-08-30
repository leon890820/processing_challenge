vehicle v;
float angle=PI/2;
float cd=0;
float cdt=0.5;
float time=0;
float r=200;
ArrayList<enemy> enemys;
ArrayList<bullet> bullets;
ArrayList<boss> bosses;
ArrayList<bossbullet> bossbullets;
float bt=0;
PImage HGU;
float dist=100000;
int index=0;
boolean autoattack=true;
PImage[] HGUboss=new PImage[20];
float score=0;
boolean bosscome=false;
boolean bossdeath=false;
void setup(){
  size(1000,1000);
  background(0);
  v=new vehicle(mouseX,mouseY);
  HGU=loadImage("HGU.png");
  enemys=new ArrayList<enemy>();
  enemys.add(new enemy());
  bullets=new ArrayList<bullet>();
  bossbullets=new ArrayList<bossbullet>();
  bosses=new ArrayList<boss>();
  for(int i=0;i<HGUboss.length;i+=1){
    HGUboss[i]=loadImage("H"+(i+1)+".png");
  }
  
}
void draw(){
  //print(enemys.size()+"\n");
 // print(autoattack+"\nw");
  cd+=0.1;
  background(0);
  playerdeath();
  v.run();
  addenemy();
  enemyremove();
  removebullets();
  attackmode();
  score();
  summonboss();
  if(bosscome==true){
    bosses.get(0).run();
  }
  
}
void addenemy(){
  time+=0.1;
  if(time>1&&v.playerisdeath()==false){
    time =0;
    enemys.add(new enemy());
  }
}
void drawline(){
  dist=1000000;
  index=0;
  for (int i=0;i<enemys.size();i+=1){
    enemy e=enemys.get(i);
    if(dist(e.location.x,e.location.y,v.location.x,v.location.y)<dist){
      dist=dist(e.location.x,e.location.y,v.location.x,v.location.y);
      index=i;
    }
  }
  if(dist<r){
    stroke(0,255,0);
    line(v.location.x,v.location.y,enemys.get(index).location.x,enemys.get(index).location.y);
    PVector path=PVector.sub(enemys.get(index).location,v.location);
    path.normalize();
    path.mult(10);
    if(cd>cdt){
      cd=0;
      bullets.add(new bullet(v.location.x,v.location.y,path.x+enemys.get(index).velocity.x,path.y+enemys.get(index).velocity.y));
    }
  }
}
void handmake(){
  PVector path=PVector.sub(v.location.get().add(new PVector (cos(angle),sin(angle))),v.location);
  path.normalize();
  path.mult(10);
  if(cd>cdt){
    cd=0;
      bullets.add(new bullet(v.location.x,v.location.y,path.x,path.y));
  }
  print((new PVector(cos(angle),sin(angle)))+"\n");
}
void keyPressed(){
  if(key==' '||key=='/'){
    autoattack=!autoattack;
  }
  
}
void removebullets(){
  for(int i=0;i<bullets.size();i+=1){
    bullet b=bullets.get(i);
    b.run();
    for(enemy e:enemys){
      if(dist(b.location.x,b.location.y,e.location.x,e.location.y)<15){
        e.hp-=b.attackdamage;
        b.location=new PVector(9999,9999);
        if(e.hp<0) score+=10;
      }
    }
    if(b.isdeath()){
      
      bullets.remove(i);
    }
  }
}
void enemyremove(){
  for (int i=0;i<enemys.size();i+=1){
    enemy e=enemys.get(i);
    e.run();
    if(e.isdeath()){
      //if(e.hp<=0) score+=10;
      enemys.remove(i);
    }    
  }
}
void attackmode(){
  if(autoattack==true){
    drawline();
  }
  else{
    handmake();
  }
  if(keyPressed){
    if(autoattack==false){
    if(key=='A'||key=='a'){
      angle-=0.03;
    }
    else if(key=='D'||key=='d'){
      angle+=0.03;
    }
  }
  }
}
void score(){
  fill(255);
  textSize(32);
  text(score,width/2,30);
  textSize(15);
  fill(255);
  text((int)v.hp,v.location.x-10,v.location.y-20);
}
void summonboss(){
  if(score>100&&bossdeath==false){
    bosscome=true;
    if(bt<=0){
      bosses.add(new boss());
    }
    bt+=1;
  }
  
}
void playerdeath(){
  if(v.playerisdeath()){
    enemys.clear();
    bullets.clear();
    textMode(CENTER);
    textSize(50);
    fill(255,0,0);
    text("YOU ARE DEAD",width/2-200,height/2);
    
  }
}
