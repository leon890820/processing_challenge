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

public class Traveling_Salesperson extends PApplet {

int citynum=8;
PVector[] cities = new PVector[citynum];
int[] best = new int[citynum];
int[] vals=new int[citynum];
boolean finish = false;
float record;
float total;
float count=0;
public void setup() {
    
    for (int i = 0; i < cities.length; i+=1) {
        PVector v=new PVector(random(width),random(height));
        cities[i]=v;
    }
    for (int i = 0; i < citynum; i+=1) {
        vals[i]=i;
    }
    record = calcDistance(cities);
    arrayCopy(vals, best);
    total=factorial(citynum);
}

public void draw() {
    
    // print(vals+"\n")
    //step1
    
    int largestI = -1;
    for (int i=0; i < citynum-1; i+=1){
        if (vals[i]<vals[i+1]){
            largestI=i;
        }
    }
    
    if( largestI == -1){
        finish=true;
        print("finished");
        noLoop();
        

    }
    if(finish==false){
        //step2
        background(0);
       
        int largestJ = -1;
        for (int j = 0; j < citynum; ++j) {
            if (vals[j] > vals[largestI]){
                largestJ=j;
            }
        }
        //step3 
        vals=swap(vals,largestI,largestJ); 
        //step4
        int[] startOfvals=subset(vals,0,largestI+1);
        int[] endOfvals=subset(vals, largestI+1);
        endOfvals = reverse(endOfvals);
        vals=concat(startOfvals,endOfvals);
        String s = "";
        String s1= "";
        for (int i = 0; i < vals.length; i+=1) {
            s+=vals[i];
            s1+=best[i];
        }
        
        textSize(20);
        fill(255);
        text(s,20,height-20);
        text(s1,20,20);
        
        fill(255);
        for (int i = 0; i < cities.length; i+=1) {
            textSize(10);
            circle(cities[i].x,cities[i].y,10);
            text(i,cities[i].x,cities[i].y-20);
        }
        stroke(255);
        beginShape();
        noFill();
        strokeWeight(2);
        for (int i = 0; i < cities.length; i+=1) {
            vertex(cities[vals[i]].x, cities[vals[i]].y);
        }
        endShape();

        beginShape();
        stroke(255,0,255);
        noFill();
        strokeWeight(4);
        for (int i = 0; i < cities.length; i+=1) {
            vertex(cities[best[i]].x,cities[best[i]].y);
        }
        endShape();

        
        float d=calcDistance(cities);
        if (d<record){
            record=d;
            arrayCopy(vals, best);
        }
        print(record+"\n");
        
    }
    count+=1;
    fill(255);
    textSize(20);
    float percent = count*100/total;
    percent=(float)floor(percent*1000)/1000;
    text(percent+"%",width/2,20);
}

public int[] swap(int[] a,int i,int j){
    int temp=a[i];
    a[i]=a[j];
    a[j]=temp;
    return a;
}

public float calcDistance(PVector[] points){
    float sum=0;
    for( int i=0; i<points.length-1; i+=1 ){
        float d=dist(points[vals[i]].x, points[vals[i]].y, points[vals[i+1]].x, points[vals[i+1]].y);
        sum+=d;
    }
    return sum;
}

public float factorial(float a){
    if(a==1) return 1;
    else if(a<1) return 0;
    else return a*factorial(a-1);

}
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Traveling_Salesperson" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
