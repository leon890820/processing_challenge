float r=100;
float time=0;
int num=100;
FloatList p;
FloatList p1;
float[] wa=new float[100];
float[][] wave;
PVector location=new PVector(0,0);

void setup(){
  for(int i=0;i<wa.length;i+=1){
    wa[i]=i;
  }
  size(800,400);
  wave=dft(wa);
  p=new FloatList();
  //println(wave[6]);
}

void draw(){
  background(0);
  translate(200,200);
  float x=0;
  float y=0;
  for(int i=0;i<wave.length;i+=1){

    float radious=wave[i][4];
    float angle=wave[i][3];
    float feq=wave[i][2];
    circle(x,y,2*radious);
    float fx=x+radious*sin(feq*time+angle);
    float fy=y+radious*cos(feq*time+angle);
    line(x,y,fx,fy);
    x=fx;
    y=fy; 
  }
  //println(wave[2]);
  fill(255);
  circle(x,y,8);
  location=new PVector(x,y);
  
  
  
  p.append(location.y);
  p1=p.copy();
  p1.reverse();
  stroke(255);
  line(location.x,location.y,200,p1.get(0));
  translate(200,0);
  noFill();
  stroke(255);
  beginShape();
  for(int i=0;i<p1.size();i+=1){
    vertex(i,p1.get(i));
  }
  endShape();
  if(p.size()>500){
    p.remove(0);
  }
  
  
  float dt=2*PI/wave.length;
  time+=dt;
  if(time>=2*PI){
   time=0;
   num+=1;
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
