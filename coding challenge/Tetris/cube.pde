class cube{
  float scl;
  int ran;
  PVector sq[][] =new PVector[8][4];
  int net[][]=new int[10][20];
  int colors[][]=new int[10][20];
  cube(){
    scl=40;
    ran=int(random(7));
    sq[0][0]=new PVector (4,1);
    sq[0][1]=new PVector (5,1);
    sq[0][2]=new PVector (5,0);
    sq[0][3]=new PVector (6,0);
    
    sq[1][0]=new PVector (4,0);
    sq[1][1]=new PVector (5,0);
    sq[1][2]=new PVector (5,1);
    sq[1][3]=new PVector (6,1);
    
    sq[2][0]=new PVector (6,0);
    sq[2][1]=new PVector (4,1);
    sq[2][2]=new PVector (5,1);
    sq[2][3]=new PVector (6,1);
    
    sq[3][0]=new PVector (4,0);
    sq[3][1]=new PVector (4,1);
    sq[3][2]=new PVector (5,1);
    sq[3][3]=new PVector (6,1);
    
    sq[4][0]=new PVector (4,0);
    sq[4][1]=new PVector (5,0);
    sq[4][2]=new PVector (4,1);
    sq[4][3]=new PVector (5,1);
    
    sq[5][0]=new PVector (3,0);
    sq[5][1]=new PVector (4,0);
    sq[5][2]=new PVector (5,0);
    sq[5][3]=new PVector (6,0);
    
    sq[6][0]=new PVector (5,0);
    sq[6][1]=new PVector (4,1);
    sq[6][2]=new PVector (5,1);
    sq[6][3]=new PVector (6,1);
    
    
  }
  void show(){
    for(int i=0;i<4;i+=1){
      //stroke(0);
      if(ran==0) fill(0,255,0);
      else if(ran==1) fill(255,0,0);
      else if(ran==2) fill(255,165,0);
      else if(ran==3) fill(0,0,255);
      else if(ran==4) fill(255,255,0);
      else if(ran==5) fill(255,255,100);
      else fill(139,0,255);
       if(ran==0) stroke(0,255,0);
      else if(ran==1) stroke(255,0,0);
      else if(ran==2) stroke(255,165,0);
      else if(ran==3) stroke(0,0,255);
      else if(ran==4) stroke(255,255,0);
      else if(ran==5) stroke(255,255,100);
      else stroke(139,0,255);
      rect(sq[ran][i].x*scl,sq[ran][i].y*scl,scl,scl);
    }
    //println(rotation);
  }
  void update(){
    for(int i=0;i<4;i+=1){
      sq[ran][i].y+=1;  
      
    }
  }
  void reset(){
    boolean re=false;
    re=false;
    for(int i=0;i<4;i+=1){
      if(sq[ran][i].y+1==20){
       re=true;
      }
    }
    
    for(int i=0;i<4;i+=1){
      if((sq[ran][i].y+1)<20){
        if(net[int(sq[ran][i].x)][int(sq[ran][i].y+1)]==1){
          re=true;
        }
      }
    }
    
    if(re==true){
      for(int i=0;i<4;i+=1){
        colors[int(sq[ran][i].x)][int(sq[ran][i].y)]=ran;
        net[int(sq[ran][i].x)][int(sq[ran][i].y)]=1;
      }
      ran=int(random(7));
      rotation=0;
      sq[0][0]=new PVector (4,0);
      sq[0][1]=new PVector (5,0);
      sq[0][2]=new PVector (5,-1);
      sq[0][3]=new PVector (6,-1);
    
      sq[1][0]=new PVector (4,-1);
      sq[1][1]=new PVector (5,-1);
      sq[1][2]=new PVector (5,0);
      sq[1][3]=new PVector (6,0);
    
      sq[2][0]=new PVector (6,-1);
      sq[2][1]=new PVector (4,0);
      sq[2][2]=new PVector (5,0);
      sq[2][3]=new PVector (6,0);
    
      sq[3][0]=new PVector (4,-1);
      sq[3][1]=new PVector (4,0);
      sq[3][2]=new PVector (5,0);
      sq[3][3]=new PVector (6,0);
    
      sq[4][0]=new PVector (4,-1);
      sq[4][1]=new PVector (5,-1);
      sq[4][2]=new PVector (4,0);
      sq[4][3]=new PVector (5,0);
    
       sq[5][0]=new PVector (3,-1);
      sq[5][1]=new PVector (4,-1);
      sq[5][2]=new PVector (5,-1);
      sq[5][3]=new PVector (6,-1);
    
      sq[6][0]=new PVector (5,-1);
      sq[6][1]=new PVector (4,0);
      sq[6][2]=new PVector (5,0);
      sq[6][3]=new PVector (6,0);
    }
  }
  
  void record(){
    for(int i=0;i<10;i+=1){
      for(int j=0;j<20;j+=1){
        if(net[i][j]==1){
          //stroke(0);
          if(colors[i][j]==0) fill(0,255,0);         
          else if(colors[i][j]==1) fill(255,0,0);
          else if(colors[i][j]==2) fill(255,165,0);
          else if(colors[i][j]==3) fill(0,0,255);
          else if(colors[i][j]==4) fill(255,255,0);
          else if(colors[i][j]==5) fill(255,255,100);
          else fill(139,0,255);
          if(colors[i][j]==0) stroke(0,255,0);
      else if(colors[i][j]==1) stroke(255,0,0);
      else if(colors[i][j]==2) stroke(255,165,0);
      else if(colors[i][j]==3) stroke(0,0,255);
      else if(colors[i][j]==4) stroke(255,255,0);
      else if(colors[i][j]==5) stroke(255,255,100);
      else stroke(139,0,255);
          rect(i*scl,j*scl,scl,scl);
        }
      }
    }
  }
  void elliminate(){
    float sum;
    for(int i=0;i<20;i+=1){
      sum=0;
      for(int j=0;j<10;j+=1){
        sum+=net[j][i];
      }
      //println(sum);
      if(sum>9){
        for(int k=0;k<10;k+=1){
          net[k][i]=0;
          colors[k][i]=8;
        }
        for(int k=1;k<i+1;k+=1){
          for(int j=0;j<10;j+=1){
            net[j][i+1-k]=net[j][i-k]; 
            colors[j][i+1-k]=colors[j][i-k];
            
          }
        }
        
        for(int k=0;k<10;k+=1){
          net[k][0]=0;
           colors[k][0]=8;
        }
      }
    }
  }
  
  void death(){
    boolean death=false;
    for(int i=0;i<10;i+=1){
        for(int j=0;j<10;j+=1){
          if(net[j][0]==1){
            death=true;
          }
        }    
    }
    if(death==true){
            for(int j=0;j<10;j+=1){
              for(int k=0;k<20;k+=1){
                net[j][k]=0;
                
                 
              }
            }
           
          }
          
  }

}
