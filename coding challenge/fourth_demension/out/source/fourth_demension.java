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

public class fourth_demension extends PApplet {

float angel=0;
float len=200;
P4Vector[] points=new P4Vector[16];
PVector[] projected=new PVector[16];

public void setup() {
    
    points[0]=new P4Vector(-1,-1, 1,1);
    points[1]=new P4Vector( 1,-1, 1,1);
    points[2]=new P4Vector(-1, 1, 1,1);
    points[3]=new P4Vector( 1, 1, 1,1);
    points[4]=new P4Vector(-1,-1,-1,1);
    points[5]=new P4Vector( 1,-1,-1,1);
    points[6]=new P4Vector(-1, 1,-1,1);
    points[7]=new P4Vector( 1, 1,-1,1);
    points[8]=new P4Vector(-1,-1, 1,-1);
    points[9]=new P4Vector( 1,-1, 1,-1);
    points[10]=new P4Vector(-1, 1, 1,-1);
    points[11]=new P4Vector( 1, 1, 1,-1);
    points[12]=new P4Vector(-1,-1,-1,-1);
    points[13]=new P4Vector( 1,-1,-1,-1);
    points[14]=new P4Vector(-1, 1,-1,-1);
    points[15]=new P4Vector( 1, 1,-1,-1);
}

public void draw() {
    
    translate(0,height/2);
    rotateX(-PI/2);
    float[][] rotationXY={
        {cos(angel),-sin(angel),0,0},
        {sin(angel),cos(angel),0,0},
        {0,0,1,0},
        {0,0,0,1}
    };
    float[][] rotationXZ={
        {cos(angel),0,-sin(angel),0},
        {0,1,0,0},
        {-sin(angel),0,cos(angel),0},
        {0,0,0,1}
    };
    float[][] rotationXW={
        {cos(angel),0,0,-sin(angel)},
        {0,1,0,0},
        {0,0,1,0},
        {sin(angel),0,0,cos(angel)}
    };
    float[][] rotationZW={
        {1,0,0,0},
        {0,1,0,0},
        {0,0,cos(angel),-sin(angel)},
        {0,0,sin(angel),cos(angel)}
    };
    
    background(0);
    translate(width/2,height/2);
    stroke(255);
    strokeWeight(8);
    noFill();
    //rotateY(angel);
    int index=0;
    for (P4Vector v:points){
        P4Vector rotated=matmul(rotationXY,v,true);
        rotated=matmul(rotationZW,rotated,true);
        float distance=2;
        float w=1/(distance-rotated.w);
        float[][] projection={
            {w,0,0,0},
            {0,w,0,0},
            {0,0,w,0}
        };
        PVector projected3d=matmul(projection,rotated);
        projected3d.mult(100);

       

             
        projected[index]=projected3d;
        index+=1;
    }
    for(PVector v:projected){
         point(v.x,v.y,v.z);
    }
    
    
    for(int i=0;i<16;i+=1){
        for(int j=0;j<16;j+=1){
            float dis=fourthDdistance(points[i],points[j]);
            if (dis<=2){
                connect(i,j);

            }

        }

    }
   

    angel+=0.01f;
}

public void connect(int i,int j){
    PVector a= projected[i];
    PVector b= projected[j];
    
    strokeWeight(1);
    stroke(255);
    line(a.x,a.y,a.z,b.x,b.y,b.z);
}
public float fourthDdistance(P4Vector a,P4Vector b){
    float dis4=pow(a.x-b.x,2)+pow(a.y-b.y,2)+pow(a.z-b.z,2)+pow(a.w-b.w,2);
    return sqrt(dis4);

}
// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #112: 3D Rendering with Rotation and Projection
// https://youtu.be/p4Iz0XJY-Qk

// Matrix Multiplication
// https://youtu.be/tzsgS19RRc8

public float[][] vecToMatrix(P4Vector v) {
  float[][] m = new float[4][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  m[3][0] = v.w;
  return m;
}

public PVector matrixToVec(float[][] m) {
  PVector v = new PVector();
  v.x = m[0][0];
  v.y = m[1][0];
  if (m.length > 2) {
    v.z = m[2][0];
  }
  return v;
}
public P4Vector matrixToVec4(float[][] m) {
  P4Vector v = new P4Vector(0,0,0,0);
  v.x = m[0][0];
  v.y = m[1][0];
  
  v.z = m[2][0];
  v.w=m[3][0];
  return v;
}

public void logMatrix(float[][] m) {
  int cols = m[0].length;
  int rows = m.length;
  println(rows + "x" + cols);
  println("----------------");
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      print(m[i][j] + " ");
    }
    println();
  }
  println();
}


public PVector matmul(float[][] a, P4Vector b) {
  float[][] m = vecToMatrix(b);
  
  return matrixToVec(matmul(a,m));
}

public P4Vector matmul(float[][] a, P4Vector b,boolean fourth) {
  float[][] m = vecToMatrix(b);
  
  return matrixToVec4(matmul(a,m));
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
class P4Vector{
    float x,y,z,w;
    P4Vector(float x,float y,float z,float w){
        this.x=x;
        this.y=y;
        this.z=z;
        this.w=w;

    }



}
  public void settings() {  size(600,400,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "fourth_demension" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
