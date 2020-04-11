bird[] b=new bird[10];
precentron p;
float w=12;
float h=20;
float[] generationrecords=new float[1000];
float generationpoint=0;
float[] worldrecords=new float[1000];

int generationtime=1;
float maxgenerator=0;
ArrayList<obstacle> obstacles;
float cdtime=2.8;
float t=2;
int point=0;
int maxpoint=0;
boolean death=true;
float deathanimationtime=0;
ArrayList<bird> matingpool;
float mutationrate=0.05;
void setup(){
  //float[] text={5,3};
  size(800,1000);
  
  matingpool=new ArrayList<bird>();
  p=new precentron();
  for(int i=0;i<b.length;i+=1){
    b[i]=new bird();
  }
  
  obstacles=new ArrayList<obstacle>();
  //p.run(text);
}
void draw(){
  background(0);
  stroke(255);
  line(30,970,800,970);
  line(30,520,30,970);
  for(int i=0;i<100;i+=1){
    if(worldrecords[i]>0){
      fill(255,255,0);
      circle(30+i*8,970-worldrecords[i]*3,5);
      fill(255,0,255);
      circle(30+i*8,970-generationrecords[i]*3,5);
    }
  }
  death=true;
  //cdtime=3-point*0.005;
  
  stroke(255);
  line(550,0,550,500);
  information();
  fill(255);
  text("generation: "+generationtime,50,50);
  greatpoint();
  for(int i=0;i<b.length;i+=1){
   
    if(b[i].deaths==false) death=false;
     b[i].run();
  }
  print(deathanimationtime+"\n");
  if (death==false) t+=0.04;
  deathanimation();
  if(deathanimationtime<2){
         
    for (int i=0;i<obstacles.size();i+=1){
      obstacle o=obstacles.get(i);
        o.run(); 
        if(o.location.x<-10) obstacles.remove(i);
        if(death==true) o.velocity.mult(0);
    }
    if(t>cdtime){
      obstacles.add(new obstacle());
      t=0;
    }
    fill(255);
    textSize(20);
    text(point,width/2,20);
  }
  else {
    generationrecords[generationtime]=point;
    worldrecords[generationtime]=maxpoint;
    
    selection();
    generation();
    death=true;
    obstacles.clear();
    for(int i=0;i<b.length;i+=1){
      b[i].deaths=false;
      b[i].velocity.mult(0);
      b[i].location=new PVector(200,500/2);
    }
    generationtime+=1;
    deathanimationtime=0;
    /*
    fill(255,0,0);
    textSize(35);
    text("your points are:"+point,width/2-150,height/2);
    textSize(15);
    text("press r to restart",width/2-50,height/2+50);
    */
  }
}
void deathanimation(){
  if(death==true) deathanimationtime+=0.1;

}
void keyPressed(){
  if(key==' '&&death==false){
    
    //b.jump();
    
  }
  if(key=='r'||key=='R'){
    obstacles.clear();
    //point=0;
    //death=false;
    
    
    deathanimationtime=0;
    //b.location=new PVector(100,height/2);
    //b.velocity.mult(0);
  }
  
}
void greatpoint(){
  float maxfitness=0;
  for(int i=0;i<b.length;i+=1){
    if(b[i].fitness>maxfitness) maxfitness=b[i].fitness;
  }
  point=(int)maxfitness/50;
  if(point>maxpoint){
    maxpoint=point;
    maxgenerator=generationtime;
  } 
}
void selection(){
  matingpool.clear();
  for(int i=0;i<b.length;i+=1){
    for(int j=0;j<b[i].fitness/5;j+=1){
      matingpool.add(b[i]);
    }
  }
  
}
void generation(){
 
  for(int i=0;i<b.length;i+=1){
    
    int a=(int) random(matingpool.size());
    int c=(int) random(matingpool.size());
    
    bird parentA=matingpool.get(a);
    bird parentB=matingpool.get(c);
    
    bird child=parentA.crossover(parentB);
    child.mutate();
    b[i]=child;
  }
}
void information(){
  for(int i=0;i<b.length;i+=1){
    textSize(15);
    if(b[i].deaths==false) fill(255);
    else fill(255,0,0);
    text((int)b[i].fitness+"   "+(int)b[i].p.input[0]+"   "+(int)b[i].p.input[1]+"   "+b[i].p.output[0],550,40*(i+1));
    fill(255);
    noStroke();
    
  }  
  text(maxpoint+"  at generation  "+(int)maxgenerator,550,480);
}
