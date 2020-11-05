class drawpoint{
  PVector position;
  PVector showposition;
  PVector preposition;
  PVector testposition;
  float[] data;
  float[] lable;
  float bias=-1;
  float [] labelsize;
  color pointcolor;
  float[] real;
  drawpoint(float x_,float y_){
    position=new PVector(x_,y_);
    showposition=new PVector(map(position.x,minnum[0],maxnum[0],0,width),map(position.y,minnum[1],maxnum[1],0,height));
    
    bias=-1;
  }
  drawpoint(float[] im,float[] _lable,color[] c){
    data=new float[im.length-1];
    position=new PVector(im[0],im[1]);
    //lable=im[im.length-1];
    labelsize=_lable;
    lable=new float[_lable.length];
    for(int i=0;i<_lable.length;i+=1){
      if (im[im.length-1]==_lable[i]){
        lable[i]=1;
        pointcolor=c[i];
      }
      else lable[i]=0;
    }
    showposition=new PVector(map(im[0],minnum[0],maxnum[0],100,400),map(im[1],minnum[1],maxnum[1],75,375));
    preposition=new PVector(map(im[0],minnum[0],maxnum[0],250,550),map(im[1],minnum[1],maxnum[1],75,375));
    testposition=new PVector(map(im[0],minnum[0],maxnum[0],600,900),map(im[1],minnum[1],maxnum[1],75,375));
    for(int i=0;i<im.length-1;i+=1){
      data[i]=im[i];
    }
  }
  void show(){
    fill(pointcolor);
    noStroke();
    circle(showposition.x,showposition.y,5);
  }
  void preview(){
    fill(pointcolor);
    noStroke();
    circle(preposition.x,preposition.y,5);
  }
   void testview(){
    fill(pointcolor);
    noStroke();
    circle(testposition.x,testposition.y,5);
  }

}
