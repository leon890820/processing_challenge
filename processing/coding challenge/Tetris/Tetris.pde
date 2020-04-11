cube cubes;
int rotation =0;
void setup(){
  size(400,800);
  
    cubes=new cube();
    stroke(255);
    for(int i=0;i<11;i+=1){
      line(i*cubes.scl,0,i*cubes.scl,height);
    }
    for(int i=0;i<21;i+=1){
      line(0,i*cubes.scl,width,i*cubes.scl);
    }
  //frameRate(3);
}

void draw(){
  background(0);
  stroke(255);
    for(int i=0;i<11;i+=1){
      line(i*cubes.scl,0,i*cubes.scl,height);
    }
    for(int i=0;i<21;i+=1){
      line(0,i*cubes.scl,width,i*cubes.scl);
    }
  cubes.show();
  
  cubes.elliminate();
  cubes.death();
  cubes.record();   
  cubes.reset();
  cubes.update();
  
  
  delay(100);
}
void keyPressed(){
  boolean right=false;
  right=false;
  boolean left;
  left=false;
   if(keyCode==RIGHT){
     for(int i=0;i<4;i+=1){
       if(cubes.sq[cubes.ran][i].x>=9){
         right=true;
       }      
     }   
     for(int i=0;i<4;i+=1){
       if(cubes.sq[cubes.ran][i].x<9){
         if(cubes.net[int(cubes.sq[cubes.ran][i].x+1)][int(cubes.sq[cubes.ran][i].y)]==1){
           right=true;
         }
       }
     }
     
      if(right==false){
        for(int i=0;i<4;i+=1){
          cubes.sq[cubes.ran][i].x+=1;
        }
      }
     
   }
   
   if(keyCode==LEFT){
     for(int i=0;i<4;i+=1){
       if(cubes.sq[cubes.ran][i].x<=0){
         left=true;
       }      
     }   
     for(int i=0;i<4;i+=1){
       if(cubes.sq[cubes.ran][i].x>0){
         if(cubes.net[int(cubes.sq[cubes.ran][i].x-1)][int(cubes.sq[cubes.ran][i].y)]==1){
           left=true;
         }
       }
     }
      if(left==false){
        for(int i=0;i<4;i+=1){
          cubes.sq[cubes.ran][i].x-=1;
        }
      }
   }
   if(keyCode==UP){
     boolean edge=false;
     boolean edgel1=false;
     boolean edger1=false;
     for(int i=0;i<4;i+=1){
       if(cubes.sq[cubes.ran][i].x>0){
         if(cubes.net[int(cubes.sq[cubes.ran][i].x-1)][int(cubes.sq[cubes.ran][i].y)]==1){
           edgel1=true; 
         }
       }
       if(cubes.sq[cubes.ran][i].x<9){
         if(cubes.net[int(cubes.sq[cubes.ran][i].x+1)][int(cubes.sq[cubes.ran][i].y)]==1){
           edger1=true; 
         }
       }
       if(cubes.sq[cubes.ran][i].x==0){
         edgel1=true;
       }
       if(cubes.sq[cubes.ran][i].x==9){
         edger1=true;
       }
     }
     
     if(rotation==0){
       cubes.sq[0][0].add(new PVector(1,-1));
       cubes.sq[0][1].add(new PVector(0,-0));
       cubes.sq[0][2].add(new PVector(1,1));
       cubes.sq[0][3].add(new PVector(0,2));
       
       
       cubes.sq[1][0].add(new PVector(2,0));
       cubes.sq[1][1].add(new PVector(1,1));
       cubes.sq[1][2].add(new PVector(0,0));
       cubes.sq[1][3].add(new PVector(-1,1));
       
       cubes.sq[2][0].add(new PVector(0,2));
       cubes.sq[2][1].add(new PVector(1,-1));
       cubes.sq[2][2].add(new PVector(0,0));
       cubes.sq[2][3].add(new PVector(-1,1));
       
       cubes.sq[3][0].add(new PVector(2,0));
       cubes.sq[3][1].add(new PVector(1,-1));
       cubes.sq[3][2].add(new PVector(0,0));
       cubes.sq[3][3].add(new PVector(-1,1));
       
       cubes.sq[4][0].add(new PVector(0,0));
       cubes.sq[4][1].add(new PVector(0,-0));
       cubes.sq[4][2].add(new PVector(0,0));
       cubes.sq[4][3].add(new PVector(0,0));
       
       cubes.sq[5][0].add(new PVector(1,-1));
       cubes.sq[5][1].add(new PVector(0,-0));
       cubes.sq[5][2].add(new PVector(-1,1));
       cubes.sq[5][3].add(new PVector(-2,2));
       
       cubes.sq[6][0].add(new PVector(1,1));
       cubes.sq[6][1].add(new PVector(1,-1));
       cubes.sq[6][2].add(new PVector(0,0));
       cubes.sq[6][3].add(new PVector(-1,1));
       
       for(int i=0;i<7;i+=1){
         for (int j=0;j<4;j+=1){
           if(cubes.sq[i][j].x<0){
             edge=true;
           }
         }
       }
       if(edge==true){
         for(int i=0;i<7;i+=1){
           for(int j=0;j<4;j+=1){
             cubes.sq[i][j].add(new PVector(1,0));
           }  
         }
       }
       
     
       rotation+=1;
     }
     
     else if(rotation==1&&(edger1==false||edgel1==false)){
       cubes.sq[0][0].add(new PVector(-1,1));
       cubes.sq[0][1].add(new PVector(0,-0));
       cubes.sq[0][2].add(new PVector(-1,-1));
       cubes.sq[0][3].add(new PVector(0,-2));
       
       
       cubes.sq[1][0].add(new PVector(-2,0));
       cubes.sq[1][1].add(new PVector(-1,-1));
       cubes.sq[1][2].add(new PVector(0,0));
       cubes.sq[1][3].add(new PVector(1,-1));
       
       cubes.sq[2][0].add(new PVector(-2,0));
       cubes.sq[2][1].add(new PVector(1,1));
       cubes.sq[2][2].add(new PVector(0,0));
       cubes.sq[2][3].add(new PVector(-1,-1));
       
       cubes.sq[3][0].add(new PVector(0,2));
       cubes.sq[3][1].add(new PVector(1,1));
       cubes.sq[3][2].add(new PVector(0,0));
       cubes.sq[3][3].add(new PVector(-1,-1));
       
       cubes.sq[4][0].add(new PVector(0,0));
       cubes.sq[4][1].add(new PVector(0,-0));
       cubes.sq[4][2].add(new PVector(0,0));
       cubes.sq[4][3].add(new PVector(0,0));
       
       cubes.sq[5][0].add(new PVector(-1,1));
       cubes.sq[5][1].add(new PVector(0,-0));
       cubes.sq[5][2].add(new PVector(1,-1));
       cubes.sq[5][3].add(new PVector(2,-2));
       if(cubes.sq[5][2].x>9){
         for(int i=0;i<4;i+=1){
           cubes.sq[5][i].add(new PVector(-2,0));
         }
       }
       
       cubes.sq[6][0].add(new PVector(-1,1));
       cubes.sq[6][1].add(new PVector(1,1));
       cubes.sq[6][2].add(new PVector(0,0));
       cubes.sq[6][3].add(new PVector(-1,-1));
       
       for(int i=0;i<7;i+=1){
         for (int j=0;j<4;j+=1){
           if(cubes.sq[i][j].x<0){
             edge=true;
           }
         }
       }
       if(edge==true){
         for(int i=0;i<7;i+=1){
           for(int j=0;j<4;j+=1){
             cubes.sq[i][j].add(new PVector(1,0));
           }  
         }
       }
     
       rotation+=1;
     }
     else if(rotation==2){
       cubes.sq[0][0].add(new PVector(1,-1));
       cubes.sq[0][1].add(new PVector(0,-0));
       cubes.sq[0][2].add(new PVector(1,1));
       cubes.sq[0][3].add(new PVector(0,2));
       
       cubes.sq[1][0].add(new PVector(2,0));
       cubes.sq[1][1].add(new PVector(1,1));
       cubes.sq[1][2].add(new PVector(0,0));
       cubes.sq[1][3].add(new PVector(-1,1));
       
       cubes.sq[2][0].add(new PVector(0,-2));
       cubes.sq[2][1].add(new PVector(-1,1));
       cubes.sq[2][2].add(new PVector(0,0));
       cubes.sq[2][3].add(new PVector(1,-1));
       
       cubes.sq[3][0].add(new PVector(-2,0));
       cubes.sq[3][1].add(new PVector(-1,1));
       cubes.sq[3][2].add(new PVector(0,0));
       cubes.sq[3][3].add(new PVector(1,-1));
       
       cubes.sq[4][0].add(new PVector(0,0));
       cubes.sq[4][1].add(new PVector(0,-0));
       cubes.sq[4][2].add(new PVector(0,0));
       cubes.sq[4][3].add(new PVector(0,0));
       
       cubes.sq[5][0].add(new PVector(1,-1));
       cubes.sq[5][1].add(new PVector(0,-0));
       cubes.sq[5][2].add(new PVector(-1,1));
       cubes.sq[5][3].add(new PVector(-2,2));
       
       cubes.sq[6][0].add(new PVector(-1,-1));
       cubes.sq[6][1].add(new PVector(-1,1));
       cubes.sq[6][2].add(new PVector(0,0));
       cubes.sq[6][3].add(new PVector(1,-1));
       
       for(int i=0;i<7;i+=1){
         for (int j=0;j<4;j+=1){
           if(cubes.sq[i][j].x<0){
             edge=true;
           }
         }
       }
       if(edge==true){
         for(int i=0;i<7;i+=1){
           for(int j=0;j<4;j+=1){
             cubes.sq[i][j].add(new PVector(1,0));
           }  
         }
       }
       
     
       rotation+=1;
     }
      else if(rotation==3&&(edger1==false||edgel1==false)){
       cubes.sq[0][0].add(new PVector(-1,1));
       cubes.sq[0][1].add(new PVector(0,-0));
       cubes.sq[0][2].add(new PVector(-1,-1));
       cubes.sq[0][3].add(new PVector(0,-2));
       
       cubes.sq[1][0].add(new PVector(-2,0));
       cubes.sq[1][1].add(new PVector(-1,-1));
       cubes.sq[1][2].add(new PVector(0,0));
       cubes.sq[1][3].add(new PVector(1,-1));
       
       cubes.sq[2][0].add(new PVector(2,0));
       cubes.sq[2][1].add(new PVector(-1,-1));
       cubes.sq[2][2].add(new PVector(0,0));
       cubes.sq[2][3].add(new PVector(1,1));
       
       cubes.sq[3][0].add(new PVector(0,-2));
       cubes.sq[3][1].add(new PVector(-1,-1));
       cubes.sq[3][2].add(new PVector(0,0));
       cubes.sq[3][3].add(new PVector(1,1));
       
       cubes.sq[4][0].add(new PVector(0,0));
       cubes.sq[4][1].add(new PVector(0,-0));
       cubes.sq[4][2].add(new PVector(0,0));
       cubes.sq[4][3].add(new PVector(0,0));
       
       cubes.sq[5][0].add(new PVector(-1,1));
       cubes.sq[5][1].add(new PVector(0,-0));
       cubes.sq[5][2].add(new PVector(1,-1));
       cubes.sq[5][3].add(new PVector(2,-2));
       if(cubes.sq[5][2].x>9){
         for(int i=0;i<4;i+=1){
           cubes.sq[5][i].add(new PVector(-2,0));
         }
       }
       
       cubes.sq[6][0].add(new PVector(1,-1));
       cubes.sq[6][1].add(new PVector(-1,-1));
       cubes.sq[6][2].add(new PVector(0,0));
       cubes.sq[6][3].add(new PVector(1,1));
       
       for(int i=0;i<7;i+=1){
         for (int j=0;j<4;j+=1){
           if(cubes.sq[i][j].x<0){
             edge=true;
           }
         }
       }
       if(edge==true){
         for(int i=0;i<7;i+=1){
           for(int j=0;j<4;j+=1){
             cubes.sq[i][j].add(new PVector(1,0));
           }  
         }
       }
     
       rotation=0;
     }
    println(edge,edger1,edgel1);
   }
   
   
}
