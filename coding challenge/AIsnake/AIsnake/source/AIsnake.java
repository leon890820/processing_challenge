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

public class AIsnake extends PApplet {

int scl=20;
int row;
int cul;
float allfitness=0;
int num=1000;
float mutationrate=0.001f;
boolean deaths=true;
snake[] s=new snake[num];
snake[] sclone=new snake[num];
float frame=0;
float[] im=new float[num];
float[] imr1=new float[num];
float[] imr2=new float[num];
ArrayList<snake> matingpool;
float[] generationrecords=new float[1000];
float[] worldrecords=new float[1000];
float generationrecord=0;
float maxscores=0;
float maxindex=0;
float deathn=1000;
float generationtime=0;
int r=(int)random(num);
float worldrecord=0;
float lastf=0;
public void setup(){
  frameRate(30);
  
  row=400/scl;
  cul=400/scl;
  for(int i=0;i<s.length;i+=1){
    s[i]=new snake();
    sclone[i]=new snake();
  }
  matingpool=new ArrayList<snake>();
}
public void draw(){
  background(0);
  translate(400,0);
  frameRate(30);
  stroke(255);
  line(0,0,0,400);
  line(0,0,400,0);
  line(400,0,400,400);
  line(0,400,400,400);
  text("generation:"+generationtime,20,20);
  deaths=true;
  deathn=num;
  maxscores=0;
  maxindex=0;
  
  for(int i=0;i<s.length;i+=1){
    if(s[i].death==false) {
      deaths=false;
      deathn-=1;
    }  
  }
  
  for(int i=0;i<s.length;i+=1){
    if(s[i].score>=maxscores&&s[i].death==false){
      maxindex=i;
      maxscores=s[i].score;
    }
    if(s[i].score>worldrecord) worldrecord=s[i].score;
    if(s[i].score>generationrecord) generationrecord=s[i].score;
  }
  frame+=1;
  
  //print(deathn+" "+deaths+"\n");
  //print(maxindex+" "+maxscores+" "+s[(int)maxindex].lifetime+" "+s[(int)maxindex].death+"\n");
  for(int i=0;i<s.length;i+=1){
    s[i].run();    
  }
  //textSize(20);
  s[(int)maxindex].show();
  s[(int)maxindex].f.run();
  text("lifetime: "+s[(int)maxindex].lifetime,20,60);
  text("worldrecord: "+worldrecord,20,40);
  text("fitness:"+s[(int)maxindex].fitness,20,80);
  if (deaths==true){
    allfitness=0;
    for(int i=0;i<s.length;i+=1){
      s[i].calculateFitness();
      im[i]=s[i].fitness;
    }
    for(int i=0;i<s.length;i+=1){
      allfitness+=s[i].fitness;
    }
    allfitness/=10;
    for(int i=0;i<s.length;i+=1){
      s[i].fitnessrate=s[i].fitness/allfitness;
    }
    float co=0;
    for(int i=0;i<s.length;i+=1){
       s[i].fitnessrange1=co;
       imr1[i]= s[i].fitnessrange1;
       co+=s[i].fitnessrate;
       s[i].fitnessrange2=co;
       imr2[i]= s[i].fitnessrange2;
    }
    lastf=co;
  
    //selection();
   
  }
  information();
  if(deaths==true){
    generationrecords[(int)generationtime]= generationrecord;
    worldrecords[(int)generationtime]=worldrecord;
    generate();
    deathn=1000;
    generationtime+=1;
    maxscores=0;
    maxindex=0;
    generationrecord=0;
  }
 
  
}

public void selection(){
  matingpool.clear();
  for(int j=0;j<s.length;j+=1){
    if(s[j].lifetime>1){
      for(int i=0;i<s[j].fitness;i+=1){
        matingpool.add(s[j]);
      }
    }
  }
}
public void generate(){
  
  
    for(int i=0;i<s.length;i+=1){
      float aaa=random(10);
      float bbb=random(10);
      int aa=0;
      int bb=0;
      for(int j=0;j<s.length;j+=1){
        if(imr1[j]<=aaa&&aaa<imr2[j]){
          aa=j;
          print(aa+"\n");
          
        }
        if(imr1[j]<=bbb&&bbb<imr2[j]){
          bb=j;
        }
      }
      
      snake parentA=s[aa];
      snake parentB=s[bb];
      snake child=parentA.crossover(parentB);
      child.mutate();
      sclone[i]=child;      
    } 
    for(int i=0;i<s.length;i+=1){
      s[i]=sclone[i];
    }
  }
  

public void information(){
  fill(255);
  for(int i=0;i<generationrecords.length;i+=1){
    if(generationrecords[i]>0){
      if(generationtime>=40){        
        text("generation count : "+i,-380,20*(i+41-generationtime));
        text(generationrecords[i],-250,20*(i+41-generationtime));
      }
      else{
         text("generation count : "+i,-380,20*(i+1));
        text(generationrecords[i],-250,20*(i+1));
      }
    }
  }
  line(0,780,800,780);
  line(0,450,0,780);
  for(int i=0;i<80;i+=1){
   // textSize(8);
   if(generationtime>66) text(i-66+generationtime,i*12,height-10);
   else text(i,i*12,height-10);
  }
  text("30",-20,450);
  text("20",-20,560);
  text("10",-20,670);
  text("0",-20,780);
  for(int i=0;i<worldrecords.length;i+=1){
    if(worldrecords[i]>0){
      if(generationtime>66){
        fill(255,255,0);
        circle(i*12,780-worldrecords[(i-66+(int)generationtime)]*11,5);
        fill(0,255,0);
        circle(i*12,780-generationrecords[i-66+(int)generationtime]*11,5);
      }
      else{
        fill(255,255,0);
        circle(i*12,780-worldrecords[i]*11,5);
        fill(0,255,0);
        circle(i*12,780-generationrecords[i]*11,5);
      }
    }
  }
  
  /*
  text(allfitness,-380,20);
  for(int i=0;i<im.length;i+=1){
    if(im[i]>=0){
      text(im[i],-380,20*(i+2));
    }
    text(imr1[i],-280,20*(i+2));
    text(imr2[i],-180,20*(i+2));
  }
  text(lastf,-100,20);
  */
}

class NeuralNetwork{
  float[] input=new float[24];
  float[] hidden1=new float[20];
  float[] hidden2=new float[20];
  float[] output=new float[4];
  float[] bias_h1=new float[20];
  float[] bias_h2=new float[20];
  float[] bias_o=new float[4];
  
