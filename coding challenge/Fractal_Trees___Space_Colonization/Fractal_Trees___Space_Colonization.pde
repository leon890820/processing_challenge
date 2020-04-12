tree t;
import peasy.*;
PeasyCam cam;
float max=100;
float min=5;
void setup(){
  t=new tree();
  cam=new PeasyCam(this,100);
  size(640,940,P3D);
  background(0);
  //frameRate(3);
}

void draw(){
  background(0);
  t.show();
  t.grow();
  //print(t.leaves.size());
}

void keyPressed(){
  for(int i=0;i<100;i+=1){
      t.leaves.add(new leave());
      
    }
}
