float r=100;
float time=0;
int num=100;
ArrayList<PVector> p;
ArrayList<PVector> p1;
float[] wa1;
float[] wa2;
float[][] fouriesX;
float[][] fouriesY;
complex[] complexFouries;

ArrayList<complex> userDraw;
float USER=1;
float DRAW=0;

float state;



void setup(){
  state=-1;
  userDraw=new ArrayList<complex>();
  size(800,800);
  p=new ArrayList<PVector>();
}
void mousePressed(){
  state=USER;
  userDraw.clear();
  p.clear();
  time=0;
}

void mouseReleased() {
  state=DRAW;
  wa1=new float[userDraw.size()];
  wa2=new float[userDraw.size()];
  complex[] c=new complex[userDraw.size()];
  for(int i=0;i<userDraw.size();i+=1){    
    c[i]=userDraw.get(i);   
  }  
  complexFouries=dft(c);
}


void draw(){
  background(0);
  //println(userDraw.size());
  if(state==USER){
    noFill();
    userDraw.add(new complex(mouseX-width/2,mouseY-height/2));
    beginShape();
    for(complex v :userDraw){
      vertex(v.re+width/2,v.im+height/2);
    }
    endShape();
  }
  else if(state==DRAW){ 
    PVector location=epiCycle(width/2,height/2,0,complexFouries);
    
    
    p.add(location);
    
    stroke(255);
    //line(locationX.x,locationX.y,p.get(p.size()-1).x,p.get(p.size()-1).y);
    //line(locationY.x,locationY.y,p.get(p.size()-1).x,p.get(p.size()-1).y);
    noFill();
    stroke(255);
    beginShape();
    
    for(int i=0;i<p.size();i+=1){
      vertex(p.get(i).x,p.get(i).y);
    }
    endShape();
    
     if(p.size()>userDraw.size()-20){
       p.remove(0);
     }  
    float dt=2*PI/wa1.length;
    time-=dt;
    if(time<-2*PI){
    time=0;
    num+=1;
    }
  }
}

complex[] dft(complex[] y){
  int N=y.length;
  complex[] X=new complex[N];
  for(int k=0;k<N;k+=1){
    complex sum=new complex(0,0);
    for(int n=0;n<N;n+=1){
      complex m=y[n].mult(cos(2*PI*n*k/N),sin(2*PI*n*k/N));      
      sum=sum.sumation(m);      
      //re+=y[n]*cos(2*PI*n*k/N);
      //im-=y[n]*sin(2*PI*n*k/N);    
    }
    
    sum.re=sum.re/N;
    sum.im=sum.im/N;
    
    sum.radious=sqrt(sum.re*sum.re+sum.im*sum.im);
    sum.angle = atan2(sum.im,sum.re);
    sum.feq=k;
    
    X[k]=sum;
    
  }
  
  return X;
}

PVector epiCycle(float _x, float _y,float theda,complex[] fouries){
  //translate(_x,_y);
  stroke(255,255,255,100);
  float x=_x;
  float y=_y;
  for(int i=0;i<fouries.length;i+=1){
    noFill();
    float radious=fouries[i].radious;
    float angle=fouries[i].angle;
    float feq=fouries[i].feq;
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

class complex{
  float re;
  float im;
  float radious;
  float feq;
  float angle;
  complex(float a,float b){
    re=a;
    im=b;
    radious=0;
    feq=0;
    angle=0;
  }
  
  complex mult(float c,float d){
    float a=re;
    float b=im;
    float re_=a*c-b*d;
    float im_=b*c+a*d;
    
    return new complex(re_,im_);
  }
  
  complex sumation(complex s){
    complex c=new complex(re+s.re,im+s.im);
    return c;
  }
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