  float[][] w1=new float[20][24];
  float[][] w2=new float[20][20];
  float[][] w3=new float[4][20];
  NeuralNetwork(){
    randomize();
  }
  public void run1(float[] in){
    input=in;
    
    for(int i=0;i<hidden1.length;i+=1){
      float sum=0;
      for(int j=0;j<input.length;j+=1){
        sum+=input[j]*w1[i][j];
      }
      //sum+=bias_h1[i];
     // sum=lexu(sum);
      hidden1[i]=sum;
    }
    run2();
  }
  public void run2(){
    for(int i=0;i<hidden2.length;i+=1){
      float sum=0;
      for(int j=0;j<hidden1.length;j+=1){
        sum+=hidden1[j]*w2[i][j];
      }
      //sum+=bias_h2[i];
     // sum=lexu(sum);
      hidden2[i]=sum;
    }
    run3();
  }
  public void run3(){
    for(int i=0;i<output.length;i+=1){
      float sum=0;
      for(int j=0;j<hidden2.length;j+=1){
        sum+=hidden2[j]*w3[i][j];
      }
     // sum+=bias_o[i];
      //sum=lexu(sum);
      output[i]=sum;
    }
  }
  public float lexu(float x){
    return max(0,x);
  }
  public void randomize(){
    for(int i=0;i<24;i+=1){
      for(int j=0;j<20;j+=1){
        w1[j][i]=random(-1,1);
      }
    }
    for(int i=0;i<20;i+=1){
      for(int j=0;j<20;j+=1){
        w2[j][i]=random(-1,1);
      }
    }
    for(int i=0;i<20;i+=1){
      for(int j=0;j<4;j+=1){
        w3[j][i]=random(-1,1);
      }
    }
    for(int i=0;i<20;i+=1){
      bias_h1[i]=random(-1,1);
    }
    for(int i=0;i<20;i+=1){
      bias_h2[i]=random(-1,1);
    }
    for(int i=0;i<4;i+=1){
      bias_o[i]=random(-1,1);
    }
  }
  

}
class food{
  PVector location;
  food(){
    location=new PVector((int)random(row),(int)random(cul));
  }
  public void run(){
    show();
    
  }
  public void show(){
    fill(255,0,0);
    rect(location.x*scl,location.y*scl,scl,scl);
  }
  public void eaten(){
    
    location=new PVector((int)random(row),(int)random(cul));
  }

}
class snake{
  PVector location;
  PVector velocity;
  boolean hitwall=false;
  boolean hitbody=false;
  ArrayList<PVector> sn;
  float fitness;
  float lifetime=200;
  float fitnessrate=0;
  float fitnessrange1=0;
  float fitnessrange2=0;
  float dis=0;
  float pdis=0;
  boolean death=false;
  food f;
  float score=0;
  float[] look=new float[24];
  NeuralNetwork n=new NeuralNetwork();
  
