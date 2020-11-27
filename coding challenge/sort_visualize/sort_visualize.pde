import processing.sound.*;
Sound s;
SinOsc sin = new SinOsc(this);
String[] al={"Bubble Sort", "Cocktail Shaker Sort", "Gnome Sort", "Odd-Even Sort", "Quick Sort"};
int AC=4;
float num=100;
float w;
float h;
boolean checkTime=false;
float cdt=0;
int checksort=0;
//BUBBLE SORT
int count=0;
int stop=1000;
boolean stopA[]={false, false, false, false, false};
int[] sortArray=new int[(int)num];
SortObject[] so=new SortObject[(int)num];
int[] bigLoop={(int)num-1};
int[] smallLoop={(int)num-2};
int comparisons=0;
int ArrayAccesses=0;
//CSS
boolean[] CSS=new boolean[(int)num];
int CSSsort=0;
boolean up=true;
//GnomeSort
int pos=0;
//Odd-Even Sort
int Odd=0;
boolean Oddb=false;
//quickSort
int leftLoop=0;
int rightLoop=(int)num-1;
int pivot=(int)num/2;
boolean[] QSB=new boolean[(int)num];

void setup() {
  frameRate(1000);
  size(1000, 1000);
  background(0);
  w=width/num;
  h=(height-100)/num;
  //CSS
  for (int i=0; i<num; i+=1) {
    sortArray[i]=i;
    CSS[i]=false;
    if (i==0||i==num-1) CSS[i]=true;
  }
  //QS
  for (int i=0; i<num; i+=1) {
    QSB[i]=false;
  }
  QSB[pivot]=true;



  //
}

void draw() {
  background(0);
  if (count<stop) {
    sortArray=shuffleSort(sortArray);
    count+=1;
    for (int i=0; i<num; i+=1) {

      so[i]=new SortObject(i*w, w, sortArray[i]*h, 255);
    }
  } else if (stopA[AC]==false) {
    algorithm();
  } else {  
    if (checkTime) {
      checkt();
    } else if (AC!=al.length-1 && cdt>2) {

      count=0;
      AC+=1;
      comparisons=0;
      ArrayAccesses=0;
      cdt=0;
    } else {
      cdt+=0.01;
      sin.stop();
    }
  }
  textAlign(CENTER);
  fill(255);
  text("algorithm : "+al[AC], 80, 20);
  text("Numbers : "+num, 60, 40);
  text("Comparisons : "+comparisons, 60, 60);
  text("Array Accesses : "+ArrayAccesses, 60, 80);



  for (SortObject o : so) {
    o.show();
  }
}
int[] shuffleSort(int[] sa) {


  for (int i=0; i<1; i+=1) {
    int a=(int)random(sa.length);
    int b=(int)random(sa.length);
    int tmp=sa[a];
    sa[a]=sa[b];
    sa[b]=tmp;
  }

  sin.play(random(100, 1000), 0.5);
  return sa;
}

int[] swap(int[] sa, int a, int b) {
  int tmp=sa[a];
  sa[a]=sa[b];
  sa[b]=tmp;



  return sa;
}

void algorithm() {
  if (AC==0) {
    bubbleSort();
  } else if (AC==1) {  
    CocktailShakerSort();
  } else if (AC==2) {
    GnomeSort();
  } else if (AC==3) {
    OddEvenSort();
  } else if (AC==4) {
    QuickSort();
  }
}


void bubbleSort() {
  if (sortArray[bigLoop[0]]<sortArray[smallLoop[0]]) {
    sortArray=swap(sortArray, bigLoop[0], smallLoop[0]);
    ArrayAccesses+=1;
  }
  float f=map(sortArray[smallLoop[0]], 0, num, 100, 1000);
  if (smallLoop[0]==0 && bigLoop[0]==1) {
    stopA[0]=true;
    checkTime=stopA[0];
  }
  smallLoop[0]-=1;
  if (smallLoop[0]<0) {
    bigLoop[0]-=1;
    smallLoop[0]=bigLoop[0]-1;
  }
  comparisons+=1;

  sin.play(f, 0.5);
  for (int i=0; i<num; i+=1) {
    if (i==bigLoop[0]||i==smallLoop[0]) {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, color(255, 0, 0));
    } else {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, 255);
    }
  }
}


