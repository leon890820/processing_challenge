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

public class multiple_neural_network extends PApplet {

int scl;
int num=28;
float[][] mosaic;
boolean save=false;
button reset;
button send;
button views;
button backM;
button next;
button prev;
button label;
button reload;
button resetweight;
button trainingM;
textbox keylabel;
NN nueralnetwork;
boolean train=false;
boolean menuM=true;
boolean view=false;
boolean blabel=false;
boolean MNISTb=false;
StringList sdata;
String[] dataM;
int page=1;
int maxpage;
number[] viewdatas=new number[100];
number[] trainingdataM;
String[] weightdata;
String[] data;
String[] dataName={"perceptron1", "perceptron2", "2Ccircle1", "2Circle1", "2Circle2", "2CloseS", "2CloseS2", "2CloseS3", "2cring", "2CS", "2Hcircle1", "2ring","Cccircle"};
String[] bonusdataName={"4satellite-6", "5CloseS1", "8OX", "C3D", "C10D", "IRIS", "Number"};
float[][] points;
float trainingnum=80;
FloatList category;
FloatList MSV;
int[] cs;
EvolutionGraph graph;
drawpoint[] database;
drawpoint[] trainingdata;
drawpoint[] testingdata;

float[] maxnum;
float[] minnum;
boolean menu=true;
boolean training=false;
boolean testing=false;
boolean bonus=false;
boolean showclassify=true;
button[] buttons=new button[dataName.length];
button[] bonusbuttons=new button[bonusdataName.length];
slider slidemenu;
slider learning;
slider iteration;
button MNIST;
button start;
button back;
button test;
button backton;
button bonusarea;
button addlayer;
button deletelayer;
button classify;
net n;
drawpoint p3;
drawpoint p4;
int count=0;
public void settings() {
  size(1000, 800);
}

public void setup() {
  
  MNISTsetup();
  category=new FloatList();
  MSV=new FloatList();
  slidemenu=new slider("slidemenu", 210, 100, 210, 500, 10, 20, 0, 0);
  learning=new slider("learning", 260, 450, 540, 450, 20, 10, 0.0001f, 1);
  iteration=new slider("iteration", 260, 520, 540, 520, 20, 10, 1, 10000);
  test=new button("test", 522, 25, 0, 150, 50);
  classify=new button("classify", 522, 25, 0, 150, 50);
  back=new button("back", 75, 25, 0, 150, 50);
  backton=new button("back",800,750,0,150,50);
  start=new button("training", 400, 565, 0, 200, 50);
  bonusarea=new button("bonus", 400, 40, 0, 150, 50);
  addlayer=new button("+", 900, 500, 0, 50, 50);
  deletelayer=new button("-", 700, 500, 0, 50, 50);
  MNIST=new button("MNIST", 400, 40, 0, 150, 50);
  
  for (int i=0; i<buttons.length; i+=1) {
    buttons[i]=new button(dataName[i], 100, 100+i*60, i, 150, 50);
  }
  for (int i=0; i<bonusbuttons.length; i+=1) {
    bonusbuttons[i]=new button(bonusdataName[i], 100, 100+i*60, i, 150, 50);
  }
  n=new net(2, 2);
  initialize(dataName[0]);
  for (int i=0; i<database.length; i+=1) {
    //println(i);
    //println(n.forward(database[i]));
    n.train(database[i]);
  }
  for (int i=0; i<database.length; i+=1) {
    //println(i);
    //println(n.forward(database[i]));
    n.train(database[i]);
  }
}



public void draw() {
  background(100, 100);
  if (menu==true) menu();
  else if (training==true) {
    training();
    testing();
  } else if (testing==true) testing();
  else if (bonus==true) bonus();
  else if (MNISTb==true) MNIST();
}
public void MNIST() {
  background(150); 
  if (menuM==true) menuM();
  else if (view==true) view();
}
public void MNISTsetup() {
  dataM=loadStrings("numberdata.txt");
  weightdata=loadStrings("weightdata.txt");
  scl=560/num;
  nueralnetwork=new NN(784, 256, 128, 10);
  
  sdata=new StringList();

  trainingdataM=new number[dataM.length];
  for (int j=0; j<trainingdataM.length; j+=1) {
    String[] t=dataM[j].split(" ");
    float[] tt=new float[t.length-1];
    int l=PApplet.parseInt(t[t.length-1]);
    for (int i=0; i<tt.length; i+=1) {
      tt[i]=PApplet.parseFloat(t[i]);
    }
    trainingdataM[j]=new number(tt, l);
  }
  for (int i=0; i<10; i+=1) {
    for (int j=0; j<10; j+=1) {
      int index=j+i*10;
      viewdatas[index]=trainingdataM[index];
    }
  }
  for (String s : dataM) {
    sdata.append(s);
  }
  mosaic=new float[num][num];
  for (int i=0; i<num; i+=1) {
    for (int j=0; j<num; j+=1) {
      mosaic[i][j]=255;
    }
  }

  String[] weight=weightdata[0].split(" ");
  for (int i=0; i<nueralnetwork.w1.cols; i+=1) {
    for (int j=0; j<nueralnetwork.w1.rows; j+=1) {
      int index=i*nueralnetwork.w1.rows+j;
      nueralnetwork.w1.w[i][j]=PApplet.parseFloat(weight[index]);
    }
  }
  weight=weightdata[1].split(" ");
  for (int i=0; i<nueralnetwork.w2.cols; i+=1) {
    for (int j=0; j<nueralnetwork.w2.rows; j+=1) {
      int index=i*nueralnetwork.w2.rows+j;
      nueralnetwork.w2.w[i][j]=PApplet.parseFloat(weight[index]);
    }
  }
  weight=weightdata[2].split(" ");
  for (int i=0; i<nueralnetwork.w3.cols; i+=1) {
    for (int j=0; j<nueralnetwork.w3.rows; j+=1) {
      int index=i*nueralnetwork.w3.rows+j;
      nueralnetwork.w3.w[i][j]=PApplet.parseFloat(weight[index]);
    }
  }



  reset=new button("reset", 675, 50, 0, 150, 50);
  resetweight=new button("resetweight",825,50,0,150,50);
  send=new button("send", 400, 700, 0, 150, 50);
  next=new button("next", 300, 650, 0, 150, 50);
  prev=new button("prev", 100, 650, 0, 150, 50);
  views=new button("view", 675, 150, 0, 150, 50);
  reload=new button("reload", 675, 250, 0, 150, 50);
  keylabel=new textbox(200, 700, 40, 75);
  backM=new button("back", 500, 650, 0, 150, 50);
  label=new button("label", 675, 150, 0, 150, 50);
  trainingM=new button("train", 675, 50, 0, 150, 50);
  maxpage=trainingdataM.length/100+1;
  //print(nueralnetwork.forward(trainingdataM[0].data));
  for (int i=0; i<trainingdataM.length; i+=1) {
    trainingdataM[i].predict=(int)nueralnetwork.forward(trainingdataM[i].data);
    trainingdataM[i].realforward=nueralnetwork.realforward();
    //nueralnetwork.training(trainingdataM[i]);
  }
  //cost();
  for (int i=0; i<trainingdataM.length; i+=1) {
    trainingdataM[i].predict=(int)nueralnetwork.forward(trainingdataM[i].data);
    trainingdataM[i].realforward=nueralnetwork.realforward();
    nueralnetwork.training(trainingdataM[i]);
  }
  //cost();
  //println(trainingdataM[0].realforward);
}
public void MNISTsetupweight() {
  dataM=loadStrings("numberdata.txt");
  weightdata=loadStrings("weightdata.txt");
  scl=560/num;
  nueralnetwork=new NN(784, 256, 128, 10);
  
  sdata=new StringList();

  trainingdataM=new number[dataM.length];
  for (int j=0; j<trainingdataM.length; j+=1) {
    String[] t=dataM[j].split(" ");
    float[] tt=new float[t.length-1];
    int l=PApplet.parseInt(t[t.length-1]);
    for (int i=0; i<tt.length; i+=1) {
      tt[i]=PApplet.parseFloat(t[i]);
    }
    trainingdataM[j]=new number(tt, l);
  }
  for (int i=0; i<10; i+=1) {
    for (int j=0; j<10; j+=1) {
      int index=j+i*10;
      viewdatas[index]=trainingdataM[index];
    }
  }
  for (String s : dataM) {
    sdata.append(s);
  }
  mosaic=new float[num][num];
  for (int i=0; i<num; i+=1) {
    for (int j=0; j<num; j+=1) {
      mosaic[i][j]=255;
    }
  }

  


  reset=new button("reset", 675, 50, 0, 150, 50);
  resetweight=new button("resetweight",850,50,0,150,50);
  send=new button("send", 400, 700, 0, 150, 50);
  next=new button("next", 300, 650, 0, 150, 50);
  prev=new button("prev", 100, 650, 0, 150, 50);
  views=new button("view", 675, 150, 0, 150, 50);
  reload=new button("reload", 675, 250, 0, 150, 50);
  keylabel=new textbox(200, 700, 40, 75);
  backM=new button("back", 500, 650, 0, 150, 50);
  label=new button("label", 675, 150, 0, 150, 50);
  trainingM=new button("train", 675, 50, 0, 150, 50);
  maxpage=trainingdataM.length/100+1;
  //print(nueralnetwork.forward(trainingdataM[0].data));
  for (int i=0; i<trainingdataM.length; i+=1) {
    trainingdataM[i].predict=(int)nueralnetwork.forward(trainingdataM[i].data);
    trainingdataM[i].realforward=nueralnetwork.realforward();
    //nueralnetwork.training(trainingdataM[i]);
  }
  //cost();
  for (int i=0; i<trainingdataM.length; i+=1) {
    trainingdataM[i].predict=(int)nueralnetwork.forward(trainingdataM[i].data);
    trainingdataM[i].realforward=nueralnetwork.realforward();
    nueralnetwork.training(trainingdataM[i]);
  }
  //cost();
  //println(trainingdataM[0].realforward);
}

public void menu() {
  MNIST.show();
  MNIST.MNIST();
  if (showclassify) classfy();
  for (button b : buttons) {
    b.show(slidemenu.value);
    b.select();
  }
  rectMode(CORNER);
  stroke(255);
  noFill();
  rect(250, 75, 300, 300);
  textSize(32);
  text("layer : "+n.h.size(), 800, 500);
  //println(buttons.touch);
  for (drawpoint p : database) {
    p.preview();
  }
  showNN();
  slidemenu.run();
  learning.run();
  iteration.run();
  learning.showtext((learning.startposition.x+learning.endposition.x)/2, learning.position.y-30);
  iteration.showtext((iteration.startposition.x+iteration.endposition.x)/2, iteration.position.y-30, 1);
  start.show();
  start.training();
  //bonusarea.show();
  //bonusarea.bonusarea();
  addlayer.show();
  addlayer.addlayer();
  deletelayer.show();
  deletelayer.deletelayer();
  //println(n.forward(database[0]));
}

public void menuM() {
  drawP();
  rectMode(CORNER);
  stroke(0);
  noFill();
  rect(0, 0, 560, 560);
  keylabel.show();
  keylabel.select();
  send.show();
  send.send();
  views.show();
  views.view();
  reload.show();
  reload.reload();
  resetweight.show();
  resetweight.resetweight();
  backton.show();
  backton.backton();
}

public void view() {
  trainingM.show();
  trainingM.trainingM();
  backM.show();
  backM.backM();
  label.show();
  label.label();
  reload.show();
  reload.reload();
  if (page!=maxpage) {
    next.show();
    next.next();
  } 
  if (page != 1) {
    prev.show();
    prev.prev();
  }
  if (train==true) {
    for (int k=0; k<100; k+=1) {
      for (int i=0; i<trainingdataM.length; i+=1) {
        trainingdataM[i].predict=(int)nueralnetwork.forward(trainingdataM[i].data);
        trainingdataM[i].realforward=nueralnetwork.realforward();
        nueralnetwork.training(trainingdataM[i]);
      }
      cost();
    }
    nueralnetwork.saveweight();
    println(trainingdataM[4].realforward[0]);
    println(trainingdataM[4].label[0]);
    train=false;
  }

  fill(0, 0, 0);
  textAlign(CENTER);
  text("page : "+str(page)+" / "+str(maxpage), 300, 580);

  int s=2;
  for (int i=0; i<10; i+=1) {
    for (int j=0; j<10; j+=1) {
      if (blabel==false) {
        int index=i+j*10;
        if (viewdatas[index]==null) continue;
        viewdatas[index].view(i*s*28, j*s*28, s);
      } else {          
        int index=i+j*10;
        if (viewdatas[index]==null) continue;
        textSize(20);
        stroke(255);
        text(viewdatas[index].predict, 28+i*56, 28+j*56);
      }
    }
  }
}

public void drawPic() {
  float positionX=mouseX*num/560;
  float positionY=mouseY*num/560;
  //if (positionX>=num) positionX=num-1;
  if (positionX<=0) positionX=0;
  //if (positionY>=num) positionY=num-1;
  if (positionY<=0) positionY=0;

  if (positionX<num && positionY<num) {
    mosaic[(int)positionX][(int)positionY]-=100;

    for (int i=-1; i<=1; i+=1) {
      for (int j=-1; j<=1; j+=1) {
        if ((int)positionX==0||(int)positionY==0||(int)positionX==num-1||(int)positionY==num-1) {
          continue;
        }
        mosaic[(int)positionX+i][(int)positionY+j]-=20;
        if (mosaic[(int)positionX+i][(int)positionY+j]<=0) {
          mosaic[(int)positionX+i][(int)positionY+j]=0;
        }
      }
    }
  }
}

public void drawP() {
  noFill();
  noStroke();
  //stroke(0,50);
  rectMode(CORNER);
  for (int i=0; i<num; i+=1) {
    for (int j=0; j<num; j+=1) {
      fill(mosaic[i][j]);
      rect(i*scl, j*scl, scl, scl);
    }
  }
  if (mousePressed == true && reset.pressed==false) drawPic();
  reset.show();
  reset.selectM();
  if (keylabel.select==true) {
    keylabel.type();
  }
}

public void reset() {
  for (int i=0; i<num; i+=1) {
    for (int j=0; j<num; j+=1) {
      mosaic[i][j]=255;
      keylabel.t="";
    }
  }
}

public void viewload(int p) {
  for (int i=0; i<10; i+=1) {
    for (int j=0; j<10; j+=1) {
      int index=j+i*10;
      if (index+(p-1)*100>=trainingdataM.length) {
        viewdatas[index]=null;
      } else {
        viewdatas[index]=trainingdataM[index+(p-1)*100];
      }
    }
  }
}

public void cost() {
  float cost=0;
  for (int i=0; i<trainingdataM.length; i+=1) {
    cost+=norm2(trainingdataM[i].label[0], trainingdataM[i].realforward[0]);
  }
  println(cost);
}

public float norm2(float[] a, float[] b) {
  float result=0;
  for (int i=0; i<a.length; i+=1) {
    result+=pow(a[i]-b[i], 2);
  }

  return sqrt(result);
}

public void mousePressed() {
  keylabel.select=false;
}
public void classfy() {
  PVector p;

  //loadPixels();
  for (int i=251; i<550; i+=1) {
    for (int j=76; j<375; j+=1) {
      int index=j*width+i;
      p=new PVector(map(i, 251, 549, minnum[0], maxnum[0]), map(j, 76, 374, minnum[1], maxnum[1]));
      float[] in={p.x, p.y};  
      float ans=calcmaxoutput(n.forward(in));
      //pixels[index]=color(cs[(int)ans],100);
      fill(cs[(int)ans], 100);
      noStroke();
      rect(i, j, 1, 1);
    }
  }
  //updatePixels();
}
public void classfytrain() {
  PVector p;

  //loadPixels();
  for (int i=100; i<400; i+=1) {
    for (int j=75; j<375; j+=1) {
      int index=j*width+i;
      p=new PVector(map(i, 100, 400, minnum[0], maxnum[0]), map(j, 75, 375, minnum[1], maxnum[1]));
      float[] in={p.x, p.y};  
      float ans=calcmaxoutput(n.forward(in));
      //pixels[index]=color(cs[(int)ans],100);
      fill(cs[(int)ans], 100);
      noStroke();
      rect(i, j, 1, 1);
    }
  }
  //updatePixels();
}
public void classfytest() {
  PVector p;

  //loadPixels();
  for (int i=600; i<900; i+=1) {
    for (int j=75; j<375; j+=1) {
      int index=j*width+i;
      p=new PVector(map(i, 600, 900, minnum[0], maxnum[0]), map(j, 75, 375, minnum[1], maxnum[1]));
      float[] in={p.x, p.y};  
      float ans=calcmaxoutput(n.forward(in));
      //pixels[index]=color(cs[(int)ans],100);
      fill(cs[(int)ans], 100);
      noStroke();
      rect(i, j, 1, 1);
    }
  }
  //updatePixels();
}


public float calcmaxoutput(float[] a) {
  //float result=0;
  float record=-100000;
  float index=0;
  for (int i=0; i<a.length; i+=1) {
    if (a[i]>record) {
      record=a[i];
      index=i;
    }
  }

  return index;
}



public void showNN() {
  float r=100;
  float ro=100;
  float r1=100;
  float r2=50;
  if (n.input.rows>5) {
    r=100*5/n.input.rows;
    r1=100*5/n.input.rows;
  }
  //zero
  if (n.h.size()==0) {
    for (int i=0; i<n.input.rows; i+=1) {
      for (int j=0; j<n.output.rows; j+=1) {
        float l=250-(n.input.rows-1)*r/2;
        float lo=250-(n.output.rows-1)*ro/2;

        stroke(255, 0, 0);
        line(675, l+i*r, 925, lo+j*ro);
      }
    }
  } else {
    //first to one
    float h=675+250*(0+1)/(n.h.size()+1);
    for (int i=0; i<n.input.rows; i+=1) {
      for (int j=0; j<n.h.get(0).rows; j+=1) {
        float l=250-(n.input.rows-1)*r1/2;
        float lh=250-(n.h.get(0).rows-1)*r2/2;
        stroke(255, 0, 0);
        line(675, l+i*r1, h, lh+j*r2);
      }
    }
    //hidden
    for (int k=0; k<n.h.size()-1; k+=1) {
      float h1=675+250*(k+1)/(n.h.size()+1);
      float h2=675+250*(k+1+1)/(n.h.size()+1);
      for (int i=0; i<n.h.get(k).rows; i+=1) {
        for (int j=0; j<n.h.get(k+1).rows; j+=1) {
          float l=250-(n.h.get(k).rows-1)*r2/2;
          float lh=250-(n.h.get(k+1).rows-1)*r2/2;
          stroke(255, 0, 0);
          line(h1, l+i*r2, h2, lh+j*r2);
        }
      }
    }


    // last to output
    h=675+250*(n.h.size()-1+1)/(n.h.size()+1);
    for (int i=0; i<n.output.rows; i+=1) {
      for (int j=0; j<n.h.get(n.h.size()-1).rows; j+=1) {
        float l=250-(n.output.rows-1)*ro/2;
        float lh=250-(n.h.get(n.h.size()-1).rows-1)*r2/2;
        stroke(255, 0, 0);
        line(925, l+i*ro, h, lh+j*r2);
      }
    }
  }

  //input
  r=100;
  if (n.input.rows>5) {
    r=100*5/n.input.rows;
    r1=100*5/n.input.rows;
  }
  for (int i=0; i<n.input.rows; i+=1) {
    float l=250-(n.input.rows-1)*r/2;   
    fill(255);
    noStroke();
    circle(675, l+i*r, 20);
  }
  //hidden
  r=50;
  for (int i=0; i<n.h.size(); i+=1) {
    float h=675+250*(i+1)/(n.h.size()+1);
    textSize(12);
    text(n.h.get(i).rows, h, 25);
    for (int j=0; j<n.h.get(i).rows; j+=1) {
      float l=250-(n.h.get(i).rows-1)*r/2;
      fill(255);
      noStroke();
      circle(h, l+j*r, 20);
    }
  }
  //output
  r=100;
  for (int i=0; i<n.output.rows; i+=1) {
    float l=250-(n.output.rows-1)*r/2;   
    fill(255);
    noStroke();
    circle(925, l+i*r, 20);
  }

  for (button b : n.plus) {
    b.show();
  }
  for (button b : n.minus) {
    b.show();
  }
  for (int i=0; i<n.plus.size(); i+=1) {
    n.plus.get(i).plus(i);
    n.minus.get(i).minus(i);
  }
}


public void training() {
  float TP=0;
  float TN=0;
  float FP=0;
  float FN=0;
  if (showclassify) classfytrain();
  //translate(width/2,height/2);
  back.show();
  back.back();

  for (drawpoint p : trainingdata) {
    p.show();
  }
  for (drawpoint pt : trainingdata) {    
    if (count<iteration.v) {
      pt.real=n.forward(pt);
      n.train(pt);
    }
  }
  for (drawpoint pt : trainingdata) {

    float guess=calcmaxoutput(n.forward(pt));
    noStroke();
    if (guess==calcmaxoutput(pt.lable)) {
      if (guess==1) TP+=1;
      else TN+=1;
    } else {
      if (guess==1 ) FP+=1;
      else FN+=1;
    }
  }
  float cost=0;
  for (drawpoint d : trainingdata) {
    float sum=0;
    for (int i=0; i<d.real.length; i+=1) {
      sum+=pow(d.real[i]-d.lable[i], 2);
    }
    cost+=sum;
  }
  MSV.append(cost);
  //println(cost);
  rectMode(CORNER);
  stroke(255);
  noFill();
  rect(100, 75, 300, 300);
  float N=TP+TN+FP+FN;
  float accuracy=(TP+TN)/N;
  float precision=TP/(TP+FP);
  float recall=TP/(TP+FN);
  if (count>=iteration.v && save==false) {
    int sum=n.input.rows;
    for(int i=0;i<n.h.size();i+=1){
      sum+=n.h.get(i).rows;
    }
    String[] d=new String[sum];
    String list="";
    int c=0;
    for(int i=0;i<n.w.size();i+=1){
      for(int j=0;j<n.w.get(i).cols;j+=1){
        for(int k=0;k<n.w.get(i).rows;k+=1){
          list+=str(n.w.get(i).w[j][k])+" ";
        }
        d[c]=list;
        c+=1;
        list="";
      }
    }
    saveStrings("weight.txt",d);
    
    
    save=true;
  }
  classify.show();
  classify.classify();
  fill(255);
  text("iteration :"+count, 600/2, 20);
  fill(0, 255, 0);
  text("Accuracy : "+str(accuracy*100)+" %", 120, 500);
  text("Precision : "+str(precision*100)+" %", 120, 540);
  text("Recall : "+str(recall*100)+" %", 120, 580);

  if (count<iteration.v) count+=1;
}


public void testing() {
  float TP=0;
  float TN=0;
  float FP=0;
  float FN=0;
  if (showclassify) classfytest();
  //translate(width/2,height/2);
  back.show();
  back.back();
  for (drawpoint p : testingdata) {
    p.testview();
  }
  for (drawpoint pt : testingdata) {

    float guess=calcmaxoutput(n.forward(pt));
    //print(guess+" ");

    //print(guess+"\n");
    noStroke();
    if (guess==calcmaxoutput(pt.lable)) {
      if (guess==1) TP+=1;
      else TN+=1;
    } else {      
      if (guess==1 ) FP+=1;
      else FN+=1;
    }
  }
  float N=TP+TN+FP+FN;
  float accuracy=(TP+TN)/N;
  float precision=TP/(TP+FP);
  float recall=TP/(TP+FN);
  //println(str(TP)+" "+str(TN)+" "+str(FP)+" "+str(FN)+" ");

  text("Accuracy : "+str(accuracy*100)+" %", 700, 500);
  text("Precision : "+str(precision*100)+" %", 700, 540);
  text("Recall : "+str(recall*100)+" %", 700, 580);
}

public void bonus() {
  for (button b : bonusbuttons) {
    b.show();
    b.select();
  }
  showNN();
  addlayer.show();
  addlayer.addlayer();
  deletelayer.show();
  deletelayer.deletelayer();
  rectMode(CORNER);
  stroke(255);
  noFill();
  rect(250, 75, 300, 300);
  //println(buttons.touch);
  for (int i=0; i<=300; i+=1) {
    for (int j=0; j<=300; j+=1) {
      noStroke();
      fill(random(255));
      rect(250+i, 75+j, 1, 1);
    }
  }

  back.show();
  back.back();
}


public void initialize(String name) {
  try { 
    data=loadStrings("NN_HW1_DataSet\\"+name+".txt");
  } 
  catch(RuntimeException e) {
    data=loadStrings("NN_HW1_DataSet\\"+name+".TXT");
  }
  category.clear();
  points=new float[data.length][];
  database=new drawpoint[data.length];
  for (int i=0; i<data.length; i+=1) {   
    String[] word=split(data[i], ' ');
    points[i]=new float[word.length];
    //if (float(word[word.length-1]) != 1) word[word.length-1]= "-1" ;

    points[i]=PApplet.parseFloat(word);
  }
  float[] la=calclable(points);
  cs=new int[la.length];
  for (int i=0; i<cs.length; i+=1) {
    cs[i]=color(random(255), random(255), random(255));
  }
  //println(la);
  maxnum=new float[points[0].length-1];
  minnum=new float[points[0].length-1] ;
  for (int i=0; i<maxnum.length; i+=1) {
    maxnum[i]=ceil(calcmax(points, i)+1);
    minnum[i]=floor(calcmin(points, i)-1);
  }
  //maxnum=new PVector( ceil(calcmax(points, 0)+1), ceil(calcmax(points, 1))+1);
  //minnum=new PVector( floor(calcmin(points, 0)-1), floor(calcmin(points, 1))-1);
  for (int i=0; i<database.length; i+=1) {
    database[i]=new drawpoint(points[i], la, cs);
  }
  //println(database[3].lable);
  n=new net(points[0].length-1, la.length);
  randomChoese();
}
public float[] calclable(float[][] a) {
  float[] result;
  FloatList l=new FloatList();
  for (int i=0; i<a.length; i+=1) {
    if (lisina(a[i][a[0].length-1], l)) {

      l.append(a[i][a[0].length-1]);
    }
  }
  result=new float[l.size()];
  for (int i=0; i<l.size(); i+=1) {
    result[i]=l.get(i);
  }
  return result;
}

public boolean lisina(float a, FloatList l) {
  // println(a);
  for (int i=0; i<l.size(); i+=1) {
    if (a==l.get(i)) {
      return false;
    }
  }

  return true;
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
class NN {
  matrix input;
  matrix hidden1;
  matrix hidden2;
  matrix output;
  matrix w1;
  matrix w2;
  matrix w3;
  matrix bias_h1;
  matrix bias_h2;
  matrix bias_o;
  float learning_rate=0.001f;
  float bias=1;
  NN(int i, int h1, int h2, int o) {
    input=new matrix(1, i);
    hidden1=new matrix(1, h1);
    hidden2=new matrix(1, h2);
    output=new matrix(1, o);
    w1=new matrix(i, h1);
    w2=new matrix(h1, h2);
    w3=new matrix(h2, o);
    bias_h1=new matrix(1, h1);
    bias_h2=new matrix(1, h2);
    bias_o=new matrix(1, o);
    w1.init();
    w2.init();
    w3.init();
    bias_h1.init();
    bias_h2.init();
    bias_o.init();
  }
  public float forward(float[] in) {
    float n=0;
    float[][] inn=new float[input.cols][input.rows];
    for (int i=0; i<inn[0].length; i+=1) {
      inn[0][i]=in[i]/255;
    }
    //inn[0][inn[0].length-1]=1;
    input.w=inn;
    matrix tem=input.multiple(w1);
    for (int i=0; i<hidden1.rows; i+=1) {
      hidden1.w[0][i]=tem.w[0][i];
    }
    //hidden1.w[0][hidden1.rows-1]=1;
    for (int i=0; i<hidden1.rows; i+=1) {
      hidden1.w[0][i]=sigmoid(hidden1.w[0][i]);
    }

    tem=hidden1.multiple(w2);
    for (int i=0; i<hidden2.rows; i+=1) {
      hidden2.w[0][i]=tem.w[0][i];
    }
    //hidden2.w[0][hidden2.rows-1]=1;
    for (int i=0; i<hidden2.rows; i+=1) {
      hidden2.w[0][i]=sigmoid(hidden2.w[0][i]);
    }
    output=hidden2.multiple(w3);
    for (int i=0; i<output.rows; i+=1) {
      output.w[0][i]=sigmoid(output.w[0][i]);
    }

    //println(output.w[0]);
    float max=calcmax(output.w[0]);


    return max;
  }

  public void training(number n) {
    matrix outputs=output;
    matrix target=new matrix(1, output.rows);
    target.w=n.label;
    matrix output_error=target.subtract(outputs);
    outputs=outputs.dsigmoidMatrix();
    outputs=outputs.scalematrix(output_error);
    outputs=outputs.scalematrix(learning_rate);

    matrix hidden2_t=hidden2.transport();
    matrix w3_deltas=hidden2_t.multiple(outputs);
    w3=w3.addiction(w3_deltas);
    bias_o=bias_o.addiction(outputs);

    matrix w3_t=w3.transport();
    matrix hidden2_error=output_error.multiple(w3_t);
    matrix hiddens2=hidden2;
    hiddens2=hiddens2.dsigmoidMatrix();
    hiddens2=hiddens2.scalematrix(hidden2_error);
    hiddens2=hiddens2.scalematrix(learning_rate);

    matrix hidden1_t=hidden1.transport();
    matrix w2_deltas=hidden1_t.multiple(hiddens2);
    w2=w2.addiction(w2_deltas);
    bias_h2=bias_h2.addiction(hiddens2);

    matrix w2_t=w2.transport();
    matrix hidden1_error=hidden2_error.multiple(w2_t);
    matrix hiddens1=hidden1;
    hiddens1=hiddens1.dsigmoidMatrix();
    hiddens1=hiddens1.scalematrix(hidden1_error);
    hiddens1=hiddens1.scalematrix(learning_rate);

    matrix input_t=input.transport();
    matrix w1_deltas=input_t.multiple(hiddens1);
    w1=w1.addiction(w1_deltas);
    bias_h1=bias_h1.addiction(hiddens1);
  }



  public float calcmax(float[] f) {
    float record=-100000;
    float[] index=new float[10];
    int in=0;
    //int inn=0;
    indexclear(index);
    for (int i=0; i<f.length; i+=1) {
      if (f[i]>record) {
        record=f[i];
        in=i;
      }
    }
    //  if (f[i]>record) {
    //    in=0;
    //    indexclear(index);
    //    record=f[i];
    //    index[in]=i;
    //    in+=1;
    //  } else if (f[i]==record) {
    //    index[in]=i;
    //    in+=1;
    //  }     
    //}
    //float n=index[(int)random(in+1)];


    return in;
  }
  public void indexclear(float[] index) {
    for (int i=0; i<index.length; i+=1) {
      index[i]=0;
    }
  }
  public float[][] realforward() {

    return output.w;
  }

  public void saveweight() {
    String[] list=new String[3];
    String s="";
    float total=w1.rows*w1.cols+w2.rows*w2.cols+w3.rows*w3.cols;
    float count=0;
    for (int i=0; i<w1.cols; i+=1) {
      for (int j=0; j<w1.rows; j+=1) {
        println((str(count*100/total)));
        count+=1;
        s+=str(w1.w[i][j])+" ";
      }
    }

    list[0]=s;

    s="";
    for (int i=0; i<w2.cols; i+=1) {
      for (int j=0; j<w2.rows; j+=1) {
        println((str(count*100/total)));
        count+=1;
        s+=str(w2.w[i][j])+" ";
      }
    }
    list[1]=s;

    s="";
    for (int i=0; i<w3.cols; i+=1) {
      for (int j=0; j<w3.rows; j+=1) {
        println((str(count*100/total)));
        count+=1;
        s+=str(w3.w[i][j])+" ";
      }
    }
    list[2]=s;
    saveStrings("data\\weightdata.txt", list);
  }
}

class number {
  float[] data;
  float[][] label=new float[1][10];
  int predict=0;
  float[][] realforward=new float[1][10];
  number(float[] d, int l) {
    data=d;

    for (int i=0; i<label[0].length; i+=1) {     
      if (i==l) {
        label[0][i]=1;
      } else label[0][i]=0;
    }
  }
  public void view(float x, float y, float _scl) {
    for (int i=0; i<num; i+=1) {
      for (int j=0; j<num; j+=1) {
        int index=i+j*num;
        noStroke();
        rectMode(CORNER);
        float d=map(data[index], 0, 255, 255, 0);
        fill(d);
        rect(x+j*_scl, y+i*_scl, _scl, _scl);
      }
    }
  }
}
class textbox {
  PVector position;
  float len;
  float hei;
  boolean pressed=false;
  boolean touch=false;
  boolean select=false;
  boolean re=false;
  boolean keyp=false;
  float time=0;
  String t="";
  textbox(float _x, float _y, float _len, float _hei) {
    position=new PVector(_x, _y);
    len=_len;
    hei=_hei;
  }
  public void show() {
    //println(t);
    rectMode(CENTER);
    fill(0);
    stroke(255);
    rect(position.x, position.y, len, hei);
    if (select==true) {
      if (re) line(position.x-len/2+2+t.length()*len/(len/40), position.y-hei/2+10, position.x-len/2+2+t.length()*len/(len/40), position.y+hei/2-10);
      time+=1;
      if (time%20==0) re=!re;
    }
    textAlign(LEFT);
    fill(255);
    textSize(64);
    text(t, position.x-len/2, position.y+20);
  }

  public void select() {
    if (mouseX>position.x-len/2 && mouseX<position.x+len/2 && mouseY>position.y-hei/2 && mouseY<position.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        select=!select;
        pressed=true;
      }
    } else pressed=false;
  }  
  public void type() {
    if (keyPressed) {
      if (key != CODED && key!= BACKSPACE && t.length()<len/40) {
        if (keyp==false) {
          t+=key;
          keyp=true;
        }
      } else {
        if (key==BACKSPACE) {
          if (keyp==false && t.length()!=0) {
            t=t.substring(0, t.length()-1);
            keyp=true;
          }
        }
      }
    } else keyp=false;
  }
}
class button {
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  boolean touch=false;
  boolean pressed=false;
  button(String _name, float _x, float _y, int _num, float _len, float _hei) {
    name=_name;
    position=new PVector(_x, _y);
    num=_num;
    len=_len;
    hei=_hei;
    pp=position.copy();
  }
  public void show(float value) {
    pp.y=position.y-value*(buttons.length*60+100-height)/100;
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(pp.x, pp.y, len, hei);
    fill(255);
    textSize(20);
    text(name, pp.x, pp.y-3);
  }
  public void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  public void show(float s, boolean i) {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(s);
    text(name, position.x, position.y-3);
  }
  public void slidershow() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    noStroke();
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  public void select() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        initialize(name);
        pressed=true;
      }
    } else pressed=false;
  }
  public void selectM() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        reset();
        pressed=true;
      }
    } else pressed=false;
  }  
  public void slide() {
  }

  public PVector sliderselect() {
    if (mouseX>position.x-len/2 && mouseX<position.x+len/2 && mouseY>position.y-hei/2 && mouseY<position.y+hei/2) {
      touch=true;
    }


    if (touch==true && mousePressed == true) {
      position.x=mouseX;
      position.y=mouseY;
    } else touch=false;
    return position;
  }

  public void training() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false; 

    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        training=true;
        menu=false;
        testing=false;
        bonus=false;
        n.learning_rate=learning.v;
        pressed=true;
        graph=new EvolutionGraph(); 
      }
    } else pressed=false;
  }  

  public void back() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=true;
        training=false;
        testing=false;
        bonus=false;
        pressed=true;
        MSV.clear();
        save=false;
        count=0;
        
      }
    } else pressed=false;
  }

  public void test() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=false;
        training=false;
        testing=true;
        bonus=false;
        pressed=true;
      }
    } else pressed=false;
  }

  public void bonusarea() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=false;
        training=false;
        testing=false;
        bonus=true;
        pressed=true;
      }
    } else pressed=false;
  }
  public void addlayer() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        n.addhiddenlayer(4);
        pressed=true;
      }
    } else pressed=false;
  }

  public void deletelayer() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        if (n.h.size()>0) {
          n.clearhidden();
        }
        pressed=true;
      }
    } else pressed=false;
  }

  public void plus(int i) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {

        n.plus(i);


        pressed=true;
      }
    } else pressed=false;
  }


  public void minus(int i) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        n.minus(i);
        pressed=true;
      }
    } else pressed=false;
  }
  public void classify() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        showclassify=!showclassify;
        pressed=true;
      }
    } else pressed=false;
  }
  public void send() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true&&keylabel.t!="") {
      if (pressed==false) {
        String mt="";
        for (int i=0; i<mosaic.length; i+=1) {
          for (int j=0; j<mosaic[i].length; j+=1) {
            mt+=str(mosaic[i][j])+" ";
          }
        }
        mt+=keylabel.t;
        sdata.append(mt);
        String[] list=new String[sdata.size()];
        for (int i=0; i<list.length; i+=1) {
          list[i]=sdata.get(i);
        }
        saveStrings("data\\numberdata.txt", list);
        reset();
        pressed=true;
      }
    } else pressed=false;
  }
  
  
  public void view() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menuM=false;
        view=true;
        pressed=true;
      }
    } else pressed=false;
  }  
  
  
  public void backM() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menuM=true;
        view=false;
        pressed=true;
      }
    } else pressed=false;
  } 
  public void next() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page+=1;
        viewload(page);
        
        pressed=true;
      }
    } else pressed=false;
  }  
  public void prev() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page-=1;
        viewload(page);
        pressed=true;
      }
    } else pressed=false;
  }  
  
  public void reload() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page=1;
        MNISTsetup();
        viewload(page);
        pressed=true;
      }
    } else pressed=false;
  }  
  public void resetweight() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        nueralnetwork.w1.init();
        nueralnetwork.w2.init();
        nueralnetwork.w3.init();
        MNISTsetupweight();
        pressed=true;
      }
    } else pressed=false;
  }  
  
  
  public void label() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        blabel=!blabel;
         pressed=true;
      }
    } else pressed=false;
  } 
  public void trainingM() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        train=true;
        pressed=true;
      }
    } else pressed=false;
  } 
  public void MNIST() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=false;
        training=false;
        testing=false;
        bonus=false;
        MNISTb=true;
        
        pressed=true;
      }
    } else pressed=false;
  } 
  public void backton() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=true;
        training=false;
        testing=false;
        bonus=false;
        MNISTb=false;
        pressed=true;
        
        
      }
    } else pressed=false;
  }
  
}
class drawpoint{
  PVector position;
  PVector showposition;
  PVector preposition;
  PVector testposition;
  float[] data;
  float[] lable;
  float bias=-1;
  float [] labelsize;
  int pointcolor;
  float[] real;
  drawpoint(float x_,float y_){
    position=new PVector(x_,y_);
    showposition=new PVector(map(position.x,minnum[0],maxnum[0],0,width),map(position.y,minnum[1],maxnum[1],0,height));
    
    bias=-1;
  }
  drawpoint(float[] im,float[] _lable,int[] c){
    data=new float[im.length-1];
    position=new PVector(im[0],im[1]);
    //lable=im[im.length-1];
    labelsize=_lable;
    lable=new float[_lable.length];
    for(int i=0;i<_lable.length;i+=1){
      if (im[im.length-1]==_lable[i]){
        lable[i]=1;
        pointcolor=c[i];
      }
      else lable[i]=0;
    }
    showposition=new PVector(map(im[0],minnum[0],maxnum[0],100,400),map(im[1],minnum[1],maxnum[1],75,375));
    preposition=new PVector(map(im[0],minnum[0],maxnum[0],250,550),map(im[1],minnum[1],maxnum[1],75,375));
    testposition=new PVector(map(im[0],minnum[0],maxnum[0],600,900),map(im[1],minnum[1],maxnum[1],75,375));
    for(int i=0;i<im.length-1;i+=1){
      data[i]=im[i];
    }
  }
  public void show(){
    fill(pointcolor);
    noStroke();
    circle(showposition.x,showposition.y,5);
  }
  public void preview(){
    fill(pointcolor);
    noStroke();
    circle(preposition.x,preposition.y,5);
  }
   public void testview(){
    fill(pointcolor);
    noStroke();
    circle(testposition.x,testposition.y,5);
  }

}
class EvolutionGraph extends PApplet {

