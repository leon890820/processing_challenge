ball[] balls;

void setup(){
  size(640,360);
  background(0);
  balls=new ball[100];
  for(int i=0;i<balls.length;i+=1){
    balls[i]=new ball(random(width),random(height),balls);
  }
}
void draw(){
  background(0);
  for(int i=0;i<balls.length;i+=1){
    balls[i].display();
    balls[i].move();
    balls[i].bounded();
    balls[i].touch();
  }
 
}
