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

public class circle_illusion extends PApplet {

Rolling[] rolling=new Rolling[56];
Rolling[] sine=new Rolling[40];

float time=0;
public void setup() {
  
  frameRate(120);
  createRolling();
  createSine();
  //print(rolling[20].bais);
}

public void draw() {
  background(100);
  translate(width/2, height/2);
  time+=20;



  for (Rolling r : rolling) {
    r.show();
  }
  
  rolling[6].show();
  rolling[4].show();
  rolling[0].show();
  rolling[2].show();
  //saveFrame("frame/data-####");
  //if(time>1440){
  //  noLoop();
  //}
}


public float[][] matmul(float[][] a, float[][] b) {
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length;

  if (colsA != rowsB) {
    println("Columns of A must match rows of B");
    return null;
  }

  float result[][] = new float[rowsA][colsB];

  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsB; j++) {
      float sum = 0;
      for (int k = 0; k < colsA; k++) {
        sum += a[i][k] * b[k][j];
      }
      result[i][j] = sum;
    }
  }
  return result;
}

public void createSine(){
  for(int i=0;i<sine.length;i+=1){
    float x=map(i,0,sine.length,0,4*PI);
    float w=map(i,0,sine.length,0,width);
    PVector b=new PVector(0,sin(x)-sin(x+0.1f));
    b.normalize();
    
    sine[i]=new Rolling(w+15,sin(x)*100,0,b.x,b.y);
  
  }
  

}


public void createRolling(){
  rolling[0]=new Rolling(-100, -100, -100,1,0);
  rolling[1]=new Rolling(-100, -100, 100,1,0);
  rolling[2]=new Rolling(-100, 100, -100,1,0);
  rolling[3]=new Rolling(-100, 100, 100,1,0);
  rolling[4]=new Rolling(100, -100, -100,-1,0);
  rolling[5]=new Rolling(100, -100, 100,-1,0);
  rolling[6]=new Rolling(100, 100, -100,-1,0);
  rolling[7]=new Rolling(100, 100, 100,-1,0);
  //8
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[36+i]=new Rolling(-j, -100, -100,0,0);
  }
  //10
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[40+i]=new Rolling(-100, -j, -100,1,0);
  }
  //6
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    rolling[28+i]=new Rolling(k, k, -j,1,0);
  }
  //100
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[44+i]=new Rolling(-j, 100, -100,0,-1);
  }
  //11
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[48+i]=new Rolling(100, -j, -100,-1,0);
  }
  //12
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    int l=100;
    rolling[52+i]=new Rolling(l, k, -j,-1,0);
  }
  //5
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    rolling[24+i]=new Rolling(-j, -100, 100,0,1);
  }
  //100
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[8+i]=new Rolling(-100, -j, 100,1,0);
  }
  //3
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=-100;
    int l=100;
    rolling[16+i]=new Rolling(k, l, -j,1,0);
  }
  //2
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[12+i]=new Rolling(-j, 100, 100,0,1);
  }
  //4
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    rolling[20+i]=new Rolling(100, -j, 100,1,0);
  }
  //7
  for (int i=0; i<4; i+=1) {
    int j=-100+(i+1)*40;
    int k=100;
    rolling[32+i]=new Rolling(k, k, -j,-1,0);
  }

  float theda_z=PI/8;
  float theda_y=-PI/10;
  float plus=0.08f;
  float[][] rotateZ={
    {1, 0, 0}, 
    {0, cos(theda_z), -sin(theda_z)}, 
    {0, sin(theda_z), cos(theda_z)}  
  };
  float[][] rotateZplus={
    {1, 0, 0}, 
    {0, cos(theda_z+plus), -sin(theda_z+plus)}, 
    {0, sin(theda_z+plus), cos(theda_z+plus)}  
  };
  float[][] rotateY={

    {cos(theda_y), 0, -sin(theda_y)}, 

    {0, 1, 0}, 
    {sin(theda_y), 0, cos(theda_y)}
  };
   float[][] rotateYplus={

    {cos(theda_y+plus), 0, -sin(theda_y+plus)}, 

    {0, 1, 0}, 
    {sin(theda_y+plus), 0, cos(theda_y+plus)}
  };
  for (Rolling r : rolling) {
    float[][] v={{r.center.x}, {r.center.y}, {r.center.z}};

    float[][] rotated=matmul(rotateY, v);
    rotated=matmul(rotateZ, rotated);
    float[][] rotateplus=matmul(rotateYplus, v);
    rotateplus=matmul(rotateZplus, v);
    
    float distance=4;
    float w=3/(distance-rotated[2][0]);
    //println(w);
    float[][] projection={
      {w, 0, 0}, 
      {0, w, 0}, 
    };
    //rotated=matmul(projection,rotated);
    PVector pplus=new PVector(rotateplus[0][0],rotateplus[1][0]);
    PVector p=new PVector(rotated[0][0]*1, rotated[1][0]*1);
    pplus.sub(p);
    pplus.normalize();
    pplus.mult(-1);
    r.bais=pplus.copy();
    r.center=p;
    
  }


}
class Rolling {
  PVector center;
  float bigRadious=15;
  float smallRadious=8;
  boolean flash=false;
  PVector bais;
  Rolling(float x, float y,float z,float bx,float by) {
    center=new PVector(x, y,z);
    bais=new PVector(bx,by);
  }

