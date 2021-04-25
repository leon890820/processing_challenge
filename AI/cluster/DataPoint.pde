class DataPoint{
  float[] dataSheet=new float[dataSheetNum];
  int label;
  String name;
  DataPoint(float[] d,int l,String _name){
    dataSheet=d;
    label=l;
    name=_name;
  }
  
  void show(){
    noStroke();
    //fill(255);
    circle(dataSheet[0],dataSheet[1],10);
  
  }


}
