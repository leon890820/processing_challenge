Rolling[] rolling=new Rolling[56];
Rolling[] sine=new Rolling[40];

float time=0;
void setup() {
  size(600, 600);
  frameRate(120);
  createRolling();
  createSine();
  //print(rolling[20].bais);
}

void draw() {
  background(100);
  translate(width/2, height/2);
  time+=20;



  for (Rolling r : rolling) {
    r.show();
  }
  
  rolling[6].show();
  rolling[4].show();
  rolling[0].show();
  rolling[2].show();
  //saveFrame("frame/data-####");
  //if(time>1440){
  //  noLoop();
  //}
}


float[][] matmul(float[][] a, float[][] b) {
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length;

  if (colsA != rowsB) {
    println("Columns of A must match rows of B");
    return null;
  }

  float result[][] = new float[rowsA][colsB];

  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsB; j++) {
      float sum = 0;
      for (int k = 0; k < colsA; k++) {
        sum += a[i][k] * b[k][j];
      }
      result[i][j] = sum;
    }
  }
  return result;
}

void createSine(){
  for(int i=0;i<sine.length;i+=1){
    float x=map(i,0,sine.length,0,4*PI);
    float w=map(i,0,sine.length,0,width);
    PVector b=new PVector(0,sin(x)-sin(x+0.1));
    b.normalize();
    
    sine[i]=new Rolling(w+15,sin(x)*100,0,b.x,b.y);
  
  }
  

}


void createRolling(){
  rolling[0]=new Rolling(-100, -100, -100,1,0);
  rolling[1]=new Rolling(-100, -100, 100,1,0);
  rolling[2]=new Rolling(-100, 100, -100,1,0);
  rolling[3]=new Rolling(-100, 100, 100,1,0);
  rolling[4]=new Rolling(100, -100, -100,-1,0);
  rolling[5]=new Rolling(100, -100, 100,-1,0);
  rolling[6]=new Rolling(100, 100, -100,-1,0);
  rolling[7]=new Rolling(100, 100, 100,-1,0);
  //8
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[36+i]=new Rolling(-j, -100, -100,0,0);
  }
  //10
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[40+i]=new Rolling(-100, -j, -100,1,0);
  }
  //6
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    rolling[28+i]=new Rolling(k, k, -j,1,0);
  }
  //100
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[44+i]=new Rolling(-j, 100, -100,0,-1);
  }
  //11
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[48+i]=new Rolling(100, -j, -100,-1,0);
  }
  //12
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    int l=100;
    rolling[52+i]=new Rolling(l, k, -j,-1,0);
  }
  //5
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    rolling[24+i]=new Rolling(-j, -100, 100,0,1);
  }
  //100
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[8+i]=new Rolling(-100, -j, 100,1,0);
  }
  //3
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    int l=100;
    rolling[16+i]=new Rolling(k, l, -j,1,0);
  }
  //2
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[12+i]=new Rolling(-j, 100, 100,0,1);
  }
  //4
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[20+i]=new Rolling(100, -j, 100,1,0);
  }
  //7
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=100;
    rolling[32+i]=new Rolling(k, k, -j,-1,0);
  }

  float theda_z=PI/8;
  float theda_y=-PI/10;
  float plus=0.08;
  float[][] rotateZ={
    {1, 0, 0}, 
    {0, cos(theda_z), -sin(theda_z)}, 
    {0, sin(theda_z), cos(theda_z)}  
  };
  float[][] rotateZplus={
    {1, 0, 0}, 
    {0, cos(theda_z+plus), -sin(theda_z+plus)}, 
    {0, sin(theda_z+plus), cos(theda_z+plus)}  
  };
  float[][] rotateY={

    {cos(theda_y), 0, -sin(theda_y)}, 

    {0, 1, 0}, 
    {sin(theda_y), 0, cos(theda_y)}
  };
   float[][] rotateYplus={

    {cos(theda_y+plus), 0, -sin(theda_y+plus)}, 

    {0, 1, 0}, 
    {sin(theda_y+plus), 0, cos(theda_y+plus)}
  };
  for (Rolling r : rolling) {
    float[][] v={{r.center.x}, {r.center.y}, {r.center.z}};

    float[][] rotated=matmul(rotateY, v);
    rotated=matmul(rotateZ, rotated);
    float[][] rotateplus=matmul(rotateYplus, v);
    rotateplus=matmul(rotateZplus, v);
    
    float distance=4;
    float w=3/(distance-rotated[2][0]);
    //println(w);
    float[][] projection={
      {w, 0, 0}, 
      {0, w, 0}, 
    };
    //rotated=matmul(projection,rotated);
    PVector pplus=new PVector(rotateplus[0][0],rotateplus[1][0]);
    PVector p=new PVector(rotated[0][0]*1, rotated[1][0]*1);
    pplus.sub(p);
    pplus.normalize();
    pplus.mult(-1);
    r.bais=pplus.copy();
    r.center=p;
    
  }


}
