float sigmoid(float x){
  return 1/(1+exp(-x));
}
float dsigmoid(float y){
  return y*(1-y);
}
class nueralnetwork{
  float learning_rate=0.1;
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
  matrix Feedforward(float[][] i){
    input.m1=i;
    hidden=input.multiply(w1);
    hidden.plus(bais_h);
    hidden.map_sigmoid();
    output=hidden.multiply(w2);
    output.plus(bais_o);
    output.map_sigmoid();
    return output;
    
  }
  void train(float[][] inputs,float[][] targets){
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
