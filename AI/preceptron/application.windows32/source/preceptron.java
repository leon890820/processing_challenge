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

public class preceptron extends PApplet {

String[] data;
String[] dataName={"perceptron1", "perceptron2", "2Ccircle1", "2Circle1", "2Circle2", "2CloseS", "2CloseS2", "2CloseS3", "2cring", "2CS", "2Hcircle1", "2ring"};
String[] bonusdataName={"4satellite-6", "5CloseS1", "8OX", "C3D", "C10D", "IRIS", "Number"};
float[][] points;
float trainingnum=80;
FloatList category;
drawpoint[] database;
drawpoint[] trainingdata;
drawpoint[] testingdata;
float[] maxnum;
float[] minnum;
boolean menu=true;
boolean training=false;
boolean testing=false;
boolean bonus=false;
button[] buttons=new button[dataName.length];
button[] bonusbuttons=new button[bonusdataName.length];
slider slidemenu;
slider learning;
slider iteration;
button start;
button back;
button test;
button bonusarea;
net n;
drawpoint p3;
drawpoint p4;
int count=0;
public void setup() {
  
  category=new FloatList();
  slidemenu=new slider("slidemenu", 210, 100, 210, 500, 10, 20, 0, 0);
  learning=new slider("learning", 260, 450, 540, 450, 20, 10, 0.0001f, 1);
  iteration=new slider("iteration", 260, 520, 540, 520, 20, 10, 1, 10000);
  test=new button("test", 522, 25, 0, 150, 50);
  back=new button("back", 75, 25, 0, 150, 50);
  start=new button("training", 400, 570, 0, 200, 50);
  bonusarea=new button("bonus", 400, 40, 0, 150, 50);
  for (int i=0; i<buttons.length; i+=1) {
    buttons[i]=new button(dataName[i], 100, 100+i*60, i, 150, 50);
  }
  for (int i=0; i<bonusbuttons.length; i+=1) {
    bonusbuttons[i]=new button(bonusdataName[i], 100, 100+i*60, i, 150, 50);
  }
  initialize(dataName[0]);
}



public void draw() {
  background(100, 100);
  if (menu==true) menu();
  else if (training==true) training();
  else if (testing==true) testing();
  else if (bonus==true) bonus();
}

public void menu() {
  for (button b : buttons) {
    b.show(slidemenu.value);
    b.select();
  }
  rectMode(CORNER);
  stroke(255);
  noFill();
  rect(250, 75, 300, 300);
  //println(buttons.touch);
  for (drawpoint p : database) {
    p.preview();
  }
  slidemenu.run();
  learning.run();
  iteration.run();
  learning.showtext((learning.startposition.x+learning.endposition.x)/2, learning.position.y-30);
  iteration.showtext((iteration.startposition.x+iteration.endposition.x)/2, iteration.position.y-30, 1);
  start.show();
  start.training();
  bonusarea.show();
  bonusarea.bonusarea();
}



public void training() {
  float TP=0;
  float TN=0;
  float FP=0;
  float FN=0;
  //translate(width/2,height/2);
  back.show();
  back.back();

  for (drawpoint p : trainingdata) {
    p.show();
  }
  for (drawpoint pt : trainingdata) {
    float[] inputs={pt.position.x, pt.position.y, pt.bias};
    if (count<iteration.v) {
      n.train(inputs, (int)pt.lable);
    }
  }
  for (drawpoint pt : trainingdata) {
    float[] inputs={pt.position.x, pt.position.y, pt.bias};
    int guess=n.guess(inputs);
    //print(guess+" ");

    //print(guess+"\n");
    noStroke();
    if (guess==pt.lable) {
      fill(0, 255, 0);
      if (guess==1) TP+=1;
      else TN+=1;
    } else {
      fill(255, 0, 0);
      if (guess==1 ) FP+=1;
      else FN+=1;
    }
    circle(pt.showposition.x, pt.showposition.y, 2);
  }
  float N=TP+TN+FP+FN;
  float accuracy=(TP+TN)/N;
  float precision=TP/(TP+FP);
  float recall=TP/(TP+FN);
  if (count>=iteration.v || accuracy>=1) {
    test.show();
    test.test();
  }
  fill(255);
  text("iteration :"+count, width/2, 20);
  fill(0, 255, 0);
  text("Accuracy : "+str(accuracy*100)+" %", 500, 500);
  text("Precision : "+str(precision*100)+" %", 500, 540);
  text("Recall : "+str(recall*100)+" %", 500, 580);
  p3=new drawpoint(minnum[0], n.guessY(minnum[0]));
  p4=new drawpoint(maxnum[0], n.guessY(maxnum[0]));

  stroke(0);
  line(p3.showposition.x, p3.showposition.y, p4.showposition.x, p4.showposition.y);
  if (count<iteration.v) count+=1;
}


public void testing() {
  float TP=0;
  float TN=0;
  float FP=0;
  float FN=0;
  //translate(width/2,height/2);
  back.show();
  back.back();
  for (drawpoint p : testingdata) {
    p.show();
  }
  for (drawpoint pt : testingdata) {
    float[] inputs={pt.position.x, pt.position.y, pt.bias};
    int guess=n.guess(inputs);
    //print(guess+" ");

    //print(guess+"\n");
    noStroke();
    if (guess==pt.lable) {
      fill(0, 255, 0);
      if (guess==1) TP+=1;
      else TN+=1;
    } else {
      fill(255, 0, 0);
      if (guess==1 ) FP+=1;
      else FN+=1;
    }
    circle(pt.showposition.x, pt.showposition.y, 2);
  }
  float N=TP+TN+FP+FN;
  float accuracy=(TP+TN)/N;
  float precision=TP/(TP+FP);
  float recall=TP/(TP+FN);
  println(str(TP)+" "+str(TN)+" "+str(FP)+" "+str(FN)+" ");
  p3=new drawpoint(minnum[0], n.guessY(minnum[0]));
  p4=new drawpoint(maxnum[0], n.guessY(maxnum[0]));
  stroke(0);
  line(p3.showposition.x, p3.showposition.y, p4.showposition.x, p4.showposition.y);
  text("Accuracy : "+str(accuracy*100)+" %", 500, 500);
  text("Precision : "+str(precision*100)+" %", 500, 540);
  text("Recall : "+str(recall*100)+" %", 500, 580);
  fill(255);
  text("w0 = "+n.weight[0][0], 100, 500);
  text("w1 = "+n.weight[0][1], 100, 540);
  text("w2 = "+n.weight[0][2], 100, 580);
}

public void bonus() {
  for (button b : bonusbuttons) {
    b.show();
    b.select();
  }
  rectMode(CORNER);
  stroke(255);
  noFill();
  rect(250, 75, 300, 300);
  //println(buttons.touch);
  for(int i=0;i<=300;i+=1){
    for(int j=0;j<=300;j+=1){
      noStroke();
      fill(random(255));
      rect(250+i,75+j,1,1);
    }
  }

  back.show();
  back.back();
}


public void initialize(String name) {
  try { 
    data=loadStrings("NN_HW1_DataSet\\"+name+".txt");
  } catch(RuntimeException e){
    data=loadStrings("NN_HW1_DataSet\\"+name+".TXT");
  }
  category.clear();
  points=new float[data.length][];
  database=new drawpoint[data.length];
  for (int i=0; i<data.length; i+=1) {   
    String[] word=split(data[i], ' ');
    points[i]=new float[word.length];
    if (PApplet.parseFloat(word[word.length-1]) != 1) word[word.length-1]= "-1" ;

    points[i]=PApplet.parseFloat(word);
  }
  n=new net(1, 3);
  maxnum=new float[points[0].length-1];
  minnum=new float[points[0].length-1];
  for(int i=0;i<maxnum.length;i+=1){
    maxnum[i]=ceil(calcmax(points,i)+1);
    minnum[i]=floor(calcmin(points,i)-1);
  }
  //maxnum=new PVector( ceil(calcmax(points, 0)+1), ceil(calcmax(points, 1))+1);
  //minnum=new PVector( floor(calcmin(points, 0)-1), floor(calcmin(points, 1))-1);
  for (int i=0; i<database.length; i+=1) {
    database[i]=new drawpoint(points[i]);
  }
  randomChoese();
}


public float calcmax(float[][] d, int n) {
  float record=-1000000000;
  for (int i=0; i<d.length; i+=1) {   
    if ((d[i][n])>record) record=(d[i][n]);
  }

  return record;
}

public float calcmin(float[][] d, int n) {
  float record=1000000000;
  for (int i=0; i<d.length; i+=1) {   
    if ((d[i][n])<record) record=(d[i][n]);
  }

  return record;
}

public void randomChoese() {
  int trnum=floor(database.length*trainingnum/100);  
  int tenum=database.length-trnum;
  trainingdata=new drawpoint[trnum];
  testingdata=new drawpoint[tenum];
  int[] lb=new int[database.length];
  int c=0;
  for (int i=0; i<database.length; i+=1) {
    lb[i]=0;
  }
  while (c<trnum) {
    for (int i=0; i<lb.length; i+=1) {
      if (random(1)<trainingnum/100 && lb[i]==0) {
        lb[i]=1;
        c+=1;
      }
      if (c>=trnum) break;
    }
  }
  int a=0;
  int b=0;
  for (int i=0; i<lb.length; i+=1) {
    if (lb[i]==1) {
      trainingdata[a]=database[i];
      a+=1;
    } else {
      testingdata[b]=database[i];
      b+=1;
    }
  }
}
class button{
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  boolean touch=false;
  boolean pressed=false;
  button(String _name,float _x,float _y,int _num,float _len,float _hei){
    name=_name;
    position=new PVector(_x,_y);
    num=_num;
    len=_len;
    hei=_hei;
    pp=position.copy();
  }
  public void show(float value){
    pp.y=position.y-value*(buttons.length*60+100-height)/100;
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if(touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(pp.x,pp.y,len,hei);
    fill(255);
    textSize(20);
    text(name,pp.x,pp.y-3);
  }
  public void show(){
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if(touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(position.x,position.y,len,hei);
    fill(255);
    textSize(20);
    text(name,position.x,position.y-3);
  }
  public void slidershow(){
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if(touch==false) fill(0);
    else fill(50);
    noStroke();
    rect(position.x,position.y,len,hei);
    fill(255);
    textSize(20);
    text(name,position.x,position.y-3);
  }
  public void select(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        initialize(name);
        pressed=true;
      }
    }
    else pressed=false;    
  }
  public void slide(){
    
  
  }
  
