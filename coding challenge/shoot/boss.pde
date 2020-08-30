class boss{
  PVector location;
  PVector velocity;
  float Hindex=0;
  boolean change=false;
  boolean fuze=false;
  float hp=5000;
  boolean skill=false;
  float skilltime=0;
  boss(){
    location=new PVector(width/2,-100);
    velocity=new PVector(0,1);
    
  }
  void run(){   
    show();
    update();
    bedamage();
    death();
    playerdeath();
    fill(255,0,0);
    text("hp:"+str((int)hp),location.x-20,location.y-150);
  }
  void show(){
    imageMode(CENTER);
    image(HGUboss[(int)Hindex],location.x,location.y,195,267);
    Hindex+=0.5;
    if(Hindex>19){
      Hindex=0;
    }
    
  }
  void update(){
    if(location.y<200){
      state1();
    }
    else if(hp>2500) {
      if(change==false){
        velocity=new PVector(2,0);
        change=true;
      }
    state2();
    killweakmonster();
    }
    else{
      fuze=true;
      state3();
    }
  }
  void state1(){
    location.add(velocity);
  }
  void state2(){
    if(location.x<50||location.x>width-50){
      velocity.mult(-1);
    }
    location.add(velocity);
  }
  void state3(){
    if(location.x<50||location.x>width-50){
      velocity.mult(-1);
    }
    location.add(velocity);
  }
  void letHGUdeath(){
    if(enemys.size()>0){
      for(enemy e:enemys){
        e.hp-=1;
      }
    }
  }
  void killweakmonster(){
    if(enemys.size()>0){
      for(enemy e:enemys){
        PVector target=PVector.sub(e.location,location);
        target.normalize();
        target.mult(20);
        bossbullets.add(new bossbullet(location.x,location.y,target.x+e.velocity.x,target.y+e.velocity.y));
      }
    }
    for(int i=0;i<bossbullets.size();i+=1){
      bossbullet b=bossbullets.get(i);
      b.run();
      for(enemy e:enemys){
        if(dist(b.location.x,b.location.y,e.location.x,e.location.y)<15){
          e.hp-=b.attackdamage;
          b.location=new PVector(9999,9999);
      }
    }
    if(b.isdeath()){     
      bossbullets.remove(i);
      }
    }
  }
  void bedamage(){
    for(bullet b:bullets){
      float d=dist(location.x,location.y,b.location.x,b.location.y);
      if(d<105){
        b.location=new PVector(9999,9999);
        hp-=b.attackdamage;
      }
    }
  }
  
  void death(){
    if(hp<=0){
      bosses.remove(0);
      bosscome=false;
      bossdeath=true;
    }
  }
  void playerdeath(){
    if(v.playerisdeath()){
      PVector target=PVector.sub(v.location,location);
        target.normalize();
        target.mult(20);
        bossbullets.add(new bossbullet(location.x,location.y,target.x,target.y));
    }
  }
  void bossSkill(){
    
    skill1();
    skill2();
    skill3();
  }
  void skill1(){
  
  }
  void skill2(){
  
  }
  void skill3(){
  
  }
  
}
