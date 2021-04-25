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

public class Hopfield extends PApplet {

String[] Basic_training_data;
String[] Basic_testing_data;
String[] Bonus_training_data;
String[] Bonus_testing_data;
ArrayList<Data> testdatas;
ArrayList<Data> datas;
ArrayList<Data> bonustestdatas;
ArrayList<Data> bonusdatas;
Button[] trainButton;
Button[] bonustrainButton;
int cols;
int rows;
int bonuscols;
int bonusrows;
boolean menu=true;
boolean train=false;
boolean[] training;
boolean[] bonustraining;
net NN;
net bonusNN;
public void setup(){
  
  background(0);
  datas=new ArrayList<Data>();
  testdatas=new ArrayList<Data>();
  bonusdatas=new ArrayList<Data>();
  bonustestdatas=new ArrayList<Data>();
  //basic_training
  FloatList input=new FloatList();  
  Basic_training_data=loadStrings("Basic_Training.txt");
  for(int i=0;i<Basic_training_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Basic_training_data[i].length();j+=1){
      if(Basic_training_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Basic_training_data[i].length()==0 || i==Basic_training_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      datas.add(new Data(in));
      input.clear();
    }
    
  }
  //basic_test
  input=new FloatList();
  Basic_testing_data=loadStrings("Basic_Testing.txt");
  for(int i=0;i<Basic_testing_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Basic_testing_data[i].length();j+=1){
      if(Basic_testing_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Basic_testing_data[i].length()==0 || i==Basic_testing_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      testdatas.add(new Data(in));
      input.clear();
    }
    
  }
  //bonus_training
  input=new FloatList();
  Bonus_training_data=loadStrings("Bonus_Training.txt");
  for(int i=0;i<Bonus_training_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Bonus_training_data[i].length();j+=1){
      if(Bonus_training_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Bonus_training_data[i].length()==0 || i==Bonus_training_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      bonusdatas.add(new Data(in));
      input.clear();
    }
    
  }
  
  //bonus_testing
  input=new FloatList();
  Bonus_testing_data=loadStrings("Bonus_Testing.txt");
  for(int i=0;i<Bonus_testing_data.length;i+=1){
    //println(Basic_training_data[i]);
    for(int j=0;j<Bonus_testing_data[i].length();j+=1){
      if(Bonus_testing_data[i].charAt(j)=='1'){
        input.append(1);
      }
      else{
        input.append(-1);
      }
    }    
    if(Bonus_testing_data[i].length()==0 || i==Bonus_testing_data.length-1){
      float[] in=new float[input.size()];
      
      for(int j=0;j<in.length;j+=1){
        in[j]=input.get(j);
      }
      bonustestdatas.add(new Data(in));
      input.clear();
    }
    
  }
  //print(bonustestdatas.size());
  trainButton=new Button[testdatas.size()];
  bonustrainButton=new Button[bonustestdatas.size()];
  rows=Basic_training_data[0].length();
  cols=(Basic_training_data.length+1)/datas.size()-1;
  bonusrows=Bonus_training_data[0].length();
  bonuscols=(Bonus_training_data.length+1)/bonusdatas.size()-1;
  for(int i=0;i<testdatas.size();i+=1){
    trainButton[i]=new Button(str(i),100+(i*15*rows)+0.5f*(rows*testdatas.get(0).scl),100+0.5f*cols*testdatas.get(0).scl,0,rows*testdatas.get(0).scl*1.1f,cols*testdatas.get(0).scl*1.1f,0);
  }
  for(int i=0;i<bonustestdatas.size();i+=1){
    bonustrainButton[i]=new Button(str(i),100+((i%5)*11*rows)+0.5f*(bonusrows*bonustestdatas.get(0).scl),255+PApplet.parseInt(i/5)*15*bonustestdatas.get(0).scl+0.5f*bonuscols*bonustestdatas.get(0).scl,0,bonusrows*bonustestdatas.get(0).scl*1.1f,cols*bonustestdatas.get(0).scl*1.1f,0);
  }
  training=new boolean[testdatas.size()];
  bonustraining=new boolean[bonustestdatas.size()];
  NN=new net(cols,rows,datas);
  bonusNN=new net(bonuscols,bonusrows,bonusdatas);
  //print(bonuscols,bonusrows);
  //println(bonusNN.network.w[0]);
} 


public void draw(){
  background(0);
  if(menu)menu();
  else if(train) train();


}

public void menu(){
  for(Button b:trainButton){
    b.show();
    b.run(b.name);
  }
  for(Button b:bonustrainButton){
    b.show();
    b.bonusrun(b.name);
  }
  for(int i=0;i<testdatas.size();i+=1){
    testdatas.get(i).show(100+i*15*rows,100,rows,cols); 
  }
  for(int i=0;i<bonustestdatas.size();i+=1){
    bonustestdatas.get(i).show(100+(i%5)*10*bonusrows,250+PApplet.parseInt(i/5)*13*bonuscols,bonusrows,bonuscols); 
  }
  
  for(int i=0;i<testdatas.size();i+=1){
    if(training[i]==true) testdatas.get(i).train();
  
  }
  for(int i=0;i<bonustestdatas.size();i+=1){
    if(bonustraining[i]==true) bonustestdatas.get(i).bonustrain();
  
  }
  
  
}

public void train(){


}
class net {
  matrix network;
  ArrayList<Data> data;
  float p;
  matrix theda;
  net(int _cols, int _rows,ArrayList s) {
    p=_cols*_rows;
    data=new ArrayList<Data>();
    network=new matrix(_cols*_rows, _cols*_rows);
    theda=new matrix(1,PApplet.parseInt(p));
    theda.zero();    
    network.zero();
    data=s;
    calcNetwork();
    
    
  }

