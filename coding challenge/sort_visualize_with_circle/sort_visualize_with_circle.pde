import peasy.*;
int num=1600;
sortDot[] sortdots=new sortDot[num];
int[] sortNumber=new int[num];
int shuffleTime=200;
int count=0;
PeasyCam cam;
Algorithm algorithm=new Algorithm();
EvolutionGraph graph=new EvolutionGraph();
boolean stop=false;
void settings() {
  size(1000, 600, P3D);
}
void setup() {
  cam=new PeasyCam(this, 500);

  frameRate(60);
  
  //translate(width/2, height/2);
  for (int i=0; i<num; i+=1) {
    sortNumber[i]=i;
    
  }
  newDot();
  
}

void draw() {
  background(0);
  //translate(width/2, height/2);
  for (sortDot sd : sortdots) {
    sd.show();
  }
}
void newDot() {
  for (int i=0; i<sortdots.length; i+=1) {
    int theda=sortNumber[i];//map(sortNumber[i], 0, num, 0, 2*PI);
    sortdots[i]=new sortDot(theda, i);
  }
}


void numberShuffle(int n) {
  for (int i=0; i<n; i+=1) {
    int a=(int)random(0, num);
    int b=(int)random(0, num);
    sortNumber=swap(a, b, sortNumber);
  }
}

int[] swap(int a, int b, int[] n) {
  int temp=n[a];
  n[a]=n[b];
  n[b]=temp;
  return n;
}