  public PVector sliderselect(){
    if(mouseX>position.x-len/2 && mouseX<position.x+len/2 && mouseY>position.y-hei/2 && mouseY<position.y+hei/2){
      touch=true;
    }
    
    
    if (touch==true && mousePressed == true){
      position.x=mouseX;
      position.y=mouseY;
    }
    else touch=false;
    return position;
    
  }
  
  public void training(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false; 
    
    if (touch==true && mousePressed == true){
      if(pressed==false){
          training=true;
          menu=false;
          testing=false;
          bonus=false;
          n.lr=learning.v;
        pressed=true;
      }
    }
    else pressed=false;
  }  
  public void back(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        menu=true;
        training=false;
        testing=false;
        bonus=false;
        pressed=true;
        count=0;
        for(int i=0;i<n.weight.length;i+=1){
          for(int j=0;j<n.weight[i].length;j+=1){
            n.weight[i][j]=random(-10,10);
          }
        }
      }
    }
    else pressed=false;    
  }
  public void test(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        menu=false;
        training=false;
        testing=true;
        bonus=false;
        pressed=true;
      }
    }
    else pressed=false;    
  }
  
  public void bonusarea(){
    if(mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2){
      touch=true;
    }
    else touch=false;     
    if (touch==true && mousePressed == true){
      if(pressed==false){
        menu=false;
        training=false;
        testing=false;
        bonus=true;
        pressed=true;
      }
    }
    else pressed=false;    
  }
  
}
class drawpoint{
  PVector position;
  PVector showposition;
  PVector preposition;
  float lable;
  float bias=-1;
  drawpoint(float x_,float y_){
    position=new PVector(x_,y_);
    showposition=new PVector(map(position.x,minnum[0],maxnum[0],0,width),map(position.y,minnum[1],maxnum[1],0,height));
    
    bias=-1;
  }
  drawpoint(float[] im){
    position=new PVector(im[0],im[1]);
    lable=im[im.length-1];
    showposition=new PVector(map(im[0],minnum[0],maxnum[0],0,width),map(im[1],minnum[1],maxnum[1],0,height));
    preposition=new PVector(map(im[0],minnum[0],maxnum[0],250,550),map(im[1],minnum[1],maxnum[1],75,375));
  
  }
  public void show(){
    if (lable==1) fill(255);
    else fill(0);
    noStroke();
    circle(showposition.x,showposition.y,8);
  }
  public void preview(){
    if (lable==1) fill(255);
    else fill(0);
    noStroke();
    circle(preposition.x,preposition.y,8);
  }

}
class net {

