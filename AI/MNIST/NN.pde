float Relu(float x) {
  return max(0, x);
}
float sigmoid(float x) {
  return 1/(1+exp(-x));
}
float dsigmoid(float y){
  return y*(1-y);
}

class NN {
  matrix input;
  matrix hidden1;
  matrix hidden2;
  matrix output;
  matrix w1;
  matrix w2;
  matrix w3;
  matrix bias_h1;
  matrix bias_h2;
  matrix bias_o;
  float learning_rate=0.001;
  float bias=1;
  NN(int i, int h1, int h2, int o) {
    input=new matrix(1, i);
    hidden1=new matrix(1, h1);
    hidden2=new matrix(1, h2);
    output=new matrix(1, o);
    w1=new matrix(i, h1);
    w2=new matrix(h1, h2);
    w3=new matrix(h2, o);
    bias_h1=new matrix(1,h1);
    bias_h2=new matrix(1,h2);
    bias_o=new matrix(1,o);
    w1.init();
    w2.init();
    w3.init();
    bias_h1.init();
    bias_h2.init();
    bias_o.init();
  }
  float forward(float[] in) {
    float n=0;
    float[][] inn=new float[input.cols][input.rows];
    for (int i=0; i<inn[0].length; i+=1) {
      inn[0][i]=in[i]/255;
    }
    //inn[0][inn[0].length-1]=1;
    input.w=inn;
    matrix tem=input.multiple(w1);
    for (int i=0; i<hidden1.rows; i+=1) {
      hidden1.w[0][i]=tem.w[0][i];
    }
    //hidden1.w[0][hidden1.rows-1]=1;
    for (int i=0; i<hidden1.rows; i+=1) {
      hidden1.w[0][i]=sigmoid(hidden1.w[0][i]);
    }

    tem=hidden1.multiple(w2);
    for (int i=0; i<hidden2.rows; i+=1) {
      hidden2.w[0][i]=tem.w[0][i];
    }
    //hidden2.w[0][hidden2.rows-1]=1;
    for (int i=0; i<hidden2.rows; i+=1) {
      hidden2.w[0][i]=sigmoid(hidden2.w[0][i]);
    }
    output=hidden2.multiple(w3);
    for (int i=0; i<output.rows; i+=1) {
      output.w[0][i]=sigmoid(output.w[0][i]);
    }

    //println(output.w[0]);
    float max=calcmax(output.w[0]);


    return max;
  }
  
  void training(number n){
    matrix outputs=output;
    matrix target=new matrix(1,output.rows);
    target.w=n.label;
    matrix output_error=target.subtract(outputs);
    outputs=outputs.dsigmoidMatrix();
    outputs=outputs.scalematrix(output_error);
    outputs=outputs.scalematrix(learning_rate);
    
    matrix hidden2_t=hidden2.transport();
    matrix w3_deltas=hidden2_t.multiple(outputs);
    w3=w3.addiction(w3_deltas);
    bias_o=bias_o.addiction(outputs);
    
    matrix w3_t=w3.transport();
    matrix hidden2_error=output_error.multiple(w3_t);
    matrix hiddens2=hidden2;
    hiddens2=hiddens2.dsigmoidMatrix();
    hiddens2=hiddens2.scalematrix(hidden2_error);
    hiddens2=hiddens2.scalematrix(learning_rate);
    
    matrix hidden1_t=hidden1.transport();
    matrix w2_deltas=hidden1_t.multiple(hiddens2);
    w2=w2.addiction(w2_deltas);
    bias_h2=bias_h2.addiction(hiddens2);
    
    matrix w2_t=w2.transport();
    matrix hidden1_error=hidden2_error.multiple(w2_t);
    matrix hiddens1=hidden1;
    hiddens1=hiddens1.dsigmoidMatrix();
    hiddens1=hiddens1.scalematrix(hidden1_error);
    hiddens1=hiddens1.scalematrix(learning_rate);
    
    matrix input_t=input.transport();
    matrix w1_deltas=input_t.multiple(hiddens1);
    w1=w1.addiction(w1_deltas);
    bias_h1=bias_h1.addiction(hiddens1);
  }
  
  
  
  float calcmax(float[] f) {
    float record=-100000;
    float[] index=new float[10];
    int in=0;
    //int inn=0;
    indexclear(index);
    for (int i=0; i<f.length; i+=1) {
      if(f[i]>record){
        record=f[i];
        in=i;
      }
    }
    //  if (f[i]>record) {
    //    in=0;
    //    indexclear(index);
    //    record=f[i];
    //    index[in]=i;
    //    in+=1;
    //  } else if (f[i]==record) {
    //    index[in]=i;
    //    in+=1;
    //  }     
    //}
    //float n=index[(int)random(in+1)];
  

    return in;
  }
  void indexclear(float[] index) {
    for (int i=0; i<index.length; i+=1) {
      index[i]=0;
    }
  }
  float[][] realforward(){
  
    return output.w;
  }
  
  void saveweight(){
    String[] list=new String[3];
    String s="";
    float total=w1.rows*w1.cols+w2.rows*w2.cols+w3.rows*w3.cols;
    float count=0;
    for(int i=0;i<w1.cols;i+=1){
      for(int j=0;j<w1.rows;j+=1){
        println((str(count*100/total)));
        count+=1;
        s+=str(w1.w[i][j])+" ";
      }
    }
    
    list[0]=s;
    
    s="";
    for(int i=0;i<w2.cols;i+=1){
      for(int j=0;j<w2.rows;j+=1){
        println((str(count*100/total)));
        count+=1;
        s+=str(w2.w[i][j])+" ";
      }
    }
    list[1]=s;
    
    s="";
    for(int i=0;i<w3.cols;i+=1){
      for(int j=0;j<w3.rows;j+=1){
        println((str(count*100/total)));
        count+=1;
        s+=str(w3.w[i][j])+" ";
      }
    }
    list[2]=s;
    saveStrings("data\\weightdata.txt", list);
  
  }
}
