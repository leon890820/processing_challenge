class Data{
  float scl=8;
  matrix inputData;
  Data(float[] _inputData){
    inputData=new matrix(1,_inputData.length);
    inputData.w[0]=_inputData;
    
  
  }
  void show(float x,float y,int r,int c){
    stroke(255);
    noFill();
    //rect(x,y,scl*r,scl*c);
    for(int i=0;i<c;i+=1){
      for(int j=0;j<r;j+=1){
        int index=i*r+j;
        noStroke();
        if(inputData.w[0][index]==1) fill(255);
        else fill(0);
        rect(x+j*scl,y+i*scl,scl,scl);
        
      }
    }
  
  
  }
  
  void train(){
    matrix transX=inputData.transport();
    matrix x=NN.network.multiple(transX);
     
    x=x.subtract(NN.theda.transport());
   
    x.sgn();
    inputData=x.transport();
    
  
  }
  void bonustrain(){
    matrix transX=inputData.transport();
    matrix x=bonusNN.network.multiple(transX);
     
    x=x.subtract(bonusNN.theda.transport());
   
    x.sgn();
    inputData=x.transport();
    
  
  }
  


}
