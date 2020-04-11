CA ca;
int delay=30;
void setup(){
  size(800,400);
  background(255);
  int[] ruleset={0,1,0,1,1,0,1,0};
  ca=new CA(ruleset);
}
void draw(){
  //background(255);
  
  ca.display();
  ca.generate();
  /*
  if(ca.finished()){
    delay+=1;
  }
  if(delay>30){
    ca.reset();
    background(255);
    delay=0;
  }
  */
}
