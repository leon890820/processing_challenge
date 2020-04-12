bubble[] bubbles=new bubble[10];

void setup(){
  size(640,360);
  for(int i=0;i<10;i+=1){
    bubbles[i]=new bubble();
  }
 
}
void draw(){
  background(0);
  for(int i=0;i<10;i+=1){
    bubbles[i].create();
    bubbles[i].raise();
    
  }
}