  public void calcNetwork() {
    for (int i=0; i<data.size(); i+=1) {
      matrix transX=data.get(i).inputData.transport();
      network=network.addiction(transX.multiple(data.get(i).inputData));
    }    
    //print(data.size());
    network=network.scalematrix(1/p);  
    println(network.w[0]);
    matrix I=new matrix(PApplet.parseInt(p),PApplet.parseInt(p));
    I.identity(); 
    I=I.scalematrix(data.size()/p);
    
    network=network.subtract(I);
    for(int i=0;i<p;i+=1){
      float sum=0;
      for(int j=0;j<p;j+=1){
        sum+=network.w[i][j];
      }
      theda.w[0][i]=sum;   
    }
     
  }
 
}
class Button {
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  float r;
  boolean touch=false;
  boolean pressed=false;
  Button(String _name, float _x, float _y, int _num, float _len, float _hei,float _r) {
    name=_name;
    position=new PVector(_x, _y);
    num=_num;
    len=_len;
    hei=_hei;
    r=_r;
    pp=position.copy();
  }
  public void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    //strokeWeight(4);
    rect(position.x, position.y, len, hei);
    //smoothRect(position.x, position.y, len, hei,r);
    fill(255);
    textSize(20);
    //text(name, position.x, position.y-3);
  }
  
  public void smoothRect(float x,float y,float l,float h,float r){
    float prx=x+l/2-r;
    float nrx=x-l/2+r;
    float pry=y+h/2-r;
    float nry=y-h/2+r;
    
    
    beginShape();
    vertex(nrx,nry-r);
    vertex(prx,nry-r);
    quarterCircle(prx,nry,-PI/2,0,r);
    vertex(prx+r,nry);
    vertex(prx+r,pry);
    quarterCircle(prx,pry,0,PI/2,r);
    vertex(prx,pry+r);
    vertex(nrx,pry+r);
    quarterCircle(nrx,pry,PI/2,PI,r);
    vertex(nrx-r,pry);
    vertex(nrx-r,nry);
    quarterCircle(nrx,nry,PI,3*PI/2,r);
    endShape(CLOSE);
  
  
  }
  public void quarterCircle(float x,float y,float sa,float ea,float r){
    for(int i=0;i<=90;i+=1){
      float theda=map(i,0,90,sa,ea);
      
      vertex(x+(r)*cos(theda),y+(r)*sin(theda));
    }
  }
  
  public void run(String s) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        // here the code
        training[PApplet.parseInt(s)]=!training[PApplet.parseInt(s)];
        
