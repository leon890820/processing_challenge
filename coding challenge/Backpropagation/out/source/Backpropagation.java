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

public class Backpropagation extends PApplet {

nueralnetwork nn=new nueralnetwork(2,5,3);
float[][][][] p=new float[4][2][][];

public void setup(){
  
  background(0);
  
  float[][] a1={{0,0}};
  float[][] g1={{random(1),random(1),random(1)}};
  float[][] a2={{0,1}};
  float[][] g2={{random(1),random(1),random(1)}};
  float[][] a3={{1,0}};
  float[][] g3={{random(1),random(1),random(1)}};
  float[][] a4={{1,1}};
  float[][] g4={{random(1),random(1),random(1)}};
  p[0][0]=a1;
  p[0][1]=g1;
  p[1][0]=a2;
  p[1][1]=g2;
  p[2][0]=a3;
  p[2][1]=g3;
  p[3][0]=a4;
  p[3][1]=g4;
  
  
  //print(nn.Feedforward(p[0][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[1][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[2][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[3][0]).m1[0][0]+"\n");
  //nn.Feedforward(a);
  //text(nn.output.m1[0][0],width/2,height/2);
  /*
  for(int i=0;i<m.culs;i+=1){
    for(int j=0;j<m.rows;j+=1){
      text(m.m1[i][j],width*(j+1)/(m.rows+1),height*(i+1)/(m.culs+1));
    }
  }
  */
  
}
public void draw(){
  background(0);
  for(int i=0;i<100;i+=1){
    int g =(int)random(0,4);
    nn.train(p[g][0],p[g][1]);
  }
  float resolution=1;
  float culs=width/resolution;
  float rows=height/resolution;
  
  
  
  for(int i=0;i<culs;i+=1){
    for(int j=0;j<rows;j+=1){
      float x1=i/culs;
      float x2=j/rows;
      float[][] in={{x1,x2}};
      float[][] test={{1,0}};
      
      fill(nn.Feedforward(in).m1[0][0]*255,nn.Feedforward(in).m1[0][1]*255,nn.Feedforward(in).m1[0][2]*255);
      noStroke();
      rect(i*resolution,j*resolution,resolution,resolution);
    }
  }
  //text(x,width/2,height/2);
  //print(nn.Feedforward(p[0][0]).m1[0][0]+"\n");
 //print(nn.Feedforward(p[1][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[2][0]).m1[0][0]+"\n");
  //print(nn.Feedforward(p[3][0]).m1[0][0]+"\n");
  
}
class matrix{
  float[][] m1;
  int culs;
  int rows;
  matrix(float[][] mm){
    m1=mm;
  }
  matrix(int c,int r){
    m1=new float[c][r];
    culs=c;
    rows=r;
  }
  public matrix transport(){
    matrix mclone=new matrix(rows,culs);
    for(int i=0;i<culs;i+=1){
      for(int j=0;j<rows;j+=1){
        mclone.m1[j][i]=m1[i][j];
       
      }
    }
     return mclone;
     
    
  }
 
  public matrix multiply(matrix m2){
    matrix m=new matrix(m1.length,m2.rows);
    //print(m1[0].length);
    for(int i=0;i<m1.length;i+=1){     
      for(int j=0;j<m2.rows;j+=1){
        float sum=0;
        //print(sum);
        for(int k=0;k<m1[0].length;k+=1){
          sum+=m1[i][k]*m2.m1[k][j]; 
        }
        m.m1[i][j]=sum;
      }
    }
   return m;
  }
  public void product(matrix a){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]*=a.m1[i][j];
      }
    }
  }
  public void product(float a){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]*=a;
      }
    }
  }
  public void plus(matrix m2){
    for(int i=0;i<culs;i+=1){
      for(int j=0;j<rows;j+=1){
        m1[i][j]+=m2.m1[i][j];
      }
    }
  }
   public void plus(float n){
    for(int i=0;i<culs;i+=1){
      for(int j=0;j<rows;j+=1){
        m1[i][j]+=n;
      }
    }
  }
  public void randomize(){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]=random(-1,1);
      }
    }
    
  }
  
  public void map_sigmoid(){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]=sigmoid(m1[i][j]);
      }
    }
  }
  public void map_dsigmoid(){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]=dsigmoid(m1[i][j]);
      }
    }
  }
   public matrix  subtract(matrix a){
    matrix c= new matrix(1,a.rows);
    for(int i=0;i<a.m1.length;i+=1){
      for(int j=0;j<a.m1[0].length;j+=1){
        c.m1[i][j]=m1[i][j]-a.m1[i][j];
      }
    }
    return c;
  }

}
public float sigmoid(float x){
  return 1/(1+exp(-x));
}
public float dsigmoid(float y){
  return y*(1-y);
}
class nueralnetwork{
  float learning_rate=0.1f;
  matrix input;
  matrix hidden;
  matrix output;
  matrix w1;
  matrix w2;
  matrix bais_h;
  matrix bais_o;
  nueralnetwork(int a,int b,int c){
    input=new matrix(1,a);
    hidden=new matrix(1,b);
    output=new matrix(1,c);
    w1=new matrix(a,b);
    w2=new matrix(b,c);
    w1.randomize();
    w2.randomize();
    bais_h=new matrix(1,b);
    bais_o=new matrix(1,c);
    bais_h.randomize();
    bais_o.randomize();
  }
  public matrix Feedforward(float[][] i){
    input.m1=i;
    hidden=input.multiply(w1);
    hidden.plus(bais_h);
    hidden.map_sigmoid();
    output=hidden.multiply(w2);
    output.plus(bais_o);
    output.map_sigmoid();
    return output;
    
  }
  public void train(float[][] inputs,float[][] targets){
    matrix outputs=Feedforward(inputs);
    matrix target=new matrix(1,output.rows);
    target.m1=targets;
    matrix output_error=target.subtract(outputs);
    outputs.map_dsigmoid();
    outputs.product(output_error);
    outputs.product(learning_rate);
    
   
    
    matrix hidden_t=hidden.transport();
    matrix w2_deltas=hidden_t.multiply(outputs);
    w2.plus(w2_deltas);
     bais_o.plus(output);
    
    matrix w2_t=w2.transport();
    matrix hidden_error=output_error.multiply(w2_t);
    
    hidden.map_dsigmoid();
    hidden.product(hidden_error);
    hidden.product(learning_rate);
    
    matrix input_t=input.transport();
    matrix w1_deltas=input_t.multiply(hidden);
    w1.plus(w1_deltas);
    bais_h.plus(hidden);
    
    //print(hidden_error.m1.length,hidden_error.m1[0].length);
  }
  

}
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Backpropagation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
