import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DFT extends PApplet {

float r=100;
float time=0;
int num=100;
ArrayList<PVector> p;
ArrayList<PVector> p1;
float[] wa1=new float[100];
float[] wa2=new float[100];
float[][] fouriesX;
float[][] fouriesY;


public void setup(){
  for(int i=0;i<wa1.length;i+=1){
    float m=map(i,0,100,0,2*PI);
    wa1[i]=50*cos(m);
    wa2[i]=50*sin(m);
  }
  
  fouriesX=dft(wa1);
  fouriesY=dft(wa2);
  p=new ArrayList<PVector>();
  //println(wave[6]);
}

public void draw(){
  background(0);
  
  PVector locationX=epiCycle(50,200,PI/2,fouriesX);
  PVector locationY=epiCycle(0,0,0,fouriesY);
  PVector location=new PVector(locationX.x,locationY.y);
  p.add(location);
  
  stroke(255);
  line(locationX.x,locationX.y,p.get(p.size()-1).x,p.get(p.size()-1).y);
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

public float[][] dft(float[] y){
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

public PVector epiCycle(float _x, float _y,float theda,float[][] fouries){
  translate(_x,_y);
  float x=0;
  float y=0;
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
  circle(x+x_,y+y_,8);
  PVector location=new PVector(x,y);
  return location;

}
  public void settings() {  size(800,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DFT" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
