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
  matrix transport(){
    matrix mclone=new matrix(rows,culs);
    for(int i=0;i<culs;i+=1){
      for(int j=0;j<rows;j+=1){
        mclone.m1[j][i]=m1[i][j];
       
      }
    }
     return mclone;
     
    
  }
 
  matrix multiply(matrix m2){
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
  void product(matrix a){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]*=a.m1[i][j];
      }
    }
  }
  void product(float a){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]*=a;
      }
    }
  }
  void plus(matrix m2){
    for(int i=0;i<culs;i+=1){
      for(int j=0;j<rows;j+=1){
        m1[i][j]+=m2.m1[i][j];
      }
    }
  }
   void plus(float n){
    for(int i=0;i<culs;i+=1){
      for(int j=0;j<rows;j+=1){
        m1[i][j]+=n;
      }
    }
  }
  void randomize(){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]=random(-1,1);
      }
    }
    
  }
  
  void map_sigmoid(){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]=sigmoid(m1[i][j]);
      }
    }
  }
  void map_dsigmoid(){
    for(int i=0;i<m1.length;i+=1){
      for(int j=0;j<m1[0].length;j+=1){
        m1[i][j]=dsigmoid(m1[i][j]);
      }
    }
  }
   matrix  subtract(matrix a){
    matrix c= new matrix(1,a.rows);
    for(int i=0;i<a.m1.length;i+=1){
      for(int j=0;j<a.m1[0].length;j+=1){
        c.m1[i][j]=m1[i][j]-a.m1[i][j];
      }
    }
    return c;
  }

}
