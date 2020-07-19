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

public class Traveling_Salesperson_GA extends PApplet {

int citynum=8;
int populationsnum=10;
PVector[] cities = new PVector[citynum];
int[] best = new int[citynum];
int[] vals=new int[citynum];
int[] orders = new int[citynum];
int[][] populations=new int[populationsnum][];
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
    for(int i=0;i<citynum;i+=1){
        orders[i]=i;
    }
    for(int i=0;i<populationsnum;i+=1){
        populations[i]=shuffle(orders);
    }
    println(populations[0]);
    
}

public void draw() { 
    background(0);   
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
    
        
    
    count+=1;
    fill(255);
    textSize(20);
    
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
public int[] shuffle(int[] order){
    
    for(int i=0;i<100;i+=1){
        int i1=PApplet.parseInt(random(order.length));
        int i2=PApplet.parseInt(random(order.length));
        order=swap(order,i1,i2);

    }
    
    return order;
}
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Traveling_Salesperson_GA" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
