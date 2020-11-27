class drawpoint{
  PVector position;
  PVector showposition;
  PVector preposition;
  float lable;
  float bias=-1;
  drawpoint(float x_,float y_){
    position=new PVector(x_,y_);
    showposition=new PVector(map(position.x,minnum[0],maxnum[0],0,width),map(position.y,minnum[1],maxnum[1],0,height));
    
    bias=-1;
  }
  drawpoint(float[] im){
    position=new PVector(im[0],im[1]);
    lable=im[im.length-1];
    showposition=new PVector(map(im[0],minnum[0],maxnum[0],0,width),map(im[1],minnum[1],maxnum[1],0,height));
    preposition=new PVector(map(im[0],minnum[0],maxnum[0],250,550),map(im[1],minnum[1],maxnum[1],75,375));
  
  }
  void show(){
    if (lable==1) fill(255);
    else fill(0);
    noStroke();
    circle(showposition.x,showposition.y,8);
  }
  void preview(){
    if (lable==1) fill(255);
    else fill(0);
    noStroke();
    circle(preposition.x,preposition.y,8);
  }

}
