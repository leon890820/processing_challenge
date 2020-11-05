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
void setup() {
  size(600, 600);
  category=new FloatList();
  slidemenu=new slider("slidemenu", 210, 100, 210, 500, 10, 20, 0, 0);
  learning=new slider("learning", 260, 450, 540, 450, 20, 10, 0.0001, 1);
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



void draw() {
  background(100, 100);
  if (menu==true) menu();
  else if (training==true) training();
  else if (testing==true) testing();
  else if (bonus==true) bonus();
}

void menu() {
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



void training() {
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


void testing() {
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

void bonus() {
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


void initialize(String name) {
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
    if (float(word[word.length-1]) != 1) word[word.length-1]= "-1" ;

    points[i]=float(word);
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
