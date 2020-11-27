int scl;
int num=28;
float[][] mosaic;
button reset;
button send;
button views;
button back;
button next;
button prev;
button label;
button reload;
button training;

textbox keylabel;
NN nueralnetwork;
EvolutionGraph graph;
boolean train=false;
boolean menu=true;
boolean view=false;
boolean blabel=false;
StringList sdata;
String[] data;
int page=1;
int maxpage;
number[] viewdatas=new number[100];
number[] trainingdata;
String[] weightdata;
public void settings() {
  size(800, 800);
}
void setup() {

  scl=560/num;
  nueralnetwork=new NN(784, 256, 128, 10);
  graph=new EvolutionGraph();
  sdata=new StringList();
  data=loadStrings("numberdata.txt");
  weightdata=loadStrings("weightdata.txt");
  trainingdata=new number[data.length];
  for (int j=0; j<trainingdata.length; j+=1) {
    String[] t=data[j].split(" ");
    float[] tt=new float[t.length-1];
    int l=int(t[t.length-1]);
    for (int i=0; i<tt.length; i+=1) {
      tt[i]=float(t[i]);
    }
    trainingdata[j]=new number(tt, l);
  }
  for (int i=0; i<10; i+=1) {
    for (int j=0; j<10; j+=1) {
      int index=j+i*10;
      viewdatas[index]=trainingdata[index];
    }
  }
  for (String s : data) {
    sdata.append(s);
  }
  mosaic=new float[num][num];
  for (int i=0; i<num; i+=1) {
    for (int j=0; j<num; j+=1) {
      mosaic[i][j]=255;
    }
  }
  
  String[] weight=weightdata[0].split(" ");
  for(int i=0;i<nueralnetwork.w1.cols;i+=1){
    for(int j=0;j<nueralnetwork.w1.rows;j+=1){
      int index=i*nueralnetwork.w1.rows+j;
      nueralnetwork.w1.w[i][j]=float(weight[index]);
    }
  }
  weight=weightdata[1].split(" ");
  for(int i=0;i<nueralnetwork.w2.cols;i+=1){
    for(int j=0;j<nueralnetwork.w2.rows;j+=1){
      int index=i*nueralnetwork.w2.rows+j;
      nueralnetwork.w2.w[i][j]=float(weight[index]);
    }
  }
  weight=weightdata[2].split(" ");
  for(int i=0;i<nueralnetwork.w3.cols;i+=1){
    for(int j=0;j<nueralnetwork.w3.rows;j+=1){
      int index=i*nueralnetwork.w3.rows+j;
      nueralnetwork.w3.w[i][j]=float(weight[index]);
    }
  }
    
  
  
  reset=new button("reset", 675, 50, 0, 150, 50);
  send=new button("send", 400, 700, 0, 150, 50);
  next=new button("next", 300, 650, 0, 150, 50);
  prev=new button("prev", 100, 650, 0, 150, 50);
  views=new button("view", 675, 150, 0, 150, 50);
  reload=new button("reload", 675, 250, 0, 150, 50);
  keylabel=new textbox(200, 700, 40, 75);
  back=new button("back", 500, 650, 0, 150, 50);
  label=new button("label", 675, 150, 0, 150, 50);
  training=new button("train", 675, 50, 0, 150, 50);
  maxpage=trainingdata.length/100+1;
  //print(nueralnetwork.forward(trainingdata[0].data));
  for (int i=0; i<trainingdata.length; i+=1) {
    trainingdata[i].predict=(int)nueralnetwork.forward(trainingdata[i].data);
    trainingdata[i].realforward=nueralnetwork.realforward();
    //nueralnetwork.training(trainingdata[i]);
  }
  cost();
  for (int i=0; i<trainingdata.length; i+=1) {
    trainingdata[i].predict=(int)nueralnetwork.forward(trainingdata[i].data);
    trainingdata[i].realforward=nueralnetwork.realforward();
    nueralnetwork.training(trainingdata[i]);
  }
  cost();
  //println(trainingdata[0].realforward);
}

void draw() {

  background(150); 



  if (menu==true) menu();
  else if (view==true) view();
}

void menu() {
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
}

void view() {
  training.show();
  training.training();
  back.show();
  back.back();
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
      for (int i=0; i<trainingdata.length; i+=1) {
        trainingdata[i].predict=(int)nueralnetwork.forward(trainingdata[i].data);
        trainingdata[i].realforward=nueralnetwork.realforward();
        nueralnetwork.training(trainingdata[i]);
      }
      cost();
    }
    nueralnetwork.saveweight();
    println(trainingdata[4].realforward[0]);
    println(trainingdata[4].label[0]);
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
  reset.select();
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
      if (index+(p-1)*100>=trainingdata.length) {
        viewdatas[index]=null;
      } else {
        viewdatas[index]=trainingdata[index+(p-1)*100];
      }
    }
  }
}

void cost() {
  float cost=0;
  for (int i=0; i<trainingdata.length; i+=1) {
    cost+=norm2(trainingdata[i].label[0], trainingdata[i].realforward[0]);
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
