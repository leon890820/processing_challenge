float r=100;
float time=0;
int num=100;
ArrayList<PVector> p;
ArrayList<PVector> p1;
float[] wa1;
float[] wa2;
float[][] fouriesX;
float[][] fouriesY;

ArrayList<PVector> userDraw;
float USER=1;
float DRAW=0;
float state;



void setup(){
  state=USER;
  userDraw=new ArrayList<PVector>();
  size(800,400);
  p=new ArrayList<PVector>();
  //println(wave[6]);
}
void mousePressed(){
  state=USER;
  userDraw.clear();
}

void mouseReleased() {
  state=DRAW;
  wa1=new float[userDraw.size()];
  wa2=new float[userDraw.size()];
  for(int i=0;i<userDraw.size();i+=1){
    
    wa1[i]=userDraw.get(i).x;
    wa2[i]=userDraw.get(i).y;
  }
  
  fouriesX=dft(wa1);
  fouriesY=dft(wa2);

}


void draw(){
  background(0);

  if(state==USER){
    noFill();
    userDraw.add(new PVector(mouseX-width/2,mouseY-height/2));
    beginShape();
    for(PVector v :userDraw){
      vertex(v.x+width/2,v.y+height/2);
    }
    endShape();
  }
  else if(state==DRAW){ 
    PVector locationX=epiCycle(50,200,PI/2,fouriesX);
    PVector locationY=epiCycle(400,50,0,fouriesY);
    PVector location=new PVector(locationY.x,locationX.y);
    
    p.add(location);
    
    stroke(255);
    line(locationX.x,locationX.y,p.get(p.size()-1).x,p.get(p.size()-1).y);
    line(locationY.x,locationY.y,p.get(p.size()-1).x,p.get(p.size()-1).y);
    noFill();
    stroke(255);
    beginShape();
    for(int i=0;i<p.size();i+=1){
      vertex(p.get(i).x,p.get(i).y);
    }
    endShape();
    // if(p.size()>500){
    //   p.remove(0);
    // }
    
    
    float dt=2*PI/wa1.length;
    time+=dt;
    if(time>=2*PI){
    time=0;
    num+=1;
    }
  }
}

float[][] dft(float[] y){
  int N=y.length;
  float[][] X=new float[N][5];
  for(int k=0;k<N;k+=1){
    float re=0;
    float im=0;
    for(int n=0;n<N;n+=1){
      re+=y[n]*cos(2*PI*n*k/N);
      im-=y[n]*sin(2*PI*n*k/N);
    
    }
    re=re/N;
    im=im/N;
    X[k][0]=re;
    X[k][1]=im;

    float radious=sqrt(re*re+im*im);
    float angle = atan2(im,re);
    float feq=k;
    X[k][2]=feq;
    X[k][3]=angle;
    X[k][4]=radious;
  }
  return X;
}

PVector epiCycle(float _x, float _y,float theda,float[][] fouries){
  //translate(_x,_y);
  float x=_x;
  float y=_y;
  for(int i=0;i<fouries.length;i+=1){
    noFill();
    float radious=fouries[i][4];
    float angle=fouries[i][3];
    float feq=fouries[i][2];
    circle(x,y,2*radious);
    float fx=x+radious*cos(feq*time+angle+theda);
    float fy=y+radious*sin(feq*time+angle+theda);
    line(x,y,fx,fy);
    x=fx;
    y=fy; 
  }
  //println(wave[2]);
  fill(255);
  circle(x,y,8);
  PVector location=new PVector(x,y);
  return location;

}
//void loadTrain() {
//  JSONArray train = loadJSONObject("train.json").getJSONArray("drawing");
//  trainX = new float[train.size()/skip];
//  trainY = new float[train.size()/skip];

//  for (int i = 0; i < train.size()/skip; i+= 1) {
//    trainX[i] = train.getJSONObject(i*skip).getFloat("x");
//    trainY[i] = train.getJSONObject(i*skip).getFloat("y");
//  }
//}