  snake(){
    
    location=new PVector((int)random(1,row-1),(int)random(1,cul-1));
    PVector l=location.get();
    velocity=new PVector(1,0);
    key='d';
    f=new food();
    sn=new ArrayList<PVector>();
    sn.add(l.add(new PVector(-1,0)));
    l=location.get();
    sn.add(l.add(new PVector(-1,0)));
  }
  public void run(){
    
   
    if(death==false){ 
      //show();
      //f.run();
      lifetime-=1;
      //pdis=abs(location.x-f.location.x)+abs(location.y-f.location.y);
      //float dif=dis-pdis;
     // if(dif>0) fitness+=1;
      //else fitness-=2;
      dis=pdis;
      lookaround();
      
      isdeath();      
      ifeat();
      turn();
      
      NN();
      //print(n.output[0]+" "+n.output[1]+" "+n.output[2]+" "+n.output[3]+"\n");
      AIturn();
      update();
      frame=0;      
    }
    
  }
  public void show(){
    
    for(PVector ss:sn){
      fill(255);
      rect(ss.x*scl,ss.y*scl,scl,scl);
    }
    fill(0,255,0);
    rect(location.x*scl,location.y*scl,scl,scl);
  }
  public void update(){
    
    for(int i=0;i<sn.size()-1;i+=1){
      PVector sp;
      sp=sn.get(i+1);
      sn.get(i).x=sp.x;
      sn.get(i).y=sp.y;
    }
    if(sn.size()>0){
      sn.get(sn.size()-1).x=location.x;
      sn.get(sn.size()-1).y=location.y;
    }
    location.add(velocity);
  }
  public void ifeat(){
    if(location.x==f.location.x&&location.y==f.location.y){
      f.eaten();
      sn.add(new PVector(location.x-velocity.x,location.y-velocity.y));
      score+=1;
      //fitness+=50;
      lifetime+=100;
      if (lifetime>200) lifetime=200;
    }
  }
  public void turn(){
    if(key=='d'||key=='D') velocity=new PVector(1,0);
    else if(key=='a'||key=='A') velocity=new PVector(-1,0);
    else if(key=='s'||key=='S') velocity=new PVector(0,1);
    else if(key=='w'||key=='W') velocity=new PVector(0,-1);
  }
  
  public void AIturn(){
    int index=0;
    float maxrecord= -1000000000;
    for(int i=0;i<n.output.length;i+=1){
      if(n.output[i]>maxrecord) {
        maxrecord=n.output[i];
        index=i;
      }
    }
    //print(index+"\n");
    if(index==0) velocity=new PVector(0,-1);
    else if(index==1) velocity=new PVector(-1,0);
    else if(index==2) velocity=new PVector(0,1);
    else  velocity=new PVector(1,0);
  
  
  }
  public void isdeath(){
    for(PVector ss:sn) {
      if(location.x==ss.x&&location.y==ss.y){
        death=true;
        hitbody=true;
      }
    }
    if(location.x>=row||location.x<0||location.y>=cul||location.y<0) {
      hitwall=true;
      death=true;
    }
    if (lifetime<=0) death=true;
  }
  public void lookaround(){
    look[0]=lookdirection(new PVector(-1,0))[0];
    look[1]=lookdirection(new PVector(-1,0))[1];
    look[2]=lookdirection(new PVector(-1,0))[2];
    look[3]=lookdirection(new PVector(-1,1))[0];
    look[4]=lookdirection(new PVector(-1,1))[1];
    look[5]=lookdirection(new PVector(-1,1))[2];
    look[6]=lookdirection(new PVector(0,1))[0];
    look[7]=lookdirection(new PVector(0,1))[1];
    look[8]=lookdirection(new PVector(0,1))[2];
    look[9]=lookdirection(new PVector(1,1))[0];
    look[10]=lookdirection(new PVector(1,1))[1];
    look[11]=lookdirection(new PVector(1,1))[2];
    look[12]=lookdirection(new PVector(1,0))[0];
    look[13]=lookdirection(new PVector(1,0))[1];
    look[14]=lookdirection(new PVector(1,0))[2];
    look[15]=lookdirection(new PVector(1,-1))[0];
    look[16]=lookdirection(new PVector(1,-1))[1];
    look[17]=lookdirection(new PVector(1,-1))[2];
    look[18]=lookdirection(new PVector(0,-1))[0];
    look[19]=lookdirection(new PVector(0,-1))[1];
    look[20]=lookdirection(new PVector(0,-1))[2];
    look[21]=lookdirection(new PVector(-1,-1))[0];
    look[22]=lookdirection(new PVector(-1,-1))[1];
    look[23]=lookdirection(new PVector(-1,-1))[2];
  
  }
  
