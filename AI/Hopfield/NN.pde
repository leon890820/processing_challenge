class net {
  matrix network;
  ArrayList<Data> data;
  float p;
  matrix theda;
  net(int _cols, int _rows,ArrayList s) {
    p=_cols*_rows;
    data=new ArrayList<Data>();
    network=new matrix(_cols*_rows, _cols*_rows);
    theda=new matrix(1,int(p));
    theda.zero();    
    network.zero();
    data=s;
    calcNetwork();
    
    
  }

  void calcNetwork() {
    for (int i=0; i<data.size(); i+=1) {
      matrix transX=data.get(i).inputData.transport();
      network=network.addiction(transX.multiple(data.get(i).inputData));
    }    
    //print(data.size());
    network=network.scalematrix(1/p);  
    println(network.w[0]);
    matrix I=new matrix(int(p),int(p));
    I.identity(); 
    I=I.scalematrix(data.size()/p);
    
    network=network.subtract(I);
    for(int i=0;i<p;i+=1){
      float sum=0;
      for(int j=0;j<p;j+=1){
        sum+=network.w[i][j];
      }
      theda.w[0][i]=sum;   
    }
     
  }
 
}
