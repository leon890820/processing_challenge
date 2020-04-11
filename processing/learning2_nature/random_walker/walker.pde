class walker{
  float x;
  float y;
  walker(){
    x=width/2;
    y=height/2;
  }
  void display(){
    stroke(0);
    point(x,y);
  }
  void step(){
    int s=int(random(4));
    if (s==0){
      x+=1;
    }
    else if(s==1){
      y+=1;
    }
    else if(s==2){
      x-=1;
    }
    else{
      y-=1;
    }
  }
  
}
