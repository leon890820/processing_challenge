class vehicle{
  PVector location;
  float attackdamage=10;
  float hp=100;
  PVector velocity;
  PVector acceleration;
  boolean invincible=false;
  float invincibletime=0;
  vehicle(float x,float y){
    location=new PVector(x,y);
    velocity=new PVector(0,0);
    acceleration=new PVector(0,0);
  }
  void run(){
    if(playerisdeath()==false){
      reject();
      show();
      update();
    }
   
    //addforce();
  }
  void show(){
    if(invincibletime%2==1)fill(255,0,0);
    else fill(255);
    
    noStroke();
    circle(location.x,location.y,30);
    noFill();
    stroke(255);
    circle(location.x,location.y,r*2);
  }
  void update(){
      location=new PVector(mouseX,mouseY);
  }
  void addforce(){
    if(keyPressed){
      if(key=='A'||key=='a') location.add(new PVector(-5,0));
      if(key=='S'||key=='s') location.add(new PVector(0,5));
      if(key=='D'||key=='d') location.add(new PVector(5,0));
      if(key=='W'||key=='w') location.add(new PVector(0,-5));
    }
  }
  void reject(){
    for(enemy e:enemys){
      float d=dist(location.x,location.y,e.location.x,e.location.y);
      if (d<30&&invincible==false){
        hp-=5;
        invincible=true;
      }
    }
    for(bossbullet b:bossbullets){
      float d=dist(location.x,location.y,b.location.x,b.location.y);
      if (d<20&&invincible==false){
        hp-=5;
        invincible=true;
      }
    }
    if(invincible==true){
      float m=map(invincibletime,0,50,150,0);
      background(m,0,0);
      invincibletime+=1;
      if(invincibletime>50){
        invincibletime=0;
        invincible=false;
      }
    }
  }
  boolean playerisdeath(){
    if(hp>0) return false;
    else return true;
  }
}
