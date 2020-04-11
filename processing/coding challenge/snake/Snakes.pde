class Snakes{
  float x;
  float y;
  float scl;
  float speedx;
  float speedy;
  float[][] tail;
  int total;
  Snakes(){
    scl=20;
    x=0;
    y=0;
    speedx=1;
    speedy=0;
    total=0;
    tail=new float[4800][2];
    for(int i=0;i<tail.length;i+=1){
      for(int j=0;j<2;j+=1){
        tail[i][j]=-100;
      }
    }
  }
  void update(){
    
    if(total>0){
      for(int i=0;i<tail.length-1;i+=1){
        for(int j=0;j<2;j+=1){
        tail[i][j]=tail[i+1][j];
        }
      }
    }
    if(total>0){
      tail[total-1][0]=x;
      tail[total-1][1]=y;
    }
    
    x+=speedx*scl;
    y+=speedy*scl;
    if(x>=width){
      x=0;
    }
    else if(x<0){
      x=width-scl;
    }
    if(y>=height){
      y=0;
    }
    else if(y<0){
      y=height-scl;
    }
    //x=constrain(x,0,width-scl);
    //y=constrain(y,0,height-scl);
  
  }
  void show(){
    fill(255);
    if(total>0){
      for(int i=0;i<tail.length;i+=1){
        rect(tail[i][0],tail[i][1],scl,scl);
      }
    }
    fill(0,255,0);
    rect(x,y,scl,scl);
  }
  void dir(float dx,float dy){
    speedx=dx;
    speedy=dy;
  }
  boolean eat(float posx,float posy){
    float d=dist(x,y,posx,posy);
    if(d<1){
      total+=1;
      return true;
    }
    else{
      return false;
    }
  }
  void AI(float posx,float posy){
    float dx=posx-x;
    float dy=posy-y;
    //right
    if(dx>0){
      if((walls[3]==1&&walls[0]==1&&walls[2]==1)||(walls[0]==1&&walls[3]==1&&walls[1]==0&&walls[2]==0)||(walls[3]==1&&walls[2]==1&&walls[0]==0&&walls[1]==0)){
        speedx=0;
        speedy=1;
      }
      else if((walls[2]==1&&walls[3]==1&&walls[1]==1)||(walls[3]==1&&walls[1]==1&&walls[0]==0&&walls[2]==0)||(walls[3]==1&&walls[2]==0&&walls[1]==0&&walls[0]==0)){
        speedx=0;
        speedy=-1;
      }
      else if(walls[0]==1&&walls[1]==1&&walls[3]==1&&walls[2]==0){
        speedx=-1;
        speedy=0;
      }
      else{
        speedx=1;
        speedy=0;
      }
    }
    //left
    else if(dx<0){
      if((walls[3]==1&&walls[0]==1&&walls[2]==1)||(walls[0]==1&&walls[2]==1&&walls[1]==0&&walls[3]==0)||(walls[2]==1&&walls[3]==1&&walls[0]==0&&walls[1]==0)){
        speedx=0;
        speedy=1;
      }
      else if((walls[2]==1&&walls[3]==1&&walls[1]==1)||(walls[2]==1&&walls[1]==1&&walls[0]==0&&walls[3]==0)||(walls[3]==0&&walls[2]==1&&walls[1]==0&&walls[0]==0)){
        speedx=0;
        speedy=-1;
      }
      else if(walls[0]==1&&walls[1]==1&&walls[2]==1&&walls[3]==0){
        speedx=1;
        speedy=0;
      }
      else{
        speedx=-1;
        speedy=0;
      }
    }
    //up
    else if(dy<0){
      if((walls[0]==1&&walls[1]==1&&walls[2]==1)||(walls[0]==1&&walls[2]==1&&walls[1]==0&&walls[3]==0)||(walls[0]==1&&walls[1]==1&&walls[2]==0&&walls[3]==0)){
        speedx=1;
        speedy=0;
      }
      else if((walls[0]==1&&walls[1]==1&&walls[3]==1)||(walls[0]==1&&walls[3]==1&&walls[1]==0&&walls[2]==0)||(walls[3]==0&&walls[2]==0&&walls[1]==0&&walls[0]==1)){
        speedx=-1;
        speedy=0;
      }
      else if(walls[0]==1&&walls[2]==1&&walls[3]==1&&walls[1]==0){
        speedx=0;
        speedy=1;
      }
      else{
        speedx=0;
        speedy=-1;
      }
    }
    //down
    else if(dy>0){
      if((walls[0]==1&&walls[1]==1&&walls[2]==1)||(walls[2]==1&&walls[1]==1&&walls[0]==0&&walls[3]==0)||(walls[1]==1&&walls[0]==1&&walls[2]==0&&walls[3]==0)){
        speedx=1;
        speedy=0;
      }
      else if((walls[0]==1&&walls[1]==1&&walls[3]==1)||(walls[1]==1&&walls[3]==1&&walls[0]==0&&walls[2]==0)||(walls[3]==0&&walls[2]==0&&walls[1]==1&&walls[0]==0)){
        speedx=-1;
        speedy=0;
      }
      else if(walls[1]==1&&walls[2]==1&&walls[3]==1&&walls[0]==0){
        speedx=0;
        speedy=-1;
      }
      else{
        speedx=0;
        speedy=1;
      }
    }
    
    
    
    
  }
  void ifwall(){
    for(int i=0;i<walls.length;i+=1){
      walls[i]=0;
    }
    
    for(int i=0;i<tail.length;i+=1){
      //right
      if(x+scl==tail[i][0]&&y==tail[i][1]){
        walls[3]=1;
      }
      //left
      if(x-scl==tail[i][0]&&y==tail[i][1]){
        walls[2]=1;
      }      
      //up
      if(y+scl==tail[i][1]&&x==tail[i][0]){
        walls[1]=1;
      }     
      //down
      if(y-scl==tail[i][1]&&x==tail[i][0]){
        walls[0]=1;
      }
    
    }
    if(x+scl==width){
      for(int i=0;i<tail.length;i+=1){
        if(tail[i][0]==0&&y==tail[i][1]){
          walls[3]=1;
        }
      }
    }
    if(x==0){
      for(int i=0;i<tail.length;i+=1){
        if(tail[i][0]==width-scl&&y==tail[i][1]){
          walls[2]=1;
        }
      }
    }
    if(y+scl==height){
      for(int i=0;i<tail.length;i+=1){
        if(tail[i][1]==0&&x==tail[i][0]){
          walls[1]=1;
        }
      }
    }
    if(y==0){
      for(int i=0;i<tail.length;i+=1){
        if(tail[i][1]==height-scl&&x==tail[i][0]){
          walls[0]=1;
        }
      }
    }
    //println(walls);
  } 
  void death(){
    if(walls[0]==1&&walls[1]==1&&walls[2]==1&&walls[3]==1){
      for(int i=0;i<tail.length;i+=1){
        tail[i][0]=-100;
        tail[i][1]=-100;
      }
      total=0;
    }
  }
}
