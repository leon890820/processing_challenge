class DataPoint{
  float[] dataSheet=new float[dataSheetNum];
  int label;
  DataPoint(float[] d,int l){
    dataSheet=d;
    label=l;
  }
  
  void show(){
    noStroke();
    //fill(255);
    circle(dataSheet[0],dataSheet[1],10);
  
  }


}
