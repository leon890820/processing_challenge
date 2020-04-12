class bird{
  boolean deaths=false;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float fitness=0;
  float[] c={random(255),random(255),random(255)};
  precentron p;
   obstacle ob;
  bird(){
    location=new PVector(200,500/2);
    velocity=new PVector (0,0);
    acceleration=new PVector (0,0.2);
    p=new precentron();
  
  }
  void run(){
    show();
    update();
    ifdeath();
    //earnpoint();
    getnearobstacle();
    if(p.output[0]>0.5&&death==false) jump();
    if(deaths==true&&death==false){
      location=new PVector(-10000,0);
      velocity=new PVector(-3,0);
    }
    if(death==true ) velocity=new PVector(-1,0);
    if(deaths==false) fitness+=1;
  }
  
  void show(){
    noStroke();
    fill(c[0],c[1],c[2]);
    circle(location.x,location.y,10);
  }
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
  }
  void jump(){
    velocity=new PVector(0,-5);
  
  }
  void ifdeath(){
    if(ifwall()==true){
      deaths=true;
    }  
  }
   void earnpoint(){
    for(obstacle o:obstacles){
    if (location.x>o.location.x&&o.getpoint==false&&deaths==false){
      o.getpoint=true;
      fitness+=1;
      
      }
    }
    //print(fitness+"\n");
  }
  boolean ifwall(){
    boolean wall=false;
    for(obstacle o:obstacles){
      if((location.x>o.location.x-w&&location.x<o.location.x+w&&location.y<o.location.y-h)||(location.x>o.location.x-w&&location.x<o.location.x+w&&location.y>o.location.y+h)){
          wall=true;
         }
      }
      return wall;
  }
  void getnearobstacle(){
   
    if(obstacles.size()>0){
      ob=obstacles.get(0);
      if(ob.location.x<location.x&&obstacles.size()>1) ob=obstacles.get(1);
       float[] in={ob.location.x-location.x,ob.location.y-location.y};
       p.run(in);
    
    }  
  }
  bird crossover(bird b){
    int midpoint=(int)random(6);
    bird child=new bird();
    for(int i=0;i<6;i+=1){
      if(i<midpoint){
        child.p.w1[0][i]=p.w1[0][i];
        child.p.w1[1][i]=p.w1[1][i];
        child.p.w2[0][i]=p.w2[0][i];
      }
      else{
        child.p.w1[0][i]=b.p.w1[0][i];
        child.p.w1[1][i]=b.p.w1[1][i];
        child.p.w2[0][i]=b.p.w2[0][i];
      }    
    }
    return child;
  }
  void mutate(){
    for(int i=0;i<2;i+=1){
      for(int j=0;j<6;j+=1){
        if(random(1)<mutationrate){
          p.w1[i][j]=random(-1,1);
        }
      }
    }
    for(int i=0;i<6;i+=1){
      if(random(1)<mutationrate){
        p.w2[0][i]=random(-1,1);
      }
    }
  }
    
    
}
