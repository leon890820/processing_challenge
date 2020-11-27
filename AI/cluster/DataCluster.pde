class DataCluster{
  PVector location;
  float[] center=new float[dataSheetNum];
  ArrayList<DataPoint> dataCluster;
  color clusterColor=color(random(255),random(255),random(255));
  String label="";
  int layer;
  DataCluster childA;
  DataCluster childB;
  DataCluster(){
  
  }
  DataCluster(DataPoint[] d,DataCluster A,DataCluster B){
    dataCluster=new ArrayList<DataPoint>();
    for(int i=0;i<d.length;i+=1){
      dataCluster.add(d[i]);
    }  
    
    calCenter();
    for(DataPoint dp:dataCluster){
      label+=str(dp.label)+" ";
    }
    childA=A;
    childB=B;
  }
  
  
  void calCenter(){
    for(int i=0;i<dataSheetNum;i+=1){
      float sum=0;
      for(int j=0;j<dataCluster.size();j+=1){
        sum+=dataCluster.get(j).dataSheet[i];
      }
      center[i]=sum/dataCluster.size();
    
    }
  
  }

}