void CocktailShakerSort() {
  if (up) {
    if (sortArray[CSSsort]>sortArray[CSSsort+1]) {
      sortArray=swap(sortArray, CSSsort, CSSsort+1);
      ArrayAccesses+=1;
    }
    if (CSS[CSSsort+1]==true) {
      CSS[CSSsort]=true;
      //CSSsort+=1;
      up=!up;
    } else {
      CSSsort+=1;
    }
  } else {
    if (sortArray[CSSsort-1]>sortArray[CSSsort]) {
      sortArray=swap(sortArray, CSSsort, CSSsort-1);
      ArrayAccesses+=1;
    }
    if (CSS[CSSsort-1]==true) {
      CSS[CSSsort]=true;
      //CSSsort-=1;
      up=!up;
    } else {
      CSSsort-=1;
    }
  }
  comparisons+=1;
  for (int i=0; i<num; i+=1) {
    if (i==CSSsort) {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, color(255, 0, 0));
    } else {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, 255);
    }
  }
  float f=map(sortArray[CSSsort], 0, num, 100, 500);
  sin.play(f, 0.5);
  stopA[1]=check();
  checkTime=stopA[1];
}
boolean check() {
  for (int i=0; i<num-1; i+=1) {
    if (sortArray[i]>sortArray[i+1]) return false;
  }
  return true;
}
void checkt() {

  for (int i=0; i<num; i+=1) {
    if (i==checksort) {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, color(0, 255, 0));
    } else {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, 255);
    }
  }
  checksort+=1;
  float n=map(checksort, 0, num, 100, 1000);
  sin.play(n, 0.5);
  if (checksort==num) {
    checkTime=false;
    checksort=0;
  }
}


void GnomeSort() {
  if (pos>=num) stopA[2]=true;
  if (pos==0) {
    pos+=1;
  } else if (sortArray[pos]>=sortArray[pos-1]) {
    pos+=1;
  } else {
    sortArray=swap(sortArray, pos, pos-1);
    pos-=1;
    ArrayAccesses+=1;
  }
  comparisons+=1;
  for (int i=0; i<num; i+=1) {
    if (i==pos) {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, color(255, 0, 0));
    } else {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, 255);
    }
  }
  float f=map(sortArray[pos], 0, num, 100, 1000);
  sin.play(f, 0.5);
  stopA[2]=check();
  checkTime=stopA[2];
}

void OddEvenSort() {
  if (sortArray[Odd]>sortArray[Odd+1]) {
    sortArray=swap(sortArray, Odd, Odd+1);
    ArrayAccesses+=1;
  }
  Odd+=2;
  if (Odd>=num||Odd+1>=num) {
    if (Oddb) {
      Odd=0;
    } else {
      Odd=1;
    }
    Oddb=!Oddb;
  }
  comparisons+=1;
  for (int i=0; i<num; i+=1) {
    if (i==Odd) {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, color(255, 0, 0));
    } else {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, 255);
    }
  }
  float f=map(sortArray[Odd], 0, num, 100, 1000);
  sin.play(f, 0.5);
  stopA[3]=check();
  checkTime=stopA[3];
}

void QuickSort() {
  println(pivot);
  if (leftLoop!=rightLoop) {
    if (sortArray[leftLoop]>pivot&&sortArray[rightLoop]<=pivot) {
      sortArray=swap(sortArray, leftLoop, rightLoop);
      leftLoop+=1;
      rightLoop-=1;
      ArrayAccesses+=1;
    } else if (sortArray[leftLoop]>pivot&&sortArray[rightLoop]>pivot) {
      rightLoop-=1;
    } else if (sortArray[leftLoop]<pivot&&sortArray[rightLoop]<=pivot) {
      leftLoop+=1;
    } else {
      leftLoop+=1;
      rightLoop-=1;
    }
  }
  if (leftLoop==pivot||rightLoop==pivot) {
    boolean l=false;
    for (int i=0; i<num; i+=1) {
      if (l==false) {
        if (QSB[i]==false) {
          leftLoop=i;
          l=true;
        }
      } else {
        if (QSB[i]==true) {
          rightLoop=i-1;
          break;
        }
      }
    }

    QSB[pivot]=true;
    pivot=(int)random(leftLoop, rightLoop);
  }
  comparisons+=1;
  for (int i=0; i<num; i+=1) {
    if (i==leftLoop||i==rightLoop) {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, color(255, 0, 0));
    } else {
      so[i]=new SortObject(i*w, w, sortArray[i]*h, 255);
    }
  }
  float f=map(sortArray[leftLoop], 0, num, 100, 500);
  sin.play(f, 0.5);
  stopA[1]=check();
  checkTime=stopA[1];
}
