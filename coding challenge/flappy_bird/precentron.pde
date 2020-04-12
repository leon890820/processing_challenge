class precentron{
  
  float[] input=new float[2];
  float[] hidden=new float[6];
  float[] output=new float[1];
  float[][] w1=new float[2][6];
  float[][] w2=new float[1][6];
  precentron(){
    randomize();
  }
  void run(float[] r){
    input=r;
    inputprecentron(input);
  }
  void inputprecentron(float[] i){
  
    for(int j=0;j<6;j+=1){
      float sum=0;
      for(int k=0;k<2;k+=1){
        sum+=i[k]*w1[k][j];
      }
       hidden[j]=sum;
    } 
    hiddenprecentron(hidden);
  }
  void hiddenprecentron(float[] h){
    float sum=0;
    for(int i=0;i<h.length;i+=1){
      sum+=h[i]*w2[0][i];
    }   
    output[0]=sum;
    outputprecentron(output);
  }
  void outputprecentron(float[] o){
    
    //print(o[0]+"\n");
  } 
  void randomize(){
    for(int i=0;i<2;i+=1){
      for(int j=0;j<6;j+=1){
        w1[i][j]=random(-1,1);
      }
    }
    for(int i=0;i<1;i+=1){
      for(int j=0;j<6;j+=1){
        w2[i][j]=random(-1,1);
      }
    }
    
  }
}
