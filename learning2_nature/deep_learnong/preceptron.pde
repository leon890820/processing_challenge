class preceptron{
  float[] weight=new float[3];
  float lr=0.0001;
  float bias;
  preceptron(){
    for(int i=0;i<weight.length;i+=1){
      weight[i]=random(-1,1);
    }
    
  }
  int guess(float[] inputs){
    float sum=0;
    for(int i=0;i<weight.length;i+=1){
      sum+=inputs[i]*weight[i];
    }
    int output=sigh(sum);
    return output;
  }
  int sigh(float n){
    if(n>=0) return 1;
    else return -1;
  }
  void train(float[] inputs,int target){
    int guess=guess(inputs);
    int error=target-guess;
    for(int i=0;i<weight.length;i+=1){
      weight[i]+=error*inputs[i]*lr;
    }
  }
  float guessY(float x){
    float w0=weight[0];
    float w1=weight[1];
    float w2=weight[2];
    
    return -(w2/w1)-(w0/w1)*x;
  }

}
