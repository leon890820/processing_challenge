int scl=20;
int row;
int cul;
float allfitness=0;
int num=1000;
float mutationrate=0.001;
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
void setup(){
  frameRate(30);
  size(1200,800);
  row=400/scl;
  cul=400/scl;
  for(int i=0;i<s.length;i+=1){
    s[i]=new snake();
    sclone[i]=new snake();
  }
  matingpool=new ArrayList<snake>();
}
void draw(){
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

void selection(){
  matingpool.clear();
  for(int j=0;j<s.length;j+=1){
    if(s[j].lifetime>1){
      for(int i=0;i<s[j].fitness;i+=1){
        matingpool.add(s[j]);
      }
    }
  }
}
void generate(){
  
  
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
  

void information(){
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
