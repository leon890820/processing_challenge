float[][] current;
float[][] previous;
int cols;
int rows;
float a=0;
float damping=0.98;
float theda=PI/8;
float s=sin(theda);
ArrayList<water> rains;
ArrayList<lightning> lights;
void setup(){
  size(600,600);
  cols=(int)(width);
  rows=(int)(height);//sin(theda));
  current=new float[cols][rows];
  previous=new float[cols][rows];
  rains=new ArrayList<water>();
  lights=new ArrayList<lightning>();
  rains.add(new water());
  
  //print(cols,rows);
}
void draw(){
  background(0);
  stroke(255);
  
  loadPixels();
  for(int i=1;i<width-1;i+=1){
    for(int j=1;j<height-1;j+=1){   
      current[i][j]=(previous[i+1][j]+previous[i-1][j]+previous[i][j+1]+previous[i][j-1])/2-current[i][j];
      current[i][j]*=damping;
      float m=map(j,0,rows,height*(1-s),height);
      
      int index=i+(int)m*width; 
      //if(width*height/3<index&&index<width*height/2)  
      pixels[index]=color(current[i][j]);
     
    }
  }  
  updatePixels(); 
  if(rains.size()>0){
    //println(rains.get(0).location.z,rains.get(0).prelocation.z);
  }
  rain();
  lighting();
  for(lightning l:lights){
    l.run();
  }
  for(water w:rains){
    w.run();
  }
  raindropped();
  lightdeath();
  a+=0.01;
  float[][] temp=previous;
  previous=current;
  current=temp;
  
}
void mousePressed(){
  previous[mouseX][mouseY]=1000;
  
}
void mouseDragged(){
  previous[mouseX][mouseY]=1000;
  
}

void rain(){
  if(random(1)<1){
    //previous[(int)random(cols)][(int)random(rows)]=random(255,1000);
    for(int i=0;i<2;i+=1){
      rains.add(new water());
    }
    
  }
}

void raindropped(){
  for(int i=rains.size()-1;i>=0;i-=1){
    if(rains.get(i).location.z<0){
      if(rains.get(i).location.x<width && rains.get(i).location.x>0){
        previous[(int)rains.get(i).location.x][(int)rains.get(i).location.y]=rains.get(i).mass*500;
      }
      rains.remove(i);
    }
  }

}

void lighting(){
  if(random(1)<0.05){
    lights.add(new lightning());
  }
}
void lightdeath(){
  for(int i=lights.size()-1;i>=0;i-=1){
    lightning l=lights.get(i);
    if(l.time<0) lights.remove(i);
  }
}
