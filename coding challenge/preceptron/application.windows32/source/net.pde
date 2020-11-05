class net {

  float[][] weight;
  float lr=0.00001;
  float bias;
  net(int n, int m) {
    weight=new float[n][m];
    for (int i=0; i<weight.length; i+=1) {
      for (int j=0; j<weight[i].length; j+=1) {
        weight[i][j]=random(-10, 10);
      }
    }
  }
  int guess(float[] inputs) {
    float sum=0;
    for (int j=0; j<weight.length; j+=1) {
      for (int i=0; i<weight[j].length; i+=1) {
        sum+=inputs[i]*weight[j][i];
      }
    }
    int output=sigh(sum);
    return output;
  }
  int sigh(float n) {
    if (n>=0) return 1;
    else return -1;
  }
  void train(float[] inputs, int target) {
    int guess=guess(inputs);
    int error=target-guess;
    for (int j=0; j<weight.length; j+=1) {
      for (int i=0; i<weight[j].length; i+=1) {
        weight[j][i]+=error*inputs[i]*lr;
      }
    }
  }
  float guessY(float x) {
    float w0=weight[0][0];
    float w1=weight[0][1];
    float w2=weight[0][2];

    return (w2/w1)-(w0/w1)*x;
  }
}
