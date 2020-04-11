import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
ArrayList<Box> box;
Box2DProcessing box2d;
void setup(){
  size(640,360);
  background(255);
  box=new ArrayList<Box>();
  box2d=new Box2DProcessing(this);
  box2d.createWorld();
}
void draw(){
  box2d.step();
  for(Box b:box){
    b.display();
  }
  if(mousePressed){
    box.add(new Box(mouseX,mouseY));
  }

}