  EvolutionGraph() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  public void settings() {
    size(900, 600);
  }

  public void setup() {
    background(150);
    frameRate(30);
  }

  public void draw() {
    background(150);
    fill(0);
    strokeWeight(1);
    textSize(15);
    textAlign(CENTER, CENTER);
    text("Iteration", width/2, height-10);
    translate(10, height/2);
    rotate(PI/2);
    text("MSV", 0, 0);      
    rotate(-PI/2);
    translate(-10, -height/2);
    textSize(10);
    noFill();
    stroke(255, 0, 0);

    beginShape();
    for (int i=0; i<MSV.size(); i+=1) {
      if(i==0) continue;
      float y=map(MSV.get(i), 0, maxM(MSV), height-60, 50);
      float x=map(i, 0, MSV.size(), 50, width-50);        
      vertex(x, y);
    }
    endShape();
    //println(pow(10, str(MSV.size()).length()));
    for (int i=0; i<MSV.size(); i+=1) {
      //float y=map(MSV.get(i), 0, maxM(MSV), height-60, 50);
      float x=map(i, 0, MSV.size(), 50, width-50);     
      if (i%pow(10, str(MSV.size()).length()-1)==0) {
        translate(x, 560);
        rotate(PI/2);
        text(i, 0, 0);
        rotate(-PI/2);
        translate(-x, -560);
      }
    }
    for(int i=0;i<10;i+=1){
      float y=map(maxM(MSV)*i/9, 0, maxM(MSV), height-60, 50);
      text(maxM(MSV)*i/9,25,y);
    }


    stroke(0);
    line(40, 50, 40, 540);
    line(40, 540, 900, 540);
  }
  public float maxM(FloatList f) {
    float max=-1000000;
    for (int i=0; i<f.size(); i+=1) {
      if (f.get(i)>max) {
        max=f.get(i);
      }
    }

    return max;
  }
  public void exit() {
    dispose();
    graph = null;
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
class net {
  float learning_rate=0.1f;
  matrix input;
  matrix output;
  ArrayList<matrix> h;
  ArrayList<matrix> w;
  ArrayList<matrix> b;
  ArrayList<button> plus;
  ArrayList<button> minus;
  net(int i, int o) {
    h=new ArrayList<matrix>();
    w=new ArrayList<matrix>();
    b=new ArrayList<matrix>();
    plus=new ArrayList<button>();
    minus=new ArrayList<button>();
    input=new matrix(1, i);
    output=new matrix(1, o);
    w.add(new matrix(i, o));
    b.add(new matrix(1, o));
    for (matrix m : w) {
      m.init();
    }
    for (matrix m : b) {
      m.init();
    }
  }
  public void plus(int i) {
    h.get(i).plus();
    b.get(i).plus();
    w.get(i).pluswf();   
    w.get(i+1).pluswb();
  }

  public void minus(int i) {
    if (n.h.get(i).rows>1) {
      h.get(i).minus();
      b.get(i).minus();
      w.get(i).minuswf();   
      w.get(i+1).minuswb();
    }
  }

  public void addhiddenlayer(int a) {
    //proggerm
    h.add(new matrix(1, a));
    w.clear();
    b.clear();
    plus.clear();
    minus.clear();
    for (int i=0; i<h.size()+1; i+=1) {      
      if (i==0) w.add(new matrix(input.rows, h.get(i).rows));
      else if (i==h.size()) w.add(new matrix(h.get(i-1).rows, output.rows));
      else w.add(new matrix(h.get(i-1).rows, h.get(i).rows));
    }
    for (int i=0; i<h.size(); i+=1) {
      b.add(new matrix(1, h.get(i).rows));
    }
    b.add(new matrix(1, output.rows));


    for (int i=0; i<h.size(); i+=1) {
      float r2=50;
      float h1=675+250*(i+1)/(n.h.size()+1);
      float l=250-(n.h.get(i).rows-1)*r2/2;
      plus.add(new button("+", h1, 50, 0, 20, 20));
      minus.add(new button("-", h1, 450, 0, 20, 20));
    }
    for (matrix m : w) {
      m.init();
    }
    for (matrix m : b) {
      m.init();
    }
  }

  public void clearhidden() {
    h.remove(h.size()-1);
    w.clear();
    b.clear();
    plus.clear();
    minus.clear();
    for (int i=0; i<h.size()+1; i+=1) { 
      if (h.size()==0) {
        w.add(new matrix(input.rows, output.rows));
        break;
      }
      if (i==0) w.add(new matrix(input.rows, h.get(i).rows));
      else if (i==h.size()) w.add(new matrix(h.get(i-1).rows, output.rows));
      else w.add(new matrix(h.get(i-1).rows, h.get(i).rows));
    }
    for (int i=0; i<h.size(); i+=1) {
      b.add(new matrix(1, h.get(i).rows));
    }
    b.add(new matrix(1, output.rows));
    //button
    for (int i=0; i<h.size(); i+=1) {
      float r2=50;
      float h1=675+250*(i+1)/(n.h.size()+1);
      float l=250-(n.h.get(i).rows-1)*r2/2;
      plus.add(new button("+", h1, 50, 0, 20, 20));
      minus.add(new button("-", h1, 450, 0, 20, 20));
    }
    for (matrix m : w) {
      m.init();
    }
    for (matrix m : b) {
      m.init();
    }
  }
  public float[] forward(drawpoint p) {
    input.w[0]=p.data.clone();
    if (h.size()==0) {
      output=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix();
    } else {
      h.get(0).w=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix().w.clone();
      for (int i=0; i<h.size()-1; i+=1) {
        h.get(i+1).w=h.get(i).multiple(w.get(i+1)).addiction(b.get(i+1)).sigmoidMatrix().w.clone();
      }
      output=h.get(h.size()-1).multiple(w.get(w.size()-1)).addiction(b.get(b.size()-1)).sigmoidMatrix();
    }


    return output.w[0].clone();
  }
  public float[] forward(float[] p) {
    input.w[0]=p.clone();
    if (h.size()==0) {
      output=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix();
    } else {
      h.get(0).w=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix().w.clone();
      for (int i=0; i<h.size()-1; i+=1) {
        h.get(i+1).w=h.get(i).multiple(w.get(i+1)).addiction(b.get(i+1)).sigmoidMatrix().w.clone();
      }
      output=h.get(h.size()-1).multiple(w.get(w.size()-1)).addiction(b.get(b.size()-1)).sigmoidMatrix();
    }


    return output.w[0].clone();
  }
  public void train(drawpoint p) {
    //println(output.w[0]);
    if (h.size()==0) {
      matrix outputs=output;
      matrix target=new matrix(1, output.rows);
      target.w[0]=p.lable.clone();
      matrix output_error=target.subtract(outputs);
      
      outputs=outputs.dsigmoidMatrix().scalematrix(output_error).scalematrix(learning_rate);
      
      matrix input_t=input.transport();
      
      matrix w_delta=input_t.multiple(outputs);
           
      w.get(0).w=w.get(0).addiction(w_delta).w.clone();
      b.get(0).w=b.get(0).addiction(outputs).w.clone();
    }
    else{
      //output to last
      matrix outputs=output;
      matrix target=new matrix(1,output.rows);
      target.w[0]=p.lable.clone();
      matrix output_error=target.subtract(outputs);
      outputs=outputs.dsigmoidMatrix().scalematrix(output_error).scalematrix(learning_rate);
      
      matrix h_t=h.get(h.size()-1).transport();
      matrix w_delta=h_t.multiple(outputs);
      w.get(w.size()-1).w=w.get(w.size()-1).addiction(w_delta).w.clone();
      b.get(b.size()-1).w=b.get(b.size()-1).addiction(outputs).w.clone();
      
      matrix wl_t=w.get(w.size()-1).transport();
      matrix h_error=output_error.multiple(wl_t);
      // hidden
      for(int i=h.size()-1;i>0;i-=1){
        matrix hh=h.get(i);
        hh=hh.dsigmoidMatrix().scalematrix(h_error).scalematrix(learning_rate);
        
        h_t=h.get(i-1).transport();
        w_delta=h_t.multiple(hh);
        w.get(i).w=w.get(i).addiction(w_delta).w.clone();
        b.get(i).w=b.get(i).addiction(hh).w.clone();
        
        wl_t=w.get(i).transport();
        h_error=h_error.multiple(wl_t);
        
    }      
      // first to input
      matrix hh=h.get(0);
      
      hh=hh.dsigmoidMatrix().scalematrix(h_error).scalematrix(learning_rate);
      
      matrix i_t=input.transport();
      w_delta=i_t.multiple(hh);
      w.get(0).w=w.get(0).addiction(w_delta).w.clone();
      b.get(0).w=b.get(0).addiction(hh).w.clone();
    }
    
  }


  public void addhidden() {
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
    noStroke();
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "multiple_neural_network" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
