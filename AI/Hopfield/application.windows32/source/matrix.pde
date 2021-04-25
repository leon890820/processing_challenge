class matrix{
  int cols;
  int rows;
  float[][] w;
  matrix(int m,int n){
    cols=m;
    rows=n;
    w=new float[m][n];
  }
  void plus(){
    rows+=1;
    w=new float[cols][rows];
    init();
  }
  void pluswf(){
    rows+=1;
    w=new float[cols][rows];
    init();
  }
  void pluswb(){
    cols+=1;
    w=new float[cols][rows];
    init();
  }
  void minus(){
    rows-=1;
    w=new float[cols][rows];
    init();
  }
  void minuswf(){
    rows-=1;
    w=new float[cols][rows];
    init();
  }
  void minuswb(){
    cols-=1;
    w=new float[cols][rows];
    init();
  }
  
  
  matrix addiction(matrix a){
    if(a.cols!=cols || a.rows!=rows) return null;
    matrix result=new matrix(a.cols,a.rows);
    for(int i=0;i<a.cols;i+=1){
      for(int j=0;j<a.rows;j+=1){
        result.w[i][j]=w[i][j]+a.w[i][j];
      }
    }
    return result;
  }
  matrix subtract(matrix a){
    if(a.cols!=cols || a.rows!=rows) return null;
    matrix result=new matrix(a.cols,a.rows);
    for(int i=0;i<a.cols;i+=1){
      for(int j=0;j<a.rows;j+=1){
        result.w[i][j]=w[i][j]-a.w[i][j];
      }
    }
    return result;
  }
  
  matrix scalematrix(float n){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=n*w[i][j];
      }
    }
    return result;
  }
  matrix scalematrix(matrix n){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=n.w[i][j]*w[i][j];
      }
    }
    return result;
  }
  
  matrix multiple(matrix a){
    matrix result=new matrix(cols,a.rows);
    if(rows!=a.cols) return null;
    for(int i=0;i<result.cols;i+=1){
      for(int j=0;j<result.rows;j+=1){
        float sum=0;
        for(int k=0;k<rows;k+=1){
          //println(k);
          sum+=w[i][k]*a.w[k][j];
        }
        result.w[i][j]=sum;
      }
    }
    return result;
  }
  matrix transport(){
    matrix result=new matrix(rows,cols);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[j][i]=w[i][j];
      }
    }
    
    
    return result;
  }
  void init(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        w[i][j]=random(-1,1);
      }
    }
  }
  void zero(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        w[i][j]=0;
      }
    }
  }
  
  matrix dsigmoidMatrix(){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=dsigmoid(w[i][j]);
      }
    }
    return result;
  }
   matrix sigmoidMatrix(){
    matrix result=new matrix(cols,rows);
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        result.w[i][j]=sigmoid(w[i][j]);
      }
    }
    return result;
  }
  void identity (){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        if(i==j) w[i][j]=1;
        else w[i][j]=0;
      }
    }
  
  }
  void sgn(){
    for(int i=0;i<cols;i+=1){
      for(int j=0;j<rows;j+=1){
        if(w[i][j]>=0) w[i][j]=1;
        else w[i][j]=-1;
      }
    }
  
  
  }
  
  
  

}


float Relu(float x) {
  return max(0, x);
}
float sigmoid(float x) {
  return 1/(1+exp(-x));
}
float dsigmoid(float y){
  return y*(1-y);
}