  public void show() {
    //text(str(center.x)+" "+str(center.y)+" "+str(center.z),center.x,center.y);

    //flashCircle(0, 362, 255, -1);
    //flashCircle(0, 362, 0, 1);
    //flashCircle(0+(int)(time*0.8), 152+(int)(time*0.8), 0,-1);
    //flashCircle(150+(int)(time*0.8), 182+(int)(time*0.8), 200,-1);
    //flashCircle(180+(int)(time*0.8), 332+(int)(time*0.8), 255,-1);
    //flashCircle(330+(int)(time*0.8), 362+(int)(time*0.8), 30,-1);


    
    
    drawCircle(0+45+(int)time, 152+45+(int)time, 0,-bais.x,-bais.y);
    drawCircle(150+45+(int)time, 182+45+(int)time, 200,-bais.x,-bais.y);
    drawCircle(180+45+(int)time, 332+45+(int)time, 255,-bais.x,-bais.y);
    drawCircle(330+45+(int)time, 362+45+(int)time, 30,-bais.x,-bais.y);
    
    drawCircle(0-45+(int)time, 152-45+(int)time, 0,bais.x,bais.y);
    drawCircle(150-45+(int)time, 182-45+(int)time, 200,bais.x,bais.y);
    drawCircle(180-45+(int)time, 332-45+(int)time, 255,bais.x,bais.y);
    drawCircle(330-45+(int)time, 362-45+(int)time, 30,bais.x,bais.y);
    
    drawCircle(0+(int)time, 152+(int)time, 0,0,0);
    drawCircle(150+(int)time, 182+(int)time, 200,0,0);
    drawCircle(180+(int)time, 332+(int)time, 255,0,0);
    drawCircle(330+(int)time, 362+(int)time, 30,0,0);
  }
  public void drawCircle(int start, int end, int c,float baisx,float baisy) {
    noStroke();
    fill(c);
    beginShape();
   
    for (int i=start; i<end; i+=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      
      vertex(center.x+baisx+bigRadious*cos(angle), center.y+baisy+bigRadious*sin(angle));
    }
    for (int i=end; i>start; i-=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      vertex(center.x+baisx+smallRadious*cos(angle), center.y+baisy+smallRadious*sin(angle));
    }

    endShape();
  }
  
  

  public void flashCircle(int start, int end, int c, float bias) {
    noStroke();
    fill(c);
    float sr=map(time%360,0,360,0,2*PI);
    beginShape();

    for (int i=start; i<end; i+=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      vertex(center.x+bias+bigRadious*cos(angle), center.y+bigRadious*sin(angle));
    }
    for (int i=end; i>start; i-=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      vertex(center.x+bias+smallRadious*cos(angle), center.y+smallRadious*sin(angle));
    }

    endShape();
  }
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "circle_illusion" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
