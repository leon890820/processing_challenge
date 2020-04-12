star[] stars=new star[2000];
float speed;
void setup(){
  size(800,800);
  for(int i=0;i<stars.length;i+=1){
    stars[i]=new star();
  }
  background(0);
}
void draw(){
  background(0);
  speed=map(mouseX,0,width,0,50);
  translate(width/2,height/2);
  for(int i=0;i<stars.length;i+=1){
    stars[i].show();
    stars[i].update();
  }

}
