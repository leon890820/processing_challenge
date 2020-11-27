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
color[] cs;
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

void setup() {
  
  MNISTsetup();
  category=new FloatList();
  MSV=new FloatList();
  slidemenu=new slider("slidemenu", 210, 100, 210, 500, 10, 20, 0, 0);
  learning=new slider("learning", 260, 450, 540, 450, 20, 10, 0.0001, 1);
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



void draw() {
  background(100, 100);
  if (menu==true) menu();
  else if (training==true) {
    training();
    testing();
  } else if (testing==true) testing();
  else if (bonus==true) bonus();
  else if (MNISTb==true) MNIST();
}
void MNIST() {
  background(150); 
  if (menuM==true) menuM();
  else if (view==true) view();
}
void MNISTsetup() {
  dataM=loadStrings("numberdata.txt");
  weightdata=loadStrings("weightdata.txt");
  scl=560/num;
  nueralnetwork=new NN(784, 256, 128, 10);
  
  sdata=new StringList();

  trainingdataM=new number[dataM.length];
  for (int j=0; j<trainingdataM.length; j+=1) {
    String[] t=dataM[j].split(" ");
    float[] tt=new float[t.length-1];
    int l=int(t[t.length-1]);
    for (int i=0; i<tt.length; i+=1) {
      tt[i]=float(t[i]);
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
      nueralnetwork.w1.w[i][j]=float(weight[index]);
    }
  }
  weight=weightdata[1].split(" ");
  for (int i=0; i<nueralnetwork.w2.cols; i+=1) {
    for (int j=0; j<nueralnetwork.w2.rows; j+=1) {
      int index=i*nueralnetwork.w2.rows+j;
      nueralnetwork.w2.w[i][j]=float(weight[index]);
    }
  }
  weight=weightdata[2].split(" ");
  for (int i=0; i<nueralnetwork.w3.cols; i+=1) {
    for (int j=0; j<nueralnetwork.w3.rows; j+=1) {
      int index=i*nueralnetwork.w3.rows+j;
      nueralnetwork.w3.w[i][j]=float(weight[index]);
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
void MNISTsetupweight() {
  dataM=loadStrings("numberdata.txt");
  weightdata=loadStrings("weightdata.txt");
  scl=560/num;
  nueralnetwork=new NN(784, 256, 128, 10);
  
  sdata=new StringList();

  trainingdataM=new number[dataM.length];
  for (int j=0; j<trainingdataM.length; j+=1) {
    String[] t=dataM[j].split(" ");
    float[] tt=new float[t.length-1];
    int l=int(t[t.length-1]);
    for (int i=0; i<tt.length; i+=1) {
      tt[i]=float(t[i]);
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

void menu() {
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

void menuM() {
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

void view() {
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

void drawPic() {
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

void drawP() {
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

void reset() {
  for (int i=0; i<num; i+=1) {
    for (int j=0; j<num; j+=1) {
      mosaic[i][j]=255;
      keylabel.t="";
    }
  }
}

void viewload(int p) {
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

void cost() {
  float cost=0;
  for (int i=0; i<trainingdataM.length; i+=1) {
    cost+=norm2(trainingdataM[i].label[0], trainingdataM[i].realforward[0]);
  }
  println(cost);
}

float norm2(float[] a, float[] b) {
  float result=0;
  for (int i=0; i<a.length; i+=1) {
    result+=pow(a[i]-b[i], 2);
  }

  return sqrt(result);
}

void mousePressed() {
  keylabel.select=false;
}
void classfy() {
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
void classfytrain() {
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
void classfytest() {
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


float calcmaxoutput(float[] a) {
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



void showNN() {
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


void training() {
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


void testing() {
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

void bonus() {
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


void initialize(String name) {
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

    points[i]=float(word);
  }
  float[] la=calclable(points);
  cs=new color[la.length];
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
float[] calclable(float[][] a) {
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

boolean lisina(float a, FloatList l) {
  // println(a);
  for (int i=0; i<l.size(); i+=1) {
    if (a==l.get(i)) {
      return false;
    }
  }

  return true;
}
float calcmax(float[][] d, int n) {
  float record=-1000000000;
  for (int i=0; i<d.length; i+=1) {   
    if ((d[i][n])>record) record=(d[i][n]);
  }

  return record;
}

float calcmin(float[][] d, int n) {
  float record=1000000000;
  for (int i=0; i<d.length; i+=1) {   
    if ((d[i][n])<record) record=(d[i][n]);
  }

  return record;
}

void randomChoese() {
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
