nueralnetwork nn=new nueralnetwork(2,6,3);
float[][][][] p=new float[4][2][][];

void setup(){
  size(400,400);
  background(0);
  
  float[][] a1={{0,0}};
  float[][] g1={{0,0,0}};
  float[][] a2={{0,1}};
  float[][] g2={{1,1,1}};
  float[][] a3={{1,0}};
  float[][] g3={{1,1,1}};
  float[][] a4={{1,1}};
  float[][] g4={{0,0,0}};
  p[0][0]=a1;
  p[0][1]=g1;
  p[1][0]=a2;
  p[1][1]=g2;
  p[2][0]=a3;
  p[2][1]=g3;
  p[3][0]=a4;
  p[3][1]=g4;
  
  
  //print(nn.Feedforward(p[0][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[1][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[2][0]).m1[0][0]+"\n");
 // print(nn.Feedforward(p[3][0]).m1[0][0]+"\n");
  //nn.Feedforward(a);
  //text(nn.output.m1[0][0],width/2,height/2);
  /*
  for(int i=0;i<m.culs;i+=1){
    for(int j=0;j<m.rows;j+=1){
      text(m.m1[i][j],width*(j+1)/(m.rows+1),height*(i+1)/(m.culs+1));
    }
  }
  */
  
}
void draw(){
  background(0);
  for(int i=0;i<100;i+=1){
    int g =(int)random(0,4);
    nn.train(p[g][0],p[g][1]);
  }
  float resolution=5;
  float culs=width/resolution;
  float rows=height/resolution;
  
  
  
  for(int i=0;i<culs;i+=1){
    for(int j=0;j<rows;j+=1){
      float x1=i/culs;
      float x2=j/rows;
      float[][] in={{x1,x2}};
      float[][] test={{1,0}};
      
      fill(nn.Feedforward(in).m1[0][0]*255,nn.Feedforward(in).m1[0][1]*255,nn.Feedforward(in).m1[0][2]*255);
      noStroke();
      rect(i*resolution,j*resolution,resolution,resolution);
    }
  }
  //text(x,width/2,height/2);
  //print(nn.Feedforward(p[0][0]).m1[0][0]+"\n");
 //print(nn.Feedforward(p[1][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[2][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[3][0]).m1[0][0]+"\n");
  
}
