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
PVector[] points=new PVector[4];
float[][] projection={
    {1,0,0},
    {0,1,0}
};
public void setup() {
    
    points[0]=new PVector(-50,-50,0);
    points[1]=new PVector(50,-50,0);
    points[2]=new PVector(-50,50,0);
    points[3]=new PVector(50,50,0);
}

public void draw() {
    background(0);
    translate(width/2,height/2);
    stroke(255);
    strokeWeight(16);
    noFill();
    for (PVector v:points){
        PVector projected2d=matmul(projection,v);

        point(projected2d.x,projected2d.y);

    }
   

    angel+=0.01f;
}
// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #112: 3D Rendering with Rotation and Projection
// https://youtu.be/p4Iz0XJY-Qk

// Matrix Multiplication
// https://youtu.be/tzsgS19RRc8

public float[][] vecToMatrix(PVector v) {
  float[][] m = new float[3][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
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


public PVector matmul(float[][] a, PVector b) {
  float[][] m = vecToMatrix(b);
  return matrixToVec(matmul(a,m));
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
  public void settings() {  size(600,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "fourth_demension" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