  public float[] lookdirection(PVector direction){
    float count=1;
    float[] rr=new float[3];
    PVector dir=direction.get();
    PVector testlocation=location.get();
    boolean body=false;
    boolean wall=false;
    boolean food=false;
    
    while (body==false){
      dir=direction.get();
      dir.mult(count);
      testlocation=location.get();
      testlocation.add(dir);
      if(testlocation.x<0||testlocation.x>=row||testlocation.y<0||testlocation.y>=cul) break;
      for(PVector ss:sn){        
        if(testlocation.x==ss.x&&testlocation.y==ss.y){
          body=true;
        }
      }
      count+=1;
      if (count<0||count>row) break;
    }
    if (body==true) rr[0]=1;//(count-1);
    else rr[0]=0;
    count=1;
    testlocation=location.get();
    dir=direction.get();
    
    
    while (food==false){
      dir=direction.get();
      testlocation=location.get();
      dir.mult(count);
      testlocation.add(dir);
      if(testlocation.x<0||testlocation.x>=row||testlocation.y<0||testlocation.y>=cul) break;
      if(testlocation.x==f.location.x&&testlocation.y==f.location.y) food=true;   
      count+=1;
      
    }
    if(food==true) rr[1]=1;//(count-1);
    else rr[1]=0;
    count=1;
    testlocation=location.get();
    dir=direction.get();
    
    while(wall==false){
       testlocation=location.get();
       dir=direction.get();
       dir.mult(count);
       testlocation.add(dir);
       if(testlocation.x<0||testlocation.x>=row||testlocation.y<0||testlocation.y>=cul) wall=true;
       count+=1;    
    }
    rr[2]=1/(count-1);
    
    
    
    return rr;
     
  }
  
  public void NN(){
    n.run1(look);
  }
  
  public snake crossover(snake k){
    snake child=new snake();
    int midpoint=(int)random(24);
    for(int i=0;i<20;i+=1){
      
      for(int j=0;j<24;j+=1){
        if(i<midpoint) child.n.w1[i][j]=n.w1[i][j];
        else child.n.w1[i][j]=k.n.w1[i][j];
      }
      if(i<midpoint) child.n.bias_h1[i]=n.bias_h1[i];
      else child.n.bias_h1[i]=k.n.bias_h1[i];
    }
    midpoint=(int)random(20);
    for(int i=0;i<20;i+=1){
      for(int j=0;j<20;j+=1){
        if(i<midpoint) child.n.w2[i][j]=n.w2[i][j];
        else child.n.w2[i][j]=k.n.w2[i][j];
      }
      if(i<midpoint) child.n.bias_h2[i]=n.bias_h2[i];
      else child.n.bias_h2[i]=k.n.bias_h2[i];
    }
    midpoint=(int)random(4);
    for(int i=0;i<4;i+=1){
      for(int j=0;j<20;j+=1){
        if(i<midpoint) child.n.w3[i][j]=n.w3[i][j];
        else child.n.w3[i][j]=k.n.w3[i][j];
      }
      if(i<midpoint) child.n.bias_o[i]=n.bias_o[i];
      else child.n.bias_o[i]=k.n.bias_o[i];
    }
    return child;
  }
  public void mutate(){
    for(int i=0;i<20;i+=1){
      for(int j=0;j<24;j+=1){
        if(random(1)<mutationrate) n.w1[i][j]+=randomGaussian()/5;
        if(n.w1[i][j]>=1) n.w1[i][j]=1;
      }
    }
    
    for(int i=0;i<20;i+=1){
      for(int j=0;j<20;j+=1){
        if(random(1)<mutationrate) n.w2[i][j]+=randomGaussian()/5;
        if(n.w2[i][j]>=1) n.w2[i][j]=1;
      }
    }
    
    for(int i=0;i<4;i+=1){
      for(int j=0;j<20;j+=1){
        if(random(1)<mutationrate) n.w3[i][j]+=randomGaussian()/5;
        if(n.w3[i][j]>=1) n.w3[i][j]=1;
      }
    }
  }
  public void keyPressed(){
    key='d';
  }
  public void calculateFitness() {//calculate the fitness of the snake
  /*
     if(score < 10) {
       if(lifetime>190&&score==0) lifetime=0;
       else if((hitwall||hitbody)&&score==0) lifetime=0;//200/lifetime;
       else if(lifetime>190||hitwall||hitbody) lifetime=200/lifetime;
       if(lifetime<0) lifetime=0;
        fitness = (int)pow(lifetime,2) * pow(5,score+2); 
     } 
     else {
        fitness = (int)(lifetime*lifetime);
        fitness *= 1024;
        fitness *= (score-9);
     }
     */
     fitness=score*score*100;
     if(hitwall) fitness*=0.2f;
     if(hitbody) fitness*=0.2f;
     if(fitness<=0) fitness=0;
  }


}
  public void settings() {  size(1200,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AIsnake" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
