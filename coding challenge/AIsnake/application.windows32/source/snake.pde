class snake{
  PVector location;
  PVector velocity;
  boolean hitwall=false;
  boolean hitbody=false;
  ArrayList<PVector> sn;
  float fitness;
  float lifetime=200;
  float fitnessrate=0;
  float fitnessrange1=0;
  float fitnessrange2=0;
  float dis=0;
  float pdis=0;
  boolean death=false;
  food f;
  float score=0;
  float[] look=new float[24];
  NeuralNetwork n=new NeuralNetwork();
  
  snake(){
    
    location=new PVector((int)random(1,row-1),(int)random(1,cul-1));
    PVector l=location.get();
    velocity=new PVector(1,0);
    key='d';
    f=new food();
    sn=new ArrayList<PVector>();
    sn.add(l.add(new PVector(-1,0)));
    l=location.get();
    sn.add(l.add(new PVector(-1,0)));
  }
  void run(){
    
   
    if(death==false){ 
      //show();
      //f.run();
      lifetime-=1;
      //pdis=abs(location.x-f.location.x)+abs(location.y-f.location.y);
      //float dif=dis-pdis;
     // if(dif>0) fitness+=1;
      //else fitness-=2;
      dis=pdis;
      lookaround();
      
      isdeath();      
      ifeat();
      turn();
      
      NN();
      //print(n.output[0]+" "+n.output[1]+" "+n.output[2]+" "+n.output[3]+"\n");
      AIturn();
      update();
      frame=0;      
    }
    
  }
  void show(){
    
    for(PVector ss:sn){
      fill(255);
      rect(ss.x*scl,ss.y*scl,scl,scl);
    }
    fill(0,255,0);
    rect(location.x*scl,location.y*scl,scl,scl);
  }
  void update(){
    
    for(int i=0;i<sn.size()-1;i+=1){
      PVector sp;
      sp=sn.get(i+1);
      sn.get(i).x=sp.x;
      sn.get(i).y=sp.y;
    }
    if(sn.size()>0){
      sn.get(sn.size()-1).x=location.x;
      sn.get(sn.size()-1).y=location.y;
    }
    location.add(velocity);
  }
  void ifeat(){
    if(location.x==f.location.x&&location.y==f.location.y){
      f.eaten();
      sn.add(new PVector(location.x-velocity.x,location.y-velocity.y));
      score+=1;
      //fitness+=50;
      lifetime+=100;
      if (lifetime>200) lifetime=200;
    }
  }
  void turn(){
    if(key=='d'||key=='D') velocity=new PVector(1,0);
    else if(key=='a'||key=='A') velocity=new PVector(-1,0);
    else if(key=='s'||key=='S') velocity=new PVector(0,1);
    else if(key=='w'||key=='W') velocity=new PVector(0,-1);
  }
  
  void AIturn(){
    int index=0;
    float maxrecord= -1000000000;
    for(int i=0;i<n.output.length;i+=1){
      if(n.output[i]>maxrecord) {
        maxrecord=n.output[i];
        index=i;
      }
    }
    //print(index+"\n");
    if(index==0) velocity=new PVector(0,-1);
    else if(index==1) velocity=new PVector(-1,0);
    else if(index==2) velocity=new PVector(0,1);
    else  velocity=new PVector(1,0);
  
  
  }
  void isdeath(){
    for(PVector ss:sn) {
      if(location.x==ss.x&&location.y==ss.y){
        death=true;
        hitbody=true;
      }
    }
    if(location.x>=row||location.x<0||location.y>=cul||location.y<0) {
      hitwall=true;
      death=true;
    }
    if (lifetime<=0) death=true;
  }
  void lookaround(){
    look[0]=lookdirection(new PVector(-1,0))[0];
    look[1]=lookdirection(new PVector(-1,0))[1];
    look[2]=lookdirection(new PVector(-1,0))[2];
    look[3]=lookdirection(new PVector(-1,1))[0];
    look[4]=lookdirection(new PVector(-1,1))[1];
    look[5]=lookdirection(new PVector(-1,1))[2];
    look[6]=lookdirection(new PVector(0,1))[0];
    look[7]=lookdirection(new PVector(0,1))[1];
    look[8]=lookdirection(new PVector(0,1))[2];
    look[9]=lookdirection(new PVector(1,1))[0];
    look[10]=lookdirection(new PVector(1,1))[1];
    look[11]=lookdirection(new PVector(1,1))[2];
    look[12]=lookdirection(new PVector(1,0))[0];
    look[13]=lookdirection(new PVector(1,0))[1];
    look[14]=lookdirection(new PVector(1,0))[2];
    look[15]=lookdirection(new PVector(1,-1))[0];
    look[16]=lookdirection(new PVector(1,-1))[1];
    look[17]=lookdirection(new PVector(1,-1))[2];
    look[18]=lookdirection(new PVector(0,-1))[0];
    look[19]=lookdirection(new PVector(0,-1))[1];
    look[20]=lookdirection(new PVector(0,-1))[2];
    look[21]=lookdirection(new PVector(-1,-1))[0];
    look[22]=lookdirection(new PVector(-1,-1))[1];
    look[23]=lookdirection(new PVector(-1,-1))[2];
  
  }
  
  float[] lookdirection(PVector direction){
    float count=1;
    float[] rr=new float[3];
    PVector dir=direction.get();
    PVector testlocation=location.get();
    boolean body=false;
    boolean wall=false;
    boolean food=false;
    
    while (body==false){
      dir=direction.get();
      dir.mult(count);
      testlocation=location.get();
      testlocation.add(dir);
      if(testlocation.x<0||testlocation.x>=row||testlocation.y<0||testlocation.y>=cul) break;
      for(PVector ss:sn){        
        if(testlocation.x==ss.x&&testlocation.y==ss.y){
          body=true;
        }
      }
      count+=1;
      if (count<0||count>row) break;
    }
    if (body==true) rr[0]=1;//(count-1);
    else rr[0]=0;
    count=1;
    testlocation=location.get();
    dir=direction.get();
    
    
    while (food==false){
      dir=direction.get();
      testlocation=location.get();
      dir.mult(count);
      testlocation.add(dir);
      if(testlocation.x<0||testlocation.x>=row||testlocation.y<0||testlocation.y>=cul) break;
      if(testlocation.x==f.location.x&&testlocation.y==f.location.y) food=true;   
      count+=1;
      
    }
    if(food==true) rr[1]=1;//(count-1);
    else rr[1]=0;
    count=1;
    testlocation=location.get();
    dir=direction.get();
    
    while(wall==false){
       testlocation=location.get();
       dir=direction.get();
       dir.mult(count);
       testlocation.add(dir);
       if(testlocation.x<0||testlocation.x>=row||testlocation.y<0||testlocation.y>=cul) wall=true;
       count+=1;    
    }
    rr[2]=1/(count-1);
    
    
    
    return rr;
     
  }
  
  void NN(){
    n.run1(look);
  }
  
  snake crossover(snake k){
    snake child=new snake();
    int midpoint=(int)random(24);
    for(int i=0;i<20;i+=1){
      
      for(int j=0;j<24;j+=1){
        if(i<midpoint) child.n.w1[i][j]=n.w1[i][j];
        else child.n.w1[i][j]=k.n.w1[i][j];
      }
      if(i<midpoint) child.n.bias_h1[i]=n.bias_h1[i];
      else child.n.bias_h1[i]=k.n.bias_h1[i];
    }
    midpoint=(int)random(20);
    for(int i=0;i<20;i+=1){
      for(int j=0;j<20;j+=1){
        if(i<midpoint) child.n.w2[i][j]=n.w2[i][j];
        else child.n.w2[i][j]=k.n.w2[i][j];
      }
      if(i<midpoint) child.n.bias_h2[i]=n.bias_h2[i];
      else child.n.bias_h2[i]=k.n.bias_h2[i];
    }
    midpoint=(int)random(4);
    for(int i=0;i<4;i+=1){
      for(int j=0;j<20;j+=1){
        if(i<midpoint) child.n.w3[i][j]=n.w3[i][j];
        else child.n.w3[i][j]=k.n.w3[i][j];
      }
      if(i<midpoint) child.n.bias_o[i]=n.bias_o[i];
      else child.n.bias_o[i]=k.n.bias_o[i];
    }
    return child;
  }
  void mutate(){
    for(int i=0;i<20;i+=1){
      for(int j=0;j<24;j+=1){
        if(random(1)<mutationrate) n.w1[i][j]+=randomGaussian()/5;
        if(n.w1[i][j]>=1) n.w1[i][j]=1;
      }
    }
    
    for(int i=0;i<20;i+=1){
      for(int j=0;j<20;j+=1){
        if(random(1)<mutationrate) n.w2[i][j]+=randomGaussian()/5;
        if(n.w2[i][j]>=1) n.w2[i][j]=1;
      }
    }
    
    for(int i=0;i<4;i+=1){
      for(int j=0;j<20;j+=1){
        if(random(1)<mutationrate) n.w3[i][j]+=randomGaussian()/5;
        if(n.w3[i][j]>=1) n.w3[i][j]=1;
      }
    }
  }
  void keyPressed(){
    key='d';
  }
  void calculateFitness() {//calculate the fitness of the snake
  /*
     if(score < 10) {
       if(lifetime>190&&score==0) lifetime=0;
       else if((hitwall||hitbody)&&score==0) lifetime=0;//200/lifetime;
       else if(lifetime>190||hitwall||hitbody) lifetime=200/lifetime;
       if(lifetime<0) lifetime=0;
        fitness = (int)pow(lifetime,2) * pow(5,score+2); 
     } 
     else {
        fitness = (int)(lifetime*lifetime);
        fitness *= 1024;
        fitness *= (score-9);
     }
     */
     fitness=score*score*100;
     if(hitwall) fitness*=0.2;
     if(hitbody) fitness*=0.2;
     if(fitness<=0) fitness=0;
  }


}