        pressed=true;
      }
    } else pressed=false;
  }
  public void bonusrun(String s) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        // here the code
        bonustraining[PApplet.parseInt(s)]=!bonustraining[PApplet.parseInt(s)];
        
        pressed=true;
      }
    } else pressed=false;
  }
  
}
class Data{
  float scl=8;
  matrix inputData;
  Data(float[] _inputData){
    inputData=new matrix(1,_inputData.length);
    inputData.w[0]=_inputData;
    
  
  }
  public void show(float x,float y,int r,int c){
    stroke(255);
    noFill();
    //rect(x,y,scl*r,scl*c);
    for(int i=0;i<c;i+=1){
      for(int j=0;j<r;j+=1){
        int index=i*r+j;
        noStroke();
        if(inputData.w[0][index]==1) fill(255);
        else fill(0);
        rect(x+j*scl,y+i*scl,scl,scl);
        
      }
    }
  
  
  }
  
  public void train(){
    matrix transX=inputData.transport();
    matrix x=NN.network.multiple(transX);
     
    x=x.subtract(NN.theda.transport());
   
    x.sgn();
    inputData=x.transport();
    
  
  }
  public void bonustrain(){
    matrix transX=inputData.transport();
    matrix x=bonusNN.network.multiple(transX);
     
    x=x.subtract(bonusNN.theda.transport());
   
    x.sgn();
    inputData=x.transport();
    
  
  }
  


}
class matrix{
  int cols;
  int rows;
  float[][] w;
  matrix(int m,int n){
    cols=m;
    rows=n;
    w=new float[m][n];
  }
  public void plus(){
    rows+=1;
    w=new float[cols][rows];
    init();
  }
  public void pluswf(){
    rows+=1;
    w=new float[cols][rows];
    init();
  }
  public void pluswb(){
    cols+=1;
    w=new float[cols][rows];
    init();
  }
  public void minus(){
    rows-=1;
    w=new float[cols][rows];
    init();
  }
  public void minuswf(){
    rows-=1;
    w=new float[cols][rows];
    init();
  }
  public void minuswb(){
    cols-=1;
    w=new float[cols][rows];
    init();
  }
  
  
  public matrix addiction(matrix a){
    if(a.cols!=cols || a.rows!=rows) return null;
    matrix result=new matrix(a.cols,a.rows);
    for(int i=0;i<a.cols;i+=1){
      for(int j=0;j<a.rows;j+=1){
        result.w[i][j]=w[i][j]+a.w[i][j];
      }
    }
    return result;
  }
  public matrix subtract(matrix a){
    if(a.cols!=cols || a.rows!=rows) return null;
    matrix result=new matrix(a.cols,a.rows);
    for(int i=0;i<a.cols;i+=1){
      for(int j=0;j<a.rows;j+=1){
        result.w[i][j]=w[i][j]-a.w[i][j];
      }
    }
    return result;
  }
  
  public matrix scalematrix(float n){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=n*w[i][j];
      }
    }
    return result;
  }
  public matrix scalematrix(matrix n){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=n.w[i][j]*w[i][j];
      }
    }
    return result;
  }
  
  public matrix multiple(matrix a){
    matrix result=new matrix(cols,a.rows);
    if(rows!=a.cols) return null;
    for(int i=0;i<result.cols;i+=1){
      for(int j=0;j<result.rows;j+=1){
        float sum=0;
        for(int k=0;k<rows;k+=1){
          //println(k);
          sum+=w[i][k]*a.w[k][j];
        }
        result.w[i][j]=sum;
      }
    }
    return result;
  }
  public matrix transport(){
    matrix result=new matrix(rows,cols);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[j][i]=w[i][j];
      }
    }
    
    
    return result;
  }
  public void init(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        w[i][j]=random(-1,1);
      }
    }
  }
  public void zero(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        w[i][j]=0;
      }
    }
  }
  
  public matrix dsigmoidMatrix(){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=dsigmoid(w[i][j]);
      }
    }
    return result;
  }
   public matrix sigmoidMatrix(){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=sigmoid(w[i][j]);
      }
    }
    return result;
  }
  public void identity (){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        if(i==j) w[i][j]=1;
        else w[i][j]=0;
      }
    }
  
  }
  public void sgn(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        if(w[i][j]>=0) w[i][j]=1;
        else w[i][j]=-1;
      }
    }
  
  
  }
  
  
  

}


public float Relu(float x) {
  return max(0, x);
}
public float sigmoid(float x) {
  return 1/(1+exp(-x));
}
public float dsigmoid(float y){
  return y*(1-y);
}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Hopfield" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
