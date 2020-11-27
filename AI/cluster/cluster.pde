int dataSheetNum=2;
int dataNum=30;
int iteration=29;
DataPoint[] dataPoints=new DataPoint[dataNum];
ArrayList<DataCluster> dataClusters;
EvolutionGraph clusterGraph;
DataCluster[][] recordClusters=new DataCluster[iteration+1][];
void settings() {
  size(600, 600);
}
void setup() {

  dataClusters=new ArrayList<DataCluster>();
  for (int i=0; i<dataPoints.length; i+=1) {
    float[] d=new float[dataSheetNum];
    for (int j=0; j<d.length; j+=1) {
      d[j]=random(0, width);
    }
    dataPoints[i]=new DataPoint(d, i);
  }
  for (int i=0; i<dataPoints.length; i+=1) {
    DataPoint[] DP={dataPoints[i]};
    dataClusters.add(new DataCluster(DP, null, null));
  }

  recordClusters[0]=new DataCluster[dataClusters.size()];
  for (int i=0; i<recordClusters[0].length; i+=1) {
    dataClusters.get(i).layer=1;
    recordClusters[0][i]=dataClusters.get(i);
  }
  for (int i=0; i<iteration; i+=1) {
    background(0);
    cluster();

    recordClusters[i+1]=new DataCluster[dataClusters.size()];
    for (int j=0; j<dataClusters.size(); j+=1) {
      recordClusters[i+1][j]=dataClusters.get(j);
    }
    for (DataCluster data : dataClusters) {
      for (DataPoint dp : data.dataCluster) {
        fill(data.clusterColor);
        dp.show();
      }
    }
  }
  for (int i=0; i<dataClusters.size(); i+=1) {
    //println(dataClusters.get(i).center);
  }
  int index=0;
  for (DataCluster dc : recordClusters[iteration]) {
    for (DataPoint dp : dc.dataCluster) {
      int i=dp.label;
      float x=index*(1000-50)/dataPoints.length+(1000-50)/dataPoints.length;
      float y=565;
      //println(dataPoints.length);
      recordClusters[0][i].clusterColor=dc.clusterColor;
      recordClusters[0][i].location=new PVector(x, y);
      index+=1;
    }
  }
  for (int j=0; j<iteration-1; j+=1) {
    for(int i=0;i<recordClusters[j].length;i+=1){
      for(int k=0;k<recordClusters[iteration].length;k+=1){
        if(isIn(recordClusters[j][i].dataCluster.get(0),recordClusters[iteration][k].dataCluster)){
          recordClusters[j][i].clusterColor=recordClusters[iteration][k].clusterColor;
          continue;
        }
      }
    }
  }

  for (int i=0; i<iteration; i+=1) {
    for (DataCluster dc : recordClusters[i+1]) {
      if (dc.childA==null||dc.childB==null) {
        dc.layer=1;
      } else {
        dc.layer=max(dc.childA.layer, dc.childB.layer)+1;
      }
    }
  }
  for (int i=0; i<iteration; i+=1) {
    for (DataCluster dc : recordClusters[i+1]) {
      if (dc.childA==null||dc.childB==null) {
        //dc.location=new PVector(0, 0);
      } else {
        int s=maxl(recordClusters[iteration]);
        dc.location=new PVector((dc.childA.location.x+dc.childB.location.x)/2, 565-(dc.layer-1)*(600/(float)s));
      }
    }
  }
  
  clusterGraph=new EvolutionGraph();
}



int maxl(DataCluster[] dc){
  int record=-1000;
  for(int i=0;i<dc.length;i+=1){
    if(dc[i].layer>record){
      record=dc[i].layer;
    }
  }
  
  return record;

}
boolean isIn(DataPoint a,ArrayList<DataPoint> b){
  for(int i=0;i<b.size();i+=1){
    if(a.label==b.get(i).label) return true;
  }

   return false;
}

void cluster() {
  int indexI=0;
  int indexJ=0;
  float record=10000000;
  for (int i=0; i<dataClusters.size()-1; i+=1) {
    for (int j=i+1; j<dataClusters.size(); j+=1) {
      float di=distant(dataClusters.get(i).center, dataClusters.get(j).center);
      if (di<record) {
        record=di;
        indexI=i;
        indexJ=j;
      }
    }
  }
  int s1=dataClusters.get(indexI).dataCluster.size();
  int s2=dataClusters.get(indexJ).dataCluster.size();
  int s=s1+s2;
  DataPoint[] dp=new DataPoint[s];
  int index=0;
  for (int i=0; i<s1; i+=1) {
    dp[index]=dataClusters.get(indexI).dataCluster.get(i);
    index+=1;
  }
  for (int i=0; i<s2; i+=1) {
    dp[index]=dataClusters.get(indexJ).dataCluster.get(i);
    index+=1;
  }
  ArrayList<DataCluster> DC=new ArrayList<DataCluster>();
  for (int i=0; i<dataClusters.size(); i+=1) {
    if (i==indexI||i==indexJ)continue;
    DC.add(dataClusters.get(i));
  }

  DC.add(new DataCluster(dp, dataClusters.get(indexI), dataClusters.get(indexJ)));

  dataClusters=DC;
}

float distant(float[] a, float[] b) {
  float Dist=0;
  for (int i=0; i<a.length; i+=1) {
    Dist+=pow(a[i]-b[i], 2);
  }

  return sqrt(Dist);
}
