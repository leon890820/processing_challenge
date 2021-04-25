class field{
  PVector[][] f;
  int resolution;
  int rows;
  int cols;
  float z=0;
  field(){
    resolution=20;
    rows=height/resolution;
    cols=width/resolution;
    f=new PVector[cols][rows];
  }
  void build(){
    noiseSeed((int)random(10000));
    float x=0;
    float y=0;
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        float theda=map(noise(x,y),0,1,0,PI*2);
        float t=map(j,0,rows,0,2*PI);
        f[i][j]=new PVector(cos(theda),sin(theda));
        
        y+=0.1;
      }
      x+=0.1;
    }
  }
  void update(){
    //noiseSeed((int)random(10000));
    float x=0;
    
    for(int i=0;i<cols;i+=1){
      float y=0;
      for(int j=0;j<rows;j+=1){
        float theda=map(noise(x,y,z),0,1,0,PI*2);
        float t=map(j,0,rows,0,2*PI);
        f[i][j]=PVector.fromAngle(theda);
        
        y+=0.1;
      }
      x+=0.1;
    }
    //z+=0.01;
  }
  void display(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        drawVector(f[i][j],i*resolution,j*resolution,resolution-2);
      }
    }
  
  }
  void drawVector(PVector v,float x,float y,float scayl){
    pushMatrix();
    float arrowsize=4;
    translate(x,y);
    stroke(0,100);
    rotate(v.heading2D());
    float len=v.mag()*scayl;
    line(0,0,len,0);
    popMatrix();
  }
  PVector lookup(PVector lookup){
    int column = int(constrain(lookup.x/resolution,0,cols-1));
    int row = int(constrain(lookup.y/resolution,0,rows-1));
    return f[column][row].get();
  }
}
