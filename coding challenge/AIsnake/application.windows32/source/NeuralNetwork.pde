
class NeuralNetwork{
  float[] input=new float[24];
  float[] hidden1=new float[20];
  float[] hidden2=new float[20];
  float[] output=new float[4];
  float[] bias_h1=new float[20];
  float[] bias_h2=new float[20];
  float[] bias_o=new float[4];
  
  float[][] w1=new float[20][24];
  float[][] w2=new float[20][20];
  float[][] w3=new float[4][20];
  NeuralNetwork(){
    randomize();
  }
  void run1(float[] in){
    input=in;
    
    for(int i=0;i<hidden1.length;i+=1){
      float sum=0;
      for(int j=0;j<input.length;j+=1){
        sum+=input[j]*w1[i][j];
      }
      //sum+=bias_h1[i];
     // sum=lexu(sum);
      hidden1[i]=sum;
    }
    run2();
  }
  void run2(){
    for(int i=0;i<hidden2.length;i+=1){
      float sum=0;
      for(int j=0;j<hidden1.length;j+=1){
        sum+=hidden1[j]*w2[i][j];
      }
      //sum+=bias_h2[i];
     // sum=lexu(sum);
      hidden2[i]=sum;
    }
    run3();
  }
  void run3(){
    for(int i=0;i<output.length;i+=1){
      float sum=0;
      for(int j=0;j<hidden2.length;j+=1){
        sum+=hidden2[j]*w3[i][j];
      }
     // sum+=bias_o[i];
      //sum=lexu(sum);
      output[i]=sum;
    }
  }
  float lexu(float x){
    return max(0,x);
  }
  void randomize(){
    for(int i=0;i<24;i+=1){
      for(int j=0;j<20;j+=1){
        w1[j][i]=random(-1,1);
      }
    }
    for(int i=0;i<20;i+=1){
      for(int j=0;j<20;j+=1){
        w2[j][i]=random(-1,1);
      }
    }
    for(int i=0;i<20;i+=1){
      for(int j=0;j<4;j+=1){
        w3[j][i]=random(-1,1);
      }
    }
    for(int i=0;i<20;i+=1){
      bias_h1[i]=random(-1,1);
    }
    for(int i=0;i<20;i+=1){
      bias_h2[i]=random(-1,1);
    }
    for(int i=0;i<4;i+=1){
      bias_o[i]=random(-1,1);
    }
  }
  

}