  float[][] weight;
  float lr=0.00001f;
  float bias;
  net(int n, int m) {
    weight=new float[n][m];
    for (int i=0; i<weight.length; i+=1) {
      for (int j=0; j<weight[i].length; j+=1) {
        weight[i][j]=random(-10, 10);
      }
    }
  }
  public int guess(float[] inputs) {
    float sum=0;
    for (int j=0; j<weight.length; j+=1) {
      for (int i=0; i<weight[j].length; i+=1) {
        sum+=inputs[i]*weight[j][i];
      }
    }
    int output=sigh(sum);
    return output;
  }
  public int sigh(float n) {
    if (n>=0) return 1;
    else return -1;
  }
  public void train(float[] inputs, int target) {
    int guess=guess(inputs);
    int error=target-guess;
    for (int j=0; j<weight.length; j+=1) {
      for (int i=0; i<weight[j].length; i+=1) {
        weight[j][i]+=error*inputs[i]*lr;
      }
    }
  }
  public float guessY(float x) {
    float w0=weight[0][0];
    float w1=weight[0][1];
    float w2=weight[0][2];

    return (w2/w1)-(w0/w1)*x;
  }
}
class slider{
  PVector startposition;
  PVector  endposition;
  PVector position;
  float value=0;
  float len;
  float hei;
  float max;
  float min;
  float v;
  boolean touch=false;
  String name;
  button sliderbutton;
  slider(String _name,float startpx,float startpy,float endpx,float endpy,float _len,float _hei,float _min,float _max){
    name=_name;
    startposition=new PVector(startpx,startpy);
    endposition=new PVector(endpx,endpy);
    position=startposition.copy();
    len=_len;
    hei=_hei;
    max=_max;
    min=_min;
    sliderbutton=new button("",startposition.x,startposition.y,0,_len,_hei);
    v=(max-min)*value/100+min;  
}
  public void run(){
    position=sliderbutton.sliderselect();
    constrainbutton();
    calcValue();
    show();
  }
  public void constrainbutton(){
    if(position.x<startposition.x) position.x=startposition.x;
    if(position.y<startposition.y) position.y=startposition.y;
    if(position.x>endposition.x) position.x=endposition.x;
    if(position.y>endposition.y) position.y=endposition.y;
    sliderbutton.position=position;
  }
  public void calcValue(){    
    float d=dist(startposition.x,startposition.y,endposition.x,endposition.y);
    float v=dist(position.x,position.y,startposition.x,startposition.y);
    value=v/d*100;
  }
  public void show(){
    rectMode(CENTER);
    fill(200);
    v=(max-min)*value/100+min;
    rect((startposition.x+endposition.x)/2,(startposition.y+endposition.y)/2,endposition.x-startposition.x+len,endposition.y-startposition.y+hei);
    sliderbutton.slidershow();
    
  
  }
  public void showtext(float _x,float _y,int a){
    textSize(16);
    float v=(max-min)*value/100+min;
    text(name+" : "+str((int)v),_x,_y);
    
  }
  public void showtext(float _x,float _y){
    textSize(16);
    
    text(name+" : "+str(v),_x,_y);
    
  }
  
  
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "preceptron" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
